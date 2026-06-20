function PlayPickupAnim()
    local lib = "anim@heists@money_grab@briefcase"
    local anim = "put_down_case"
    local count = 0
    RequestAnimDict(lib)
    while not HasAnimDictLoaded(lib) do
        Wait(33)
        count = count + 1
        if count > 5 then
            break
        end
    end

    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1,0, 0, 0, false, false, false)
end