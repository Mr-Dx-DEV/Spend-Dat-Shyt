UniqersMarriage = UniqersMarriage or {}

UniqersMarriage.TargetIcon1 = "fas fa-heart" --- you can change target icon https://fontawesome.com/v5/search
UniqersMarriage.TargetIcon2 = "fas fa-heart" --- you can change target icon https://fontawesome.com/v5/search
UniqersMarriage.TargetIcon3 = "fas fa-tshirt" --- you can change target icon https://fontawesome.com/v5/search
UniqersMarriage.TargetIcon4 = "fas fa-signature" --- you can change target icon https://fontawesome.com/v5/search

UniqersMarriage.InteractionMethod = "auto" -- "auto" or "DrawText" or "Target"
UniqersMarriage.targetSystem = "auto" -- "auto" or "ox_target" or "qb-target"

local TargetExports = {
    ['qb-target'] = exports['qb-target'],
    ['ox_target'] = exports.ox_target,
}

UniqersMarriage.Interaction = {
    DrawText = {
        Enable = (UniqersMarriage.InteractionMethod == 'DrawText'),
        Distance = 2.5,
        Show = function(text, key)
            key = key or 'E'
            exports['uniqers-uipack']:drawText(key, text, true, "BACK", "HUD_AMMO_SHOP_SOUNDSET")
        end,
        Press = function()
            exports['uniqers-uipack']:drawTextPress(true, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET")
        end, 
        Hide = function()
            exports['uniqers-uipack']:drawTextClose()
            exports['uniqers-uipack']:resetDrawTextState()
        end
    },
    Target = {
        Enable = (UniqersMarriage.InteractionMethod == 'Target'),


        AddEntity = function(entity, options)
            if not UniqersMarriage.Interaction.Target.Enable then return end
            local targetExport = TargetExports[UniqersMarriage.targetSystem]
            if not targetExport then return end

            if UniqersMarriage.targetSystem == 'qb-target' then
                targetExport:AddTargetEntity(entity, options)

            elseif UniqersMarriage.targetSystem == 'ox_target' then

                local oxOptions = {}
                if options.options then
                    for _, v in ipairs(options.options) do
                        local newOption = {
                            icon = v.icon,
                            label = v.label,
                            onSelect = v.action, 
                            canInteract = v.canInteract,
                            job = v.job,
                            item = v.item,
                            key = v.key,
							distance = v.distance,
							groups = v.groups,
							citizenid = v.citizenid,
                        }
                        table.insert(oxOptions, newOption)
                    end
                end

                targetExport:addLocalEntity(entity, oxOptions)
            end
        end,


        RemoveEntity = function(entity)
            if not UniqersMarriage.Interaction.Target.Enable then return end
            local targetExport = TargetExports[UniqersMarriage.targetSystem]
            if not targetExport then return end

            if UniqersMarriage.targetSystem == 'qb-target' then
                targetExport:RemoveTargetEntity(entity)
            elseif UniqersMarriage.targetSystem == 'ox_target' then
                targetExport:removeLocalEntity(entity)
            end
        end,
        

        AddZone = function(zoneName, coords, size, options)
            if not UniqersMarriage.Interaction.Target.Enable then return end
            
            local targetExport = TargetExports[UniqersMarriage.targetSystem]

            if not targetExport then
                print(('[uniqers-marriage] Error interaction: %s'):format(UniqersMarriage.targetSystem))
                return
            end

            if UniqersMarriage.targetSystem == 'qb-target' then
                targetExport:AddBoxZone(zoneName, coords, size.x, size.y, {
                    name = zoneName,
                    heading = size.w,
                    debugPoly = false,
                    minZ = coords.z - (size.z / 2),
                    maxZ = coords.z + (size.z / 2)
                }, options)

            elseif UniqersMarriage.targetSystem == 'ox_target' then
 
                local oxOptions = {}
                if options.options then
                    for _, v in ipairs(options.options) do
                        local newOption = {
                            icon = v.icon,
                            label = v.label,
                            onSelect = v.action, 
                            canInteract = v.canInteract,
                            job = v.job,
                            item = v.item,
                            key = v.key,
							distance = v.distance,
							groups = v.groups,
							citizenid = v.citizenid,
                        }
                        table.insert(oxOptions, newOption)
                    end
                end

                targetExport:addBoxZone({
                    name = zoneName,
                    coords = coords,
                    size = vec3(size.x, size.y, size.z),
                    rotation = size.w,
                    debug = false,
                    distance = options.distance or 2.5, 
                    options = oxOptions 
                })
            end
        end,
        
        RemoveZone = function(zoneName)
            if not UniqersMarriage.Interaction.Target.Enable then return end
            
            local targetExport = TargetExports[UniqersMarriage.targetSystem]
            if not targetExport then return end

            if UniqersMarriage.targetSystem == 'qb-target' then
                targetExport:RemoveZone(zoneName)
            elseif UniqersMarriage.targetSystem == 'ox_target' then
                targetExport:removeZone(zoneName)
            end
        end
    }
}
