---@class functions
---@field GetDiscordRoles fun(self, source: any): boolean

---@class discord
---@field api nil|functions
discord = {
    api = nil,
}

function discord.hasRole(source)
    if not Configuration.DiscordRole.Enabled then
        return false
    end

    local roles <const> = discord.api:GetDiscordRoles(source)

    for i = 1, #roles do
        if roles[i] == Configuration.DiscordRole.RoleID then
            return true
        end
    end

    return false
end

function discord.sendLog(hook, title, description, color, fields)
    local webhookURL = Logs[hook]

    if not webhookURL or webhookURL == "" then
        return print("💳  ^3spoodyFraudV3^0 ^1ERROR^0 -> Discord logging webhook not configured!^0")
    end

    local embed = {{
        ["title"] = title,
        ["description"] = description,
        ["color"] = (color or 3447003),
        ["fields"] = fields or {},
        ["footer"] = {["text"] = "spoodyFraud • " .. os.date("%Y-%m-%d %H:%M:%S")},
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}

    local payload = json.encode({
        username = "spoodyFraud Logs",
        avatar_url = "https://dunb17ur4ymx4.cloudfront.net/webstore/logos/c7c1c00f55367971310c0e2afd6aecb0af5e94bb.png",
        embeds = embed
    })

    PerformHttpRequest(webhookURL, function(statusCode)
        if statusCode ~= 204 and statusCode ~= 200 then
            print(('💳  ^3spoodyFraudV3^0 ^1ERROR^0 -> Discord webhook failed! Status: ^3%s^0'):format(tostring(statusCode)))
        end
    end, 'POST', payload, {['Content-Type'] = 'application/json'})
end

CreateThread(function()
    if Configuration.DiscordRole.Enabled then
        if GetResourceState(Configuration.DiscordRole.Resource) == 'started' then
            discord.api = exports[Configuration.DiscordRole.Resource]
        else
            return error("Your Discord API resource could not be found, please make sure it exists, or spoodyFraud is started AFTER the API resource.")
        end
    end
end)