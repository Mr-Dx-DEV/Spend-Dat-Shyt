--[[
Configuration for Debugging and Items
This script manages debugging settings and a list of items used in the system.
]]

Config = {}

--[[
debug:
If set to `true`, debug mode is enabled, which provides additional information 
during script execution for troubleshooting purposes. Set to `false` to disable.
]]
Config.debug = false
Config.max5GAdapterUse = 4 -- Maximum times player can use 5G Adapter
Config.dispatch = 'ps' -- [ps, rcore, cd, or custom (configurable in client/open.lua)]
Config.chequeBouncechance = 75 -- Chance for cheque to bounce (0-100)

Config.items = {
    ['blank_card'] --[[ Leave This ]] = 'blank_card', --[[ Change This ]] -- Represents a blank card in the system
    ['written_card'] = 'written_card', -- Represents a card with written data
    ['fraud_laptop'] = 'fraud_laptop', -- Represents a laptop used for fraudulent activities
    ['card_writer'] = 'card_writer',
    ['trap_phone'] = 'trap_phone',
    ['wifi_adapter'] = 'wifi_adapter',
    ['5g_adapter'] = '5g_adapter',
    ['blank_sim'] = 'blank_sim',
    ['written_sim'] = 'written_sim',
    ['printer'] = 'printer', -- Represents a printer for printing cheques
    ['blank_cheque'] = 'blank_cheque', -- Represents a blank cheque
    ['cheque'] = 'cheque' -- Represents a written/printed cheque
}

Config.atms = { -- All ATM Props
    'prop_atm_01',
    'prop_atm_02',
    'prop_fleeca_atm',
    'prop_atm_03'
}