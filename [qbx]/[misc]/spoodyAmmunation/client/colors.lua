---@meta

--- If you would like to add more blip colors here, you are free to do so!
--- There are over 100+ FiveM blip colors, configuring them all would take too long, so you are free to do it!

--- Converted colors from blip-color IDs to RGB for markers
---@class CColors
---@field getColor fun(self: CColors, id: number): {r:number, g:number, b:number}
---@type table<number, {r:number, g:number, b:number}>
_COLORs = {
    [0]  = { r = 255, g = 255, b = 255 },   -- White
    [1]  = { r = 224, g =  50, b =  50 },   -- Red
    [2]  = { r =   0, g = 255, b =   0 },   -- Green
    [3]  = { r =   0, g =   0, b = 255 },   -- Blue
    [4]  = { r =   0, g =   0, b =   0 },   -- Black
    [5]  = { r = 255, g =   0, b = 255 },   -- Magenta
    [6]  = { r = 255, g = 165, b =   0 },   -- Orange
    [7]  = { r = 238, g = 130, b = 238 },   -- Violet (light purple-ish)
    [8]  = { r = 144, g = 238, b = 144 },   -- Bright green (light green)
    [9]  = { r = 255, g =   0, b =   0 },   -- Bright red (full red)
    [10] = { r = 255, g = 105, b = 180 },   -- Dark pink (hot pink)
    [11] = { r = 255, g = 140, b =   0 },   -- Dark orange (orangered)
    [12] = { r =   0, g = 128, b = 128 },   -- Teal
    [13] = { r =   0, g = 255, b = 255 },   -- Cyan
    [14] = { r = 255, g = 255, b = 224 },   -- Light yellow (ivory)
    [15] = { r =   0, g = 100, b =   0 },   -- Dark green
    [16] = { r = 128, g =   0, b = 128 },   -- Purple
    [17] = { r = 221, g = 160, b = 221 },   -- Light purple (plum)
    [18] = { r = 255, g = 200, b =  50 },   -- Light orange (amber)
    [19] = { r = 255, g = 255, b =   0 },   -- Yellow
}

---@diagnostic disable-next-line: inject-field
function _COLORs:getColor(id)
    return _COLORs[id] or { r = 255, g = 255, b = 255 }
end