-- ═══════════════════════════════════════════════════════════
-- NEX Hotels — Localization
-- ═══════════════════════════════════════════════════════════
-- Loads locales/<Config.Locale>.json and exposes a global L(key, ...) used
-- across the server and client. English (en) is always loaded as the fallback,
-- so any key a translation forgets still resolves to readable text — and if the
-- requested file is missing entirely we fall back to English wholesale.
--
-- Add a language by dropping locales/<code>.json next to en.json and pointing
-- Config.Locale at its code. Runs as a shared_script so both sides share L().
-- ═══════════════════════════════════════════════════════════

local active   = {}
local fallback = {}

local function loadLocale(code)
    if not code or code == '' then return nil end
    local raw = LoadResourceFile(GetCurrentResourceName(), ('locales/%s.json'):format(code))
    if not raw or raw == '' then return nil end
    local ok, decoded = pcall(json.decode, raw)
    if not ok or type(decoded) ~= 'table' then return nil end
    return decoded
end

fallback = loadLocale('en') or {}

local requested = (Config and Config.Locale) or 'en'
active = loadLocale(requested)
if not active then
    if requested ~= 'en' then
        print(("^3[nex_hotels]^7 Locale '%s' not found in locales/ — falling back to 'en'.^0"):format(tostring(requested)))
    end
    active = fallback
end

-- Resolve a dot-separated key ("notify.room_taken") against a decoded table.
local function lookup(tbl, key)
    local node = tbl
    for part in string.gmatch(key, '[^.]+') do
        if type(node) ~= 'table' then return nil end
        node = node[part]
    end
    return node
end

--- Global translation accessor.
---   L("notify.room_taken")            → "That room is currently rented."
---   L("notify.extend_success", 3, 90) → "Extended by 3 day(s) — $90."  (string.format on extra args)
--- Missing keys fall back to English, then to the key string itself, so nothing
--- ever renders as nil.
function L(key, ...)
    local val = lookup(active, key)
    if val == nil then val = lookup(fallback, key) end
    if val == nil then return key end
    if type(val) == 'string' and select('#', ...) > 0 then
        local ok, formatted = pcall(string.format, val, ...)
        if ok then return formatted end
    end
    return val
end

--- The merged `ui` block (active over English) the NUI renders its own text from.
--- Shallow-merged one level deep so a translation that omits a key still shows
--- the English string for it. Sent to the React app via the `setLocale` message.
function LocaleUI()
    local enUi = type(fallback.ui) == 'table' and fallback.ui or {}
    local acUi = type(active.ui)   == 'table' and active.ui   or {}
    local out = {}
    for k, v in pairs(enUi) do out[k] = v end
    for k, v in pairs(acUi) do out[k] = v end
    return { language = active.language or fallback.language or 'English', ui = out }
end
