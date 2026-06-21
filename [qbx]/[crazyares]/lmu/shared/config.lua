Config = {}

-- -
--  FRAMEWORK  (auto-detect QBX/QBCore/ESX)
-- -
local detectedFramework = 'standalone'
if GetResourceState('qbx_core') == 'started' then
    detectedFramework = 'qbx'
elseif GetResourceState('qb-core') == 'started' then
    detectedFramework = 'qb-core'
elseif GetResourceState('es_extended') == 'started' then
    detectedFramework = 'esx'
end

Config.Framework = detectedFramework

-- -
--  DEBUG
-- -
Config.Debug      = false   -- spawn clone for solo anim testing
Config.DebugPrint = false   -- verbose server prints

Config.Tablet = {
    SoundDebounceMs = 90,
}

Config.Items = {
    LoveTablet = 'love_tablet',
    DNAResult = 'dna_result',
    BirthCertBoy = 'birth_cert_boy',
    BirthCertGirl = 'birth_cert_girl',
    UltrasoundReport = 'ultrasound_report',
    PregnancyTest = 'pregnancy_test',
    Contraception = 'contraception',
    PrenatalVitamins = 'prenatal_vitamins',
    STDTestKit = 'std_test_kit',
    DNATest = 'dna_test',
    PrescriptionMeds = 'prescription_meds',
    Condoms = 'condoms',
    PlanC = 'plan_c',
    RhinoPill = 'rhino_pill',
    Lubricant = 'lubricant',
}

local function NewRoleWhitelist()
    return {
        Enabled = false,
        UseJobs = true,
        UseGangs = false,
        UseCitizenIds = false,
        AllowedJobs = {},
        AllowedGangs = {},
        AllowedCitizenIds = {},
    }
end

local function ClampWholeNumber(value, fallback, minimum, maximum)
    local number = math.floor(tonumber(value or fallback) or fallback or 0)
    if minimum ~= nil and number < minimum then
        number = minimum
    end
    if maximum ~= nil and number > maximum then
        number = maximum
    end
    return number
end

function GetPregnancyDurationConfig(override)
    override = type(override) == 'table' and override or {}
    local cfg = Config.Pregnancy or {}
    local maxDays = ClampWholeNumber(override.maxDays or cfg.MaxDurationDays, Config.PregnancyMaxDuration or 30, 1, 30)
    local days = ClampWholeNumber(override.days or cfg.DurationDays, Config.PregnancyDuration or 7, 0, maxDays)
    local hours = ClampWholeNumber(override.hours or cfg.DurationHours, Config.PregnancyDurationHours or 0, 0, 23)
    local totalHours = (days * 24) + hours
    local maxHours = maxDays * 24

    if totalHours < 1 then
        totalHours = 7 * 24
        days = 7
        hours = 0
    end

    if totalHours > maxHours then
        totalHours = maxHours
        days = math.floor(totalHours / 24)
        hours = totalHours % 24
    end

    return {
        days = days,
        hours = hours,
        totalHours = totalHours,
        totalSeconds = totalHours * 3600,
        maxDays = maxDays,
    }
end

function GetPregnancyDurationSeconds(override)
    return GetPregnancyDurationConfig(override).totalSeconds
end


-- -
--  APP ACCESS / PED GATING
-- -
Config.StrictModelGenderApps = false -- true = Coffee/Bro Code require exact freemode models

-- -
--  CHILD SUPPORT
-- -
Config.ChildSupport = {
    Enabled = true,
    Percent = 0.25,
    RequireDNA = true,
    RequireBirth = true,
    OneTimeOnly = true,
    IncludeCash = true,
    IncludeBank = true,
    IncludeBlackMoney = true,
    BlackMoneyType = 'item', -- item/account
    BlackMoneyName = 'black_money',
    RequireFatherOnline = true,
    PayToAccount = 'bank',
    RoleLock = NewRoleWhitelist()
}

