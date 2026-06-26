-- Add this inside ox_inventory/data/items.lua

['kodeinee_paperwork'] = {
    label = 'Police Paperwork',
    weight = 0,
    stack = false,
    close = true,
    description = 'Unique police paperwork for one player.',
    client = {
        event = 'kodeinee-paperworkV2:client:usedItem'
    }
},

-- Optional old item name support if your server already uses paperwork:
['paperwork'] = {
    label = 'Paperwork',
    weight = 0,
    stack = false,
    close = true,
    description = 'Unique police paperwork for one player.',
    client = {
        event = 'kodeinee-paperworkV2:client:usedItem'
    }
},
