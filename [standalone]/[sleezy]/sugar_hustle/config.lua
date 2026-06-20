-- ════════════════════════════════════════════════════════════════
-- SUGAR HUSTLE SYSTEM - CONFIGURATION FILE
-- ════════════════════════════════════════════════════════════════
-- 
-- ✅ THIS IS THE ONLY FILE YOU NEED TO EDIT!
-- 
-- All customization is done here. DO NOT edit client.lua or server.lua
-- as they are protected and modifications will break the script.
--
-- For support: discord.gg/royaltcustomz
-- Documentation: See README.md and installation guide
--
-- ════════════════════════════════════════════════════════════════



Config = {}

-- ════════════════════════════════════════════════════════════════
-- FRAMEWORK DETECTION
-- ════════════════════════════════════════════════════════════════
-- The script will automatically detect which framework is running
-- Supported: QBCore, QBOX, ESX
Config.Framework = nil -- Auto-detected, don't change

-- ════════════════════════════════════════════════════════════════
-- GENERAL SETTINGS
-- ════════════════════════════════════════════════════════════════
Config.UseOxTarget = true -- Set to false if using qb-target
Config.Debug = false -- Enable debug prints

-- Multiple partners (rotation): 2–3 active partners; switch in app; separate relationship levels and cooldowns
Config.MaxActivePartners = 3 -- Max partners at once (1 = original single-partner behavior)
Config.AllowReplacePartner = false -- If true, finding when at max replaces lowest-level partner; if false, must end one first

-- ════════════════════════════════════════════════════════════════
-- ITEM SETTINGS
-- ════════════════════════════════════════════════════════════════
Config.RequiredItem = 'sugarphone' -- Item needed to access the app

-- ════════════════════════════════════════════════════════════════
-- COOLDOWN SETTINGS
-- ════════════════════════════════════════════════════════════════
Config.FindPartnerCooldown = 0 -- Seconds (1 hour = 3600)
Config.EncounterCooldown = 0 -- Seconds between encounters (1800 seconds = 30 mins)
Config.FlirtCooldown = 300 -- Seconds between flirts (5 mins)
Config.RobberyCooldown = 0 -- Seconds between robberies (7200 seconds = 2 hours)
Config.MessagePlugCooldown = 0 -- Seconds between contacting the plug (172800 seconds = 2 days)

-- ════════════════════════════════════════════════════════════════
-- PAWN SHOP SETTINGS (Define early for date settings to reference)
-- ════════════════════════════════════════════════════════════════
Config.PawnShop = {
    Enabled = true,
    Location = vector3(182.53, -1318.74, 29.32), -- Strawberry Ave (shady area)
    PedModel = 'g_m_m_armboss_01', -- Shady looking dude
    PedHeading = 242.0,
    BlipEnabled = true, -- Set to true if you want a map blip
    BlipSprite = 52,
    BlipColor = 1,
    BlipScale = 0.7,
    BlipLabel = 'Luxury Goods Dealer',
}


-- ════════════════════════════════════════════════════════════════
-- ROBBERY SETTINGS
-- ════════════════════════════════════════════════════════════════
Config.RobberySettings = {
    Enabled = true,
    RequireWeapon = true, -- Player must have a gun
    SpawnDistance = 30.0, -- How far away NPC spawns
    RunToPlayer = true, -- NPC runs to player location
    RelationshipPenalty = 15, -- Relationship points lost
    MinCash = 1000, -- Minimum robbery cash
    MaxCash = 5000, -- Maximum robbery cash
    PoliceAlertChance = 0, -- % chance to alert police
    HandsUpDuration = 30, -- How long NPC stays hands up (seconds)
}



