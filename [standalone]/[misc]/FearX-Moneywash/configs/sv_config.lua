ServerConfig = {}

ServerConfig.Discord = {
    enabled = false,
    webhook = '',
    username = 'FearX Moneywash',
    avatar = '',
    color = 0xE74C3C,
    events = {
        deposit = true,
        withdraw = true,
        policeAlert = true,
        refund = true,
        suspicious = true,
        cancel = true,
    },
    highValueThreshold = 100000,
    suspiciousWashesPerHour = 3,
    rolePingId = '',
}
