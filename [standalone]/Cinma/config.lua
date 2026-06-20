Config = {}

---- blips 
Config.Blip = {
    {
        coord = vector3(335.538452, 175.635162, 103.183105), 
        Sprite= 23 , 
        Scale = 1.0 ,
        Colour = 1 , 
        Text = 'Cinema'

    },
}
--- Buy Ticket Bot

Config.BuyTicketBots = {
    {
        ped ='csb_reporter' , 
        coord = vector3(349.358246, 212.175827, 103.312134)  , 
        heading = 160.0 , 
        Label  = 'PRESS ~INPUT_PICKUP~ TO BUY ~g~ TICKET '  , 
    },
}
---- Check Ticket 

Config.CkeckTicketBots = {
    {
        ped ='s_m_m_bouncer_01' , 
        coord = vector3(329.881317, 203.301102, 109.462280)  , 
        heading = 340.0 , 
        Label  = 'PRESS ~INPUT_PICKUP~ TO Check Your ~g~ TICKET '  , 
        Cinma = 1 
    },
    {
        ped ='s_m_m_bouncer_01' , 
        coord = vector3(339.217590, 229.661545, 109.512817)  , 
        heading = -190.0 , 
        Label  = 'PRESS ~INPUT_PICKUP~ TO Check Your ~g~ TICKET '  , 
        Cinma = 2 
    },
    {
        ped ='s_m_m_bouncer_01' , 
        coord = vector3(376.852753, 239.156052, 89.899658)  , 
        heading = 90.0 , 
        Label  = 'PRESS ~INPUT_PICKUP~ TO Check Your ~g~ TICKET '  , 
        Cinma = 3 
    },
}

---  Cinma  

Config.ExitBot  = {
    {
        ped ='s_m_m_bouncer_01' , 
        coord =  vector3(325.714294, 199.265930, 109.512817)  , 
        heading = 160.0 , 
        Label  = 'PRESS ~INPUT_PICKUP~ TO Exit Cinma '  , 
        Cinma = 1  , 
        TeleportToCoord =   vector3(330.804382, 205.661545, 110.462280)  , 
    },
    {
        ped ='s_m_m_bouncer_01' , 
        coord =  vector3(344.479126, 232.298904, 109.512817)  , 
        heading = -10.0 , 
        Label  = 'PRESS ~INPUT_PICKUP~ TO Exit Cinma '  , 
        Cinma = 2  , 
        TeleportToCoord =   vector3(337.793396, 225.995605, 110.512817)  , 
    },
    {
        ped ='s_m_m_bouncer_01' , 
        coord =  vector3(378.923065, 235.661545, 89.882812)  , 
        heading = 258.0 , 
        Label  = 'PRESS ~INPUT_PICKUP~ TO Exit Cinma '  , 
        Cinma = 3  , 
        TeleportToCoord = vector3(374.334076, 240.013184, 90.899658)  , 
    },
}

Config.Cinma = {
    [1] = {
        Screen = 'CinmaHall1',  -- CinmaI 
        TpToCinma =  vector3(328.048340, 198.619781, 110.512817)  ,
        LookATScreen =   vector3(324.43, 188.50, 112.96)  ,  
        LookATScreenH = 156.0 , 
    } , 
    [2] = {
        Screen = 'CinmaHall2',  -- CinmaI 
        TpToCinma =  vector3(340.232971, 232.312088, 110.512817) ,
        LookATScreen =   vector3(343.92, 244.23, 112.96) ,  
        LookATScreenH = 336.0 , 
    } , 
    [3] = {
        Screen = 'CinmaHall3',  -- CinmaI 
        TpToCinma =  vector3(380.518677, 238.272522, 90.882812)  ,
        LookATScreen =   vector3(385.04, 237.56, 92.90)  ,
        LookATScreenH = 250.0 , 
    } , 
}

--[[ See This To Know Have Add New Screen 
https://github.com/charming-byte/fivem-hypnonema?tab=readme-ov-file#createscreen
]]
------ Admins Can Use Admin Plan
Config.OpenAdminPlanCMD = 'cinemapelan'

Config.EveryOneCanUseCMD = true 

Config.Admins = {
    ['steam:hex'] = true , --your steamhex 
}

-----log
Config.WeebHook = ''
Config.WeebHookIcon = ''

-----Notif translation
Config.NotPlaying = 'Cinema Is Not Playing Any Movie'
Config.AlreadyHaveTicket = 'You already have this ticket'
Config.BoughtTicket = 'You bought a ticket of '
Config.StatMovie = 'The cinema is not playing any movie.'
----ToGether
Config.NoTicket = 'You dont have ticket Of '
Config.Now = 'Now '
----
Config.MovieAdded = 'Your movie has been added to the list'
Config.NotFound = 'cinema Data Is Not Found At Config'
Config.SetPrice = 'Set Price With Numbers'
Config.CompleteFields = 'Complete all fields.'
Config.NewDataMovie = 'Your new movie data has been added.'
Config.RemoveFromList = 'Movie removed from list.'
Config.DosentExist = 'This movie doesnt exist.'
Config.MoviePlaying = 'Movie is now playing.'
Config.AnotherMovie = 'Another movie is currently playing in this cinema.'
Config.IsLiveON = 'Is live on'
Config.BuyTicketOf = ' buy ticket Of '
-------------------------------------
-----  Server Side functions 
-------------------------------------
function SendNotifction(playerId , txt )
    TriggerClientEvent('Cinma:SimpleNotif', playerId, txt)
end 
function RemoveMoney( playerId , price) 
    return true 
    --- return false 
    ---- Write Your Remove Money Code 
end 
function IsPlayerAdmin( playerId , price) 
    local identifierlist = ExtractIdentifiers(playerId)
    return Config.Admins[identifierlist.steam] or Config.EveryOneCanUseCMD
end 
function ExtractIdentifiers(id)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(id) - 1 do
        local playerID = GetPlayerIdentifier(id, i)

        if string.find(playerID, "steam") then
            identifiers.steam = playerID
        elseif string.find(playerID, "ip") then
            identifiers.ip = playerID
        elseif string.find(playerID, "discord") then
            identifiers.discord = playerID
        elseif string.find(playerID, "license") then
            identifiers.license = playerID
        elseif string.find(playerID, "xbl") then
            identifiers.xbl = playerID
        elseif string.find(playerID, "live") then
            identifiers.live = playerID
        end
    end

    return identifiers
end