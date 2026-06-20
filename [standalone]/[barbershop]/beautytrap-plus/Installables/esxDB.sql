-- Society, Job, and Job Grades Setup
INSERT INTO `addon_account` (name, label, shared) VALUES
    ('society_beauty', 'Beauty Trap', 1)
;
INSERT INTO `datastore` (name, label, shared) VALUES
    ('society_beauty', 'Beauty Trap', 1)
;
INSERT INTO `addon_inventory` (name, label, shared) VALUES
    ('society_beauty', 'Beauty Trap', 1)
;
INSERT INTO `jobs` (name, label) VALUES
    ('beauty', 'Beauty Trap')
;
INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
    ('beauty', 0, 'recruit', 'Recruit', 50, '{}', '{}'),
    ('beauty', 1, 'nail tech', 'Nail Tech', 75, '{}', '{}'),
    ('beauty', 2, 'wax expert', 'Wax Expert', 100, '{}', '{}'),
    ('beauty', 3, 'manager', 'Manager', 125, '{}', '{}'),
    ('beauty', 4, 'boss', 'Boss', 150, '{}', '{}')
;

-- Beauty Shop Items
INSERT INTO `items` (name, label, weight, rare, can_remove) VALUES
    ('activatorcream', 'Curl Activator Cream', 1, 0, 1),
    ('annasui', 'ius anna Perfume', 1, 0, 1),
    ('apricotoil', 'Apricot Oil', 1, 0, 1),
    ('arganoil', 'Argan Oil Sheen', 1, 0, 1),
    ('blushpalette', 'Blush Palette', 1, 0, 1),
    ('bonnet', 'Bonnet', 1, 0, 1),
    ('brownliquidfoundation', 'Brown Liquid Foundation', 1, 0, 1),
    ('brushset', 'Makeup Brush Set', 1, 0, 1),
    ('castoroil', 'Castor Oil', 1, 0, 1),
    ('concealer', 'Concealer', 1, 0, 1),
    ('conditioner', 'Conditioner', 1, 0, 1),
    ('curlingcream', 'Curling Cream', 1, 0, 1),
    ('curlshampoo', 'Curl Shampoo', 1, 0, 1),
    ('duneperfume', 'Dune Perfume', 1, 0, 1),
    ('durag', 'Durag', 1, 0, 1),
    ('dyebrush', 'Dye Brush', 1, 0, 1),
    ('ecoblack', 'Black Styling Gel', 1, 0, 1),
    ('ecoblue', 'Blue Styling Gel', 1, 0, 1),
    ('ecobrown', 'Brown Styling Gel', 1, 0, 1),
    ('ecored', 'Red Styling Gel', 1, 0, 1),
    ('enameldryer', 'Nail Enamel Dryer', 1, 0, 1),
    ('eyeliner', 'Eyeliner', 1, 0, 1),
    ('eyelinerpencil', 'Eyeliner Pencil', 1, 0, 1),
    ('eyeshadowpalette', 'Eye Shadow Palette', 1, 0, 1),
    ('faceprimer', 'Face Primer', 1, 0, 1),
    ('flexirod', 'Flexi Rods', 1, 0, 1),
    ('foambodywash', 'Foaming Body Wash', 1, 0, 1),
    ('foundation', 'Foundation', 1, 0, 1),
    ('foundationprimer', 'Foundation Primer', 1, 0, 1),
    ('gammaxevo', 'Gamma x Evo Clippers', 1, 0, 1),
    ('goldfx', 'Gold FX Clippers', 1, 0, 1),
    ('grocomplex', 'Gro Complex Hairdress', 1, 0, 1),
    ('hairgrease', 'Blue Hair Grease', 1, 0, 1),
    ('hairserum', 'Hair Serum', 1, 0, 1),
    ('hommestylinggel', 'Homme Styling Gel', 1, 0, 1),
    ('instincttrimmer', 'Instinct Trimmer', 1, 0, 1),
    ('lightliquidfoundation', 'Light Liquid Foundation', 1, 0, 1),
    ('lipgloss', 'Lip Gloss', 1, 0, 1),
    ('lipset', 'Lip Set', 1, 0, 1),
    ('lipstick', 'Lipstick', 1, 0, 1),
    ('magicclip', 'Magic Clip Clippers', 1, 0, 1),
    ('mascara', 'Mascara', 1, 0, 1),
    ('masque', 'Masque', 1, 0, 1),
    ('menshampoo', 'Mens Shampoo', 1, 0, 1),
    ('moisturizer', 'Moisturizer', 1, 0, 1),
    ('nailpolishremover', 'Nail Polish Remover', 1, 0, 1),
    ('oliveoilsheen', 'Olive Oil Sheen', 1, 0, 1),
    ('pediscrub', 'Pedi Scrub', 1, 0, 1),
    ('pedisoft', 'Pedi Soft', 1, 0, 1),
    ('powdereyeshadow', 'Powder Eye Shadow', 1, 0, 1),
    ('prepnprime', 'Prep n Prime', 1, 0, 1),
    ('restoringsmoothie', 'Restoring Smoothie', 1, 0, 1),
    ('settingpowder', 'Setting Powder', 1, 0, 1),
    ('settingspray', 'Setting Spray', 1, 0, 1),
    ('sheenspray', 'Sheen Spray', 1, 0, 1),
    ('thermalwater', 'Probiotic Thermal Water', 1, 0, 1),
    ('toutliner', 'T-Outliner', 1, 0, 1),

    ('beauty_tablet', 'Beauty Salon Tablet', 1, 0, 1),
;