-- legacy mirrors kept for compatibility
Config.ChildSupportPercent = Config.ChildSupport.Percent
Config.CountDirtyMoneyForChildSupport = Config.ChildSupport.IncludeBlackMoney
Config.DirtyMoneyItem = Config.ChildSupport.BlackMoneyName
Config.ChildSupportRequiresFatherOnline = Config.ChildSupport.RequireFatherOnline
Config.ChildSupportPayoutItem = Config.ChildSupport.PayToAccount

-- -
--  ANIMATION
-- -
Config.MaxDistance = 2.0    -- metres to start synced anim
Config.CancelKey   = 73     -- X key
Config.FinishKey   = 38     -- E key during paired scene

-- -
--  PREGNANCY
-- -
Config.Pregnancy = {
    DurationDays = 7, -- default real-life days
    DurationHours = 0, -- extra hours added on top of DurationDays
    MaxDurationDays = 30, -- hard cap for default and override durations
    VitaminRiskReduction = 5,
    VitaminDoseHours = 3,
    VitaminReminderHours = 3,
    PartnerRiskReduction = 5,
    RoleWhitelist = NewRoleWhitelist(), -- optional access lock for the pregnancy system
    RoleOverrides = {
        Enabled = false, -- optional per-role duration overrides
        Roles = {
            -- { job = 'police', gang = nil, citizenid = nil, durationDays = 3, durationHours = 0 },
        },
    },
}

Config.PregnancyDuration = Config.Pregnancy.DurationDays
Config.PregnancyDurationHours = Config.Pregnancy.DurationHours
Config.PregnancyMaxDuration = Config.Pregnancy.MaxDurationDays
Config.VitaminRiskReduction = Config.Pregnancy.VitaminRiskReduction
Config.VitaminDoseHours = Config.Pregnancy.VitaminDoseHours
Config.VitaminReminderHours = Config.Pregnancy.VitaminReminderHours
Config.PartnerRiskReduction = Config.Pregnancy.PartnerRiskReduction
Config.PregnancyRoleOverrides = Config.Pregnancy.RoleOverrides

Config.Risk = {
    pregnancy = {
        inside         = 80,   -- % chance when finishing inside (E key), unprotected
        both_protected = 1,
        condoms_only   = 5,
        contra_only    = 3,
        pullout_only   = 20,   -- % chance when pulling out (O key), unprotected
        unprotected    = 60,   -- % chance with no finish choice, unprotected
    },
    std = {
        both_protected = 2,
        condoms_only   = 5,
        contra_only    = 40,   -- pill does NOT block STDs
        pullout_only   = 40,
        unprotected    = 40,
    },
}

-- -
--  CONTRACEPTION / CONDOMS
-- -
Config.ContraceptionDuration = 72  -- hours per pill use
Config.CondomWindowMinutes   = 30  -- fallback cleanup window if animation never fires (condom is consumed on first animation regardless)

-- -
--  PLAN C  (morning-after pill)
--  Set PlanCEnabled = false to remove from pharmacy entirely
-- -
Config.PlanC = {
    Enabled = true,
    WindowHours = 24,
    FailureChance = 10,
}

Config.PlanCEnabled         = Config.PlanC.Enabled
Config.PlanCWindowHours     = Config.PlanC.WindowHours
Config.PlanCSuccessChance   = 100 - Config.PlanC.FailureChance

-- -
--  PARTNER SYSTEM
-- -
Config.PartnerRequestTimeout  = 30   -- seconds for unregister consent
Config.PartnerRequestCooldown = 60   -- seconds anti-spam cooldown
-- Partners NEVER transmit STDs to each other (even unprotected)
Config.PartnerSTDImmunity     = true

-- -
--  STD / HEALTH
-- -
Config.STDCheckCooldown  = 600   -- seconds between passive symptom ticks
Config.STDTransmitChance = 40    -- % base (overridden by protection matrix)

