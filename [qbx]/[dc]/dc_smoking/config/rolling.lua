Config.Rolling = {
    Animation = {
        Dict = "dc@rollupanim",
        Anim = "rollup_c",
        Duration = 27033 
    },

    -- Ingredients: one block per type of wrap/paper available for rolling.
    -- Players choose a group, and the RollingStages define the visual
    -- sequence that plays during the animation.
    Ingredients = {
        -- 'joint' — rolling with standard rolling papers. Most common type.
        ['joint'] = {
            Label = "Joint Paper",
            Capacity = 2.0,                                -- Grams of weed this wrap can hold.
            -- Items: which inventory items count as this wrap type. Only one here, but you can add more.
            Items = {
                {
                    Name = "dc_rollingpaper",
                    GrabItem = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },   -- Anim played when the paper first appears.
                    -- HoldProp: the prop placed in hand after the grab finishes.
                    HoldProp = {
                        Model = "dc_joint_empty",
                        Bone = 58866,
                        Offset = vector3(0.116, -0.036, 0.008),
                        Rotation = vector3(-125.6, 41.4, 28.1),
                    },
                    HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },   -- Anim played while holding the paper.
                },
            },
            -- RollingStages: scripted prop sequence that plays during the rolling animation.
            -- Each entry fires at the given `at` ms into the anim.
            --   action = 'spawn'  -> spawn the model at the given bone/offset/rotation
            --   action = 'delete' -> delete the prop that was spawned earlier with this model name
            -- This choreography makes it look like the player is actually assembling the joint.
            RollingStages = {
                { at = 0,    action = 'spawn',  model = 'dc_joint_empty',  bone = 58866, offset = vec3(0.089,-0.076,0.003), rotation = vec3(-163.5,5.7,-36.3) },
                { at = 20, action = 'spawn',  model = 'dc_weednug',           bone = 18905, offset = vec3(0.114,0.046,0.049), rotation = vec3(87.6,30.8,-1.2) },
                { at = 7500, action = 'delete', target = 'dc_weednug' },
                { at = 7501, action = 'delete', target = 'dc_joint_empty' },
                { at = 7510, action = 'spawn',   model = 'dc_jointfilled',  bone = 58866, offset = vec3(0.089,-0.076,0.003), rotation = vec3(-163.5,5.7,-36.3) },
                { at = 11990, action = 'delete', target = 'dc_jointfilled' },
                { at = 12000, action = 'spawn',   model = 'dc_jointfilled',  bone = 57005, offset = vec3(0.167,-0.017,-0.044), rotation = vec3(-169.4,-14.0,34.4) },
                { at = 26900, action = 'delete', target = 'dc_jointfilled' },
                { at = 26905, action = 'spawn',   model = 'dc_joint100',  bone = 57005, offset = vec3(0.180,-0.021,-0.057), rotation = vec3(-13.8,18.2,-152.0) },
                { at = 27000, action = 'delete', target = 'dc_joint100' },
            },
        },
        -- 'leaf' — rolling with natural leaf wraps (fronto, smackaleaf, etc.).
        ['leaf'] = {
            Label = "Leaf",
            Capacity = 3.0,
            Items = {
                {
                    Name = "dc_leaf",
                    GrabItem = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 3000, AttachPropAt = 2000, Flag = 0 },
                    HoldProp = {
                        Model = "dc_leaf_empty",
                        Bone = 58866,
                        Offset = vector3(0.116, -0.036, 0.008),
                        Rotation = vector3(-125.6, 41.4, 28.1),
                    },
                    HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
                },
                {
                    Name = "dc_smackaleaf_s",
                    GrabItem = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 3000, AttachPropAt = 2000, Flag = 0 },
                    HoldProp = {
                        Model = "dc_smackaleaf_s",
                        Bone = 58866,
                        Offset = vector3(0.112,-0.040,0.002),
                        Rotation = vector3(-53.5,48.6,19.2),
                    },
                    HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
                },
                {
                    Name = "dc_frontoleaf_s",
                    GrabItem = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 3000, AttachPropAt = 2000, Flag = 0 },
                    HoldProp = {
                        Model = "dc_frontoleaf_s",
                        Bone = 58866,
                        Offset = vector3(0.112,-0.040,0.002),
                        Rotation = vector3(-53.5,48.6,19.2),
                    },
                    HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
                },
            },
            RollingStages = {
                { at = 0,    action = 'spawn',  model = 'dc_leaf_empty',  bone = 58866, offset = vec3(0.089,-0.076,0.003), rotation = vec3(-163.5,5.7,-36.3) },
                { at = 20, action = 'spawn',  model = 'dc_weednug',           bone = 18905, offset = vec3(0.114,0.046,0.049), rotation = vec3(87.6,30.8,-1.2) },
                { at = 7500, action = 'delete', target = 'dc_weednug' },
                { at = 7501, action = 'delete', target = 'dc_leaf_empty' },
                { at = 7510, action = 'spawn',   model = 'dc_leaf_filled',  bone = 58866, offset = vec3(0.089,-0.076,0.003), rotation = vec3(-163.5,5.7,-36.3) },
                { at = 11990, action = 'delete', target = 'dc_leaf_filled' },
                { at = 12000, action = 'spawn',   model = 'dc_leaf_filled',  bone = 57005, offset = vec3(0.167,-0.017,-0.044), rotation = vec3(-169.4,-14.0,34.4) },
                { at = 26900, action = 'delete', target = 'dc_leaf_filled' },
                { at = 26905, action = 'spawn',   model = 'dc_leaf100',  bone = 57005, offset = vec3(0.180,-0.021,-0.057), rotation = vec3(-13.8,18.2,-152.0) },
                { at = 27000, action = 'delete', target = 'dc_leaf100' },
            },
        },
        -- 'blunt' — rolling with tobacco-leaf blunt wraps.
        ['blunt'] = {
            Label = "Blunt Wrap",
            Capacity = 2.0,
            Items = {
                {
                    Name = "dc_blunt",
                    GrabItem = { Dict = "dc@pack", Anim = "packgrab_c", Duration = 1500, AttachPropAt = 800, Flag = 0 },
                    HoldProp = {
                        Model = "dc_bluntempty",
                        Bone = 58866,
                        Offset = vector3(0.116, -0.036, 0.008),
                        Rotation = vector3(-125.6, 41.4, 28.1),
                    },
                    HoldAnim = { Dict = "dc@handsmoke", Anim = "handsmokehold_c", Flag = 49 },
                },
            },
            RollingStages = {
                { at = 0,    action = 'spawn',  model = 'dc_bluntempty',  bone = 58866, offset = vec3(0.089,-0.076,0.003), rotation = vec3(-163.5,5.7,-36.3) },
                { at = 20, action = 'spawn',  model = 'dc_weednug',           bone = 18905, offset = vec3(0.114,0.046,0.049), rotation = vec3(87.6,30.8,-1.2) },
                { at = 7500, action = 'delete', target = 'dc_weednug' },
                { at = 7501, action = 'delete', target = 'dc_bluntempty' },
                { at = 7510, action = 'spawn',   model = 'dc_bluntfilled',  bone = 58866, offset = vec3(0.089,-0.076,0.003), rotation = vec3(-163.5,5.7,-36.3) },
                { at = 11990, action = 'delete', target = 'dc_bluntfilled' },
                { at = 12000, action = 'spawn',   model = 'dc_bluntfilled',  bone = 57005, offset = vec3(0.167,-0.017,-0.044), rotation = vec3(-169.4,-14.0,34.4) },
                { at = 26900, action = 'delete', target = 'dc_bluntfilled' },
                { at = 26905, action = 'spawn',   model = 'dc_blunt100',  bone = 57005, offset = vec3(0.180,-0.021,-0.057), rotation = vec3(-13.8,18.2,-152.0) },
                { at = 27000, action = 'delete', target = 'dc_blunt100' },
            },
        },
    }
}

-- Don't Touch: auto-registers any wrap items listed above as "wrapper" components so the mixing engine knows about them.
if Config.Components and Config.Rolling and Config.Rolling.Ingredients then
    for category, ingredient in pairs(Config.Rolling.Ingredients) do
        for _, item in ipairs(ingredient.Items) do
            local existing = Config.Components[item.Name]
            if existing and existing.CanWrap then
                existing.Capacity = ingredient.Capacity
            elseif not existing then
                Config.Components[item.Name] = {
                    Role = 'wrapper',
                    Label = ingredient.Label,
                    Capacity = ingredient.Capacity,
                    OutputCategory = category,
                }
            else
                existing.Capacity = ingredient.Capacity
            end
        end
    end
end