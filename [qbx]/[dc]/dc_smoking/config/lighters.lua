Config.Lighters = {
    -- ItemGroups: a way to share the same settings across many lighters at
    -- once. Every lighter listed inside one group uses the same FluidDecay
    -- and Particle settings below. Add more groups if you want different
    -- lighter types with different flame effects or fluid usage.
    ItemGroups = {
        {
            -- ItemInfo: the list of actual inventory items in this group.
            --   Name  = the item name in your inventory database
            --   Prop  = the 3D model that attaches to the player's hand
            --   Label = the name shown to the player in menus
            ItemInfo = {
                { Name = 'dc_lighterblack', Prop = 'dc_lighterblack', Label = 'Black Lighter' },
                { Name = 'dc_lighterblue', Prop = 'dc_lighterblue', Label = 'Blue Lighter' },
                { Name = 'dc_lightergreen', Prop = 'dc_lightergreen', Label = 'Green Lighter' },
                { Name = 'dc_lighterlightblue', Prop = 'dc_lighterlightblue', Label = 'Light Blue Lighter' },
                { Name = 'dc_lighterpink', Prop = 'dc_lighterpink', Label = 'Pink Lighter' },
                { Name = 'dc_lighterpurple', Prop = 'dc_lighterpurple', Label = 'Purple Lighter' },
                { Name = 'dc_lighterred', Prop = 'dc_lighterred', Label = 'Red Lighter' },
                { Name = 'dc_lighterwhite', Prop = 'dc_lighterwhite', Label = 'White Lighter' },
                { Name = 'dc_lighteryellow', Prop = 'dc_lighteryellow', Label = 'Yellow Lighter' },
            },
            FluidDecay = 1.0,   -- Extra fluid lost per second while the flame is active. Higher = drains faster.
            -- Particle: the flame visual that plays on the lighter tip.
            --   dict/name = which built-in game particle to use (don't change unless you know what you're doing)
            --   scale     = how big the flame looks
            --   offset    = fine-tune the flame position on the lighter model (x, y, z)
            --   rot       = flame rotation in degrees
            Particle = { dict = "core", name = "ent_amb_candle_flame", scale = 0.3, offset = vector3(0.008, 0.000, 0.048), rot = vector3(0.0, 0.0, 0.0) },
        },
    },
    Items = {} -- Don't Touch (auto-filled from ItemGroups above)
}
ExpandItemGroups(Config.Lighters)

Config.Lighters.StartFluid = 100                     -- Fluid amount a brand-new lighter starts with (0-100). Leave at 100 unless you want lighters to spawn partially empty.
Config.Lighters.FluidPerUse = { Min = 3, Max = 5 }   -- Fluid drained each time the player lights something. A random number between Min and Max is picked per use.