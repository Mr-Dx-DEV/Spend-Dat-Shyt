-- =====================================================================
-- STRAINS
-- Each entry has:
--   Label = name shown to players in menus
--   Type  = which strain effect profile to use (see Config.StrainEffects in config.lua)
--           Must match one of: 'sativa', 'indica', 'hybrid' (or a custom type you added).
--   Stats = base effects per hit: Stress reduction, Armor gain, High added.
--           Gets combined with the smoking device's own Stats.
-- =====================================================================
Config.Strains = {
    ['ak47']            = { Label = "AK-47",              Type = "sativa",  Stats = { Stress = 10, Armor = 0, High = 15 } },
    ['applefritter']    = { Label = "Apple Fritter",      Type = "hybrid",  Stats = { Stress = 14, Armor = 3, High = 22 } },
    ['applegelato']     = { Label = "Apple Gelato",       Type = "hybrid",  Stats = { Stress = 13, Armor = 2, High = 21 } },
    ['appleruntz']      = { Label = "Apple Runtz",        Type = "hybrid",  Stats = { Stress = 12, Armor = 2, High = 20 } },
    ['bananakush']      = { Label = "Banana Kush",        Type = "indica",  Stats = { Stress = 16, Armor = 4, High = 18 } },
    ['biscotti']        = { Label = "Biscotti",           Type = "indica",  Stats = { Stress = 15, Armor = 5, High = 22 } },
    ['blackice']        = { Label = "Black Ice",          Type = "hybrid",  Stats = { Stress = 14, Armor = 3, High = 24 } },
    ['blueberrycruff']  = { Label = "Blueberry Cruff",    Type = "indica",  Stats = { Stress = 16, Armor = 4, High = 19 } },
    ['bluedream']       = { Label = "Blue Dream",         Type = "sativa",  Stats = { Stress = 11, Armor = 0, High = 20 } },
    ['bluetomyz']       = { Label = "Blue Tomyz",         Type = "indica",  Stats = { Stress = 14, Armor = 3, High = 21 } },
    ['bluezlushie']     = { Label = "Blue Zlushie",       Type = "indica",  Stats = { Stress = 15, Armor = 4, High = 20 } },
    ['bomptonberries']  = { Label = "Bompton Berries",    Type = "indica",  Stats = { Stress = 16, Armor = 5, High = 23 } },
    ['bubbakush']       = { Label = "Bubba Kush",         Type = "indica",  Stats = { Stress = 18, Armor = 6, High = 17 } },
    ['cakemix']         = { Label = "Cake Mix",           Type = "hybrid",  Stats = { Stress = 13, Armor = 3, High = 21 } },
    ['cerealmilk']      = { Label = "Cereal Milk",        Type = "hybrid",  Stats = { Stress = 12, Armor = 2, High = 19 } },
    ['cheetahpiss']     = { Label = "Cheetah Piss",       Type = "sativa",  Stats = { Stress = 10, Armor = 0, High = 24 } },
    ['cherryfritter']   = { Label = "Cherry Fritter",     Type = "hybrid",  Stats = { Stress = 14, Armor = 3, High = 22 } },
    ['cherrygumbo']     = { Label = "Cherry Gumbo",       Type = "indica",  Stats = { Stress = 15, Armor = 4, High = 23 } },
    ['collinsave']      = { Label = "Collins Ave",        Type = "sativa",  Stats = { Stress = 11, Armor = 1, High = 22 } },
    ['dankdough']       = { Label = "Dank Dough",         Type = "hybrid",  Stats = { Stress = 13, Armor = 3, High = 20 } },
    ['ether']           = { Label = "Ether",              Type = "hybrid",  Stats = { Stress = 14, Armor = 4, High = 26 } },
    ['finechina']       = { Label = "Fine China",         Type = "hybrid",  Stats = { Stress = 13, Armor = 2, High = 21 } },
    ['fishscale']       = { Label = "Fish Scale",         Type = "sativa",  Stats = { Stress = 10, Armor = 1, High = 23 } },
    ['flowerpower']     = { Label = "Flower Power",       Type = "sativa",  Stats = { Stress = 11, Armor = 0, High = 18 } },
    ['frosties']        = { Label = "Frosties",           Type = "indica",  Stats = { Stress = 16, Armor = 5, High = 21 } },
    ['garypaytons']     = { Label = "Gary Payton",        Type = "hybrid",  Stats = { Stress = 14, Armor = 3, High = 25 } },
    ['gelato']          = { Label = "Gelato",             Type = "hybrid",  Stats = { Stress = 14, Armor = 4, High = 24 } },
    ['gelatti']         = { Label = "Gelatti",            Type = "hybrid",  Stats = { Stress = 13, Armor = 3, High = 23 } },
    ['georgia']         = { Label = "Georgia",            Type = "hybrid",  Stats = { Stress = 12, Armor = 2, High = 19 } },
    ['girlscout']       = { Label = "Girl Scout Cookies", Type = "hybrid",  Stats = { Stress = 14, Armor = 4, High = 23 } },
    ['gmocookies']      = { Label = "GMO Cookies",        Type = "indica",  Stats = { Stress = 17, Armor = 5, High = 22 } },
    ['gorillaglue']     = { Label = "Gorilla Glue",       Type = "hybrid",  Stats = { Stress = 15, Armor = 5, High = 25 } },
    ['gumbo']           = { Label = "Gumbo",              Type = "indica",  Stats = { Stress = 16, Armor = 5, High = 24 } },
    ['gushmintz']       = { Label = "Gush Mintz",         Type = "hybrid",  Stats = { Stress = 13, Armor = 3, High = 22 } },
    ['icecreamcake']    = { Label = "Ice Cream Cake",     Type = "indica",  Stats = { Stress = 17, Armor = 5, High = 21 } },
    ['jefe']            = { Label = "Jefe",               Type = "indica",  Stats = { Stress = 16, Armor = 4, High = 23 } },
    ['khalifakush']     = { Label = "Khalifa Kush",       Type = "sativa",  Stats = { Stress = 11, Armor = 1, High = 22 } },
    ['laconfidential']  = { Label = "LA Confidential",    Type = "indica",  Stats = { Stress = 18, Armor = 6, High = 20 } },
    ['lemonchello']     = { Label = "Lemonchello",        Type = "sativa",  Stats = { Stress = 10, Armor = 0, High = 21 } },
    ['lemoncherry']     = { Label = "Lemon Cherry",       Type = "hybrid",  Stats = { Stress = 12, Armor = 2, High = 20 } },
    ['loundoncake']     = { Label = "Loudon Cake",        Type = "indica",  Stats = { Stress = 15, Armor = 4, High = 22 } },
    ['marathonog']      = { Label = "Marathon OG",        Type = "indica",  Stats = { Stress = 16, Armor = 5, High = 21 } },
    ['marshmallowog']   = { Label = "Marshmallow OG",     Type = "indica",  Stats = { Stress = 15, Armor = 4, High = 19 } },
    ['mochi']           = { Label = "Mochi",              Type = "hybrid",  Stats = { Stress = 13, Armor = 3, High = 22 } },
    ['moonrocks']       = { Label = "Moon Rocks",         Type = "hybrid",  Stats = { Stress = 18, Armor = 6, High = 30 } },
    ['naterobinson']    = { Label = "Nate Robinson",      Type = "hybrid",  Stats = { Stress = 13, Armor = 2, High = 21 } },
    ['northenlights']   = { Label = "Northern Lights",    Type = "indica",  Stats = { Stress = 18, Armor = 6, High = 19 } },
    ['ogkush']          = { Label = "OG Kush",            Type = "indica",  Stats = { Stress = 15, Armor = 5, High = 20 } },
    ['oreoz']           = { Label = "Oreoz",              Type = "indica",  Stats = { Stress = 16, Armor = 5, High = 23 } },
    ['papplexpress']    = { Label = "Pineapple Express",  Type = "sativa",  Stats = { Stress = 10, Armor = 0, High = 22 } },
    ['pircklypear']     = { Label = "Prickly Pear",       Type = "hybrid",  Stats = { Stress = 12, Armor = 2, High = 18 } },
    ['purplehaze']      = { Label = "Purple Haze",        Type = "sativa",  Stats = { Stress = 10, Armor = 0, High = 25 } },
    ['runtzog']         = { Label = "Runtz OG",           Type = "hybrid",  Stats = { Stress = 14, Armor = 3, High = 24 } },
    ['snowman']         = { Label = "Snowman",            Type = "hybrid",  Stats = { Stress = 13, Armor = 3, High = 21 } },
    ['sourdiesel']      = { Label = "Sour Diesel",        Type = "sativa",  Stats = { Stress = 10, Armor = 0, High = 23 } },
    ['tahoeog']         = { Label = "Tahoe OG",           Type = "indica",  Stats = { Stress = 17, Armor = 6, High = 20 } },
    ['trainwreck']      = { Label = "Trainwreck",         Type = "sativa",  Stats = { Stress = 11, Armor = 1, High = 25 } },
    ['whitecherrygel']  = { Label = "White Cherry Gelato",Type = "hybrid",  Stats = { Stress = 14, Armor = 3, High = 23 } },
    ['whiteruntz']      = { Label = "White Runtz",        Type = "hybrid",  Stats = { Stress = 13, Armor = 3, High = 24 } },
    ['whitewidow']      = { Label = "White Widow",        Type = "hybrid",  Stats = { Stress = 12, Armor = 2, High = 18 } },
    ['ygog']            = { Label = "YG OG",              Type = "indica",  Stats = { Stress = 16, Armor = 5, High = 21 } },
    ['zazitos']         = { Label = "Zazitos",            Type = "hybrid",  Stats = { Stress = 13, Armor = 2, High = 22 } },
    ['zushi']           = { Label = "Zushi",              Type = "indica",  Stats = { Stress = 15, Armor = 4, High = 25 } },
}

if Config.Components then
    for strainCode, strain in pairs(Config.Strains) do
        local gramKey = strainCode .. '_gram'
        if not Config.Components[gramKey] then
            Config.Components[gramKey] = {
                Role = 'weed',
                Label = strain.Label,
                Strain = strainCode,
                GramsPerUnit = 1.0,
            }
        end
    end
end

-- Don't Touch: auto-builds the list of weed refill items (one per strain + hashish) used by bongs/pipes.
if Config.Refills then
    Config.Refills['weed'] = {}
    for strainCode in pairs(Config.Strains) do
        Config.Refills['weed'][#Config.Refills['weed'] + 1] = strainCode .. '_gram'
    end
    Config.Refills['weed'][#Config.Refills['weed'] + 1] = 'dc_hashish'
end
