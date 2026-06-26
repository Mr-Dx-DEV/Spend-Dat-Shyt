-- ============================================
-- Orbit OnlyPics v2.0.0 — QBCORE INSTALLATION
-- ============================================
-- For QBCore you need ALL steps below:
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
-- ============================================

-- [[[ STEP 1: RUN DATABASE SETUP ]]]
-- Run install/database.sql in your database first.

-- [[[ STEP 2: ADD ITEMS TO SQL ]]]
-- Run this SQL in your database:

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `description`)
VALUES
('baddie_cam', 'Baddie Camera', 500, 0, 1, 'Exclusive camera for taking photos'),
('baddie_pic', 'Photograph', 100, 0, 1, 'A developed photograph ready for sale'),
('baddie_bundle', 'Photo Bundle', 500, 0, 1, 'A collection of photographs'),
('baddie_phone', 'Baddie Phone', 190, 0, 1, 'A phone with the OnlyPics app on it');

-- ============================================
-- [[[ STEP 3: QB-INVENTORY ITEMS ]]]
-- Add the definitions below to: qb-inventory/shared/items.lua
-- (or qb-core/shared/items.lua depending on your setup)
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
    combinable = nil,
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
    combinable = nil,
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
    combinable = nil,
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
    combinable = nil,
    description = 'A phone with the OnlyPics app on it'
},

-- ============================================
-- [[[ STEP 4: ADD IMAGES ]]]
-- Place baddie_cam.png, baddie_pic.png, baddie_bundle.png, and baddie_phone.png in:
--   qb-inventory/html/images/
--
-- [[[ STEP 5: RESTART ]]]
-- Restart qb-inventory and orbit-onlypics
--
-- V2 PLAYER COMMANDS:
--   /onlypics     → Start a photo sale
--   /topbaddies   → Open the leaderboard
--   /baddiestats  → View your rank, XP, followers, earnings
--   /baddiegoals  → Daily + weekly challenges
--   /baddieawards → Achievement grid
-- ============================================