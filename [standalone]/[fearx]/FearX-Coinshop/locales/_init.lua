Locales = Locales or {}

function T(key, ...)
    local lang = Config.Locale or 'en'
    local locale = Locales[lang] or Locales['en'] or {}
    local str = locale[key]
    if not str then
        local fallback = Locales['en'] or {}
        str = fallback[key] or key
    end
    if select('#', ...) > 0 then
        local ok, result = pcall(string.format, str, ...)
        if ok then return result end
    end
    return str
end