Config.Diseases = {
    { id='chlamydia',     label='Chlamydia',      curable=true,  treatDays=1   },
    { id='gonorrhea',     label='Gonorrhoea',     curable=true,  treatDays=1   },
    { id='syphilis',      label='Syphilis',       curable=true,  treatDays=3   },
    { id='hiv',           label='HIV',            curable=false, treatDays=999 },
    { id='herpes',        label='Herpes',         curable=false, treatDays=999 },
    { id='hpv',           label='HPV',            curable=true,  treatDays=7   },
    { id='trichomoniasis',label='Trichomoniasis', curable=true,  treatDays=1   },
}

-- -
--  PHARMACY SHOP
-- -
--  PHARMACY SHOP  - Edit prices, amounts, and icons here
-- -
Config.Pharmacy = {
    Enabled = true,
    RoleWhitelist = NewRoleWhitelist(),
    Items = {
        { itemKey='Condoms',          label='Condoms (x3)',            price=20,  amount=3, desc='Single-use STD and pregnancy barrier.',                icon='SAFE' },
        { itemKey='Contraception',    label='Contraception (Pill)',    price=40,  amount=1, desc='72h pregnancy risk reduction. No STD protection.',      icon='PILL' },
        { itemKey='PregnancyTest',    label='Pregnancy Test',          price=15,  amount=1, desc='Single-use home test kit.',                            icon='TEST' },
        { itemKey='PrenatalVitamins', label='Prenatal Vitamins (x5)',  price=30,  amount=5, desc='Dose timing follows Config.Pregnancy.VitaminDoseHours.', icon='VIT' },
        { itemKey='DNATest',          label='DNA Test',                price=75,  amount=1, desc='Paternity verification kit.',                           icon='DNA' },
        { itemKey='STDTestKit',       label='STD Test Kit (7-Panel)',  price=60,  amount=1, desc='Screen for 7 diseases.',                               icon='STD' },
        { itemKey='PrescriptionMeds', label='Prescription Medication', price=80,  amount=1, desc='Treats curable STDs.',                                 icon='RX' },
        { itemKey='PlanC',            label='Plan C (Morning-After)',  price=120, amount=1, desc='Emergency contraception. 90% effective within 24h.',    icon='PLAN', planc=true },
        { itemKey='RhinoPill',        label='Rhino Pill',              price=50,  amount=1, desc='Performance supplement. No mechanical effect.',        icon='RNO' },
        { itemKey='Lubricant',        label='Lubricant',               price=10,  amount=1, desc='Personal use.',                                        icon='LUBE' },
    }
}

Config.PharmacyEnabled = Config.Pharmacy.Enabled
Config.PharmacyItems = Config.Pharmacy.Items

for _, pharmacyItem in ipairs(Config.PharmacyItems) do
    if pharmacyItem.itemKey and Config.Items[pharmacyItem.itemKey] then
        pharmacyItem.item = Config.Items[pharmacyItem.itemKey]
    elseif type(pharmacyItem.item) ~= 'string' or pharmacyItem.item == '' then
        pharmacyItem.item = nil
    end

    pharmacyItem.price = math.max(0, math.floor(tonumber(pharmacyItem.price) or 0))
    pharmacyItem.amount = math.max(1, math.floor(tonumber(pharmacyItem.amount) or 1))
end

