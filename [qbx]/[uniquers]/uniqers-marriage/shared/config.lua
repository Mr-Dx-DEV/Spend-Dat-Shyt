UniqersMarriage = UniqersMarriage or {}
UniqersMarriage.DatabaseSelect = "oxmysql" --change your mysql service oxmysql or mysql-async or ghmattimysql
UniqersMarriage.Framework = "auto" -- "auto" or "qbcore" or "esx" or "qbus" or "oldesx" - if you need custom framework contact us  https://discord.gg/MyrGhbf9tM
UniqersMarriage.CoreName = "auto" -- "auto" or for qbcore = "QBCore", for qbus = "QBCore", for esx = "ESX", forold esx = "ESX", for qbcore or esx variation like ASDCore, Blabla core = "BLABLACore",
UniqersMarriage.CoreName2 = "auto" -- "auto" or for qbcore = "qb-core", for qbus = "QBCore:GetObject", for esx = "es_extended", forold esx = "esx:getSharedObject", for qbcore or esx variation like ASDCore, Blabla core = "blabla-core",
UniqersMarriage.Notify = "qbcore" -- if u use custom notify write "custom" if u dont write "qbcore" - "esx" -  or "uniqers-notify" what u using
UniqersMarriage.Inventory = "otherqb" -- "auto" or select your inventory - qb-inventory = "qbcore" or other qbcore inventory like ox-inventory and others = "otherqb" or esx-inventory = "esx"  or like ox-inventory and others esx inventory = "otheresx"
UniqersMarriage.Clothes = "auto" -- "auto" or select your clothes script "qb-clothing" or "esx-skinchanger" or "fivem-apperance" or "illenum-apperance" or "rcore-clothing" or "tgiann-clothing" or "custom" if u use custom add your custom code below the function function customclothes
UniqersMarriage.ForEsxAvatar = "discord" --- select your for esx framework avatar system "steam" or "discord" or ""
UniqersMarriage.NPCFunction = "yes" -- If you say "yes". The player and the NPC in the priest job can use the marriage and divorce functions. /marriage and divorce command for the player. If you say "no", the NPC cannot use it and everything related to the NPC will be destroyed and everything will remain with the player in the priest profession.
UniqersMarriage.ConsensualDivorce = "yes" -- if no, no need spouse with you for divorce if yes, need online and with you for spouse
UniqersMarriage.MultiMarriage = false -- if is true, players can marry more than one person. if false, players can only marry one person.
UniqersMarriage.GarageName = "caears24" --- for qbcore garage name 
UniqersMarriage.Society = false -- if you want all married pay going to qb-management or esx society set true if u dont want set false.
UniqersMarriage.ClothingChange = true -- if true players can change clothing with target if false players cant change clothings.
UniqersMarriage.NeedTwoRing = false -- if true aach couple needs 1 ring. If false, only the person proposing will need 1 ring.
UniqersMarriage.UseRing = true -- if true copules can use ring if false cant this mean gps at the tag map. 
UniqersMarriage.WeddingPay = 250 -- wedding pay amount
UniqersMarriage.WeddingClothingPay = 250 -- wedding clothes pay amount
UniqersMarriage.PreparationTime = 60 -- minutes
UniqersMarriage.MarriedNotifyVisible = true -- global married notify true or false 
UniqersMarriage.MarriedNotify = 30 -- 30 >> 3 seconds
UniqersMarriage.LevelUpNotify = 40 -- 30 >> 3 seconds
UniqersMarriage.RingPay = 5000 -- ring pay amount
UniqersMarriage.SpouseTopEmojiVisible = true -- your spouse emoji at top head if is true visible if false hidden.
UniqersMarriage.SpouseBlipVisible = true -- your spouse emoji at top head if is true visible if false hidden.
UniqersMarriage.BlipType = "normal" -- "hard" for big server cpu  "normal" for normal
UniqersMarriage.SpouseTopEmoji = "❤️" -- your spouse emoji at top head
UniqersMarriage.SpouseTopEmojiTopValue = 1 -- your spouse emoji at top head top value high number top down number for bottom player a head
UniqersMarriage.ManAnimName = "amb@world_human_bum_wash@male@low@idle_a" -- man first anim name
UniqersMarriage.ManAnimName2 = "idle_a" -- man first anim name 2
UniqersMarriage.GirlAnimName = "anim@heists@ornate_bank@chat_manager" --girl first anim name
UniqersMarriage.GirlAnimName2 = "fail" -- -girl first anim name 2
UniqersMarriage.ManRingFirstAnimName = "dollie_mods@propose_001b" -- man first ring used anim name 1
UniqersMarriage.ManRingFirstAnimName2 = "propose_001b" -- man first ring used anim name 2
UniqersMarriage.PutAnimName = "missmic4" -- when use ring anim name 1
UniqersMarriage.PutAnimName2 = "michael_tux_fidget" --when use ring anim name 2
UniqersMarriage.StaffPermissionNames = { -- write your staff names for qbcore like "admin" for esx like group name "superadmin" 
    "admin",
	"superadmin",
	-- "others", -- add more
}
UniqersMarriage.CeremonyFee = 10000 -- ceremony fee amount
UniqersMarriage.CarRentPrice = 5000 -- wedding car rent price amount
UniqersMarriage.CarDeposit = 2000 -- wedding car deposit amount
UniqersMarriage.WeddingCarModel = "stretch" -- wedding car model

