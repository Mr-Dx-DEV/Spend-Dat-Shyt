--[[
    FearX Bridge Configuration
]]

BridgeConfig = {
    --[[
        Framework Detection
        Options: 'auto', 'esx', 'qbcore', 'qbox', 'standalone'
    ]]
    Framework = 'auto',

    --[[
        Inventory Detection
        Options: 'auto', 'ox_inventory', 'qb-inventory', 'ps-inventory', 'qs-inventory', 'core_inventory', 'codem-inventory', 'esx', 'qb', 'none'
    ]]
    Inventory = 'auto',

    --[[
        Target System Detection
        Options: 'auto', 'ox_target', 'qb-target', 'qtarget', 'none'
    ]]
    Target = 'auto',

    --[[
        Notification & TextUI System
        Options: 'fearx' (built-in), 'ox_lib', 'okok', 'esx', 'qb', 'native'
        Default: 'fearx' - Uses the built-in FearX notification and TextUI system
    ]]
    Notify = 'fearx',

    --[[
        Clothing/Appearance System Detection
        Options: 'auto', 'illenium-appearance', 'fivem-appearance', 'bl_appearance', 'qb-clothing', 'esx_skin', 'skinchanger', 'codem-appearance', 'ox_appearance', 'wasabi_clothing', 'rcore_clothing', 'none'
    ]]
    Clothing = 'auto',

    --[[
        Garage System Detection
        Options: 'auto', 'qs-advancedgarages', 'jg-advancedgarages', 'cd_garage', 'okokGarage', 'qb-garages', 'loaf_garage', 'ak47_qb_garage', 'renzu_garage', 'ND_Garage', 'mGarage', 'none'
    ]]
    Garage = 'auto',

    --[[
        Ambulance/Death System Detection
        Options: 'auto', 'p_ambulancejob', 'ak47_ambulancejob', 'ak47_qb_ambulancejob', 'qbx_medical', 'wasabi_ambulance', 'brutal_ambulance', 'esx_ambulancejob', 'qb-ambulancejob', 'ars_ambulancejob', 'cd_dispatch', 'ps-dispatch', 'none'
    ]]
    Ambulance = 'auto',

    --[[
        TextUI Position
        Options: 'right-center', 'left-center', 'bottom-center', 'top-center', 'center'
    ]]
    TextUIPosition = 'right-center',
}