-- ════════════════════════════════════════════════════════════════
-- DRUG PLUG SETTINGS
-- ════════════════════════════════════════════════════════════════
Config.DrugPlug = {
    Enabled = true,
    ContactName = 'The Plug',
    PaymentType = 'cash', -- Cash account used when removing payment
    NPCModel = 'g_m_y_mexgoon_02',
    DeliveryDriverModel = 'g_m_y_mexgoon_03',
    DeliveryVehicle = 'speedo',
    PickupNPCAnimation = { dict = 'amb@world_human_drug_dealer_hard@male@idle_a', anim = 'idle_a' },
    GiveAnimation = { dict = 'mp_common', anim = 'givetake1_a', duration = 2000 },
    DeliverySettings = {
        SpawnRadius = 120.0,
        ArrivalDistance = 35.0,
        ApproachDistance = 4.0,
        Timeout = 180, -- seconds before delivery cancels
        DrivingSpeed = 25.0
    },
    Drugs = {
        { id = 'og_kush', label = 'OG Kush', item = 'weed', amount = 50, price = 250 },
        { id = 'blue_dream', label = 'Blue Dream', item = 'weed_small_bag', amount = 5, price = 900 },
        { id = 'coke_eighth', label = 'Coke (8 Ball)', item = 'coke_small_brick', amount = 1, price = 3000 },
    },
    PickupLocations = {
        { coords = vector3(1413.37, 3618.41, 34.5), heading = 203.25, label = 'Sandy Shores Motel' },
        { coords = vector3(-1152.57, -1530.94, 4.24), heading = 16.05, label = 'Vespucci Canals' },
        { coords = vector3(379.42, -2066.88, 21.74), heading = 232.00, label = 'Rancho Alley' },
        { coords = vector3(1242.66, -3345.51, 5.90), heading = 269.85, label = 'Terminal Docks' }
    }
}

-- ════════════════════════════════════════════════════════════════
-- RELATIONSHIP SYSTEM
-- ════════════════════════════════════════════════════════════════
Config.RelationshipSettings = {
    StartingLevel = 0, -- Starting relationship level (0-100)
    SuccessIncrease = 5, -- Points gained on successful encounter
    DramaDecrease = 10, -- Points lost on drama events
    MaxLevel = 100,
    MinLevel = 0,
}

-- Relationship tier bonuses
Config.RelationshipTiers = {
    { min = 0, max = 25, cashMultiplier = 0.5, giftChanceBonus = 0 },
    { min = 26, max = 50, cashMultiplier = 1.0, giftChanceBonus = 5 },
    { min = 51, max = 75, cashMultiplier = 1.5, giftChanceBonus = 10 },
    { min = 76, max = 100, cashMultiplier = 2.0, giftChanceBonus = 20 },
}

-- ════════════════════════════════════════════════════════════════
-- PARTNER PERSONALITIES
-- ════════════════════════════════════════════════════════════════
Config.Personalities = {
    {
        type = 'generous',
        icon = '💎',
        label = 'Generous',
        cashMultiplier = 1.5,
        giftChanceBonus = 15,
        dramaChance = 5,
    },
    {
        type = 'jealous',
        icon = '😈',
        label = 'Jealous',
        cashMultiplier = 1.0,
        giftChanceBonus = 5,
        dramaChance = 35,
    },
    {
        type = 'cheap',
        icon = '💰',
        label = 'Cheap',
        cashMultiplier = 0.6,
        giftChanceBonus = -10,
        dramaChance = 25,
    },
    {
        type = 'mysterious',
        icon = '🎭',
        label = 'Mysterious',
        cashMultiplier = 1.2,
        giftChanceBonus = 10,
        dramaChance = 15,
    },
}



-- ════════════════════════════════════════════════════════════════
-- REWARDS SYSTEM
-- ════════════════════════════════════════════════════════════════
Config.CashReward = {
    min = 500,
    max = 2500,
}

Config.Rewards = {
    { item = 'luxury_bag', label = 'Luxury Designer Bag', chance = 25, sellPrice = 3000 },
    { item = 'diamond_necklace', label = 'Diamond Necklace', chance = 15, sellPrice = 5000 },
    { item = 'expensive_perfume', label = 'Expensive Perfume', chance = 20, sellPrice = 1500 },
    { item = 'gold_watch', label = 'Gold Watch', chance = 18, sellPrice = 4000 },
    { item = 'designer_shoes', label = 'Designer Shoes', chance = 22, sellPrice = 2500 },
}

-- ════════════════════════════════════════════════════════════════
-- ENCOUNTER OUTCOMES
-- ════════════════════════════════════════════════════════════════
Config.EncounterOutcomes = {
    cash = { chance = 40, enabled = true },
    gift = { chance = 25, enabled = true },
    drama = { chance = 20, enabled = true },
    police = { chance = 5, enabled = true }, -- Very rare
    perfect = { chance = 10, enabled = true }, -- Cash + Gift
}