UniqersMarriage.CeremonyData = {
    spawnCoords = vector4(-1577.23, 68.48, 60.81, 47.89),
    podiumCoords = vector4(-1583.78, 83.24, 59.69, 318.24),
    coupleCoords = vector4(-1582.56, 84.80, 59.15, 140.45),
    fireworks = {
        vector4(-1586.48, 86.36, 59.39, 140.68),
        vector4(-1581.05, 79.81, 59.39, 328.97)
    }
}
UniqersMarriage.DeliveryCargoBlipName = "Ring Cargo" -- cargo vehicle blip name
UniqersMarriage.RingBoxProp = "pata_freevalentinesday" -- ring box prop name
UniqersMarriage.RingCargoCarModel = "youga2" -- ring cargo car model
UniqersMarriage.RingCargoCarPlate = "RING" -- ring cargo car plate name
UniqersMarriage.MoneyProp = "prop_anim_cash_note_b" -- money prop name
UniqersMarriage.ActiveDiscordLogs = true -- if u want use discord log write true if u dont want write false
UniqersMarriage.TitleWebhook = "www.uniqers-scripts.tebex.io Best Script" -- info title bottom
UniqersMarriage.WebhookPhoto = "" -- webhook profile picture
UniqersMarriage.DiscordBotToken = "" -- discord bot token
UniqersMarriage.UploadMethod = "FiveManage" -- Options: "FiveManage" or "Discord"
UniqersMarriage.FiveManageToken = "" -- FiveManage token for uploading images, required if UploadMethod is set to "Five
UniqersMarriage.DiscordWebhook = "" -- discord webhook url for logs


UniqersMarriage.Locations = {
    -- City Priest AND target functions and blip functions
    ['citypriest'] = {
        ['label'] = 'Marriage City', -- blip name
        ['coordsdist'] = vector3(-766.6118, -23.75499, 41.080276), -- coords distance
		['coords'] = vector4(-766.6118, -23.75499, 41.080276, 211.11624), --- npc priest coords
        ['ped'] = 'cs_priest', -- priest model name
        ['scenario'] = 'WORLD_HUMAN_GUARD_STAND', -- priest scenario name >> example is here >> https://github.com/DioneB/gtav-scenarios
        ['showblip'] = true, -- blips show or off
        ['blipsprite'] = 621, -- blip sprite
        ['blipscale'] = 0.7, -- blip scale
		['blipdisplay'] = 4, -- blipd display
        ['blipcolor'] = 1, -- blip color https://docs.fivem.net/docs/game-references/blips/
        ['weddingCarSpawn'] = vector4(-759.60, -37.66, 37.68, 118.77),
        ['garagelocations'] = {
          vector4(-772.6629, 45.183414, 49.290657, 73.097679),
        },		
    },
    -- Town Priest AND target functions and blip functions
    ['townpriest'] = {
        ['label'] = 'Marriage Town',
		['coordsdist'] = vector3(-330.0823, 6154.3388, 32.313293),
        ['coords'] = vector4(-330.0823, 6154.3388, 32.313293, 46.612247),
        ['ped'] = 'cs_priest',
        ['scenario'] = 'WORLD_HUMAN_GUARD_STAND',
        ['showblip'] = true,
        ['blipsprite'] = 621,
        ['blipscale'] = 0.7,
		['blipdisplay'] = 4,
        ['blipcolor'] = 1,
        ['weddingCarSpawn'] = vector4(-342.96, 6150.23, 31.49, 44.29),
        ['garagelocations'] = {
           vector4(-323.2235, 6128.6816, 31.492708, 47.394233),
        },			
    }
	-- you can add mooore
    -- ['townpriest'] = {
        -- ['label'] = 'Marriage Town',
		-- ['coordsdist'] = vector3(-330.0823, 6154.3388, 32.313293),
        -- ['coords'] = vector4(-330.0823, 6154.3388, 32.313293, 46.612247),
        -- ['ped'] = 'cs_priest',
        -- ['scenario'] = 'WORLD_HUMAN_GUARD_STAND',
        -- ['showblip'] = true,
        -- ['blipsprite'] = 621,
        -- ['blipscale'] = 0.7,
		-- ['blipdisplay'] = 4,
        -- ['blipcolor'] = 1
    -- }	
}

UniqersMarriage.BadgeRewards = {
                ["1"] = 1000, -- month
                ["3"] = 2500, -- month
                ["6"] = 5000, -- month
                ["12"] = 10000 -- year
} -- players marriage badge how much won for each badge.

UniqersMarriage.Adversting = true -- marriage adversting for all players server true or false
UniqersMarriage.AdverstingHours = 3 -- hours display marriage adversting for all players for server

UniqersMarriage.Refreshtime = {
    ["spousetag"] = 5000,
}

UniqersMarriage.ItemUpdateType = "reload" -- reload or remove items update type if u select reload item will remove and will add 
UniqersMarriage.IDCard = true -- if u use this item and if u want update this item write true if dont want write false
UniqersMarriage.IDCardName = "id_card" -- this item name
UniqersMarriage.DriverCard = true -- if u use this item and if u want update this item write true if dont want write false
UniqersMarriage.DriverCardName = "driver_license"  -- this item name
UniqersMarriage.Temporary = false -- if u use this item and if u want update this item write true if dont want write false
UniqersMarriage.TemporaryName = "temporary"  -- this item name
UniqersMarriage.LawyerPass = false -- if u use this item and if u want update this item write true if dont want write false
UniqersMarriage.LawyerPassName = "lawyerpass"  -- this item name
UniqersMarriage.WeaponLicense = false -- if u use this item and if u want update this item write true if dont want write false
UniqersMarriage.WeaponLicenseName = "weaponlicense"  -- this item name




