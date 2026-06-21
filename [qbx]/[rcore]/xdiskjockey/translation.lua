Locales = {}

--- this is for translation
--- @param str string
--- @param ... parameters
function _U(str, ...)
    if type(Locales) ~= "table" then
        return string.format("[%s] the locales is wrong type, it is not a table..", GetCurrentResourceName())
    end
    if not Locales[Config.Locale] then
        return string.format("[%s] The language does not exists: %s", GetCurrentResourceName(), Config.Locale)
    end
    if not Locales[Config.Locale][str] then
        print(("You're missing this translation in: %s the key is called: %s"):format(Config.Locale, str))
        return string.format(Locales["en"][str], ...)
    end
    return string.format(Locales[Config.Locale][str], ...)
end