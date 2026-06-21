-- ═══════════════════════════════════════════════════════════════════════════════
-- FADE TRAP PLUS - ESX DATABASE SETUP
-- RP and Chill · Scripts
-- ═══════════════════════════════════════════════════════════════════════════════

-- Society, Job, and Job Grades Setup
INSERT INTO `addon_account` (name, label, shared) VALUES
    ('society_barber', 'Fade Trap', 1)
;
INSERT INTO `datastore` (name, label, shared) VALUES
    ('society_barber', 'Fade Trap', 1)
;
INSERT INTO `addon_inventory` (name, label, shared) VALUES
    ('society_barber', 'Fade Trap', 1)
;
INSERT INTO `jobs` (name, label) VALUES
    ('barber', 'Fade Trap')
;
INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('barber', 0, 'starter', 'Starter Barber', 50, '{}', '{}'),
    ('barber', 1, 'experienced', 'Experienced Barber', 75, '{}', '{}'),
    ('barber', 2, 'advanced', 'Advanced Barber', 100, '{}', '{}'),
    ('barber', 3, 'manager', 'Manager', 125, '{}', '{}'),
    ('barber', 4, 'boss', 'Boss', 150, '{}', '{}')
;

-- ═══════════════════════════════════════════════════════════════════════════════
-- FADE TRAP ITEMS
-- ═══════════════════════════════════════════════════════════════════════════════

-- ONLY USE THESE ITEMS IF YOU DONT HAVE THE LATEST UPDATED VERSION OF BEAUTY TRAP PLUS BECAUSE THEY ARE ALREADU A PART OF THAT SCRIPT. 
-- THE FIRST FEW ITEMS THAT ARE COMMENTED OUT ARE FOR PEOPLE WHO DO NOT HAVE BEAUTY TRAP PLUS.
-- ALL YOU HAVE TO DO IS REMOVE THE "--" ON LINES 36 TO 47 AND USE THE FULL LIST

INSERT INTO `items` (name, label, weight, rare, can_remove) VALUES
--    ('gammaergo', 'Gamma + Ergo Clippers', 1, 0, 1),
--    ('gammaergobox', 'UNOPENED Gamma + Ergo Clippers', 1, 0, 1),
--    ('goldfx', 'Gold FX Clippers', 1, 0, 1),
--    ('goldfxbox', 'UNOPENED Gold FX Clippers', 1, 0, 1),
--    ('instincttrimmer', 'Instinct Trimmer', 1, 0, 1),
--    ('instincttrimmerbox', 'UNOPENED Instinct Trimmer', 1, 0, 1),
--    ('magicclip', 'Magic Clip Clippers', 1, 0, 1),
--    ('magicclipbox', 'UNOPENED Magic Clip Clippers', 1, 0, 1),
--    ('neckduster', 'Neck Duster', 1, 0, 1),
--    ('pocketcomb', 'Pocket Comb', 1, 0, 1),
--    ('toutliner', 'T-Outliner', 1, 0, 1),
--    ('toutlinerbox', 'UNOPENED T-Outliner', 1, 0, 1),

-- IF YOU HAVE THE LATEST BEAUTY TRAP PLUS, ONLY USE THE LIST BELOW SO YOU DONT HAVE DUPLICATES 
-- DO NOT USE LIST ABOVE OR RISK DUPLICATE ITEMS

    ('barber_tablet', 'Barber Tablet', 1, 0, 1),
    ('bootleg_dvd', 'Bootleg DVD', 1, 0, 1),
    ('bootleg_cd', 'Bootleg CD', 1, 0, 1),
    ('bootleg_game', 'Bootleg Video Game', 1, 0, 1),
    ('fake_j_sneakers', 'Fake Js', 1, 0, 1),
    ('fake_y_sneakers', 'Fake Yees', 1, 0, 1),
    ('fake_n_sneakers', 'Fake Zikes', 1, 0, 1),
    ('fake_af_sneakers', 'Fake Forces', 1, 0, 1),
    ('fake_g_belt', 'Fake Belt', 1, 0, 1),
    ('fake_lv_bag', 'Fake Bag', 1, 0, 1),
    ('fake_designer_shirt', 'Fake Designer Shirt', 1, 0, 1),
    ('fake_designer_hat', 'Fake Designer Hat', 1, 0, 1),
    ('fake_designer_glasses', 'Fake Designer Shades', 1, 0, 1),
    ('fake_gold_chain', 'Fake Gold Chain', 1, 0, 1),
    ('fake_watch', 'Fake Watch', 1, 0, 1),
    ('fake_earrings', 'Fake Earrings', 1, 0, 1),
    ('fake_bracelet', 'Fake Gold Bracelet', 1, 0, 1),
    ('fake_airpods', 'AirNods', 1, 0, 1),
    ('fake_beats', 'Heats Headphones', 1, 0, 1),
    ('bootleg_charger', 'Bootleg Charger', 1, 0, 1),
    ('fake_phone', 'tPhone', 1, 0, 1),
    ('fake_tablet', 'iPed', 1, 0, 1),
    ('fake_cologne', 'Fake Cologne', 1, 0, 1),
    ('fake_perfume', 'Fake Perfume', 1, 0, 1),
    ('bootleg_jersey', 'Bootleg Jersey', 1, 0, 1),
    ('fake_wallet', 'Fake Designer Wallet', 1, 0, 1),
    ('loose_cigs', 'Loose Cigarettes', 1, 0, 1)

;