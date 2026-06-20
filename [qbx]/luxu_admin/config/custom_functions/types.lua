---@meta Custom Functions Type Definitions

---@class Addon
---@field name string
---@field label string
---@field icon string
---@field color string
---@field type 'button' | 'offline_button' | 'quick_action' | 'quick_toggle'
---@field options? string[] -- Sub-options displayed in the quick menu (for quick_action and quick_toggle)
---@field handler fun(...): any
---@field permission? string

---@class OfflineAddonTarget
---@field charId string
---@field uniqueId string
---@field name string
---@field identifiers string[]

---@class Zone
---@field id string
---@field points [number, number][]
---@field rgba {r: number, g: number, b: number, a: number}
---@field debug boolean
---@field name string
---@field customHandler string
---@field metadata table
---@field height number

---@alias ZoneHandlerReturn {onEnter: fun(zone: Zone)|nil, onExit: fun(zone: Zone)|nil, inside: fun(zone: Zone)|nil}

--- Registers multiple addon functions in bulk with support for quick menu options.
--- Defined in cl_user_addon.lua; stubs provide type hints when types.lua is loaded standalone.
---@param data Addon[]
function RegisterAddons(data) end

--- Registers statistic block names for the Statistics page.
--- Each name must have a matching RegisterAddonStatisticBlocksCallback on the server.
---@param names string[]
function RegisterAddonStatisticBlocks(names) end

--- Registers a zone handler. The name must be unique and is referenced by zones via their customHandler field.
--- Defined in zones.lua.
---@param name string
---@param handler fun(): ZoneHandlerReturn
function RegisterZoneHandler(name, handler) end
