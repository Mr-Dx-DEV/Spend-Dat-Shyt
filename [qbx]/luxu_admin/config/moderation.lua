---@class BanInfo
---@field id number
---@field player_name string
---@field player_id string
---@field staff_id number?
---@field staff_name string?
---@field reason string
---@field identifiers string[]
---@field tokens string[]
---@field created_at number
---@field expires_at number



--- Runs when the player connecting is banned
---@param name string
---@param setKickReason function
---@param deferrals table
---@param source number
---@param checkBan fun(source:number):BanInfo?
local function playerConnecting(name, setKickReason, deferrals, source, checkBan)
    local license2 = GetPlayerIdentifierByType(source, 'license2') or GetPlayerIdentifierByType(source, 'license')

    if not license2 then
        deferrals.done("Missing license or license")
        return
    end

    deferrals.update("Checking if you are banned...")

    local banInfo = checkBan(source)

    if not banInfo then
        Wait(0)
        deferrals.done()
        return
    end

    local createdAt = os.date("%Y-%m-%d %H:%M", math.floor(banInfo.created_at / 1000))
    local expiresAt = os.date("%Y-%m-%d %H:%M", math.floor(banInfo.expires_at / 1000))

    local banMessage = ([[

    You Are Banned!
    Created at: %s
    Expires at: %s
    Reason: %s
    Banned by: %s]]):format(
        createdAt,
        expiresAt,
        banInfo.reason,
        banInfo.staff_name or "Unknown"
    )

    Wait(0)
    deferrals.done(banMessage)
end

--- Used for generating the discord embed for the ban
--- data: BanInfo
---@param data BanInfo
---@param discordId string?
---@param staffName string?
---@return table
local function formatDiscordId(discordId)
    if not discordId or discordId == '' then
        return 'N/A'
    end

    if Config.logs and Config.logs.tag_discord_user == false then
        return discordId
    end

    return ("<@%s>"):format(discordId)
end

local function playerBannedEmbed(data, discordId, staffName)
    return {
        {

            title = Locales.new_ban,
            color = 15548997,
            fields = {
                {
                    name = Locales.player,
                    value = data.player_name,
                },
                {
                    name = 'Discord ID',
                    value = formatDiscordId(discordId),
                    inline = true,
                },
                {
                    name = 'license',
                    value = data.player_id,
                },
                {
                    name = Locales.reason,
                    value = data.reason,
                },
                {
                    name = Locales.expires,
                    value = os.date("%Y-%m-%d %H:%M", math.floor(data.expires_at / 1000)),
                },
                {
                    name = Locales.author,
                    value = staffName or 'system',
                },
            }

        }
    }
end

---@param data {playerName:string, uniqueId:string, discordId:string, reason:string, staffName:string, staffId:number?}
local function playerWarningEmbed(data)
    return {
        {
            title = Locales.new_warning,
            color = 16705372,
            fields = {
                {
                    name = Locales.player,
                    value = data.playerName,
                },
                {
                    name = 'Discord ID',
                    value = formatDiscordId(data.discordId),
                },
                {
                    name = 'license',
                    value = "license2:" .. data.uniqueId,
                    inline = true,
                },
                {
                    name = Locales.reason,
                    value = data.reason,
                },
                {
                    name = Locales.author,
                    value = data.staffName,
                },
            }
        },
    }
end

exports("playerConnecting", playerConnecting)
exports("playerBannedEmbed", playerBannedEmbed)
exports("playerWarningEmbed", playerWarningEmbed)
