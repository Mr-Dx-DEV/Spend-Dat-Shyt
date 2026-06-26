-- ============================================
-- Orbit OnlyPics v2.0.0 — ESX INSTALLATION
-- ============================================
-- This file contains everything needed for ESX.
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

-- [[[ STEP 1: SQL DATABASE SETUP ]]]
-- Run install/database.sql in your database first, THEN run the items SQL below.

-- Add camera, photo, and bundle items to ESX items table
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `description`)
VALUES
('baddie_cam', 'Baddie Camera', 1, 0, 1, 'Exclusive camera for taking photos'),
('baddie_pic', 'Photograph', 1, 0, 1, 'A developed photograph ready for sale'),
('baddie_bundle', 'Photo Bundle', 5, 0, 1, 'A collection of photographs'),
('baddie_phone', 'Baddie Phone', 1, 0, 1, 'A phone with the OnlyPics app on it');

-- ============================================
-- [[[ STEP 2: RESTART ]]]
-- ============================================
-- 1. Restart your server
-- 2. Female-only: make sure players are using mp_f_freemode_01 ped
-- 3. Visit the Makeup Supply Shop in-game to buy a camera
--
-- V2 PLAYER COMMANDS:
--   /onlypics     → Start a photo sale
--   /topbaddies   → Open the leaderboard
--   /baddiestats  → View your rank, XP, followers, earnings
--   /baddiegoals  → Daily + weekly challenges
--   /baddieawards → Achievement grid
-- ============================================

print("========================================")
print("Orbit OnlyPics v2 — ESX Installation")
print("========================================")
print("1. Run install/database.sql in your database")
print("2. Run the items SQL above")
print("3. ESX uses its built-in inventory system (no images needed)")
print("4. Restart your server")
print("5. Try /baddiestats once you've bought a camera")
print("========================================")