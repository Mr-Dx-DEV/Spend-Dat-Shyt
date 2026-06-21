--[[
Configuration for Dumps
This script defines a list of dumps with associated prices, subtypes, and types.
Each dump represents an entry with details such as name, price, subtype, and type.
]]

dumpsConfig = {}

-- Example Entry:
-- { name = "John Doe", price = 10, subtypes = { "Gold" }, type = { "Credit" } }
-- - name: The name of the individual associated with the dump.
-- - price: The price of the dump in DEVC (Equivalent to BTC).
-- - subtypes: Categories such as Gold, Silver, Bronze, etc.
-- - type: The type of account or card (Credit, Debit, Prepaid, etc.).


-- all prices assuming $100,000 USD btc price. prices scale depending on multiplier set in crypto_config.lua
dumpsConfig.dumps = {
    { name = "Alex Johnson", price = 0.001800, subtypes = { "Silver" }, type = { "Credit" } }, -- $180
    { name = "Martha Wilson", price = 0.000600, subtypes = { "Bronze" }, type = { "Debit" } }, -- $60
    { name = "Samuel Perkins", price = 0.002500, subtypes = { "Gold" }, type = { "Credit" } }, -- $250
    { name = "Lila Gomez", price = 0.001400, subtypes = { "Silver" }, type = { "Prepaid" } }, -- $140
    { name = "Jonathan Baker", price = 0.001000, subtypes = { "Classic" }, type = { "Credit" } }, -- $100
    { name = "Emma Sanders", price = 0.003200, subtypes = { "Diamond" }, type = { "Business" } }, -- $320
    { name = "Ethan Mills", price = 0.000900, subtypes = { "Bronze" }, type = { "Debit" } }, -- $90
    { name = "Sophia Carter", price = 0.002100, subtypes = { "Platinum" }, type = { "Prepaid" } }, -- $210
    { name = "Liam Peterson", price = 0.001900, subtypes = { "Gold" }, type = { "Credit" } }, -- $190
    { name = "Olivia Reed", price = 0.002700, subtypes = { "Premium" }, type = { "Credit" } }, -- $270
    { name = "Noah Turner", price = 0.001300, subtypes = { "Classic" }, type = { "Debit" } }, -- $130
    { name = "Ava Mitchell", price = 0.002300, subtypes = { "Platinum" }, type = { "Prepaid" } }, -- $230
    { name = "William Parker", price = 0.003800, subtypes = { "Exclusive" }, type = { "Business" } }, -- $380
    { name = "Emily Lopez", price = 0.000700, subtypes = { "Bronze" }, type = { "Debit" } }, -- $70
    { name = "James Harris", price = 0.003000, subtypes = { "Diamond" }, type = { "Credit" } }, -- $300
    { name = "Evelyn Walker", price = 0.001500, subtypes = { "Classic" }, type = { "Debit" } }, -- $150
    { name = "Michael Brown", price = 0.002000, subtypes = { "Platinum" }, type = { "Prepaid" } }, -- $200
    { name = "Charlotte Davis", price = 0.002800, subtypes = { "Premium" }, type = { "Credit" } }, -- $280
    { name = "Benjamin Wilson", price = 0.004000, subtypes = { "Exclusive" }, type = { "Business" } }, -- $400
    { name = "Lucas Martinez", price = 0.000700, subtypes = { "Bronze" }, type = { "Debit" } }, -- $70
    { name = "Amelia Scott", price = 0.003300, subtypes = { "Diamond" }, type = { "Credit" } }, -- $330
    { name = "Alexander Young", price = 0.001700, subtypes = { "Silver" }, type = { "Prepaid" } }, -- $170
    { name = "Elizabeth Moore", price = 0.002000, subtypes = { "Silver" }, type = { "Credit" } }, -- $200
    { name = "Matthew Taylor", price = 0.000800, subtypes = { "Bronze" }, type = { "Debit" } }, -- $80
    { name = "Chloe Anderson", price = 0.002700, subtypes = { "Gold" }, type = { "Credit" } }, -- $270
    { name = "Andrew Thomas", price = 0.002800, subtypes = { "Premium" }, type = { "Credit" } }, -- $280
    { name = "Mia Lewis", price = 0.003300, subtypes = { "Diamond" }, type = { "Business" } }, -- $330
    { name = "Ryan Martin", price = 0.000900, subtypes = { "Bronze" }, type = { "Debit" } }, -- $90
    { name = "Isabella Thompson", price = 0.002000, subtypes = { "Platinum" }, type = { "Prepaid" } }, -- $200
    { name = "Jacob Garcia", price = 0.002000, subtypes = { "Gold" }, type = { "Credit" } }, -- $200
    { name = "Zachary Bell", price = 0.001500, subtypes = { "Classic" }, type = { "Debit" } }, -- $150
    { name = "Sophia Green", price = 0.003200, subtypes = { "Premium" }, type = { "Credit" } }, -- $320
    { name = "Jack Adams", price = 0.001700, subtypes = { "Silver" }, type = { "Prepaid" } }, -- $170
    { name = "Emma Clark", price = 0.003500, subtypes = { "Diamond" }, type = { "Credit" } }, -- $350
    { name = "Oliver Hall", price = 0.004500, subtypes = { "Exclusive" }, type = { "Business" } }, -- $450
    { name = "Ava Baker", price = 0.002200, subtypes = { "Platinum" }, type = { "Prepaid" } }, -- $220
    { name = "Mason Wright", price = 0.000800, subtypes = { "Bronze" }, type = { "Debit" } }, -- $80
    { name = "Liam Edwards", price = 0.000900, subtypes = { "Bronze" }, type = { "Debit" } }, -- $90
    { name = "Ella Carter", price = 0.001800, subtypes = { "Silver" }, type = { "Prepaid" } }, -- $180
    { name = "Lucas Turner", price = 0.002800, subtypes = { "Premium" }, type = { "Credit" } }, -- $280
    { name = "Aria Morris", price = 0.002000, subtypes = { "Gold" }, type = { "Credit" } }, -- $200
    { name = "Noah Collins", price = 0.003400, subtypes = { "Diamond" }, type = { "Business" } }, -- $340
    { name = "Mila Sanders", price = 0.004500, subtypes = { "Exclusive" }, type = { "Business" } }, -- $450
    { name = "Ethan Nelson", price = 0.002000, subtypes = { "Silver" }, type = { "Credit" } }, -- $200
    { name = "Isabella Ward", price = 0.001700, subtypes = { "Silver" }, type = { "Prepaid" } }, -- $170
    { name = "William Gray", price = 0.002200, subtypes = { "Platinum" }, type = { "Prepaid" } }, -- $220
    { name = "Chloe Foster", price = 0.000900, subtypes = { "Bronze" }, type = { "Debit" } }, -- $90
    { name = "James Hughes", price = 0.003000, subtypes = { "Premium" }, type = { "Credit" } }, -- $300
}

