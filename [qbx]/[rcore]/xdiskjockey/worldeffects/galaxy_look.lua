-- for this you need to have bob74_ipl on your server
Config.GalaxyLooks = {
    -- walls looks
    --Int01_ba_Style01
    --Int01_ba_Style02
    --Int01_ba_Style03
    interiorStyle = "Int01_ba_Style03",

    -- I have no idea
    --Int01_ba_style01_podium
    --Int01_ba_style02_podium
    --Int01_ba_style03_podium
    podiumStyle = "Int01_ba_style03_podium",

    -- this is the DJ table looks
    --Int01_ba_dj01
    --Int01_ba_dj02
    --Int01_ba_dj03
    --Int01_ba_dj04
    turntablesStyle = "Int01_ba_dj04",
}

CreateThread(function()
    local breakme = 10
    while not IsResourceOnServer("bob74_ipl") do
        Wait(1000)
        breakme = breakme - 1
        if breakme == 0 then
            return
        end
    end

    local bob74 = exports["bob74_ipl"]

    bob74:GetAfterHoursNightclubsObject().Interior.Style.Set(Config.GalaxyLooks.interiorStyle, true)
    bob74:GetAfterHoursNightclubsObject().Interior.Podium.Set(Config.GalaxyLooks.podiumStyle, true)
    bob74:GetAfterHoursNightclubsObject().Interior.Turntables.Set(Config.GalaxyLooks.turntablesStyle, true)
    bob74:GetAfterHoursNightclubsObject().Interior.Lights.Bands.Clear(true)
end, "setting default galaxy looks (export side)")