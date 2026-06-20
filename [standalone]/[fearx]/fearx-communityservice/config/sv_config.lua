SvConfig = {}

SvConfig.AdminIdentifiers = {

}

SvConfig.Discord = {
    enabled = true,
    botToken = 'DISCORD_BOT_TOKEN_HERE',
    guildId = 'GUILD_ID_HERE',
    adminRoleIds = {
        'ROLE_ID_HERE',
        'ROLE_ID_HERE'
    },
    apiUrl = 'https://discord.com/api/v10'
}

SvConfig.Webhooks = {
    enabled = true,
    urls = {
        punish = 'YOUR_WEBHOOK_URL_HERE',
        release = 'YOUR_WEBHOOK_URL_HERE',
        edit = 'YOUR_WEBHOOK_URL_HERE',
        complete = 'YOUR_WEBHOOK_URL_HERE',
        escape = 'YOUR_WEBHOOK_URL_HERE'
    },
    botName = 'Community Service Logs',
    botAvatar = 'https://i.imgur.com/YourAvatarURL.png',
    colors = {
        punish = 15158332,
        release = 3066993,
        edit = 3447003,
        complete = 10181046,
        escape = 15105570
    }
}