-- ════════════════════════════════════════════════════════════════
-- NPC SPAWN LOCATIONS
-- ════════════════════════════════════════════════════════════════
Config.MeetingLocations = {
    -- { coords = vector3(-1368.26, -1165.36, 3.54), heading = 120.0, label = 'Beach Pier' },
    -- { coords = vector3(-1172.45, -1572.36, 3.36), heading = 215.0, label = 'Vespucci Beach' },
    -- { coords = vector3(236.89, -877.89, 29.49), heading = 70.0, label = 'Downtown Hotel' },
    -- { coords = vector3(-626.83, -1114.23, 21.18), heading = 270.0, label = 'Yacht Club' },
    { coords = vector3(-1559.47, -567.28, 107.52), heading = 35.0, label = 'Luxury Villa' },
}

-- ════════════════════════════════════════════════════════════════
-- DATE LOCATIONS (Restaurants & Dining)
-- ════════════════════════════════════════════════════════════════
Config.DateLocations = {
    -- {
    --     name = 'Bahama Mamas West',
    --     coords = vector3(-1387.08, -588.47, 30.32),
    --     npcHeading = 210.0,
    --     playerSeat = vector4(-1387.72, -587.39, 30.32, 30.0), -- x, y, z, heading
    --     npcSeat = vector4(-1388.92, -588.71, 30.32, 210.0),
    --     prop = 'prop_table_03_chr', -- Optional table prop
    -- },
    -- {
    --     name = 'Tequi-la-la VIP',w
    --     coords = vector3(-565.16, 276.62, 83.14),
    --     npcHeading = 175.0,
    --     playerSeat = vector4(-565.87, 278.70, 83.14, 355.0),
    --     npcSeat = vector4(-564.46, 278.70, 83.14, 175.0),
    -- },
    {
        name = 'Biker Lounge',
        coords = vector3(983.41, -99.78, 74.84),
        npcHeading = 45.0,
        playerSeat = vector4(988.00, -100.22, 74.84, 48.49),
        npcSeat = vector4(986.66, -101.51, 74.84, 45.21),
    },
    -- {
    --     name = 'Pops Diner',
    --     coords = vector3(1587.5616, 6455.0645, 26.0140),
    --     npcHeading = 270.0,
    --     playerSeat = vector4(1586.02, 6456.70, 26.33, 315.5),
    --     npcSeat = vector4(1586.80, 6456.46, 26.36, 341.1),
    -- },
}

-- ════════════════════════════════════════════════════════════════
-- DATE SETTINGS
-- ════════════════════════════════════════════════════════════════
Config.DateSettings = {
    Duration = 120, -- Seconds (2 minutes)
    RewardMultiplier = 1.5, -- Extra reward for completing date
    RequireBothSeated = true, -- Both player and NPC must be seated
    AllowCancel = true, -- Player can cancel date early (no reward)
    DespawnDelay = 120, -- Seconds before NPC despawns after date (2 minutes)
}

-- ════════════════════════════════════════════════════════════════
-- NPC PED MODELS
-- ════════════════════════════════════════════════════════════════
Config.NPCModels = {
    Male = {
        'a_m_m_business_01',
        'a_m_m_bevhills_01',
        'a_m_m_bevhills_02',
        'a_m_y_business_01',
        'a_m_y_business_02',
        'a_m_y_business_03',
    },
    Female = {
        'a_f_m_bevhills_01',
        'a_f_m_bevhills_02',
        'a_f_y_bevhills_01',
        'a_f_y_bevhills_02',
        'a_f_y_business_01',
        'a_f_y_business_02',
    }
}

-- ════════════════════════════════════════════════════════════════
-- POLICE ALERT SETTINGS
-- ════════════════════════════════════════════════════════════════
Config.PoliceAlert = {
    enabled = false,
    dispatch = 'ps-dispatch', -- Options: 'ps-dispatch', 'cd_dispatch', 'none'
    alertChance = 5, -- % chance police are alerted during drama
}