Config.AnimDescriptions = {
    ['Standing BJ']          = { desc='Standing. Requires a partner nearby.',   solo=false },
    ['Standing Sex']         = { desc='Standing. Requires a partner nearby.',   solo=false },
    ['Anal Sex']             = { desc='Standing. Requires a partner nearby.',   solo=false },
    ['Car Sex (Driver)']     = { desc='Must be driver. Partner in passenger.',  solo=false },
    ['Car Sex (Female Driver)'] = { desc='Female must be driver.',              solo=false },
    ['Car BJ (Driver)']      = { desc='Must be driver. Partner in passenger.',  solo=false },
    ['Missionary (M Lead)']  = { desc='Floor. Partner required.',               solo=false },
    ['Missionary (F Lead)']  = { desc='Floor. Partner required.',               solo=false },
    ['Doggystyle (M Lead)']  = { desc='Floor. Partner required.',               solo=false },
    ['Doggystyle (F Lead)']  = { desc='Floor. Partner required.',               solo=false },
    ['Cowgirl (M Lead)']     = { desc='Floor. Partner required.',               solo=false },
    ['Cowgirl (F Lead)']     = { desc='Floor. Partner required.',               solo=false },
    ['Spooning (M Lead)']    = { desc='Floor. Partner required.',               solo=false },
    ['Spooning (F Lead)']    = { desc='Floor. Partner required.',               solo=false },
    ['Standing Cowgirl (M Lead)'] = { desc='Standing against wall.',            solo=false },
    ['Standing Cowgirl (F Lead)'] = { desc='Standing against wall.',            solo=false },
    ['Wall Sex (M Lead)']    = { desc='Standing against wall.',                 solo=false },
    ['Wall Sex (F Lead)']    = { desc='Standing against wall.',                 solo=false },
}

-- -
--  STRINGS
-- -
Config.Strings = {
    RequestSent         = 'Invitation sent - awaiting consent.',
    RequestReceived     = '%s wants to perform: %s',
    TooFar              = 'Your partner is too far away.',
    NoPartner           = 'You must select a partner first.',
    NoOneClose          = 'No one nearby.',
    AnimCancelled       = 'Animation cancelled.',
    CancelPrompt        = '[~r~X~w~] Cancel',
    NoHandcuffs         = 'You can\'t do that while handcuffed.',
    NoLaststand         = 'You need medical attention!',
    NoDead              = 'You are dead.',
    NotInCar            = 'You are not in a vehicle.',
    PartnerSelected     = 'Partner selected: %s',
    PregnancyPos        = '- Test is positive.',
    PregnancyNeg        = '- Test is negative.',
    BirthAlert          = '- Your baby is ready! Visit a hospital.',
    STDPositive         = '- Positive for: %s',
    STDNegative         = '- All panels came back clean.',
    DNAMatch            = '- DNA Match: %s%%',
    ContraceptionActive = '- Contraception active for %sh.',
    CondomsActive       = '- Condom ready for next encounter.',
    VitaminsActive      = '- Prenatal vitamins active.',
    NotPregnant         = 'You are not pregnant.',
    UltrasoundReady     = '- Ultrasound report added to inventory.',
    PlanCSuccess        = '- Plan C taken. Pregnancy terminated.',
    PlanCFailed         = '- Plan C taken. No effect - not pregnant or window passed.',
    PlanCTooLate        = '- It\'s too late for Plan C to be effective.',
    -- Partner unregister consent
    UnregReqSent        = '- Unregister request sent to %s.',
    UnregReqReceived    = '- %s wants to end your connection. Accept?',
    UnregAccepted       = '- Connection ended by mutual consent.',
    UnregDeclined       = '- Unregister request was declined.',
    UnregTimedOut       = 'Unregister request timed out.',
    UnregSpam           = 'Please wait before sending another request.',
    UnregOffline        = 'Your partner must be online to unregister.',
    FinishPrompt        = '[~g~E~w~] Finish In Her   [~r~X~w~] Cancel',
    FinishTriggered     = 'Finish action triggered.',
}

