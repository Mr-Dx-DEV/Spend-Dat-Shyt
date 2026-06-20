
-- ######################### --
-- ## DISCORD.GG/CODEWAVE ## --
-- ######################### --

-- ─── Webhook Configuration ───────────────────────────────────────────────────
--
-- Set each URL to your Discord channel webhook.
-- Leave as empty string "" to disable that webhook entirely.

local Webhooks = {
    Sales    = "",   -- fires on every successful NPC sale
    Crafting = "",   -- fires when a craft completes and item is delivered
    Cheating = "",   -- fires on cheat detection (selling without starting process)
}

-- Bot appearance in Discord
local BotName   = "CW Sneakers | Anti-Cheat" -- Recommended to keep the name.
local BotAvatar = "https://i.imgur.com/yourlogo.png"  -- replace with your own image URL




---- #### DO NOT EDIT ANYTHING BELOW, UNLESS YOU KNOW WHAT YOU'RE DOING! #### ----










-- ─── Identifier collector ────────────────────────────────────────────────────

local function getAllIdentifiers(src)
    local ids = {
        steam   = "N/A",
        license = "N/A",
        discord = "N/A",
        live    = "N/A",
        xbl     = "N/A",
        ip      = "N/A",
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if id then
            if     id:sub(1, 6)  == "steam:"   then ids.steam   = id
            elseif id:sub(1, 8)  == "license:" then ids.license = id
            elseif id:sub(1, 8)  == "discord:" then ids.discord = id
            elseif id:sub(1, 5)  == "live:"    then ids.live    = id
            elseif id:sub(1, 4)  == "xbl:"     then ids.xbl     = id
            elseif id:sub(1, 3)  == "ip:"      then ids.ip      = id
            end
        end
    end

    return ids
end

-- ─── Core send function ──────────────────────────────────────────────────────

local function sendWebhook(url, payload)
    if not url or url == "" then return end

    PerformHttpRequest(url, function(statusCode)
        if Config.DebugMode then
            print(('[CWSneakers] Webhook sent — status: %d'):format(statusCode))
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end

-- ─── Embed builder ───────────────────────────────────────────────────────────

local function buildEmbed(colour, title, fields)
    return {
        username   = BotName,
        avatar_url = BotAvatar,
        embeds = {
            {
                title     = title,
                color     = colour,
                fields    = fields,
                footer    = { text = os.date("📅 %Y-%m-%d  🕐 %H:%M:%S UTC") },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            }
        }
    }
end

local function buildIdentifierFields(src, ids)
    return {
        { name = "💬  Steam Name",  value = GetPlayerName(src) or "N/A",   inline = true  },
        { name = "🆔  Steam",       value = "`" .. ids.steam   .. "`",     inline = false },
        { name = "🔑  License",     value = "`" .. ids.license .. "`",     inline = true  },
        { name = "💬  Discord",     value = "`" .. ids.discord .. "`",     inline = true  },
        { name = "🎮  Live",        value = "`" .. ids.live    .. "`",     inline = true  },
        { name = "🕹️  XBL",        value = "`" .. ids.xbl     .. "`",     inline = true  },
        { name = "🌐  IP",          value = "`" .. ids.ip      .. "`",     inline = true  },
    }
end

-- ─── Public webhook triggers ─────────────────────────────────────────────────

function CWSneakers_WebhookSale(src, itemName, sellCount, totalPrice, xpEarned, currentLevel)
    if Webhooks.Sales == "" then return end

    local ids    = getAllIdentifiers(src)
    local fields = buildIdentifierFields(src, ids)

    fields[#fields + 1] = { name = "─────────────────", value = "**Sale Details**",          inline = false }
    fields[#fields + 1] = { name = "📦  Item",          value = itemName,                    inline = true  }
    fields[#fields + 1] = { name = "🔢  Quantity Sold", value = tostring(sellCount),         inline = true  }
    fields[#fields + 1] = { name = "💰  Payout",        value = ("$%s"):format(totalPrice),  inline = true  }
    fields[#fields + 1] = { name = "⭐  XP Earned",     value = tostring(xpEarned),          inline = true  }
    fields[#fields + 1] = { name = "📈  Player Level",  value = tostring(currentLevel),      inline = true  }

    sendWebhook(Webhooks.Sales, buildEmbed(3066993, "💸  Sneaker Sale", fields))
end

function CWSneakers_WebhookCraft(src, recipeName, yieldQuantity)
    if Webhooks.Crafting == "" then return end

    local ids    = getAllIdentifiers(src)
    local fields = buildIdentifierFields(src, ids)

    fields[#fields + 1] = { name = "─────────────────", value = "**Craft Details**",     inline = false }
    fields[#fields + 1] = { name = "🔨  Recipe",        value = recipeName,              inline = true  }
    fields[#fields + 1] = { name = "📦  Yield",         value = tostring(yieldQuantity), inline = true  }

    sendWebhook(Webhooks.Crafting, buildEmbed(3447003, "🔨  Sneaker Craft", fields))
end

function CWSneakers_WebhookCheat(src, reason)
    if Webhooks.Cheating == "" then return end

    local ids    = getAllIdentifiers(src)
    local fields = buildIdentifierFields(src, ids)

    fields[#fields + 1] = { name = "─────────────────", value = "**Detection Details**", inline = false }
    fields[#fields + 1] = { name = "🚨  Reason",        value = reason,                  inline = false }

    sendWebhook(Webhooks.Cheating, buildEmbed(15158332, "🚨  Cheat Detected", fields))
end