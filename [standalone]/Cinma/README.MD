# CINMA 


**Setup Guide**

1.The first step is to download the requirements script (hypnonema).
2.We've made some Changes to the Hypnonema script. Please use our customized version by downloading it from the link below.
**https://mega.nz/file/OP5lWLSS#tOYQdVwIEyzvp7DF8z95NmanyxHnMvsjzVT9p_0YOkg**
3.Add these codes to your server.cfg
- exec @hypnonema/permissions.cfg
- start hypnonema
- start Cinma 
- add_ace group.admin hypnonema allow
- add_ace builtin.everyone hypnonema.playback allow
4.Last step just Run Your Server 

**Verify these settings to make sure script is working 100%**
1.Go to the Screen Management section using the /hypnonema command and make sure that three new screens have been added.(CinmaHall1 , CinmaHall2 , CinmaHall3) If they haven't been added, just restart the cinema script once. The addition process only needs to be done once and you don't need to do it again.
2.Now you can add and manage videos using the Open Admin Menu command that can be set in the configuration(/cinemapelan).


**Cinma Config**

*RemoveMoney* 
- We tried as much as we could to make the script stand-alone. Only in the romve money section do you need to provide an export or code to romve money from player when purchasing a ticket.
- by return true  A ticket is purchased for the player.
- by return false This means that there is insufficient money and the ticket will not be purchased for the player. 

*Blip*
- you can add blip in this table  Config.Blip
[[
{
    coord = vector3() , -- blip coord 
    Sprite= 5 , -- Sprite
    Scale = 1.0 , -- Scale
    Colour = 1 , -- Colour
    Text = 'Cinma 1' , --  Text

},
]]

*BuyTicketBots* 
- this is BuyTicket Bot.Here player can buy ticket 
[[

 {
        ped ='a_m_m_bevhills_02' ,  -- ped name 
        coord = vector3(349.358246, 212.175827, 103.312134)  , -- coord 
        heading = 80.0 ,  -- heading of bot 
        Label  = 'PRESS ~INPUT_PICKUP~ TO BUY ~g~ TICKET '  ,  -- label 
    },


]]


*CkeckTicketBots*  
- this bot will check if player have the ticket of movie is playing and if they have player will spawn in cinma hall
- Don't forget: every theater hall has its own ticket check system.
- add is same like buy ticket 
-- Config.ExitBot 
-- this bots can help player to exit cinma moive playing section 

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


*Config.Cinma*
- Cinma Screen data 
[[

 [1] = {
        Screen = 'CinmaHall1',  -- name of screen added in  hypnonema
        TpToCinma =  vector3(324.43, 188.50, 108.96)  , -- player in after check ticket bot will spawn here 
        LookATScreen =   vector3(324.43, 188.50, 112.96)  ,  -- this is for live editor 
        LookATScreenH = 156.0 , --  -- this is for live editor  
    } , 

]]


- Config.OpenAdminPlanCMD   -- *Cmd of Open Admin plan*

- Config.EveryOneCanUseCMD = true  *if its true all player can use  OpenAdminPlanCMD ,set false to use admin system* 
- Config.Admins *add your steam hex here if you want use this and make sure Config.EveryOneCanUseCMD  is false if you want use this system* 

- [steam] = true , 

*log System*
- log is for when player buy ticket it will send log in your discord channel by using webhook url 

Config.WeebHook = ''
Config.WeebHookIcon = ''


*Important*
- Be careful not to restart the cinema too Much, as it may cause the Hypnonema sound to bug. If this happens, don't worry By restarting the server you can fix this bug


*If you need more help you can open a ticket in our discord*
- https://discord.gg/EBdtnnKQrU