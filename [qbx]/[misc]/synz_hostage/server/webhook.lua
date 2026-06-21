-- ============================================================
-- server/webhook.lua — Logs ALL NPC interactions
-- ============================================================

local function wbLog(fmt, ...)
    if Config.Debug then
        print(("[synz_hostage][webhook] " .. fmt):format(...))
    end
end

local function hasWebhook()
    return Config and Config.Webhook and Config.Webhook.url and Config.Webhook.url ~= ""
end

local function sendWebhook(title, description, color)
    if not hasWebhook() then return end

    local cfg = Config.Webhook
    local fullTitle = title
    if cfg.serverTag and cfg.serverTag ~= "" then
        fullTitle = ("[%s] %s"):format(cfg.serverTag, title)
    end

    local embed = {
        title       = fullTitle,
        description = description,
        color       = color or 5814783,
        footer      = { text = "synz_hostage" },
        timestamp   = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    }

    local payload = json.encode({
        username   = cfg.username or "synz_hostage",
        avatar_url = (cfg.avatar and cfg.avatar ~= "") and cfg.avatar or nil,
        embeds     = { embed },
    })

    PerformHttpRequest(cfg.url, function(err, text, headers)
        if err ~= 200 and err ~= 204 then
            wbLog("Discord error %s: %s", tostring(err), tostring(text))
        end
    end, "POST", payload, { ["Content-Type"] = "application/json" })
end

-- =====================
-- Interaction type config: emoji, label, color per action
-- =====================
local InteractionMeta = {
    surrender    = { emoji = ":raised_hands:",     label = "NPC Surrendered",     color = 16776960 }, -- yellow
    kneel        = { emoji = ":person_kneeling:",  label = "NPC Ordered to Kneel",color = 16744448 }, -- orange
    give_money   = { emoji = ":money_with_wings:", label = "NPC Robbed (Drop)",   color = 3066993  }, -- green
    follow       = { emoji = ":footprints:",       label = "NPC Following",       color = 3447003  }, -- blue
    hostage_take = { emoji = ":chains:",           label = "NPC Taken Hostage",   color = 15158332 }, -- red
    hostage_release = { emoji = ":dove:",          label = "Hostage Released",    color = 10070709 }, -- light purple
    hostage_kill = { emoji = ":skull:",            label = "Hostage Executed",    color = 10038562 }, -- dark red
    leave        = { emoji = ":wave:",             label = "NPC Released",        color = 8421504  }, -- gray
    loot_pickup  = { emoji = ":package:",          label = "Loot Picked Up",      color = 5025616  }, -- teal
}

-- =====================
-- Generic interaction log (called for every action)
-- =====================
function SynzLogInteraction(src, action, extraInfo)
    if not hasWebhook() then return end
    if not src then return end

    local meta = InteractionMeta[action] or { emoji = ":question:", label = action or "Unknown", color = 5814783 }
    local name = GetPlayerName(src) or ("ID " .. tostring(src))
    local ped  = GetPlayerPed(src)
    local coords = (ped and ped ~= 0) and GetEntityCoords(ped) or nil

    local lines = {}
    table.insert(lines, meta.emoji .. " **" .. meta.label .. "**")
    table.insert(lines, "")
    table.insert(lines, (":bust_in_silhouette: **Player:** %s (ID %d)"):format(name, src))
    if coords then
        table.insert(lines, (":round_pushpin: **Location:** `%.1f, %.1f, %.1f`"):format(coords.x, coords.y, coords.z))
    end
    if extraInfo and extraInfo ~= "" then
        table.insert(lines, "")
        table.insert(lines, extraInfo)
    end

    sendWebhook("NPC Interaction", table.concat(lines, "\n"), meta.color)
end

-- =====================
-- Loot-specific log (keeps backward compat with Bridge.Server.GiveLoot)
-- =====================
local function summarizeLootForLog(loot)
    if not loot then return "No loot" end
    local parts = {}
    if loot.cash and loot.cash > 0 then
        table.insert(parts, ("**Cash:** $%d"):format(loot.cash))
    end
    if loot.black and loot.black > 0 then
        table.insert(parts, ("**Black Money:** $%d"):format(loot.black))
    end
    if loot.items and #loot.items > 0 then
        local itemParts = {}
        for _, it in ipairs(loot.items) do
            table.insert(itemParts, ("%s x%d"):format(it.name or "?", it.amount or 1))
        end
        table.insert(parts, "**Items:** " .. table.concat(itemParts, ", "))
    end
    if #parts == 0 then return "Empty package" end
    return table.concat(parts, "\n")
end

function NpcRobberyLogLoot(src, loot)
    if not hasWebhook() then return end
    if not src or not loot then return end
    SynzLogInteraction(src, "loot_pickup", ":package: " .. summarizeLootForLog(loot))
end
