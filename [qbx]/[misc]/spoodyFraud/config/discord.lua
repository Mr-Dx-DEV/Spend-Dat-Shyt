--- NOTICE: This file is only loaded on the server side, and cannot be accessed by cheaters/dumpers

Logs = {
    ['Sold'] = '', --- Logs whenever anyone sells any product (Card, Check, SIM)
    ['Shop'] = '', --- Logs whenever anyone purchase anything from the built in shops (Laptop, MSR, etc)
    ['Exploit'] = '', --- Logs whenever anyone is kicked for exploiting (sales / giving items, etc)
}

--- Function that is executed upon an exploiter being kicked
--- If you would like to ban them using your AC, you can do so here.
--- @param source any
--- @param reason string[]
function Logs:onPlayerKick(source, reason)
    --- Anti-cheat ban / admin menu ban, etc
end

DiscordConfig = {
    Enabled = true, --- Enable the auto-posting Discord leaderboard embed?

    --- A Discord BOT token (NOT a webhook)
    --- https://discord.com/developers/applications  ->  Bot  ->  Reset Token
    --- The bot needs to be in your server with "Send Messages" + "Manage Messages" permissions in the target channel.
    BotToken = "",

    --- The channel ID where the leaderboard message lives.
    --- Enable Developer Mode in Discord -> right-click channel -> Copy Channel ID
    ChannelId = "",
    UpdateInterval = 30, --- How often (in MINUTES) the board auto-refreshes.

    --- Re-post the board immediately when someone makes a sale?
    --- (limited internally so it can't exceed the rate limit + optimized.)
    UpdateOnSale = true,

    Embed = {
        Title        = "🏆 Top Scammers Leaderboard",
        Color        = 16744576, --- Decimal color. Default = orange-ish.
        ThumbnailUrl = "", --- Optional image URL shown top-right. Leave "" to hide.
        FooterText   = "Updates every 30 minutes", --- " | Last updated" is appended automatically.
        ShowCount = 10, --- How many players to show in the embed (max 25 — Discord field/length limits).
        ShowEarnings = true, --- Show the $ earned next to each player?
    },
}