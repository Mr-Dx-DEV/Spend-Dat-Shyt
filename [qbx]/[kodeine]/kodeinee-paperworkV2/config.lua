Config = {}

-- Kodeinee Paperwork V2
-- This is the only escrow ignored file.

Config.Debug = true

Config.Framework = 'auto' -- auto, qb, qbox, esx
Config.Inventory = 'auto' -- auto, qb, ox, none

-- Commands
Config.Command = 'setpaperwork'          -- /setpaperwork or /setpaperwork id = police create/update
Config.ViewCommand = 'paperwork'         -- /paperwork, /paperwork id, /paperwork set id, /paperwork item id
Config.GiveItemCommand = 'paperworkitem' -- /paperworkitem id = police gives item copy

Config.PoliceJobs = {
    police = true,
    sheriff = true,
    state = true,
    bcso = true,
    lspd = true,
}

Config.AdminAce = 'kodeinee.paperwork.admin'
Config.AllowAdmins = true

Config.MaxNearbyPlayers = 10
Config.NearbyDistance = 8.0

Config.Statuses = {
    { value = 'solid', label = 'Solid', image = 'solid.png' },
    { value = 'cooperated', label = 'Cooperated', image = 'cooperated.png' },
    { value = 'snitch', label = 'Snitch', image = 'snitch.png' },
}

-- Inventory item support
Config.EnablePaperworkItem = true
Config.PaperworkItem = 'kodeinee_paperwork'
Config.PaperworkItems = {
    'kodeinee_paperwork',
    'paperwork'
}

-- Cooldown blocks creating another copy for the same player until this time passes.
Config.CopyCooldownHours = 24
Config.AllowPoliceBypassCopyCooldown = false

-- Metadata displayed on the item in qb/ox inventories.
Config.ItemLabelFormat = "%s's Police Paperwork"
Config.ItemDescriptionFormat = "Police paperwork for %s. Issued by %s."

Config.Notifications = {
    Saved = 'Paperwork saved.',
    NoPermission = 'You do not have permission to use this.',
    NoPlayers = 'No nearby players found.',
    NoPaperwork = 'No paperwork found for this person. Police must create it first.',
    InvalidTarget = 'Invalid target selected. Use a valid player ID.',
    ItemGiven = 'Paperwork copy created and given to player.',
    ItemReceived = 'You received your police paperwork copy.',
    CopyCooldown = 'This player already received a paperwork copy recently. Try again later.',
    InventoryError = 'Inventory could not add the paperwork item. Make sure the item exists in your inventory.',
}

Config.SQLTable = 'paperwork'
Config.SQLCopiesTable = 'paperwork_copies'
