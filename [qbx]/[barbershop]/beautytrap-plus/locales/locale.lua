--[[
    ============================================
    BEAUTYTRAP-PLUS LOCALIZATION SYSTEM
    ============================================
    
    How to use:
    1. Set your language in config.lua: Config.Locale = 'en'
    2. Available languages: 'en', 'es', 'fr', 'de', 'pt', 'zh', 'ja'
    3. Use _L("Key") in your code to get translated text
    4. Use _L("Key", var1, var2) for dynamic text with variables
    
    Example:
    _L("Basket.NeedBasket") returns "You need to grab a basket first!"
    _L("Trap.SaleSuccess", 2, "Lipstick", 50) returns "Sold 2x Lipstick for $50"
]]--

Locales = Locales or {}

-- Helper function to get localized text
function _L(key, ...)
    local locale = Config.Locale or 'en'
    local lang = Locales[locale] or Locales['en']
    
    if not lang then
        print("^1[BEAUTYTRAP] ERROR: No locale found for '" .. locale .. "' or fallback 'en'^7")
        return key
    end
    
    local text = lang[key]
    
    -- Fallback to English if key not found in selected language
    if not text and locale ~= 'en' then
        text = Locales['en'] and Locales['en'][key]
    end
    
    -- If still not found, return the key itself
    if not text then
        if Config.Debug then
            print("^3[BEAUTYTRAP] WARNING: Missing locale key '" .. key .. "'^7")
        end
        return key
    end
    
    -- If arguments provided, format the string
    local args = {...}
    if #args > 0 then
        local success, result = pcall(string.format, text, ...)
        if success then
            return result
        else
            print("^1[BEAUTYTRAP] ERROR: Failed to format locale key '" .. key .. "'^7")
            return text
        end
    end
    
    return text
end

-- Export the function globally
_G._L = _L