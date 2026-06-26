-- ============================================
-- Orbit OnlyPics v2.0.0 — OX INVENTORY INSTALLATION
-- ============================================
-- Add the item definitions below to: ox_inventory/data/items.lua
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

-- [[[ STEP 1: RUN THE DATABASE SETUP ]]]
-- Run install/database.sql in your MySQL database first.

-- [[[ STEP 2: ADD THESE ITEMS TO ox_inventory/data/items.lua ]]]

['baddie_cam'] = {
    label = 'Baddie Camera',
    weight = 200,
    stack = false,
    close = true,
    description = 'An exclusive camera for taking photos.',
    client = {
        export = 'orbit-onlypics.useCamera'
    }
},

['baddie_pic'] = {
    label = 'Photograph',
    weight = 10,
    stack = false,
    close = true,
    description = 'A developed photograph.',
    client = {
        export = 'orbit-onlypics.viewPhoto'
    }
},

['baddie_bundle'] = {
    label = 'Photo Bundle',
    weight = 50,
    stack = false,
    close = true,
    description = 'A collection of photographs.',
    client = {
        export = 'orbit-onlypics.viewBundle'
    }
},

['baddie_phone'] = {
    label = 'Baddie Phone',
    weight = 190,
    stack = false,
    close = true,
    description = 'A phone with the OnlyPics app on it.',
    client = {
        export = 'orbit-onlypics.useBaddiePhone'
    }
},

-- ============================================
-- [[[ STEP 3: ADD INVENTORY IMAGES (OPTIONAL) ]]]
-- Drop camera/photo/bundle PNGs into: ox_inventory/web/images/
-- Filenames must match: baddie_cam.png, baddie_pic.png, baddie_bundle.png, baddie_phone.png
--
-- [[[ STEP 4: RESTART ]]]
-- Restart ox_inventory and your server.
--
-- V2 PLAYER COMMANDS:
--   /onlypics     → Start a photo sale
--   /topbaddies   → Open the leaderboard
--   /baddiestats  → View your rank, XP, followers, earnings
--   /baddiegoals  → Daily + weekly challenges
--   /baddieawards → Achievement grid
-- ============================================