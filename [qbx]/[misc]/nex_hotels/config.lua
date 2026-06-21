Config = {}

---@type 'qbox'|'esx'|'qbcore'|'ox'
Config.Framework = 'qbox'

-- ─── Language ───────────────────────────────────────────────
-- Which locales/<code>.json file the script (notifications, prompts, rent UI)
-- reads its text from. "en" → locales/en.json. Ships with English ("en") and
-- Spanish ("es"). To add a language, copy locales/en.json to locales/<code>.json,
-- translate the values, set this to that <code>, and restart. Any key a
-- translation leaves out falls back to English, so nothing renders blank.
Config.Locale = 'en'

-- Toggle to draw debug zones at every entrance / room door
Config.Debug = false

-- ─── UI theme ───────────────────────────────────────────────
-- The in-game panels are a black + single-accent design. By default that
-- accent is white; set it to ANY color and every accented element (headings,
-- buttons, highlights, borders, glows) recolors to match. Text that sits on
-- top of the accent fill auto-switches between black/white for readability,
-- so any color stays legible.
--
-- Accepts a hex string ('#E11D48', '#0EA5E9', '#FFFFFF') or an "R,G,B" triplet
-- ('225,29,72'). Tip: pick a bright/vivid color — the design is tuned for the
-- accent to read as a light highlight against the near-black background.
Config.Theme = {
    AccentColor = '#FFFFFF',
}

-- ─── Interaction style ──────────────────────────────────────────
-- Pick the one your server already uses.
--   'textui'  → ox_lib showTextUI prompt + key press to interact
--               (default; works out of the box, only needs ox_lib)
--   'target'  → ox_target eye-tracking — point at things, click an option
--               (requires the `ox_target` resource to be started)
-- If 'target' is chosen but ox_target isn't present, the script falls back
-- to 'textui' automatically and prints a warning to the F8 console.
---@type 'textui'|'target'
Config.Interact = 'textui'

-- Interaction key for textui mode (default: E = 38). Ignored when Config.Interact = 'target'.
Config.InteractKey = 38

-- Distance at which the "Front Desk" / "Check Out" prompt shows
Config.InteractDistance = 1.8

-- Screen fade duration (ms) when teleporting in/out of a room
Config.FadeDuration = 600

-- Default payment account: 'cash' | 'bank'
Config.PaymentAccount = 'bank'

-- ─── Rental duration ────────────────────────────────────────
Config.Rent = {
    MinDays = 1,    -- can't rent for less than this
    MaxDays = 30,   -- can't rent / extend beyond this in one transaction
    -- How often the server scans for and evicts expired rentals (ms).
    -- Lower = faster eviction; higher = less DB load. 60s is a good default.
    SweepIntervalMs = 60000,
}

-- ─── How many rooms one player may rent ─────────────────────
-- Caps how many rooms a single character can hold at once. Enforced server-side
-- on every rent attempt, so changing these takes effect immediately on restart.
--   PerHotel → max rooms in any ONE hotel. 1 = the classic "one room per hotel"
--              behavior. Set to 3 to let a player hold up to 3 rooms in the same
--              hotel. Minimum 1.
--   Total    → max rooms across ALL hotels combined. 0 = unlimited (a player can
--              keep renting at as many hotels as they like, PerHotel each).
Config.RentLimits = {
    PerHotel = 1,
    Total    = 0,
}

-- ─── Hotel ownership ────────────────────────────────────────
-- Optional feature: lets players purchase entire hotels for a `retail_price`
-- and earn passive rental income via a job society account.
--
-- When ON:
--   • Admin sets `retail_price` and a `job_name` (job lock) per hotel via /hoteladmin.
--   • Players see a "Buy Hotel" CTA at the front desk; on purchase they become
--     the owner_identifier and the hotel is locked to job_name.
--   • Owner + anyone holding job_name at boss grade can use /myhotel to manage
--     rooms, elevators, blip, ped, descriptions. They CANNOT relocate the
--     building, change the retail price, or delete the hotel.
--   • Rent + extension payments deposit into the job's society account
--     (qb-banking / qb-management / esx_addonaccount) when available, else
--     into the owner's personal bank if online.
--   • The job MUST already exist in your framework — this script does not
--     create jobs. Predefine each hotel's job_name in your qbox/qbcore/esx
--     job config, then enter it in the admin panel's Ownership section.
--
-- When OFF: the Pricing section, Ownership section, and Buy CTA are all
-- hidden, and any leftover ownership rows in the DB are ignored.
Config.HotelOwnership = true

-- Percentage of each rent / extension payment that's deposited to the hotel's
-- society account. The remainder is the server's cut and is discarded (never
-- credited anywhere). 100 = owner gets everything (original behavior),
-- 80 = 20% server tax, 0 = no payout at all. Clamped to [0, 100].
Config.SocietyCutPercent = 100

-- ─── Inventory stash capacity (ox_inventory) ────────────────
-- Size of the per-room stashes and the per-player recovery locker. `slots` is the
-- number of item slots; `weight` is the max total weight in GRAMS (100000 = 100kg).
-- These apply to every room that has the matching coord set in /hoteladmin:
--   storage  → the room's storage closet
--   safe     → the in-room safe (smaller, for valuables)
--   recovery → the personal locker that holds items pulled from a room when a
--              rental ends (one shared locker per character, not per room)
-- Only takes effect for stashes registered after a resource restart.
Config.StashCapacity = {
    storage  = { slots = 50,  weight = 100000 },
    safe     = { slots = 10,  weight = 25000  },
    recovery = { slots = 100, weight = 200000 },
}

-- ─── Minibar (ox_inventory shop) ─────────────────────────────
-- Each room with a minibar coord registers a private shop with this stock.
-- Stock is per-room; restocked when the resource restarts. Item names must
-- match entries in your ox_inventory items list.
Config.Minibar = {
    { name = 'water',    price = 10, count = 50 },  -- drink
    { name = 'sandwich', price = 25, count = 50 },  -- food
}

-- Ace groups allowed to run /hoteladmin. Each entry is checked as `group.<name>`,
-- which matches the FiveM principal system (e.g. `add_principal identifier.xxx group.admin`).
-- Framework admin groups (qbox/qbcore "admin"/"god", esx "admin"/"superadmin") are also honored.
Config.AdminGroups = { 'admin' }

-- All hotel/room data lives in MySQL (see install.sql) and is managed in-game via /hoteladmin.
