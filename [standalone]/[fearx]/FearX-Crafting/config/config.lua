FearXCrafting = FearXCrafting or {}

FearXCrafting.Language = 'en'

function FearXCrafting.Debug(...)
    if FearXCrafting.Config and FearXCrafting.Config.Get then
        local settings = FearXCrafting.Config.Get('settings')
        if settings and settings.debug then
            print('^3[FearX-Crafting DEBUG]^7', ...)
        end
    end
end

-- Set your item images path here. This is the folder/URL where your inventory item images are stored.
-- Examples:
--   'nui://ox_inventory/web/images/'       (ox_inventory default)
--   'nui://qs-inventory/html/images/'      (qs-inventory)
--   'nui://codem-inventory/html/img/'      (codem-inventory)
--   'https://your-cdn.com/images/'         (custom web URL)
FearXCrafting.ItemImagePath = 'nui://ox_inventory/web/images/'

FearXCrafting.Defaults = {
    debug = false,
    inventory = 'ox_inventory',
    commands = {
        creator = 'craftingcreator',
        creatorAlias = 'cc'
    }
}

if not IsDuplicityVersion() then
    FearXCrafting.ClientConfig = nil

    RegisterNetEvent('fearx-crafting:client:receiveConfig', function(config)
        FearXCrafting.ClientConfig = config
        FearXCrafting.Debug('Client config received')
    end)

    function FearXCrafting.GetConfig(path)
        if not FearXCrafting.ClientConfig then return nil end

        if not path then return FearXCrafting.ClientConfig end

        local keys = {}
        for key in string.gmatch(path, "[^.]+") do
            table.insert(keys, key)
        end

        local current = FearXCrafting.ClientConfig
        for _, key in ipairs(keys) do
            if type(current) == 'table' and current[key] ~= nil then
                current = current[key]
            else
                return nil
            end
        end

        return current
    end

    CreateThread(function()
        Wait(500)
        TriggerServerEvent('fearx-crafting:server:requestConfig')
    end)
end
