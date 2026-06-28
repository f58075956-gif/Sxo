// ╔══════════════════════════════════════════════╗
// ║     NEXO UNIVERSAL CHAT — Servidor Relay     ║
// ║  Deploy gratis en Railway o Render           ║
// ╚══════════════════════════════════════════════╝
//
// INSTRUCCIONES DE DEPLOY:
//   1. Sube este archivo a un repo de GitHub
//   2. En railway.app o render.com conecta el repo
//   3. El comando de inicio es: node server.js
//   4. Copia la URL pública que te den (ej: https://nexo-chat.up.railway.app)
//   5. Pégala en el script Lua donde dice GLOBAL_SERVER_URL

const http = require("http");

// ── Configuración ──────────────────────────────
const PORT        = process.env.PORT || 3000;
const MAX_MSGS    = 100;   // mensajes guardados en memoria
const MSG_TTL     = 300;   // segundos que vive un mensaje (5 min)
const RATE_LIMIT  = 8;     // máx mensajes por usuario cada 30 seg
const RATE_WINDOW = 30;    // ventana anti-spam en segundos

// ── Estado en memoria ──────────────────────────
let messages  = [];        // [ { id, ts, sender, display, text, rank, quoteName, quoteText, uid, game } ]
let msgIdSeq  = 0;
let rateMap   = {};        // { userId: [ timestamps ] }

// ── Helpers ────────────────────────────────────
function now() { return Math.floor(Date.now() / 1000); }

function cleanOld() {
    const cutoff = now() - MSG_TTL;
    messages = messages.filter(m => m.ts > cutoff);
    if (messages.length > MAX_MSGS)
        messages = messages.slice(messages.length - MAX_MSGS);
}

function isRateLimited(userId) {
    const key   = String(userId);
    const times = (rateMap[key] || []).filter(t => now() - t < RATE_WINDOW);
    rateMap[key] = times;
    if (times.length >= RATE_LIMIT) return true;
    times.push(now());
    rateMap[key] = times;
    return false;
}

function readBody(req) {
    return new Promise((resolve, reject) => {
        let body = "";
        req.on("data", chunk => body += chunk);
        req.on("end",  ()    => resolve(body));
        req.on("error", reject);
    });
}

function json(res, status, data) {
    const body = JSON.stringify(data);
    res.writeHead(status, {
        "Content-Type":                "application/json",
        "Access-Control-Allow-Origin": "*",
        "Content-Length":              Buffer.byteLength(body),
    });
    res.end(body);
}

// ── Servidor HTTP ──────────────────────────────
const server = http.createServer(async (req, res) => {
    // CORS preflight
    if (req.method === "OPTIONS") {
        res.writeHead(204, { "Access-Control-Allow-Origin": "*",
                             "Access-Control-Allow-Methods": "GET,POST",
                             "Access-Control-Allow-Headers": "Content-Type" });
        return res.end();
    }

    const url = req.url.split("?")[0];

    // ── GET /messages?after=<id>&game=<gameId> ──
    if (req.method === "GET" && url === "/messages") {
        cleanOld();
        const params = new URLSearchParams(req.url.split("?")[1] || "");
        const after  = parseInt(params.get("after") || "0");
        const game   = params.get("game") || null;  // null = todos los juegos

        const filtered = messages.filter(m =>
            m.id > after && (game === null || m.game === game || game === "ALL")
        );
        return json(res, 200, { msgs: filtered, lastId: msgIdSeq });
    }

    // ── POST /send ──────────────────────────────
    if (req.method === "POST" && url === "/send") {
        let body;
        try { body = JSON.parse(await readBody(req)); }
        catch { return json(res, 400, { error: "JSON inválido" }); }

        const { userId, display, text, rank, quoteName, quoteText, uid, game } = body;

        if (!userId || !display || !text)
            return json(res, 400, { error: "Faltan campos: userId, display, text" });

        if (typeof text !== "string" || text.length > 200)
            return json(res, 400, { error: "Texto inválido (máx 200 chars)" });

        if (isRateLimited(userId))
            return json(res, 429, { error: "Rate limit: demasiados mensajes" });

        cleanOld();
        msgIdSeq++;
        const msg = {
            id:         msgIdSeq,
            ts:         now(),
            sender:     String(userId),
            display:    String(display).slice(0, 50),
            text:       String(text),
            rank:       rank    || null,
            quoteName:  quoteName  || null,
            quoteText:  quoteText  || null,
            uid:        uid     || null,
            game:       game    || "ALL",
        };
        messages.push(msg);
        return json(res, 200, { ok: true, id: msgIdSeq });
    }

    // ── POST /cmd  (ban/mute/clear sincronizados) ─
    if (req.method === "POST" && url === "/cmd") {
        let body;
        try { body = JSON.parse(await readBody(req)); }
        catch { return json(res, 400, { error: "JSON inválido" }); }

        // Guardamos el comando como mensaje especial
        msgIdSeq++;
        messages.push({
            id:     msgIdSeq,
            ts:     now(),
            sender: "__CMD__",
            display:"__CMD__",
            text:   body.cmd || "",
            rank:   null,
            game:   body.game || "ALL",
        });
        return json(res, 200, { ok: true });
    }

    // ── GET /ping ───────────────────────────────
    if (req.method === "GET" && url === "/ping")
        return json(res, 200, { ok: true, msgs: messages.length });

    json(res, 404, { error: "Ruta no encontrada" });
});

server.listen(PORT, () => {
    console.log(`[NexoChat] Servidor corriendo en puerto ${PORT}`);
});
