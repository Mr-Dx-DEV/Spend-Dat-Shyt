local menu = {}

local menuSystems = {
    "wasabi_uikit",
    "lation_ui",
    "ox_lib",
}

local menuSystem = "ox_lib"

function menu.init()
    for _, resourceName in ipairs(menuSystems) do
        if GetResourceState(resourceName):find('start') then
            lib.print.debug('[menu] Using menu system:', resourceName)
            menuSystem = resourceName
            break
        end
    end
end

function menu.openContext(data)
    if menuSystem == "wasabi_uikit" then
        local uiKitData = {
            id = data.id,
            title = data.title,
            enableWalk = false,
            options = data.options
        }

        exports.wasabi_uikit:RegisterContextMenu(uiKitData)
        exports.wasabi_uikit:OpenContextMenu(uiKitData)
    elseif menuSystem == "lation_ui" then
        exports.lation_ui:registerMenu(data)
        exports.lation_ui:showMenu(data.id)
    else
        lib.registerContext(data)
        lib.showContext(data.id)
    end
end

Modules.register("menu", menu)
