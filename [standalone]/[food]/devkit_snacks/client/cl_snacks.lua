-- Snacks: Eating
RegisterNetEvent("devkit_snacks:onEat", function(item)
    local food = Config.Food[item]
    if not food then
        print("Invalid food item: " .. tostring(item))
        return
    end

    local propData = food.prop or {}
    local animData = food.anim or {}
    local ped = PlayerPedId()
    local attachedProps = {}

    -- Attach props if any
    local function attachProps()
        if propData[1] then
            for _, prop in ipairs(propData) do
                if prop.model then
                    RequestModel(prop.model)
                    while not HasModelLoaded(prop.model) do
                        Wait(10)
                    end

                    local obj = CreateObject(prop.model, 0.0, 0.0, 0.0, true, true, false)
                    local pos = prop.pos or vec3(0.12, 0.028, 0.001)
                    local rot = prop.rot or vec3(10.0, 175.0, 0.0)
                    local bone = prop.bone or 18905

                    AttachEntityToEntity(
                        obj,
                        ped,
                        GetPedBoneIndex(ped, bone),
                        pos.x or pos[1], pos.y or pos[2], pos.z or pos[3],
                        rot.x or rot[1], rot.y or rot[2], rot.z or rot[3],
                        true, true, false, true, 1, true
                    )

                    table.insert(attachedProps, obj)
                    SetModelAsNoLongerNeeded(prop.model)
                end
            end
            return true
        elseif propData.model then
            return false
        end
        return true
    end

    -- Cleanup props
    local function removeProps()
        for _, obj in ipairs(attachedProps) do
            if DoesEntityExist(obj) then
                DeleteEntity(obj)
            end
        end
        attachedProps = {}
    end

    if attachProps() then
        lib.progressBar({
            duration = 7000,
            label = "Eating " .. food.name .. "...",
            useWhileDead = false,
            canCancel = false,
            anim = {
                dict = animData.dict,
                clip = animData.clip
            }
        })
        removeProps()
    else
        lib.progressBar({
            duration = 7000,
            label = "Eating " .. food.name .. "...",
            useWhileDead = false,
            canCancel = false,
            anim = {
                dict = animData.dict,
                clip = animData.clip
            },
            prop = {
                model = propData.model,
                bone = propData.bone or 18905,
                pos = propData.pos or { x = 0.12, y = 0.028, z = 0.001 },
                rot = propData.rot or { x = 10.0, y = 175.0, z = 0.0 }
            }
        })
    end
end)


-- Drinks: Drinking
RegisterNetEvent("devkit_snacks:onDrink", function(item)
    local drink = Config.Drinks[item]
    if not drink then
        print("Invalid drink item: " .. tostring(item))
        return
    end

    local propData = drink.prop or {}
    local animData = drink.anim or {}

    local model = propData.model or "prop_ld_flow_bottle"

    lib.progressBar({
        duration = 3000,
        label = "Drinking " .. drink.name .. "...",
        useWhileDead = false,
        canCancel = false,
        anim = {
            dict = animData.dict or "mp_player_intdrink",
            clip = animData.clip or "loop_bottle_fp"
        },
        prop = {
            model = model,
            bone = propData.bone or 18905,
            pos = propData.pos or { x = 0.12, y = 0.028, z = 0.001 },
            rot = propData.rot or { x = 10.0, y = 175.0, z = 0.0 }
        }
    })
end)