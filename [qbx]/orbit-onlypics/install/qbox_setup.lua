-- ============================================
-- Orbit OnlyPics v2.0.0 — QBOX INSTALLATION
-- ============================================
-- For QBox, follow these steps:
--
-- ⚠️  SCREENCAPTURE USERS - READ THIS:
-- If your server runs the "screencapture" resource it will hijack
-- screenshot-basic's client exports and break photo capture.
-- You MUST start screenshot-basic and orbit-onlypics BEFORE screencapture
-- in your server.cfg:
--
--   ensure screenshot-basic
--   ensure orbit-onlypics
--   ensure screencapture    <-- must be AFTER the two above
--
-- ⚠️  IMPORTANT: QBox usually ships with ox_inventory by default.
-- If you're using ox_inventory (check resources folder), use
-- install/ox_inventory_setup.lua instead of this file!
--
-- ============================================

-- [[[ STEP 1: RUN DATABASE SETUP ]]]
-- Run install/database.sql in your database first.

-- [[[ STEP 2: ADD ITEMS TO SQL (if using legacy qb-inventory) ]]]

INSERT INTO `items` (`name`, `label`, `weight`, `decay`, `remove`, `description`, `stack`, `close`, `client`)
VALUES
('baddie_cam', 'Baddie Camera', 500, NULL, 1, 'Exclusive camera for taking photos', false, true, NULL),
('baddie_pic', 'Photograph', 100, NULL, 1, 'A developed photograph ready for sale', true, true, NULL),
('baddie_bundle', 'Photo Bundle', 500, NULL, 1, 'A collection of photographs', false, true, NULL),
('baddie_phone', 'Baddie Phone', 190, NULL, 1, 'A phone with the OnlyPics app on it', false, true, NULL);

-- ============================================
-- [[[ STEP 3: SHARED ITEMS (if using qbx-core inventory) ]]]
-- Add to: qbx-core/shared/items.lua or your items file
-- ============================================

['baddie_cam'] = {
    name = 'baddie_cam',
    label = 'Baddie Camera',
    weight = 500,
    type = 'item',
    image = 'baddie_cam.png',
    unique = false,
    useable = true,
    shouldClose = true,
    description = 'Exclusive camera for taking photos'
},

['baddie_pic'] = {
    name = 'baddie_pic',
    label = 'Photograph',
    weight = 100,
    type = 'item',
    image = 'baddie_pic.png',
    unique = false,
    useable = true,
    shouldClose = true,
    description = 'A developed photograph ready for sale'
},

['baddie_bundle'] = {
    name = 'baddie_bundle',
    label = 'Photo Bundle',
    weight = 500,
    type = 'item',
    image = 'baddie_bundle.png',
    unique = false,
    useable = true,
    shouldClose = true,
    description = 'A collection of photographs'
},

['baddie_phone'] = {
    name = 'baddie_phone',
    label = 'Baddie Phone',
    weight = 190,
    type = 'item',
    image = 'baddie_phone.png',
    unique = false,
    useable = true,
    shouldClose = true,
    description = 'A phone with the OnlyPics app on it'
},

-- ============================================
-- [[[ CHECK YOUR SETUP ]]]
--   Using OX Inventory with QBox?  → Use install/ox_inventory_setup.lua instead
--   Using QBox's built-in inventory? → Use the steps above
--
-- [[[ STEP 4: ADD IMAGES ]]]
-- Drop baddie_cam.png, baddie_pic.png, baddie_bundle.png, and baddie_phone.png into your
-- inventory's images folder.
--
-- [[[ STEP 5: RESTART ]]]
-- Restart your core, inventory, and orbit-onlypics.
--
-- V2 PLAYER COMMANDS:
--   /onlypics     → Start a photo sale
--   /topbaddies   → Open the leaderboard
--   /baddiestats  → View your rank, XP, followers, earnings
--   /baddiegoals  → Daily + weekly challenges
--   /baddieawards → Achievement grid
-- ============================================