-- -
--  SYNCED ANIMATIONS
-- -
Config.Animations = {
    { label='Standing BJ',   requesterLabel='Standing BJ',   category='standing', car=false,
      Requester={ type='animation', dict='misscarsteal2pimpsex', anim='pimpsex_hooker',  flags=1, attach={bone=9816,xP=0.0,yP=0.65,zP=0.0,xR=120.0,yR=0.0,zR=180.0} },
      Accepter ={ type='animation', dict='misscarsteal2pimpsex', anim='pimpsex_punter',  flags=1 } },

    { label='Standing Sex',  requesterLabel='Standing Sex',  category='standing', car=false,
      Requester={ type='animation', dict='misscarsteal2pimpsex', anim='shagloop_hooker', flags=1, attach={bone=9816,xP=0.05,yP=0.4,zP=0.0,xR=120.0,yR=0.0,zR=180.0} },
      Accepter ={ type='animation', dict='misscarsteal2pimpsex', anim='shagloop_pimp',   flags=1 } },

    { label='Anal Sex',      requesterLabel='Anal Sex',      category='standing', car=false,
      Requester={ type='animation', dict='rcmpaparazzo_2', anim='shag_loop_a',    flags=1 },
      Accepter ={ type='animation', dict='rcmpaparazzo_2', anim='shag_loop_poppy',flags=1, attach={bone=9816,xP=0.015,yP=0.35,zP=0.0,xR=0.9,yR=0.3,zR=0.0} } },

    { label='Car Sex (Driver)',requesterLabel='Car Sex',      category='vehicle',  car=true,
      Requester={ type='animation', dict='oddjobs@assassinate@vice@sex', anim='frontseat_carsex_loop_m', flags=1 },
      Accepter ={ type='animation', dict='oddjobs@assassinate@vice@sex', anim='frontseat_carsex_loop_f', flags=1 } },

    { label='Car Sex (Female Driver)',requesterLabel='Car Sex',category='vehicle', car=true,
      Requester={ type='animation', dict='random@drunk_driver_2', anim='cardrunksex_loop_f', flags=1 },
      Accepter ={ type='animation', dict='random@drunk_driver_2', anim='cardrunksex_loop_m', flags=1 } },

    { label='Car BJ (Driver)',requesterLabel='Car BJ',        category='vehicle',  car=true,
      Requester={ type='animation', dict='oddjobs@towing', anim='m_blow_job_loop', flags=1 },
      Accepter ={ type='animation', dict='oddjobs@towing', anim='f_blow_job_loop', flags=1 } },

    { label='Missionary (M Lead)',requesterLabel='Missionary',category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_missionary2m', anim='missionary2m', flags=1, attach={bone=1,xP=0.08,yP=0.02,zP=0.0,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_missionary2f', anim='missionary2f', flags=1 } },

    { label='Missionary (F Lead)',requesterLabel='Missionary',category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_missionary2f', anim='missionary2f', flags=1, attach={bone=1,xP=0.08,yP=0.02,zP=0.0,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_missionary2m', anim='missionary2m', flags=1 } },

    { label='Doggystyle (M Lead)',requesterLabel='Doggystyle',category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_doggystylem', anim='doggystylem', flags=1, attach={bone=1,xP=-0.35,yP=0.0,zP=0.0,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_doggystylef', anim='doggystylef', flags=1 } },

    { label='Doggystyle (F Lead)',requesterLabel='Doggystyle',category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_doggystylef', anim='doggystylef', flags=1 },
      Accepter ={ type='animation', dict='genesismods@erotica_doggystylem', anim='doggystylem', flags=1, attach={bone=1,xP=-0.35,yP=0.0,zP=0.0,xR=0.0,yR=0.0,zR=0.0} } },

    { label='Cowgirl (M Lead)',   requesterLabel='Cowgirl',   category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_cowgirlm', anim='cowgirlm', flags=1, attach={bone=1,xP=0.0,yP=0.05,zP=0.0,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_cowgirlf', anim='cowgirlf', flags=1 } },

    { label='Cowgirl (F Lead)',   requesterLabel='Cowgirl',   category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_cowgirlf', anim='cowgirlf', flags=1, attach={bone=1,xP=0.0,yP=0.05,zP=0.0,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_cowgirlm', anim='cowgirlm', flags=1 } },

    { label='Spooning (M Lead)',  requesterLabel='Spooning',  category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_spooningm', anim='spooningm', flags=1, attach={bone=1,xP=-0.09,yP=-0.20,zP=0.0,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_spooningf', anim='spooningf', flags=1 } },

    { label='Spooning (F Lead)',  requesterLabel='Spooning',  category='floor',   car=false,
      Requester={ type='animation', dict='genesismods@erotica_spooningf', anim='spooningf', flags=1 },
      Accepter ={ type='animation', dict='genesismods@erotica_spooningm', anim='spooningm', flags=1, attach={bone=1,xP=-0.09,yP=-0.20,zP=0.0,xR=0.0,yR=0.0,zR=0.0} } },

    { label='Standing Cowgirl (M Lead)',requesterLabel='Standing Cowgirl',category='standing',car=false,
      Requester={ type='animation', dict='genesismods@erotica_standingcowgirlm', anim='standingcowgirlm', flags=1, attach={bone=1,xP=-0.30,yP=0.0,zP=0.05,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_standingcowgirlf', anim='standingcowgirlf', flags=1 } },

    { label='Standing Cowgirl (F Lead)',requesterLabel='Standing Cowgirl',category='standing',car=false,
      Requester={ type='animation', dict='genesismods@erotica_standingcowgirlf', anim='standingcowgirlf', flags=1 },
      Accepter ={ type='animation', dict='genesismods@erotica_standingcowgirlm', anim='standingcowgirlm', flags=1, attach={bone=1,xP=-0.30,yP=0.0,zP=0.05,xR=0.0,yR=0.0,zR=0.0} } },

    { label='Wall Sex (M Lead)',  requesterLabel='Wall Sex',  category='standing',car=false,
      Requester={ type='animation', dict='genesismods@erotica_standingm', anim='standingm', flags=1, attach={bone=1,xP=-0.35,yP=0.02,zP=0.0,xR=0.0,yR=0.0,zR=0.0} },
      Accepter ={ type='animation', dict='genesismods@erotica_standingf', anim='standingf', flags=1 } },

    { label='Wall Sex (F Lead)',  requesterLabel='Wall Sex',  category='standing',car=false,
      Requester={ type='animation', dict='genesismods@erotica_standingf', anim='standingf', flags=1 },
      Accepter ={ type='animation', dict='genesismods@erotica_standingm', anim='standingm', flags=1, attach={bone=1,xP=-0.35,yP=0.02,zP=0.0,xR=0.0,yR=0.0,zR=0.0} } },
}

-- -
--  PHARMACY WORLD ZONE (ox_target)
-- -
Config.PharmacyZoneEnabled = true   -- set false to disable ox_target zone

Config.PharmacyLocations = {
    { label = 'Downtown Pharmacy',   coords = vector3(1164.8, -332.4, 69.2),  heading = 270.0, radius = 1.5 },
    { label = 'Sandy Pharmacy',      coords = vector3(1732.8, 3708.9, 34.2),  heading = 0.0,   radius = 1.5 },
    { label = 'Paleto Pharmacy',     coords = vector3(-112.3, 6424.0, 31.6),  heading = 90.0,  radius = 1.5 },
}


Config.ThemeOrder = { 'dark', 'pink', 'green', 'purple', 'teal' }

Config.FinishPromptScenes = {
    ['Car Sex (Driver)'] = true,
    ['Car Sex (Female Driver)'] = true,
    ['Missionary (M Lead)'] = true,
    ['Missionary (F Lead)'] = true,
    ['Doggystyle (M Lead)'] = true,
    ['Doggystyle (F Lead)'] = true,
    ['Cowgirl (M Lead)'] = true,
    ['Cowgirl (F Lead)'] = true,
    ['Spooning (M Lead)'] = true,
    ['Spooning (F Lead)'] = true,
    ['Standing Cowgirl (M Lead)'] = true,
    ['Standing Cowgirl (F Lead)'] = true,
    ['Wall Sex (M Lead)'] = true,
    ['Wall Sex (F Lead)'] = true,
}