-- ════════════════════════════════════════════════════════════════
-- ANIMATIONS & SCENARIOS
-- ════════════════════════════════════════════════════════════════
Config.Animations = {
    flirt = { dict = 'anim@mp_player_intcelebrationfemale@blow_kiss', anim = 'blow_kiss', duration = 3000 },
    argue = { dict = 'misscarsteal4@actor', anim = 'actor_berating_loop', duration = 5000 },
    gift = { dict = 'mp_common', anim = 'givetake1_a', duration = 3000 },
}

-- ════════════════════════════════════════════════════════════════
-- PARTNER MESSAGES (SMS-style in-app Messages tab)
-- ════════════════════════════════════════════════════════════════
-- Shown in the Messages tab. Some can trigger time-limited "Partner wants to meet at X" with bonus.
Config.MeetRequestDuration = 600 -- Seconds (10 min) to accept meet request before it expires
Config.MeetRequestBonusMultiplier = 1.5 -- Extra reward multiplier for accepting a meet request in time

Config.PartnerMessages = {
    -- Generic SMS-style lines (no meet request)
    { text = 'Thinking of you 💕', timeAgo = 'Just now' },
    { text = 'We need to talk.', timeAgo = '5 min ago' },
    { text = 'Had a great time last night', timeAgo = '1 hr ago' },
    { text = 'You free later?', timeAgo = '2 hrs ago' },
    { text = 'Miss you already', timeAgo = '3 hrs ago' },
    { text = 'Don\'t forget about me 😘', timeAgo = 'Yesterday' },
    { text = 'Something came up. Call me?', timeAgo = 'Yesterday' },
    { text = 'You\'re so good to me', timeAgo = '2 days ago' },
    { text = 'We should do that again soon', timeAgo = '2 days ago' },
    { text = 'Hey stranger 👋', timeAgo = '3 days ago' },
    -- Meet-request messages: partner wants to meet at a specific place (time-limited bonus encounter)
    { text = 'I\'m at the usual spot. Come see me? 💋', timeAgo = 'Just now', triggerMeetRequest = true },
    { text = 'Can you meet me? I have a surprise for you', timeAgo = 'Just now', triggerMeetRequest = true },
    { text = 'I really want to see you. You know where.', timeAgo = '1 min ago', triggerMeetRequest = true },
    { text = 'Come over. Now. 😏', timeAgo = '2 min ago', triggerMeetRequest = true },
    { text = 'I\'m waiting. Don\'t keep me waiting too long.', timeAgo = 'Just now', triggerMeetRequest = true },
}
-- How many generic messages to show when opening Messages tab (randomly picked)
Config.PartnerMessagesCount = 5
-- Max one active meet request at a time when opening Messages tab (random if any triggerMeetRequest is chosen)
Config.MaxMeetRequestsInFeed = 1

-- When app is closed: show in-game notification (ox_lib/framework notify) for new partner messages or meet requests
Config.AppNotifications = true

-- ════════════════════════════════════════════════════════════════
-- BLACKMAIL (after drama or robbery)
-- ════════════════════════════════════════════════════════════════
-- Partner (or "associate") can send an in-app blackmail: pay X or they go to police / relationship ruined.
-- New message type "Blackmail" in Messages tab; timer to pay; if not paid, police alert and/or relationship loss.
Config.Blackmail = {
    Enabled = true,
    ChanceAfterDrama = 25,        -- % chance a drama triggers a blackmail message (0 = off)
    ChanceAfterRobbery = 60,      -- % chance a robbery triggers a blackmail message
    MinAmount = 2000,
    MaxAmount = 8000,
    PayTimerSeconds = 600,        -- 10 minutes to pay or consequences
    PoliceChanceIfUnpaid = 80,    -- % chance police are alerted if player doesn't pay in time
    RelationshipLossIfUnpaid = 25, -- Relationship points lost if not paid
}

-- ════════════════════════════════════════════════════════════════
-- LOCALIZATION
-- ════════════════════════════════════════════════════════════════
Config.Locale = 'en'

