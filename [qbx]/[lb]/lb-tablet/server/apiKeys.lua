-- Set your API keys for uploading media here.
-- Please note that the API key needs to match the correct upload method defined in Config.UploadMethod.
-- The default and recommended upload method is Fivemanage
-- Use code "LBPHONE25" for 25% off - forever
-- You can get your API keys from https://refer.fivemanage.com/lb
-- Affiliate link - purchases made through this link will give us a commission at no extra cost to you
-- A video tutorial for how to set up Fivemanage can be found here: https://www.youtube.com/watch?v=y3bCaHS6Moc
API_KEYS = {
    Video = "nZzvFNiv00eSNdrtNoDNvpH30LBBjO0q",
    Image = "nZzvFNiv00eSNdrtNoDNvpH30LBBjO0q",
    Audio = "nZzvFNiv00eSNdrtNoDNvpH30LBBjO0q",
}

-- Discord webhook or API key for server logs
-- We recommend Fivemanage for logs
-- Use code "LBPHONE25" at https://refer.fivemanage.com/lb for 25% off forever
-- Affiliate link - purchases made through this link will give us a commission at no extra cost to you
LOG_WEBHOOKS = {
    Default = "https://discord.com/api/webhooks/", -- set to false to disable
    Police = "https://discord.com/api/webhooks/",
    Ambulance = "https://discord.com/api/webhooks/",
    Dispatch = "https://discord.com/api/webhooks/"
}

DISCORD_TOKEN = nil -- you can set a discord bot token here to get the players discord avatar for logs

-- Here you can set your credentials for Config.DynamicWebRTC
-- You can get your credentials from https://dash.cloudflare.com/?to=/:account/realtime/turn/overview
WEBRTC = {
    TokenID = nil,
    APIToken = nil,
}
