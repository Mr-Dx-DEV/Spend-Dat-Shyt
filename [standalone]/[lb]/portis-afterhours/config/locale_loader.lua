local lang = Config.Locale or 'en'
local path = ('locales/%s.json'):format(lang)
local res  = 'portis-afterhours'
local raw  = LoadResourceFile(res, path)

if not raw then
    raw = LoadResourceFile(res, 'locales/en.json')
end

Locale = raw and json.decode(raw) or {}

function L(key, params)
    local val = Locale
    for seg in string.gmatch(key, '[^.]+') do
        if val == nil then break end
        val = val[tonumber(seg) or seg]
    end
    if type(val) ~= 'string' then return key end
    if params then
        for k, v in pairs(params) do
            val = string.gsub(val, '{' .. k .. '}', tostring(v))
        end
    end
    return val
end
