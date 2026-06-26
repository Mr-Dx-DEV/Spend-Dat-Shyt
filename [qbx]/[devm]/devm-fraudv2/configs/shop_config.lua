shopConfig = {
    Shop = {
        Enabled = true, -- ✅ Enable/Disable the shop
        Coords = vector4(871.2375, -2100.4568, 29.4707, 97.4089), -- 📌 Location of the NPC
        Account = 'money',
        Blip = {
            Enabled = true,
            Sprite = 500, -- 🏪 Blip Icon
            Scale = 0.5,  -- 📏 Blip Size
            Color = 1,     -- 🔴 Blip Color (1 = Red)
            Name = "Fraud Market" -- 🏷️ Blip Name
        }
    },
    Job = {
        Enabled = true, -- ✅ Require a job to access?
        Name = "fraudster" -- 🔹 Job name (set if enabled)
    },
    Prices = { -- 🏷️ Item Prices
        blank_sim = 40,      -- 💳 Blank SIM Card
        blank_card = 50,     -- 💳 Blank Card
        blank_cheque = 50,  -- 📄 Blank Cheques
        card_writer = 500,
        printer = 1250,       -- 🖨️ Printer
        fraud_laptop = 1500,        -- 💻 Hacking Laptop
        trap_phone = 500,     -- 📱 Trap Phone
        ["5g_adapter"] = 200, -- 📡 5G Module
        wifi_adapter = 250     -- 📶 WiFi Module
    },
    Locales = {
        lack_perms_shop = "❌ You do not have access to this shop.",
        cannot_afford = "❌ You cannot afford {0}x {1}!"
    }
}