Config.Locales = {
    en = {
        -- Menu headers
        menu_main_header = '💋 Sugar Hustle App',
        menu_main_description = 'Manage your sugar relationships',
        
        -- Menu options
        find_partner = '📱 Find Sugar Partner',
        find_partner_desc = 'Search for a new arrangement',
        check_messages = '💌 Check Messages',
        check_messages_desc = 'View your relationship status',
        end_arrangement = '❌ End Arrangement',
        end_arrangement_desc = 'End current relationship',
        
        -- Notifications
        no_item = 'You need a Sugar Phone to access this app',
        cooldown_active = 'You need to wait before finding a new partner',
        partner_found = 'New partner found: %s (%s)',
        no_partner = 'You don\'t have an active arrangement',
        arrangement_ended = 'You ended your arrangement',
        max_partners_reached = 'You have the maximum number of partners. End one first.',
        relationship_increased = 'Your relationship improved! (+%s)',
        relationship_decreased = 'Your relationship worsened! (-%s)',
        
        -- Encounter messages
        received_cash = 'You received $%s from %s',
        received_gift = 'You received a %s from %s!',
        drama_occurred = 'A jealous scene occurred! Your partner is upset.',
        perfect_date = 'Perfect encounter! You got cash and a gift!',
        
        -- Interaction options
        interact_flirt = '💕 Flirt',
        interact_gift = '🎁 Ask for Gift',
        interact_argue = '😤 Argue',
        interact_leave = '👋 Leave',
        
        -- Relationship status
        relationship_level = 'Relationship Level: %s/100',
        relationship_tier = 'Status: %s',
        
        -- Tiers
        tier_cold = 'Cold',
        tier_warm = 'Warm',
        tier_hot = 'Hot',
        tier_passionate = 'Passionate',

        -- Drug plug UI
        message_plug_opening = 'Yo, what\'s good? What you tryna grab?',
        message_plug_confirm_price = 'Aight, {product} gonna run you {price}.',
        message_plug_select_method = 'You sliding through or need me to send the runner?',
        message_plug_pickup_option = 'I\'ll pull up',
        message_plug_delivery_option = 'Send the runner',
        message_plug_no_drugs = 'I\'m tapped out right now. Hit me later.',
        message_plug_pickup_assigned = 'Bet. Meet me at %s.',
        message_plug_pickup_details = 'Dropped a pin at %s. Check your GPS.',
        message_plug_collect_prompt = 'Press [E] to grab the pack',
        message_plug_delivery_assigned = 'Cool. My runner is already headed your way.',
        message_plug_runner_arrived = 'My guy just pulled up. Handle that.',
        message_plug_order_ready = 'Here\'s that %s you wanted.',
        message_plug_deal_done = 'Pleasure doing business. Hit me if you need more.',
        message_plug_cancelled = 'Deal fell through. Catch you later.',
        message_plug_cooldown = 'The plug is laying low. Try again in %s.',
        message_plug_cooldown_plug = 'I just served you. Hit me again in %s.',
        message_plug_insufficient_cash = 'You short on cash for that move.',
        message_plug_bag_received = 'You grabbed %s.',
        message_plug_player_thanks = 'Good looking out.',
        message_plug_player_ack_pickup = 'Say less, I\'m on the way.',
        message_plug_player_cancel = 'All good, maybe next time.',

        -- Messages tab (partner SMS)
        message_meet_at = 'Meet at %s',
        message_meet_request_expired = 'The meet request has expired.',
        message_meet_accepted = 'Heading to meet %s...',

        -- App notifications (when app is closed)
        notification_partner_message = '💌 %s sent you a message',
        notification_partner_message_preview = '💌 %s: %s',
        notification_meet_request = 'Your partner wants to meet! Open the app to see where.',
        notification_meet_request_at = 'Your partner wants to meet at %s! Open the app to accept.',
        -- Blackmail (Messages tab)
        blackmail_message = 'You have until the timer runs out. Pay $%s or I go to the police and everyone finds out.',
        blackmail_pay_btn = 'Pay $%s',
        blackmail_expired = 'Time\'s up. You had your chance.',
        blackmail_paid = 'Fine. We\'re even. Don\'t push your luck again.',
        blackmail_insufficient_funds = 'You don\'t have enough cash to pay.',
        blackmail_notification = '⚠️ %s sent you a blackmail demand. Open the app!',
    }
}

return Config

