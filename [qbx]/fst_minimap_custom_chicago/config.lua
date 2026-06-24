config = {}
config.scaleform_minimap_main_map = "minimap_main_map"
config.scaleform_minimap = "minimap"
config.offset = 0.1

config.remove_blur = true
config.radar_masks = "radar_masks"

-- Minimap options
config.options = {
    zoom_level = 1100,
    enable_map_zoom_levels = true,
    using_affected_hud = false,
}

-- HUD Color Customization
-- To change colors: modify the RGBA values below and restart the resource
-- RGB values range from 0-255, Alpha ranges from 0-255 (0 = transparent, 255 = opaque)
config.hud_customization = {
    enabled = true,
    colors = {
        line = { red = 255, green = 20, blue = 147, alpha = 255 },      -- Minimap border line
        background = { red = 139, green = 32, blue = 82, alpha = 170 }, -- Minimap background
        pause_bg = { red = 139, green = 32, blue = 82, alpha = 170 },   -- Pause menu background overlay
        waypoint = { red = 255, green = 20, blue = 147, alpha = 255 },  -- gps point Neon pink
    }
}

config.tiles = {
    -- ['1'] = {
    --     txd = "logo",
    --     txn = "logo",
    --     x_offset = 0,
    --     y_offset = 2,
    --     x_scale = 1.0,
    --     y_scale = 1.0,
    --     rotation = 0.0,
    --     alpha = 100,
    --     centered = false,
    --     visible = true
    -- },
}
