

#################################################################################################

## [Features]
- 14 Add-On Weapons 🔫


## [Installation]
- Put the ``Devkit_PDWeaponPack`` folder into your ``resources`` folder and then ensure Devkit_PDWeaponPack -- ⚠️PLEASE READ⚠️; Requires ``Devkit_PDWeaponPack`` to work properly.
- Put the Images in  ->  qb-inventory/html/images
	


[#################################################################################################]

## 1st Step ##


##  qb-core/shared/items.lua 

```lua
	--Devkit's PD Pack
    weapon_endura               = { name = 'weapon_endura', label = 'Endura 4', weight = 1000, type = 'weapon', ammotype = nil, image = 'weapon_endura.png', unique = true, useable = false, description = 'Endura 4' },
    weapon_dkbaton              = { name = 'weapon_dkbaton', label = 'Baton', weight = 1000, type = 'weapon', ammotype = nil, image = 'weapon_dkbaton.png', unique = true, useable = false, description = 'Baton' },
    weapon_taserx               = { name = 'weapon_taserx', label = 'TASER X', weight = 1000, type = 'weapon', ammotype = nil, image = 'weapon_taserx.png', unique = true, useable = false, description = 'TASER X' },
    weapon_taserxblk            = { name = 'weapon_taserxblk', label = 'TASER X (BLK)', weight = 1000, type = 'weapon', ammotype = nil, image = 'weapon_taserxblk.png', unique = true, useable = false, description = 'TASER X (BLK)' },
    weapon_pdm3                 = { name = 'weapon_pdm3', label = 'PD BELLENI M3', weight = 1000, type = 'weapon', ammotype = 'AMMO_SHOTGUN', image = 'weapon_pdm3.png', unique = true, useable = false, description = 'PD BELLENI M3' },
    weapon_pdhkusp              = { name = 'weapon_pdhkusp', label = 'PD HK USP', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'weapon_pdhkusp.png', unique = true, useable = false, description = 'PD HK USP' },
    weapon_pdmpx                = { name = 'weapon_pdmpx', label = 'PD MPX', weight = 1000, type = 'weapon', ammotype = 'AMMO_SMG', image = 'weapon_pdmpx.png', unique = true, useable = false, description = 'PD MPX' },
    weapon_pdddm411             = { name = 'weapon_pdddm411', label = 'PD DM4 BLK', weight = 1000, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'weapon_pdddm411.png', unique = true, useable = false, description = 'PD DM4 BLK' },
    weapon_pdddm414             = { name = 'weapon_pdddm414', label = 'PD DDM4 TAN', weight = 1000, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'weapon_pdddm414.png', unique = true, useable = false, description = 'PD DDM4 TAN' },
    weapon_pdddm416             = { name = 'weapon_pdddm416', label = 'PD DDM4 FDE', weight = 1000, type = 'weapon', ammotype = 'AMMO_RIFLE', image = 'weapon_pdddm416.png', unique = true, useable = false, description = 'PD DDM4 FDE' },
    weapon_pdm9a3               = { name = 'weapon_pdm9a3', label = 'PD M9A3', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'weapon_pdm9a3.png', unique = true, useable = false, description = 'PD M9A3' },
    weapon_pdg19                = { name = 'weapon_pdg19', label = 'PD G19 BLK', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'weapon_pdg19.png', unique = true, useable = false, description = 'PD G19 BLK' },
    weapon_pdg19fde             = { name = 'weapon_pdg19fde', label = 'PD G19 FDE', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'weapon_pdg19fde.png', unique = true, useable = false, description = 'PD G19 FDE' },
    weapon_pdg19tan             = { name = 'weapon_pdg19tan', label = 'PD G19 TAN', weight = 1000, type = 'weapon', ammotype = 'AMMO_PISTOL', image = 'weapon_pdg19tan.png', unique = true, useable = false, description = 'PD G19 TAN' },


    

    -- Devkit's Attachments
    at_flashlight = { name = 'at_flashlight', label = 'Flashlight', weight = 10, type = 'item', image = 'at_flashlight.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A flashlight for a weapon' },
    at_laser = { name = 'at_laser', label = 'Laser', weight = 10, type = 'item', image = 'at_laser.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A laser for a weapon' },
    at_pistol_sight = { name = 'at_pistol_sight', label = 'Pistol Sight', weight = 10, type = 'item', image = 'at_pistol_sight.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A small scope for a pistol' },
    at_grip = { name = 'at_grip', label = 'Grip', weight = 10, type = 'item', image = 'at_grip.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'A grip for a weapon' },
    at_scope_medium = { name = 'at_scope_medium',   label = 'Rifle Sight',   weight = 10,    type = 'item',   image = 'at_scope_medium.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'Sight for rifle'},
    at_pistol_suppressor = { name = 'at_pistol_suppressor', label = 'Pistol Suppressor', weight = 10, type = 'item', image = 'at_pistol_suppressor.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Suppressor for a pistol' },
    at_rifle_suppressor = { name = 'at_rifle_suppressor', label = 'Rifle Suppressor', weight = 10, type = 'item', image = 'at_rifle_suppressor.png', unique = false, useable = true, shouldClose = true, combinable = nil, description = 'Suppressor for a rifle' },
    at_clip_extended_pistol = { name = 'at_clip_extended_pistol',  label = 'Pistol Extended Mag',    weight = 10,    type = 'item',   image = 'at_clip_extended_pistol.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'Pistol Extended Mag'},
    at_clip_extended_rifle = { name = 'at_clip_extended_rifle',  label = 'Rifle Extended Mag',    weight = 10,    type = 'item',   image = 'at_clip_extended_rifle.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'Rifle Extended Mag'},
    at_clip_extended_shotgun = { name = 'at_clip_extended_shotgun',  label = 'Shotgun Extended Mag',    weight = 10,    type = 'item',   image = 'at_clip_extended_shotgun.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'Shotgun Extended Mag'},
    at_clip_extended_smg = { name = 'at_clip_extended_smg',  label = 'SMG Extended Mag',    weight = 10,    type = 'item',   image = 'at_clip_extended_smg.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'SMG Extended Mag'},
    at_clip_drum_smg = { name = 'at_clip_drum_smg',  label = 'SMG Drum Mag',    weight = 10,    type = 'item',   image = 'at_clip_drum_smg.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'SMG Drum Mag'},
    at_clip_drum_pistol = { name = 'at_clip_drum_pistol',  label = '50 Round Mag',    weight = 10,    type = 'item',   image = 'at_clip_drum_pistol.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'Pistol Drum Mag'},
    at_clip_100_pistol = { name = 'at_clip_100_pistol',   label = '100 Round Mag',   weight = 10,    type = 'item',   image = 'at_clip_100_pistol.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = '100 Round Pistol Mag'},
    at_clip_drum_rifle = { name = 'at_clip_drum_rifle',  label = '50 Round Mag',    weight = 10,    type = 'item',   image = 'at_clip_drum_rifle.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = 'Rifle Drum Mag'},
    at_clip_100_rifle = { name = 'at_clip_100_rifle',   label = '100 Round Mag',   weight = 10,    type = 'item',   image = 'at_clip_100_rifle.png',   unique = false,   useable = true,  shouldClose = true,   combinable = nil,   description = '100 Round Rifle Mag'},
    at_clip_seethrough_pistol = { name = 'at_clip_seethrough_pistol', label = 'See-through Pistol Mag', weight = 200, type = 'attachment', image = 'at_clip_seethrough_pistol.png', unique = false, useable = true, description = 'See-through magazine for pistols' },
    at_clip_vector_mag = { name = 'at_clip_vector_mag', label = 'Vector Magazine', weight = 300, type = 'attachment', image = 'at_clip_vector_mag.png', unique = false, useable = true, description = 'Vector Magazine' },
    at_stacked_mag_rifle = { name = 'at_stacked_mag_rifle', label = '60 Stack Magazine', weight = 300, type = 'attachment', image = 'at_stacked_mag_rifle.png', unique = false, useable = true, description = '60 Stack Magazine' },
    at_clip_akdrum = { name = 'at_clip_akdrum', label = 'AK Drum Magazine', weight = 300, type = 'attachment', image = 'at_clip_akdrum.png', unique = false, useable = true, description = 'Ak Drum Magazine' },
    at_clip_ardrum = { name = 'at_clip_ardrum', label = 'AR Drum Magazine', weight = 300, type = 'attachment', image = 'at_clip_ardrum.png', unique = false, useable = true, description = 'AR Drum Magazine' },

    
```

## 2nd Step ##


## qb-core/shared/weapons.lua (https://github.com/qbcore-framework/qb-core)

```lua

	[`weapon_endura`] = {['name'] = 'weapon_endura', ['label'] = 'Endura 4', ['weapontype'] = 'Melee', ['ammotype'] = nil, ['damagereason'] = 'Struck / Bludgeoned / Hit / Whacked'},
    [`weapon_dkbaton`] = {['name'] = 'weapon_dkbaton', ['label'] = 'Baton', ['weapontype'] = 'Melee', ['ammotype'] = nil, ['damagereason'] = 'Struck / Bludgeoned / Hit / Whacked'},
    [`weapon_taserx`] = {['name'] = 'weapon_taserx', ['label'] = 'TASER X', ['weapontype'] = 'Taser', ['ammotype'] = nil, ['damagereason'] = 'Shocked / Tased / Paralyzed / Zapped'},
    [`weapon_taserxblk`] = {['name'] = 'weapon_taserxblk', ['label'] = 'TASER X (BLK)', ['weapontype'] = 'Taser', ['ammotype'] = nil, ['damagereason'] = 'Shocked / Tased / Paralyzed / Zapped'},
    [`weapon_pdm3`] = {['name'] = 'weapon_pdm3', ['label'] = 'PD BELLENI M3', ['weapontype'] = 'Shotgun', ['ammotype'] = 'AMMO_SHOTGUN', ['damagereason'] = 'Blasted / Shot down / Pulverized / Shotgunned'},
    [`weapon_pdhkusp`] = {['name'] = 'weapon_pdhkusp', ['label'] = 'PD HK USP', ['weapontype'] = 'Pistol', ['ammotype'] = 'AMMO_PISTOL', ['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
    [`weapon_pdmpx`] = {['name'] = 'weapon_pdmpx', ['label'] = 'PD MPX', ['weapontype'] = 'Submachine Gun', ['ammotype'] = 'AMMO_SMG', ['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
    [`weapon_pdddm411`] = {['name'] = 'weapon_pdddm411', ['label'] = 'PD DM4 BLK', ['weapontype'] = 'Assault Rifle', ['ammotype'] = 'AMMO_RIFLE', ['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
    [`weapon_pdddm414`] = {['name'] = 'weapon_pdddm414', ['label'] = 'PD DDM4 TAN', ['weapontype'] = 'Assault Rifle', ['ammotype'] = 'AMMO_RIFLE', ['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
    [`weapon_pdddm416`] = {['name'] = 'weapon_pdddm416', ['label'] = 'PD DDM4 FDE', ['weapontype'] = 'Assault Rifle', ['ammotype'] = 'AMMO_RIFLE', ['damagereason'] = 'Ended / Rifled / Shot down / Floored'},
    [`weapon_pdm9a3`] = {['name'] = 'weapon_pdm9a3', ['label'] = 'PD M9A3', ['weapontype'] = 'Pistol', ['ammotype'] = 'AMMO_PISTOL', ['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
    [`weapon_pdg19`] = {['name'] = 'weapon_pdg19', ['label'] = 'PD G19 BLK', ['weapontype'] = 'Pistol', ['ammotype'] = 'AMMO_PISTOL', ['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
    [`weapon_pdg19fde`] = {['name'] = 'weapon_pdg19fde', ['label'] = 'PD G19 FDE', ['weapontype'] = 'Pistol', ['ammotype'] = 'AMMO_PISTOL', ['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},
    [`weapon_pdg19tan`] = {['name'] = 'weapon_pdg19tan', ['label'] = 'PD G19 TAN', ['weapontype'] = 'Pistol', ['ammotype'] = 'AMMO_PISTOL', ['damagereason'] = 'Pistoled / Blasted / Plugged / Bust a cap in'},


```


## 3rd Step ##


## qb-weapons/config.lua   (https://github.com/qbcore-framework/qb-weapons)

# under #   Config.DurabilityMultiplier = {

```lua

    weapon_endura = 0.15,
    weapon_dkbaton = 0.15,
    weapon_taserx = 0.15,
    weapon_taserxblk = 0.15,
    weapon_pdm3 = 0.15,
    weapon_pdhkusp = 0.15,
    weapon_pdmpx = 0.15,
    weapon_pdddm411 = 0.15,
    weapon_pdddm414 = 0.15,
    weapon_pdddm416 = 0.15,
    weapon_pdm9a3 = 0.15,
    weapon_pdg19 = 0.15,
    weapon_pdg19fde = 0.15,
    weapon_pdg19tan = 0.15,



```


## 4th Step ##


## qb-smallresources/client/weapdraw.lua (https://github.com/qbcore-framework/qb-smallresources)

# under # 	local weapons = {

```lua

    'WEAPON_ENDURA',
    'WEAPON_DKBATON',
    'WEAPON_TASERX',
    'WEAPON_TASERXBLK',
    'WEAPON_PDM3',
    'WEAPON_PDHKUSP',
    'WEAPON_PDMPX',
    'WEAPON_PDDDM411',
    'WEAPON_PDDDM414',
    'WEAPON_PDDDM416',
    'WEAPON_PDM9A3',
    'WEAPON_PDG19',
    'WEAPON_PDG19FDE',
    'WEAPON_PDG19TAN',

```


## 5th Step ##


## qb-smallresources/client/recoil.lua (https://github.com/qbcore-framework/qb-smallresources)

# under #    local recoils = {

```lua

    [`weapon_taserx`] = 0.1,
    [`weapon_taserxblk`] = 0.1,
    [`weapon_pdm3`] = 0.1,
    [`weapon_pdhkusp`] = 0.1,
    [`weapon_pdmpx`] = 0.1,
    [`weapon_pdddm411`] = 0.1,
    [`weapon_pdddm414`] = 0.1,
    [`weapon_pdddm416`] = 0.1,
    [`weapon_pdm9a3`] = 0.1,
    [`weapon_pdg19`] = 0.1,
    [`weapon_pdg19fde`] = 0.1,
    [`weapon_pdg19tan`] = 0.1,


```



## Last Step ##

## qb-weapons/config.lua  (https://github.com/qbcore-framework/qb-weapons)

# under the #   WeaponAttachments = {
    
```lua
    
    
    at_grip = {

        --V1 attachments
        weapon_mdr2 = `COMPONENT_MDR2_GRIP_03`, --v6



        --v6 attachments
        weapon_arcqb = `COMPONENT_AT_AR_AFGRIP_ARCQB`, --v6

        -- PD attachments
        weapon_pdddm411 = `COMPONENT_AT_AR_AFGRIP_PDDD11`, -- DKPDv1
        weapon_pdddm414 = `COMPONENT_AT_AR_AFGRIP_PDDD14`, -- DKPDv1
        weapon_pdddm416 = `COMPONENT_AT_AR_AFGRIP_PDDD16`, -- DKPDv1
    },

    at_clip_extended_pistol = {

        --v1 Attachemnts
        weapon_glock19p80 = `COMPONENT_GLOCK19P80_CLIP_02`, --v1
		weapon_dkglock19x = `COMPONENT_DKGLOCK19X_CLIP_02`, --v1
		weapon_glock21 = `COMPONENT_DKGLOCK21_CLIP_02`, --v1
		weapon_glockp80 = `COMPONENT_GLOCKP80_CLIP_02`, --v1
		weapon_sig = `COMPONENT_SIG_CLIP_02`, --v1
		weapon_m45a1 = `COMPONENT_M45A1_CLIP_02`, --v1
		weapon_swmp9 = `COMPONENT_SWMP9_CLIP_02`, --v1

        --v2 Attachemnts
        weapon_fnx45 = `COMPONENT_FNX45_CLIP_02`,
        weapon_ghostglock = `COMPONENT_GHOSTGLOCK_CLIP_02`,
        weapon_glock17 = `COMPONENT_GLOCK17_CLIP_02`,

        --v3 Attachments
        weapon_dkglock17 = `COMPONENT_DKGLOCK17_CLIP_02`, -- v3
		weapon_dkglock17x = `COMPONENT_DKGLOCK17X_CLIP_02`, -- v3
		weapon_dkglock26 = `COMPONENT_DKGLOCK26_CLIP_02`, -- v3
		weapon_pf940 = `COMPONENT_PF940_CLIP_02`, -- v3

        --v4 attachments
        weapon_fn57 = `COMPONENT_FN57_CLIP_02`, -- v4
        weapon_g17gen5 = `COMPONENT_G17GEN5_CLIP_02`, -- v4
        weapon_g19grip = `COMPONENT_G19GRIP_CLIP_02`, -- v4
        weapon_g19kmr = `COMPONENT_G19KMR_CLIP_02`, --v4
        weapon_m9 = `COMPONENT_M9_CLIP_02`, --v4
        weapon_mandp9 = `COMPONENT_MANDP9_CLIP_02`, --v4
        weapon_sfn509 = `COMPONENT_SFN509_CLIP_02`, --v4
        weapon_xdm = `COMPONENT_XDM_CLIP_02`, --v4
        weapon_tp9sf = `COMPONENT_TP9SF_CLIP_02`, --v4

        --v5 attachments
        weapon_pdp = `COMPONENT_PDP_CLIP_02`, --v5

        --v6 attachments
        weapon_g17gb = `COMPONENT_G17GB_CLIP_02`, --v6
		weapon_g18 = `COMPONENT_G18_CLIP_02`, --v6
		weapon_incognitog26 = `COMPONENT_INCOGNITOG26_CLIP_02`, --v6
		weapon_lljg17 = `COMPONENT_LLJG17_CLIP_02`, --v6
        weapon_px4 = `COMPONENT_PX4_CLIP_02`, --v6


        --pd attachments
        weapon_pdhkusp = `COMPONENT_PDHKUSP_CLIP_02`, --DKPDv1
		weapon_pdm9a3 = `COMPONENT_PDM9A3_CLIP_02`, --DKPDv1
		weapon_pdg19 = `COMPONENT_PDG19_CLIP_02`, --DKPDv1
		weapon_pdg19fde = `COMPONENT_PDG19FDE_CLIP_02`, --DKPDv1
		weapon_pdg19tan = `COMPONENT_PDG19TAN_CLIP_02`, --DKPDv1


        --unisex attachments
        weapon_berettam9 = `COMPONENT_BERETTAM9_CLIP_02`, --Unisex
        weapon_g17g5mos = `COMPONENT_G17G5MOS_CLIP_02`, --Unisex
        weapon_g22gen4 = `COMPONENT_G22GEN4_CLIP_02`, --Unisex
        weapon_g41gen4 = `COMPONENT_G22GEN4_CLIP_02`, --Unisex
        weapon_gen5steelbutton = `COMPONENT_GEN5STEELBUTTON_CLIP_02`, --Unisex
        weapon_dkglock20 = `COMPONENT_DKGLOCK20_CLIP_02`, --Unisex
        weapon_dkglock30 = `COMPONENT_DKGLOCK30_CLIP_02`, --Unisex
        weapon_mp10mm = `COMPONENT_MP10MM_CLIP_02`, --Unisex
        weapon_sigp238 = `COMPONENT_SIGP238_CLIP_02`, --Unisex
        weapon_dkxd9 = `COMPONENT_SPXD9_CLIP_02`, -- Unisex
    },

    at_clip_extended_rifle = {

        --v1 Attachemnts
        weapon_akm = `COMPONENT_AKM_CLIP_06`, --v1
		weapon_sr25 = `COMPONENT_SR25_CLIP_01`, --v1
		weapon_mdr2 = `COMPONENT_MDR2_CLIP_06`, --v1
		weapon_bracearp = `COMPONENT_BRACEARP_CLIP_02`, --v1
		weapon_straparp = `COMPONENT_STRAPARP_CLIP_02`, --v1

        --v3 attachments
        weapon_ak104 = `COMPONENT_AK104_CLIP_02`, --v3
		weapon_type56 = `COMPONENT_TYPE56_CLIP_02`, --v3
        weapon_keltecplr = `COMPONENT_KELTECPLR_CLIP_02`, --v3



        --pd attachments
        weapon_pdddm411 = `COMPONENT_PDDD11_CLIP_02`, -- DKPDv1
		weapon_pdddm414 = `COMPONENT_PDDD14_CLIP_02`, -- DKPDv1
		weapon_pdddm416 = `COMPONENT_PDDD16_CLIP_02`, -- DKPDv1


    },

    at_clip_extended_shotgun = {


        -- Unisex attachments
        weapon_ak12gauge = `COMPONENT_AK12GAUGE_CLIP_02`, -- Unisex
    },

    at_clip_extended_smg = {

        --v1 Attachemnts
        weapon_mp7 = `COMPONENT_MP7_CLIP_02`, --v1



        --v5 attachments
        weapon_ump = `COMPONENT_UMP_CLIP_02`, --v5

        -- Unisex attachments
        weapon_armac = `COMPONENT_ARMAC_CLIP_02`, -- Unisex
        weapon_hkmp5 = `COMPONENT_HKMP5_CLIP_02`, -- Unisex
        weapon_spc9 = `COMPONENT_SPC9_CLIP_02`, --Unisex
    },

    at_clip_drum_pistol = {

        --v1 attachments
        weapon_glock19p80 = `COMPONENT_GLOCK19P80_CLIP_05`, --v1
		weapon_dkglock19x = `COMPONENT_DKGLOCK19X_CLIP_05`, --v1
		weapon_glock21 = `COMPONENT_DKGLOCK21_CLIP_05`, --v1
		weapon_glockp80 = `COMPONENT_GLOCKP80_CLIP_05`, --v1

        --v3 Attachments
        weapon_dkglock17 = `COMPONENT_DKGLOCK17_CLIP_05`, -- v3
		weapon_dkglock17x = `COMPONENT_DKGLOCK17X_CLIP_05`, -- v3
		weapon_dkglock26 = `COMPONENT_DKGLOCK26_CLIP_05`, -- v3
		weapon_pf940 = `COMPONENT_PF940_CLIP_05`, -- v3

        --v4 attachments
        weapon_fn57 = `COMPONENT_FN57_CLIP_03`, -- v4
        weapon_g17gen5 = `COMPONENT_G17GEN5_CLIP_03`, -- v4
        weapon_g19grip = `COMPONENT_G19GRIP_CLIP_04`, -- v4
        weapon_g19kmr = `COMPONENT_G19KMR_CLIP_03`, --v4
        weapon_mandp9 = `COMPONENT_MANDP9_CLIP_03`, --v4
        weapon_sfn509 = `COMPONENT_SFN509_CLIP_03`, --v4
        weapon_xdm = `COMPONENT_XDM_CLIP_03`, --v4
        weapon_tp9sf = `COMPONENT_TP9SF_CLIP_03`, --v4

        --v5 attachments
        weapon_blackglock = `COMPONENT_BLACKGLOCKSWITCH_CLIP_04`, --v5
		weapon_blueglock = `COMPONENT_BLUEGLOCKSWITCH_CLIP_04`, --v5
		weapon_greenglock = `COMPONENT_GREENGLOCKSWITCH_CLIP_04`, --v5
		weapon_redglock = `COMPONENT_REDGLOCKSWITCH_CLIP_04`, --v5
		weapon_whiteglock = `COMPONENT_WHITEGLOCKSWITCH_CLIP_04`, --v5
		weapon_dagger19 = `COMPONENT_DAGGER19_CLIP_04`, --v5
		weapon_g18c = `COMPONENT_G18C_CLIP_04`, --v5
		weapon_uzi = `COMPONENT_UZI_CLIP_02`, --v5

        --v6 attachments
        weapon_g17gb = `COMPONENT_G17GB_CLIP_05`, --v6
		weapon_g18 = `COMPONENT_G18_CLIP_05`, --v6
		weapon_incognitog26 = `COMPONENT_INCOGNITOG26_CLIP_05`, --v6
		weapon_lljg17 = `COMPONENT_LLJG17_CLIP_05`, --v6
        weapon_tp9 = `COMPONENT_CANIKTP9_CLIP_03`, --v6
        weapon_akv9 = `COMPONENT_AKV9_CLIP_03`, --v6
        weapon_px4 = `COMPONENT_PX4_CLIP_03`, --v6

        --unisex attachments
        weapon_g17g5mos = `COMPONENT_G17G5MOS_CLIP_05`, --Unisex
        weapon_g22gen4 = `COMPONENT_G22GEN4_CLIP_05`, --Unisex
        weapon_g41gen4 = `COMPONENT_G22GEN4_CLIP_05`, --Unisex
        weapon_gen5steelbutton = `COMPONENT_GEN5STEELBUTTON_CLIP_05`, --Unisex
        weapon_dkglock20 = `COMPONENT_DKGLOCK20_CLIP_05`, --Unisex
        weapon_dkglock30 = `COMPONENT_DKGLOCK30_CLIP_05`, --Unisex
        weapon_dkxd9 = `COMPONENT_SPXD9_CLIP_03`, -- Unisex
    },

    at_clip_drum_smg = {
        --v1 Attachemnts
        weapon_mp5sdfm = `COMPONENT_MP5SD_CLIP_02`, --v1

        --v3 attachments
        weapon_bansheearp = `COMPONENT_BANSHEEARP_CLIP_02`, --v3

        --v4 attachments
        weapon_keltecsub = `COMPONENT_KELTECSUB_CLIP_02`, --v4

        --PD attachments
        weapon_pdmpx = `COMPONENT_PDMPX_CLIP_02`, --DKPDv1

        -- Unisex attachments
        weapon_armac = `COMPONENT_ARMAC_CLIP_03`, -- Unisex
        weapon_hkmp5 = `COMPONENT_HKMP5_CLIP_03`, -- Unisex
        weapon_spc9 = `COMPONENT_SPC9_CLIP_03`, --Unisex
    },


    at_clip_drum_shotgun = {

        --v4 attachments
        weapon_aa12 = `COMPONENT_AA12_CLIP_02`, -- v4

        -- Unisex attachments
        weapon_ak12gauge = `COMPONENT_AK12GAUGE_CLIP_03`, -- Unisex
    },

    at_clip_100_pistol = {

        --v1 attachments
        weapon_glock19p80 = `COMPONENT_GLOCK19P80_CLIP_06`, --v1
		weapon_dkglock19x = `COMPONENT_DKGLOCK19X_CLIP_06`, --v1
		weapon_glock21 = `COMPONENT_DKGLOCK21_CLIP_06`, --v1
		weapon_glockp80 = `COMPONENT_GLOCKP80_CLIP_06`, --v1

        --v3 Attachments
        weapon_dkglock17 = `COMPONENT_DKGLOCK17_CLIP_06`, -- v3
		weapon_dkglock17x = `COMPONENT_DKGLOCK17X_CLIP_06`, -- v3
		weapon_dkglock26 = `COMPONENT_DKGLOCK26_CLIP_06`, -- v3
		weapon_pf940 = `COMPONENT_PF940_CLIP_06`, -- v3

        --v4 attachments
        weapon_g17gen5 = `COMPONENT_G17GEN5_CLIP_04`, -- v4
        weapon_g19grip = `COMPONENT_G19GRIP_CLIP_05`, -- v4
        weapon_g19kmr = `COMPONENT_G19KMR_CLIP_04`, --v4

        --v6 attachments
        weapon_g17gb = `COMPONENT_G17GB_CLIP_06`, --v6
		weapon_g18 = `COMPONENT_G18_CLIP_06`, --v6
		weapon_incognitog26 = `COMPONENT_INCOGNITOG26_CLIP_06`, --v6
		weapon_lljg17 = `COMPONENT_LLJG17_CLIP_06`, --v6

        --unisex attachments
        weapon_g17g5mos = `COMPONENT_G17G5MOS_CLIP_06`, --Unisex
        weapon_g22gen4 = `COMPONENT_G22GEN4_CLIP_06`, --Unisex
        weapon_g41gen4 = `COMPONENT_G22GEN4_CLIP_06`, --Unisex
        weapon_gen5steelbutton = `COMPONENT_GEN5STEELBUTTON_CLIP_06`, --Unisex
        weapon_dkglock20 = `COMPONENT_DKGLOCK20_CLIP_06`, --Unisex
        weapon_dkglock30 = `COMPONENT_DKGLOCK30_CLIP_06`, --Unisex
    },

    at_clip_100_rifle = {

        --v1 attachments
        weapon_bracearp = `COMPONENT_BRACEARP_CLIP_04`, --v1
		weapon_straparp = `COMPONENT_STRAPARP_CLIP_04`, --v1

        --v3 Attachemnts
        weapon_fn15 = `COMPONENT_FN15_CLIP_04`, --v3
		weapon_dkminiarp = `COMPONENT_DKMINIARP_CLIP_04`, --v3
        weapon_keltecplr = `COMPONENT_DKKELTECPLR_CLIP_05`, --v3

        --v4 attachments
        weapon_ar15pistol = `COMPONENT_AR15PISTOL_CLIP_04`, -- v4
        weapon_fr15 = `COMPONENT_FR15_CLIP_04`, -- v4
        weapon_g36 = `COMPONENT_G36_CLIP_04`, --v4
        weapon_hk417 = `COMPONENT_HK417_CLIP_04`, --v4
        weapon_sig556 = `COMPONENT_SIG556_CLIP_04`, --v4
        weapon_sigsg552 = `COMPONENT_SIGSG552_CLIP_04`, --v4
        weapon_tx15 = `COMPONENT_TX15_CLIP_04`, --v4

        --v5 attachments
        weapon_camoarp = `COMPONENT_CAMOARP_CLIP_03`, --v5
		weapon_armagpul = `COMPONENT_ARMAGPUL_CLIP_03`, --v5
		weapon_skeletalar = `COMPONENT_SKELETALAR_CLIP_03`, --v5

        --v6 attachments
        weapon_lilarp = `COMPONENT_LILARP_CLIP_04`, --v6
		weapon_arcqb = `COMPONENT_ARCQB_CLIP_04`, --v6
        weapon_4incharp = `COMPONENT_4INARP_CLIP_04`, --v6
		weapon_10incharp = `COMPONENT_10INARP_CLIP_04`, --v6

        -- Unisex attachments
        weapon_8incharp = `COMPONENT_8INCHARP_CLIP_04`, -- Unisex
        weapon_ghmicroarp = `COMPONENT_GHMICROARP_CLIP_04`, -- Unisex
        weapon_micromcx = `COMPONENT_MICROMCX_CLIP_04`, -- Unisex
        weapon_microredarp = `COMPONENT_MICROREDARP_CLIP_04`, -- Unisex
    },

    at_laser = {

        --#v3 attachments
        weapon_dkglock17 = `COMPONENT_DKGLOCK17_PI_FLSH`, --v3
		weapon_dkglock17 = `COMPONENT_DKGLOCK17X_PI_FLSH`, --v3

        --v4 attachments
        weapon_g36 = `COMPONENT_G36_LASER`, --v4
        weapon_hk417 = `COMPONENT_HK417_LASER`, --v4
        weapon_sfn509 = `COMPONENT_SFN509_LASER`, --v4

        --v6 attachments
        weapon_lljg17 = `COMPONENT_AT_PI_FLCOMBO_LLJG17`, --v6
		weapon_tp9 = `COMPONENT_AT_PI_LASER_CANIKTP9`, --v6
        weapon_g17gb = `COMPONENT_AT_PI_LASER_G17GB`, --v6
        weapon_akv9 = `COMPONENT_AT_AR_FLSH_AKV9`, --v6


        --Unisex attachments
        weapon_g17g5mos = `COMPONENT_G17G5MOS_PI_FLSH`, --Unisex
        weapon_g22gen4 = `COMPONENT_G22GEN4_LSR`, --Unisex
        weapon_gen5steelbutton = `COMPONENT_GEN5STEELBUTTON_PI_LSR`, --Unisex
        weapon_dkglock20 = `COMPONENT_DKGLOCK20_LSR`, -- Unisex
        weapon_dkxd9 = `COMPONENT_SPXD9_LSR`, -- Unisex
    },

    at_flashlight = {

        --v1 Attachemnts
        weapon_mdr2 = `COMPONENT_MDR_FLSH`,
        weapon_mp7 = `COMPONENT_AT_PI_FLSH_MP7`, --v1
        weapon_sig = `COMPONENT_SIG_FLSH_01`, --v1
        weapon_m45a1 = `COMPONENT_AT_PI_FLSH_M45A1`, --v1
        weapon_swmp9 = `COMPONENT_SWMP9_FLSH_01`, --v1

        --v2 Attachemnts
        weapon_fnx45 = `COMPONENT_AT_PI_FLSH_FNX45`,

        --v3 Attachemnts
        weapon_bansheearp = `COMPONENT_AT_AR_FLSH`,
        weapon_fn509 = `COMPONENT_AT_PI_FN509_FLSH`,
        weapon_pf940 = `COMPONENT_AT_PI_FLSH`,
        weapon_ruger57 = `COMPONENT_AT_PI_FLSH`,
        weapon_taurusg2c = `COMPONENT_AT_PI_FLSH`,


        --v4 attachments
        weapon_fn57 = `COMPONENT_AT_PI_FLSH_FN57`, --v4
        weapon_fr15 = `COMPONENT_FR15_FLSH`, --v4
        weapon_g19kmr = `COMPONENT_AT_PI_FLSH_G19KMR`, --v4
        weapon_m9 = `COMPONENT_M9_FLSH_01`, --v4
        weapon_mandp9 = `COMPONENT_AT_PI_FLSH_MANDP9`, --v4
        weapon_xdm = `COMPONENT_AT_PI_FLSH_XDM`, --v4
        weapon_tp9sf = `COMPONENT_AT_PI_TP9SF_FLSH`, --v4
        weapon_tx15 = `COMPONENT_TX15_FLSH`, --v4
        

        --v5 attachments
        weapon_ump = `COMPONENT_AT_AR_FLSH_UMP`, --v5
		weapon_pdp = `COMPONENT_AT_PDP_FLSH`, --v5

        --v6 attachments
        weapon_lilarp = `COMPONENT_AT_AR_FLSH_LILARP`, --v6
		weapon_arcqb = `COMPONENT_AT_AR_FLSH_ARCQB`, --v6
        weapon_10incharp = `COMPONENT_AT_AR_FLSH_10INARP`, --v6
        weapon_4incharp = `COMPONENT_AT_AR_SUPP_4INARP`, --v6
        weapon_px4 = `COMPONENT_AT_PI_FLSH_PX4`, --v6

        --PD attachements
        weapon_pdmpx = `COMPONENT_AT_AR_FLSH_PDMPX`, -- DKPDv1
        weapon_pdm3 = `COMPONENT_AT_AR_FLSH_PDM3`, -- DKPDv1
        weapon_pdhkusp = `COMPONENT_AT_PI_FLSH_PDHKUSP`, -- DKPDv1
        weapon_pdm9a3 = `COMPONENT_AT_PI_FLSH_PDM9A3`, -- DKPDv1
        weapon_pdddm411 = `COMPONENT_AT_AR_FLSH_PDDD11`, -- DKPDv1
        weapon_pdddm414 = `COMPONENT_AT_AR_FLSH_PDDD14`, -- DKPDv1
        weapon_pdddm416 = `COMPONENT_AT_AR_FLSH_PDDD16`, -- DKPDv1
        weapon_pdg19 = `COMPONENT_AT_PI_FLSH_PDG19`, -- DKPDv1
        weapon_pdg19fde = `COMPONENT_AT_PI_FLSH_PDG19FDE`, -- DKPDv1
        weapon_pdg19tan = `COMPONENT_AT_PI_FLSH_PDG19TAN`, -- DKPDv1

        -- Unisex attachments
        weapon_8incharp = `COMPONENT_8INCHARP_AR_FLSH`, -- Unisex
        weapon_ghmicroarp = `COMPONENT_GHMICROARP_AR_FLSH`, -- Unisex
        weapon_micromcx = `COMPONENT_MICROMCX_FLSH`, -- Unisex
        weapon_mp10mm = `COMPONENT_MP10MM_FLSH`, --Unisex
    },

    at_rifle_suppressor = {

        --v1 Attachemnts
        weapon_sr25 = `COMPONENT_SR25_SUPP_01`, --v1
        weapon_mdr2 = `COMPONENT_MDR2_SUPP_03`, --v1
        weapon_akm = `COMPONENT_AKM_SUPP_03`, --v1
        

        --v2 Attachemnts
        weapon_ak47 = `COMPONENT_AT_AK47_SUPP_02`,


        --v3 attachments
        weapon_fn15 = `COMPONENT_FN15_AR_SUPP`, --v3
		weapon_dkkeltecplr = `COMPONENT_DKKELTECPLR_AR_SUPP`, --v3
		weapon_dkminiarp = `COMPONENT_DKMINIARP_AR_SUPP`, --v3
		weapon_ak104 = `COMPONENT_AK104_AR_SUPP_02`, --v3
		weapon_type56 = `COMPONENT_TYPE56_AR_SUPP_02`, --v3

        --v4 attachments
        weapon_aa12 = `COMPONENT_AT_AR_SUPP_AA12`, -- v4
        weapon_fr15 = `COMPONENT_FR15_SUPP`, -- v4
        weapon_g36 = `COMPONENT_G36_SUPP`, --v4
        weapon_hk417 = `COMPONENT_HK417_SUPP`, --v4
        weapon_sig556 = `COMPONENT_SIG556_SUPP`, --v4
        weapon_sigsg552 = `COMPONENT_SIGSG552_SUPP`, --v4
        weapon_tx15 = `COMPONENT_TX15_SUPP`, --v4

        --v6 attachments
        weapon_arcqb = `COMPONENT_AT_AR_SUPP_ARCQB`, --v6
        weapon_lilarp = `COMPONENT_AT_AR_SUPP_LILARP`, --v6
        weapon_10incharp = `COMPONENT_AT_AR_SUPP_10INARP`, --v6

        --PD attachements
        weapon_pdm3 = `COMPONENT_AT_AR_SUPP_PDM3`, -- DKPDv1
        weapon_pdddm411 = `COMPONENT_AT_AR_SUPP_PDDD11`, -- DKPDv1
        weapon_pdddm414 = `COMPONENT_AT_AR_SUPP_PDDD14`, -- DKPDv1
        weapon_pdddm416 = `COMPONENT_AT_AR_SUPP_PDDD16`, -- DKPDv1

        -- Unisex attachments
        weapon_8incharp = `COMPONENT_8INCHARP_AR_SUPP`, -- Unisex
        weapon_ak12gauge = `COMPONENT_AK12GAUGE_SUPP`, -- Unisex
        weapon_ghmicroarp = `COMPONENT_GHMICROARP_AR_SUPP`, -- Unisex
        weapon_micromcx = `COMPONENT_MICROMCX_SUPP`, -- Unisex
        weapon_microredarp = `COMPONENT_MICROREDARP_SUPP`, -- Unisex
    },
    
    at_pistol_suppressor = {

        --v1 attachments
        weapon_mp7 = `COMPONENT_AT_AR_SUPP_02_MP7`, --v1
        weapon_sig = `COMPONENT_SIG_SUPP_03`, --v1
		weapon_m45a1 = `COMPONENT_AT_PI_SUPP_M45A1`, --v1

        --v2 Attachemnts
        weapon_fnx45 = `COMPONENT_AT_PI_FLSH_FNX45`,
        weapon_ghostglock = `COMPONENT_AT_PI_SUPP_GHOSTGLOCK`,

        --v3 Attachemnts
        weapon_bansheearp = `COMPONENT_BANSHEEARP_PI_SUPP`, --v3
		weapon_dkglock26 = `COMPONENT_DKGLOCK26_PI_SUPP`, --v3
		weapon_mkgsarp = `COMPONENT_MKGSARP_PI_SUPP`, --v3
        
        --v4 attachments
        weapon_fn57 = `COMPONENT_AT_PI_SUPP_FN57`, -- v4
        weapon_g19kmr = `COMPONENT_AT_PI_SUPP_G19KMR`, --v4
        weapon_m9 = `COMPONENT_M9_SUPP_01`, --v4
        weapon_mandp9 = `COMPONENT_AT_PI_SUPP_MANDP9`, --v4
        weapon_xdm = `COMPONENT_AT_PI_SUPP_XDM`, --v4

        --v5 attachments
        weapon_ump = `COMPONENT_AT_AR_FLSH_UMP`, --v5
		weapon_pdp = `COMPONENT_AT_PDP_FLSH`, --v5

        --PD attachements
        weapon_pdmpx = `COMPONENT_AT_AR_SUPP_PDMPX`, -- DKPDv1
        weapon_pdhkusp = `COMPONENT_AT_PI_SUPP_PDHKUSP`, -- DKPDv1
        weapon_pdm9a3 = `COMPONENT_AT_PI_SUPP_PDM9A3`, -- DKPDv1
        weapon_pdg19 = `COMPONENT_AT_PI_SUPP_PDG19`, -- DKPDv1
        weapon_pdg19fde = `COMPONENT_AT_PI_SUPP_PDG19FDE`, -- DKPDv1
        weapon_pdg19tan = `COMPONENT_AT_PI_SUPP_PDG19TAN`, -- DKPDv1

        --Unisex Attachments
        weapon_berettam9 = `COMPONENT_BERETTAM9_PI_SUPP`, --Unisex
        weapon_g17g5mos = `COMPONENT_G17G5MOS_PI_SUPP`, --Unisex
        weapon_sigp238 = `COMPONENT_SIGP238_SUPP`, --Unisex
    },

    at_pistol_sight = {
        --v1 attachments
        weapon_sig = `COMPONENT_SIG_SCOPE_02`, --v1


    },

    at_scope_medium = {

        --v1 attachments
        weapon_sr25 = `COMPONENT_SR25_SCOPE`,
        weapon_mdr2 = `COMPONENT_MDR_SCOPE`,
        weapon_m4a1fm = `COMPONENT_M4A1FM_SCOPE`,
        weapon_akm = `COMPONENT_AKM_SCOPE`,
        weapon_mp7 = `COMPONENT_AT_SCOPE_MACRO_MP7`,

        --v3 attachments
        weapon_bansheearp = `COMPONENT_BANSHEEARP_SCOPE_MEDIUM`, --v3
		weapon_fn15 = `COMPONENT_FN15_SCOPE_MEDIUM`, --v3
		weapon_mkgsarp = `COMPONENT_MKGSARP_SCOPE_MEDIUM`, --v3


        --v4 attachments
        weapon_ar15pistol = `COMPONENT_AR15PISTOL_SCOPE_MEDIUM`, -- v4
        weapon_fr15 = `COMPONENT_FR15_SCOPE_MEDIUM`, -- v4
        weapon_hk417 = `COMPONENT_HK417_SCOPE_MEDIUM`, --v4
        weapon_tx15 = `COMPONENT_TX15_SCOPE_MEDIUM`, --v4

        --v6 attachments
        weapon_lilarp = `COMPONENT_AT_SCOPE_MEDIUM_LILARP`, --v6
		weapon_arcqb = `COMPONENT_AT_SCOPE_MEDIUM_ARCQB`, --v6
        weapon_10incharp = `COMPONENT_AT_SCOPE_MEDIUM_10INARP`, --v6


        --pd attachments
        weapon_pdmpx = `COMPONENT_AT_SCOPE_MEDIUM_PDMPX`, -- DKPDv1
		weapon_pdddm411 = `COMPONENT_AT_SCOPE_MEDIUM_PDDD11`, -- DKPDv1
		weapon_pdddm414 = `COMPONENT_AT_SCOPE_MEDIUM_PDDD14`, -- DKPDv1
		weapon_pdddm416 = `COMPONENT_AT_SCOPE_MEDIUM_PDDD16`, -- DKPDv1

        -- Unisex attachments
        weapon_8incharp = `COMPONENT_8INCHARP_SCOPE_MEDIUM`, -- Unisex
        weapon_ghmicroarp = `COMPONENT_GHMICROARP_SCOPE_MEDIUM`, -- Unisex
        weapon_micromcx = `COMPONENT_MICROMCX_SCOPE_MEDIUM`, -- Unisex
        weapon_microredarp = `COMPONENT_MICROREDARP_SCOPE_MEDIUM`, -- Unisex
    },


    at_clip_100_rifle_blk = {
        --v5 Attachments
        weapon_arblue = `COMPONENT_ARBLUEGANG_CLIP_03`, --v5
		weapon_arblack = `COMPONENT_ARBLACKGANG_CLIP_03`, --v5
		weapon_argreen = `COMPONENT_ARGREENGANG_CLIP_03`, --v5
		weapon_arred = `COMPONENT_ARREDGANG_CLIP_03`, --v5
		weapon_arwhite = `COMPONENT_ARWHITEGANG_CLIP_03`, --v5
    },

    at_clip_100_rifle_blue = {
        --v5 Attachments
        weapon_arblue = `COMPONENT_ARBLUEGANG_CLIP_02`, --v5
		weapon_arblack = `COMPONENT_ARBLACKGANG_CLIP_02`, --v5
		weapon_argreen = `COMPONENT_ARGREENGANG_CLIP_02`, --v5
		weapon_arred = `COMPONENT_ARREDGANG_CLIP_02`, --v5
		weapon_arwhite = `COMPONENT_ARWHITEGANG_CLIP_02`, --v5
    },

    at_clip_100_rifle_green = {
        --v5 Attachments
        weapon_arblue = `COMPONENT_ARBLUEGANG_CLIP_04`, --v5
		weapon_arblack = `COMPONENT_ARBLACKGANG_CLIP_04`, --v5
		weapon_argreen = `COMPONENT_ARGREENGANG_CLIP_04`, --v5
		weapon_arred = `COMPONENT_ARREDGANG_CLIP_04`, --v5
		weapon_arwhite = `COMPONENT_ARWHITEGANG_CLIP_04`, --v5
    },

    at_clip_100_rifle_red = {
        --v5 Attachments
        weapon_arblue = `COMPONENT_ARBLUEGANG_CLIP_05`, --v5
		weapon_arblack = `COMPONENT_ARBLACKGANG_CLIP_05`, --v5
		weapon_argreen = `COMPONENT_ARGREENGANG_CLIP_05`, --v5
		weapon_arred = `COMPONENT_ARREDGANG_CLIP_05`, --v5
		weapon_arwhite = `COMPONENT_ARWHITEGANG_CLIP_05`, --v5
    },

    at_clip_100_rifle_white = {
        --v5 Attachments
        weapon_arblue = `COMPONENT_ARBLUEGANG_CLIP_06`, --v5
		weapon_arblack = `COMPONENT_ARBLACKGANG_CLIP_06`, --v5
		weapon_argreen = `COMPONENT_ARGREENGANG_CLIP_06`, --v5
		weapon_arred = `COMPONENT_ARREDGANG_CLIP_06`, --v5
		weapon_arwhite = `COMPONENT_ARWHITEGANG_CLIP_06`, --v5
    },

    at_clip_seethrough_pistol = {

        --v1 attachments
        weapon_glock19p80 = `COMPONENT_GLOCK19P80_CLIP_03`, --v1
		weapon_dkglock19x = `COMPONENT_DKGLOCK19X_CLIP_03`, --v1
		weapon_glock21 = `COMPONENT_DKGLOCK21_CLIP_03`, --v1
		weapon_glockp80 = `COMPONENT_GLOCKP80_CLIP_03`, --v1


        --v3 Attachments
        weapon_dkglock17 = `COMPONENT_DKGLOCK17_CLIP_03`, -- v3
		weapon_dkglock17x = `COMPONENT_DKGLOCK17X_CLIP_03`, -- v3
		weapon_dkglock26 = `COMPONENT_DKGLOCK26_CLIP_03`, -- v3
		weapon_pf940 = `COMPONENT_PF940_CLIP_03`, -- v3

        --v5 Attachments
        weapon_blackglock = `COMPONENT_BLACKGLOCKSWITCH_CLIP_02`, --v5
		weapon_blueglock = `COMPONENT_BLUEGLOCKSWITCH_CLIP_02`, --v5
		weapon_greenglock = `COMPONENT_GREENGLOCKSWITCH_CLIP_02`, --v5
		weapon_redglock = `COMPONENT_REDGLOCKSWITCH_CLIP_02`, --v5
		weapon_whiteglock = `COMPONENT_WHITEGLOCKSWITCH_CLIP_02`, --v5
		weapon_dagger19 = `COMPONENT_DAGGER19_CLIP_02`, --v5
		weapon_g18c = `COMPONENT_G18C_CLIP_02`, --v5

        --v6 attachments
        weapon_g17gb = `COMPONENT_G17GB_CLIP_03`, --v6
		weapon_g18 = `COMPONENT_G18_CLIP_03`, --v6
		weapon_incognitog26 = `COMPONENT_INCOGNITOG26_CLIP_03`, --v6
		weapon_lljg17 = `COMPONENT_LLJG17_CLIP_03`, --v6


        --unisex attachments
        weapon_g22gen4 = `COMPONENT_G22GEN4_CLIP_03`, --Unisex
        weapon_g41gen4 = `COMPONENT_G22GEN4_CLIP_03`, --Unisex
        weapon_gen5steelbutton = `COMPONENT_GEN5STEELBUTTON_CLIP_03`, --Unisex
        weapon_dkglock20 = `COMPONENT_DKGLOCK20_CLIP_03`, --Unisex
        weapon_dkglock30 = `COMPONENT_DKGLOCK30_CLIP_03`, --Unisex
    },

    at_clip_vector_mag = {

        --v1 attachments
        weapon_glock19p80 = `COMPONENT_GLOCK19P80_CLIP_04`, --v1
		weapon_dkglock19x = `COMPONENT_DKGLOCK19X_CLIP_04`, --v1
		weapon_glock21 = `COMPONENT_DKGLOCK21_CLIP_04`, --v1
		weapon_glockp80 = `COMPONENT_GLOCKP80_CLIP_04`, --v1

        --v3 Attachments
        weapon_dkglock17 = `COMPONENT_DKGLOCK17_CLIP_04`, -- v3
		weapon_dkglock17x = `COMPONENT_DKGLOCK17X_CLIP_04`, -- v3
		weapon_dkglock26 = `COMPONENT_DKGLOCK26_CLIP_04`, -- v3
		weapon_pf940 = `COMPONENT_PF940_CLIP_04`, -- v3

        --v4 attachments
        weapon_g19grip = `COMPONENT_G19GRIP_CLIP_03`, -- v4

        --v5 Attachments
        weapon_blackglock = `COMPONENT_BLACKGLOCKSWITCH_CLIP_03`, --v5
		weapon_blueglock = `COMPONENT_BLUEGLOCKSWITCH_CLIP_03`, --v5
		weapon_greenglock = `COMPONENT_GREENGLOCKSWITCH_CLIP_03`, --v5
		weapon_redglock = `COMPONENT_REDGLOCKSWITCH_CLIP_03`, --v5
		weapon_whiteglock = `COMPONENT_WHITEGLOCKSWITCH_CLIP_03`, --v5
		weapon_dagger19 = `COMPONENT_DAGGER19_CLIP_03`, --v5
		weapon_g18c = `COMPONENT_G18C_CLIP_03`, --v5

        --v6 attachments
        weapon_g17gb = `COMPONENT_G17GB_CLIP_04`, --v6
		weapon_g18 = `COMPONENT_G18_CLIP_04`, --v6
		weapon_incognitog26 = `COMPONENT_INCOGNITOG26_CLIP_04`, --v6
		weapon_lljg17 = `COMPONENT_LLJG17_CLIP_04`, --v6
        weapon_akv9 = `COMPONENT_AKV9_CLIP_02`, --v6


        --unisex attachments
        weapon_g17g5mos = `COMPONENT_G17G5MOS_CLIP_04`, --Unisex
        weapon_g22gen4 = `COMPONENT_G22GEN4_CLIP_04`, --Unisex
        weapon_g41gen4 = `COMPONENT_G22GEN4_CLIP_04`, --Unisex
        weapon_gen5steelbutton = `COMPONENT_GEN5STEELBUTTON_CLIP_04`, --Unisex
        weapon_dkglock20 = `COMPONENT_DKGLOCK20_CLIP_04`, --Unisex
        weapon_dkglock30 = `COMPONENT_DKGLOCK30_CLIP_04`, --Unisex
    },

    at_clip_ardrum = {

        --v1 attachments
        weapon_bracearp = `COMPONENT_BRACEARP_CLIP_03`, --v1
		weapon_straparp = `COMPONENT_STRAPARP_CLIP_03`, --v1

        --v3 attachments
        weapon_fn15 = `COMPONENT_FN15_CLIP_02`, --v3
		weapon_dkkeltecplr = `COMPONENT_DKKELTECPLR_CLIP_03`, --v3
		weapon_dkminiarp = `COMPONENT_DKMINIARP_CLIP_02`, --v3
        weapon_fn15 = `COMPONENT_FN15_CLIP_02`,

        --v4 attachments
        weapon_ar15pistol = `COMPONENT_AR15PISTOL_CLIP_02`, -- v4
        weapon_fr15 = `COMPONENT_FR15_CLIP_02`, -- v4
        weapon_g36 = `COMPONENT_G36_CLIP_02`, --v4
        weapon_hk417 = `COMPONENT_HK417_CLIP_02`, --v4
        weapon_sig556 = `COMPONENT_SIG556_CLIP_02`, --v4
        weapon_sigsg552 = `COMPONENT_SIGSG552_CLIP_02`, --v4
        weapon_tx15 = `COMPONENT_TX15_CLIP_02`, --v4

        --v6 attachments
        weapon_lilarp = `COMPONENT_LILARP_CLIP_02`, --v6
		weapon_arcqb = `COMPONENT_ARCQB_CLIP_02`, --v6
        weapon_4incharp = `COMPONENT_4INARP_CLIP_02`, --v6
		weapon_10incharp = `COMPONENT_10INARP_CLIP_02`, --v6

        --pd attachments
        weapon_pdddm411 = `COMPONENT_PDDD11_CLIP_03`, -- DKPDv1
		weapon_pdddm414 = `COMPONENT_PDDD14_CLIP_03`, -- DKPDv1
		weapon_pdddm416 = `COMPONENT_PDDD16_CLIP_03`, -- DKPDv1

        -- Unisex attachments
        weapon_8incharp = `COMPONENT_8INCHARP_CLIP_02`, -- Unisex
        weapon_dkaug = `COMPONENT_DKAUG_CLIP_02`, -- Unisex
        weapon_ghmicroarp = `COMPONENT_GHMICROARP_CLIP_02`, -- Unisex
        weapon_micromcx = `COMPONENT_MICROMCX_CLIP_02`, -- Unisex
        weapon_microredarp = `COMPONENT_MICROREDARP_CLIP_02`, -- Unisex
    },

    at_clip_akdrum = {
        --v1 attachments
        weapon_dkdraco = `COMPONENT_DKDRACO_CLIP_03`, --v1
		weapon_dkmicrodraco = `COMPONENT_DKMICRODRACO_CLIP_03`, --v1

        --v3 attachments
        weapon_dkminidraco = `COMPONENT_DKMINIDRACO_CLIP_03`, --v3
		weapon_ak104 = `COMPONENT_AK104_CLIP_04`, --v3
		weapon_type56 = `COMPONENT_TYPE56_CLIP_04`, --v3

        --v4 attachments
        weapon_ak74u = `COMPONENT_AK74U_CLIP_03`, -- v4
        weapon_m92 = `COMPONENT_M92_CLIP_03`, --v4

        --v6 attachments
        weapon_cadraco = `COMPONENT_CADRACO_CLIP_03`, --v6
		weapon_camicrodraco = `COMPONENT_CAMICRODRACO_CLIP_03`, --v6

        -- Unisex attachments
        weapon_aks74 = `COMPONENT_AKS74_CLIP_03`, -- Unisex
    },

    at_stacked_mag_rifle = {

        --v1 attachments
        weapon_dkdraco = `COMPONENT_DKDRACO_CLIP_02`, --v1
		weapon_dkmicrodraco = `COMPONENT_DKMICRODRACO_CLIP_02`, --v1

        --v3 attachments
        weapon_dkkeltecplr = `COMPONENT_DKKELTECPLR_CLIP_04`, --v3
		weapon_dkminiarp = `COMPONENT_DKMINIARP_CLIP_03`, --v3
		weapon_dkminidraco = `COMPONENT_DKMINIDRACO_CLIP_02`, --v3
		weapon_ak104 = `COMPONENT_AK104_CLIP_03`, --v3
		weapon_type56 = `COMPONENT_TYPE56_CLIP_03`, --v3

        --v4 attachments
        weapon_ak74u = `COMPONENT_AK74U_CLIP_02`, -- v4
        weapon_ar15pistol = `COMPONENT_AR15PISTOL_CLIP_03`, -- v4
        weapon_fr15 = `COMPONENT_FR15_CLIP_03`, -- v4
        weapon_g36 = `COMPONENT_G36_CLIP_03`, --v4
        weapon_hk417 = `COMPONENT_HK417_CLIP_03`, --v4
        weapon_sig556 = `COMPONENT_SIG556_CLIP_03`, --v4
        weapon_sigsg552 = `COMPONENT_SIGSG552_CLIP_03`, --v4
        weapon_tx15 = `COMPONENT_TX15_CLIP_03`, --v4
        weapon_m92 = `COMPONENT_M92_CLIP_02`, --v4

        --v6 attachments
        weapon_lilarp = `COMPONENT_LILARP_CLIP_03`, --v6
		weapon_arcqb = `COMPONENT_ARCQB_CLIP_03`, --v6
        weapon_4incharp = `COMPONENT_4INARP_CLIP_03`, --v6
		weapon_10incharp = `COMPONENT_10INARP_CLIP_03`, --v6
		weapon_cadraco = `COMPONENT_CADRACO_CLIP_02`, --v6
		weapon_camicrodraco = `COMPONENT_CAMICRODRACO_CLIP_02`, --v6

        --pd attachments
        weapon_pdddm411 = `COMPONENT_PDDD11_CLIP_04`, -- DKPDv1
		weapon_pdddm414 = `COMPONENT_PDDD14_CLIP_04`, -- DKPDv1
		weapon_pdddm416 = `COMPONENT_PDDD16_CLIP_04`, -- DKPDv1

        -- Unisex attachments
        weapon_8incharp = `COMPONENT_8INCHARP_CLIP_03`, -- Unisex
        weapon_aks74 = `COMPONENT_AKS74_CLIP_02`, -- Unisex
        weapon_dkaug = `COMPONENT_DKAUG_CLIP_03`, -- Unisex
        weapon_ghmicroarp = `COMPONENT_GHMICROARP_CLIP_03`, -- Unisex
        weapon_micromcx = `COMPONENT_MICROMCX_CLIP_03`, -- Unisex
        weapon_microredarp = `COMPONENT_MICROREDARP_CLIP_03`, -- Unisex
    },


```

