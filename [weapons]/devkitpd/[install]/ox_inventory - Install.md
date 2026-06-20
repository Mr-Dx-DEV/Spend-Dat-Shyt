

## [Features]
- 14 Add-On Weapons 🔫

## [Installation]
- Put the `Devkit_PDWeaponPack` folder into your ``resources`` folder and then ensure Devkit_PDWeaponPack

# FOUR EASY STEPS 

# STEP 1: ADD IMAGES TO             ■   [ox_inventory\web\images]  
# STEP 2: ADD WEAPONS TO            ■   [ox_inventory\data\weapons.lua]  add to the  Weapons = {      
# STEP 3: ADD Attachments TO        ■   [ox_inventory\data\weapons.lua]  add to the Components = { these are extra attachments.
# STEP 4: ADD AMMO TO               ■   [ox_inventory\data\weapons.lua]  add to the Ammo = { = this is another type of ammo.



[#################################################################################################]



```lua
	--#Devkit PD WeaponPack

    ['WEAPON_PDG19'] = {
		label = 'PD G19 BLK',
		weight = 1800,
		durability = 0.2,
		ammoname = 'ammo-pd',
	},

	['WEAPON_PDG19FDE'] = {
		label = 'PD G19 FDE',
		weight = 1800,
		durability = 0.2,
		ammoname = 'ammo-pd',
	},

	['WEAPON_PDG19TAN'] = {
		label = 'PD G19 TAN',
		weight = 1800,
		durability = 0.2,
		ammoname = 'ammo-pd',
	},

	['WEAPON_PDDDM411'] = {
		label = 'PD DDM4 BLK',
		weight = 3900,
		durability = 0.3,
		ammoname = 'ammo-pd'
	},

	['WEAPON_PDDDM414'] = {
		label = 'PD DDM4 TAN',
		weight = 3900,
		durability = 0.3,
		ammoname = 'ammo-pd'
	},

	['WEAPON_PDDDM416'] = {
		label = 'PD DDM4 FDE',
		weight = 3900,
		durability = 0.3,
		ammoname = 'ammo-pd'
	},

	['WEAPON_PDM9A3'] = {
		label = 'PD M9A3',
		weight = 1500,
		durability = 0.2,
		ammoname = 'ammo-pd',
	},

	['WEAPON_PDHKUSP'] = {
		label = 'PD HK USP',
		weight = 1500,
		durability = 0.2,
		ammoname = 'ammo-pd',
	},

	['WEAPON_PDM3'] = {
		label = 'PD BELLENI M3',
		weight = 3300,
		durability = 0.3,
		ammoname = 'ammo-pd'
	},

	['WEAPON_PDMPX'] = {
		label = 'PD MPX',
		weight = 2900,
		durability = 0.4,
		ammoname = 'ammo-pd',
	},

	['WEAPON_DKBATON'] = {
		label = 'Baton',
		weight = 1000,
		durability = 0.1,
		anim = { 'anim@melee@switchblade@holster', 'unholster', 200, 'anim@melee@switchblade@holster', 'holster', 600 },
	},

	['WEAPON_TASERX'] = {
		label = 'Taser X',
		weight = 227,
		durability = 0.1,
	},

	['WEAPON_TASERXBLK'] = {
		label = 'Taser X (BLK)',
		weight = 227,
		durability = 0.1,
	},

	['WEAPON_ENDURA'] = {
		label = 'Endura 4',
		weight = 300,
		durability = 0.1,
		anim = { 'anim@melee@switchblade@holster', 'unholster', 200, 'anim@melee@switchblade@holster', 'holster', 600 },
	},





Components = {

		['at_flashlight'] = {
			label = 'Tactical Flashlight',
			weight = 120,
			type = 'flashlight',
			client = {
				component = {
					`COMPONENT_SIG_FLSH_01`, --v1
					`COMPONENT_AT_PI_FLSH_M45A1`, --v1
					`COMPONENT_AT_PI_FLSH_MP7`, --v1
					`COMPONENT_SWMP9_FLSH_01`, --v1
					`COMPONENT_BANSHEEARP_AR_FLSH`, --v3
					`COMPONENT_AT_PI_FN509_FLSH`, --v3
					`COMPONENT_MKGSARP_AR_FLSH`, --v3
					`COMPONENT_AK104_AR_FLSH`, --v3
					`COMPONENT_AT_PI_FLSH_FN57`, --v4
					`COMPONENT_AT_PI_FLSH_G19KMR`, --v4
					`COMPONENT_M9_FLSH_01`, --v4
					`COMPONENT_AT_PI_FLSH_MANDP9`, --v4
					`COMPONENT_AT_PI_FLSH_XDM`, --v4
					`COMPONENT_AT_PI_TP9SF_FLSH`, --V4
					`COMPONENT_FR15_FLSH`, --v4
					`COMPONENT_TX15_FLSH`, --v4
					`COMPONENT_AT_AR_FLSH_LILARP`, --v6
					`COMPONENT_AT_AR_FLSH_ARCQB`, --v6
					`COMPONENT_AT_AR_FLSH_4INARP`, --v6
					`COMPONENT_AT_AR_FLSH_10INARP`, --v6
					`COMPONENT_AT_PI_FLSH_PX4`, --v6
					`COMPONENT_AT_AR_FLSH_PDMPX`, -- DKPDv1
					`COMPONENT_AT_AR_FLSH_PDM3`, -- DKPDv1
					`COMPONENT_AT_PI_FLSH_PDHKUSP`, -- DKPDv1
					`COMPONENT_AT_PI_FLSH_PDM9A3`, -- DKPDv1
					`COMPONENT_AT_AR_FLSH_PDDD11`, -- DKPDv1
					`COMPONENT_AT_AR_FLSH_PDDD14`, -- DKPDv1
					`COMPONENT_AT_AR_FLSH_PDDD16`, -- DKPDv1
					`COMPONENT_AT_PI_FLSH_PDG19`, -- DKPDv1
					`COMPONENT_AT_PI_FLSH_PDG19FDE`, -- DKPDv1
					`COMPONENT_AT_PI_FLSH_PDG19TAN`, -- DKPDv1
					`COMPONENT_8INCHARP_AR_FLSH`, -- Unisex
					`COMPONENT_GHMICROARP_AR_FLSH`, -- Unisex
					`COMPONENT_MICROMCX_FLSH`, -- Unisex
					`COMPONENT_MP10MM_FLSH`, -- Unisex
				},
				usetime = 1500
			}
		},

		['at_grip'] = {
			label = 'Grip',
			type = 'grip',
			weight = 280,
			client = {
				component = {
					`COMPONENT_MDR2_GRIP_03`, --v1
					`COMPONENT_AT_AR_AFGRIP_ARCQB`, --v6
					`COMPONENT_AT_AR_AFGRIP_PDDD11`, -- DKPDv1
					`COMPONENT_AT_AR_AFGRIP_PDDD14`, -- DKPDv1
					`COMPONENT_AT_AR_AFGRIP_PDDD16`, -- DKPDv1
				},
				usetime = 1500
			}
		},

		['at_laser'] = {
			label = 'Tactical Laser',
			weight = 120,
			type = 'flashlight',
			client = {
				component = {
					`COMPONENT_DKGLOCK17_PI_FLSH`, --v3
					`COMPONENT_DKGLOCK17X_PI_FLSH`, --v3
					`COMPONENT_DKKELTECPLR_AR_AFGRIP`, --v3
					`COMPONENT_HK417_LASER`, --v4
					`COMPONENT_G36_LASER`, --v4
					`COMPONENT_SFN509_LASER`, --v4
					`COMPONENT_AT_PI_FLCOMBO_LLJG17`, --v6
					`COMPONENT_AT_PI_LASER_CANIKTP9`, --v6
					`COMPONENT_AT_PI_LASER_G17GB`, --v6
					`COMPONENT_AT_AR_FLSH_AKV9`, --v6
					`COMPONENT_G17G5MOS_PI_FLSH`, -- Unisex
					`COMPONENT_GEN5STEELBUTTON_PI_LSR`, -- Unisex
					`COMPONENT_SPXD9_LSR`, --Unisex
					`COMPONENT_G22GEN4_LSR`, --Unisex
					`COMPONENT_DKGLOCK20_LSR`, --Unisex
				},
				usetime = 1500
			}
		},

		['at_pistol_sight'] = {
			label = 'Pistol Sight',
			type = 'sight',
			weight = 280,
			client = {
				component = {
					`COMPONENT_SIG_SCOPE_02`, --v1
				},
				usetime = 1500
			}
		},

		['at_pistol_suppressor'] = {
			label = 'Pistol Suppressor',
			type = 'suppressor',
			weight = 280,
			client = {
				component = {
					`COMPONENT_SIG_SUPP_03`, --v1
					`COMPONENT_AT_PI_SUPP_M45A1`, --v1
					`COMPONENT_AT_AR_SUPP_02_MP7`, --v1
					`COMPONENT_BANSHEEARP_PI_SUPP`, --v3
					`COMPONENT_DKGLOCK26_PI_SUPP`, --v3
					`COMPONENT_MKGSARP_PI_SUPP`, --v3
					`COMPONENT_AT_PI_SUPP_FN57`, --v4
					`COMPONENT_AT_PI_SUPP_G19KMR`, --v4
					`COMPONENT_M9_SUPP_01`, --v4
					`COMPONENT_AT_PI_SUPP_MANDP9`, --v4
					`COMPONENT_AT_PI_SUPP_XDM`, --v4
					`COMPONENT_AT_AR_SUPP_LILARP`, --v6
					`COMPONENT_AT_AR_SUPP_PDMPX`, -- DKPDv1
					`COMPONENT_AT_PI_SUPP_PDHKUSP`, -- DKPDv1
					`COMPONENT_AT_PI_SUPP_PDM9A3`, -- DKPDv1
					`COMPONENT_AT_PI_SUPP_PDG19`, -- DKPDv1
					`COMPONENT_AT_PI_SUPP_PDG19FDE`, -- DKPDv1
					`COMPONENT_AT_PI_SUPP_PDG19TAN`, -- DKPDv1
					`COMPONENT_G17G5MOS_PI_SUPP`, -- Unisex
					`COMPONENT_BERETTAM9_PI_SUPP`, -- Unisex
					`COMPONENT_SIGP238_SUPP`, -- Unisex
				},
				usetime = 1500
			}
		},

		['at_rifle_suppressor'] = {
			label = 'Rifle Suppressor',
			type = 'suppressor',
			weight = 280,
			client = {
				component = {
					`COMPONENT_AKM_SUPP_03`, --v1
					`COMPONENT_SR25_SUPP_01`, --v1
					`COMPONENT_MDR2_SUPP_03`, --v1
					`COMPONENT_FN15_AR_SUPP`, --v3
					`COMPONENT_DKKELTECPLR_AR_SUPP`, --v3
					`COMPONENT_DKMINIARP_AR_SUPP`, --v3
					`COMPONENT_AK104_AR_SUPP_02`, --v3
					`COMPONENT_TYPE56_AR_SUPP_02`, --v3
					`COMPONENT_AT_AR_SUPP_AA12`, -- v4
					`COMPONENT_FR15_SUPP`, --v4
					`COMPONENT_G36_SUPP`, --v4
					`COMPONENT_HK417_SUPP`, --v4
					`COMPONENT_SIG556_SUPP`, --v4
					`COMPONENT_SIGSG552_SUPP`, --v4
					`COMPONENT_TX15_SUPP`, --v4
					`COMPONENT_AT_AR_SUPP_ARCQB`, --v6
					`COMPONENT_AT_AR_SUPP_4INARP`, --v6
					`COMPONENT_AT_AR_SUPP_10INARP`, --v6
					`COMPONENT_AT_AR_SUPP_LILARP`, --v6
					`COMPONENT_AT_AR_SUPP_PDM3`, -- DKPDv1
					`COMPONENT_AT_AR_SUPP_PDDD11`, -- DKPDv1
					`COMPONENT_AT_AR_SUPP_PDDD14`, -- DKPDv1
					`COMPONENT_AT_AR_SUPP_PDDD16`, -- DKPDv1
					`COMPONENT_8INCHARP_AR_SUPP`, -- Unisex
					`COMPONENT_GHMICROARP_AR_SUPP`, -- Unisex
					`COMPONENT_MICROMCX_SUPP`, -- Unisex
					`COMPONENT_MICROREDARP_SUPP`, -- Unisex
					`COMPONENT_AK12GAUGE_SUPP`, -- Unisex
				},
				usetime = 1500
			}
		},

		['at_clip_extended_shotgun'] = {
			label = 'Extended Shotgun Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_AK12GAUGE_CLIP_02`, -- Unisex
				},
				usetime = 1500
			}
		},

		['at_clip_drum_shotgun'] = {
			label = 'Shotgun Drum Mag',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_AA12_CLIP_02`, -- v4
					`COMPONENT_AK12GAUGE_CLIP_03`, -- Unisex
				},
				usetime = 1500
			}
		},

		['at_clip_extended_smg'] = {
			label = 'Extended SMG Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_MP7_CLIP_02`, --v1
					`COMPONENT_ARMAC_CLIP_02`, -- Unisex
					`COMPONENT_HKMP5_CLIP_02`, -- Unisex
					`COMPONENT_SPC9_CLIP_02`, -- Unisex
				},
				usetime = 1500
			}
		},

		['at_clip_drum_smg'] = {
			label = 'SMG Drum Mag',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_MP5SD_CLIP_02`, --v1
					`COMPONENT_BANSHEEARP_CLIP_02`, --v3
					`COMPONENT_MKGSARP_CLIP_02`, --v3
					`COMPONENT_KELTECSUB_CLIP_02`, --v4
					`COMPONENT_PDMPX_CLIP_02`, --DKPDv1
					`COMPONENT_ARMAC_CLIP_03`, -- Unisex
					`COMPONENT_HKMP5_CLIP_03`, -- Unisex
					`COMPONENT_SPC9_CLIP_03`, -- Unisex
				},
				usetime = 1500
			}
		},

        ['at_clip_extended_rifle'] = {
			label = 'Extended Rifle Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_AKM_CLIP_06`, --v1
					`COMPONENT_SR25_CLIP_01`, --v1
					`COMPONENT_MDR2_CLIP_06`, --v1
					`COMPONENT_BRACEARP_CLIP_02`, --v1
					`COMPONENT_STRAPARP_CLIP_02`, --v1
					`COMPONENT_AK104_CLIP_02`, --v3
					`COMPONENT_TYPE56_CLIP_02`, --v3
					`COMPONENT_DKKELTECPLR_CLIP_02`, --V3
					`COMPONENT_PDDD11_CLIP_02`, -- DKPDv1
					`COMPONENT_PDDD14_CLIP_02`, -- DKPDv1
					`COMPONENT_PDDD16_CLIP_02`, -- DKPDv1
				},
				usetime = 1500
			}
		},

		['at_clip_extended_pistol'] = {
			label = 'Extended Pistol Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_GLOCK19P80_CLIP_02`, --v1
					`COMPONENT_DKGLOCK19X_CLIP_02`, --v1
					`COMPONENT_DKGLOCK21_CLIP_02`, --v1
					`COMPONENT_GLOCKP80_CLIP_02`, --v1
					`COMPONENT_SIG_CLIP_02`, --v1
					`COMPONENT_M45A1_CLIP_02`, --v1
					`COMPONENT_SWMP9_CLIP_02`, --v1
					`COMPONENT_FN509_CLIP_02`, --v3
					`COMPONENT_DKGLOCK17_CLIP_02`, -- v3
					`COMPONENT_DKGLOCK17X_CLIP_02`, -- v3
					`COMPONENT_DKGLOCK26_CLIP_02`, -- v3
					`COMPONENT_PF940_CLIP_02`, -- v3
					`COMPONENT_G17GEN5_CLIP_02`, --v4
					`COMPONENT_FN57_CLIP_02`, --v4
					`COMPONENT_G19KMR_CLIP_02`, --v4
					`COMPONENT_M9_CLIP_02`, --v4
					`COMPONENT_MANDP9_CLIP_02`, --v4
					`COMPONENT_XDM_CLIP_02`, --v4
					`COMPONENT_TP9SF_CLIP_02`, --V4
					`COMPONENT_G19GRIP_CLIP_02`, --v4
					`COMPONENT_SFN509_CLIP_02`, --v4
					`COMPONENT_G17GB_CLIP_02`, --v6
					`COMPONENT_G18_CLIP_02`, --v6
					`COMPONENT_INCOGNITOG26_CLIP_02`, --v6
					`COMPONENT_UDP9_CLIP_02`, --v6
					`COMPONENT_CANIKTP9_CLIP_02`, --v6
					`COMPONENT_MAC10_CLIP_02`, --v6
					`COMPONENT_LLJG17_CLIP_02`, --v6
					`COMPONENT_PX4_CLIP_02`, --v6
					`COMPONENT_PDHKUSP_CLIP_02`, --DKPDv1
					`COMPONENT_PDM9A3_CLIP_02`, --DKPDv1
					`COMPONENT_PDG19_CLIP_02`, --DKPDv1
					`COMPONENT_PDG19FDE_CLIP_02`, --DKPDv1
					`COMPONENT_PDG19TAN_CLIP_02`, --DKPDv1
					`COMPONENT_G17G5MOS_CLIP_02`, -- Unisex
					`COMPONENT_GEN5STEELBUTTON_CLIP_02`, -- Unisex
					`COMPONENT_BERETTAM9_CLIP_02`, -- Unisex
					`COMPONENT_MP10MM_CLIP_02`, -- Unisex
					`COMPONENT_SIGP238_CLIP_02`, -- Unisex
					`COMPONENT_SPXD9_CLIP_02`, -- Unisex
					`COMPONENT_G22GEN4_CLIP_02`, -- Unisex
					`COMPONENT_G41GEN4_CLIP_02`, -- Unisex
					`COMPONENT_DKGLOCK30_CLIP_02`, -- Unisex
					`COMPONENT_DKGLOCK20_CLIP_02`, --Unisex
				},
				usetime = 1500
			}
		},

		['at_clip_seethrough_pistol'] = {
			label = 'See Through Pistol Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_GLOCK19P80_CLIP_03`, --v1
					`COMPONENT_DKGLOCK19X_CLIP_03`, --v1
					`COMPONENT_DKGLOCK21_CLIP_03`, --v1
					`COMPONENT_GLOCKP80_CLIP_03`, --v1
					`COMPONENT_DKGLOCK17_CLIP_03`, -- v3
					`COMPONENT_DKGLOCK17X_CLIP_03`, -- v3
					`COMPONENT_DKGLOCK26_CLIP_03`, -- v3
					`COMPONENT_PF940_CLIP_03`, -- v3
					`COMPONENT_G17GB_CLIP_03`, --v6
					`COMPONENT_G18_CLIP_03`, --v6
					`COMPONENT_INCOGNITOG26_CLIP_03`, --v6
					`COMPONENT_LLJG17_CLIP_03`, --v6
					`COMPONENT_G17G5MOS_CLIP_03`, -- Unisex
					`COMPONENT_GEN5STEELBUTTON_CLIP_03`, -- Unisex
					`COMPONENT_G22GEN4_CLIP_03`, -- Unisex
					`COMPONENT_G41GEN4_CLIP_03`, -- Unisex
					`COMPONENT_DKGLOCK30_CLIP_03`, -- Unisex
					`COMPONENT_DKGLOCK20_CLIP_03`, --Unisex
				},
				usetime = 1000
			}
		},

		['at_clip_vector_mag'] = {
			label = 'Vector Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_GLOCK19P80_CLIP_04`, --v1
					`COMPONENT_DKGLOCK19X_CLIP_04`, --v1
					`COMPONENT_DKGLOCK21_CLIP_04`, --v1
					`COMPONENT_GLOCKP80_CLIP_04`, --v1
					`COMPONENT_DKGLOCK17_CLIP_04`, -- v3
					`COMPONENT_DKGLOCK17X_CLIP_04`, -- v3
					`COMPONENT_DKGLOCK26_CLIP_04`, -- v3
					`COMPONENT_PF940_CLIP_04`, -- v3
					`COMPONENT_G19GRIP_CLIP_03`, --v4
					`COMPONENT_G17GB_CLIP_04`, --v6
					`COMPONENT_G18_CLIP_04`, --v6
					`COMPONENT_INCOGNITOG26_CLIP_04`, --v6
					`COMPONENT_LLJG17_CLIP_04`, --v6
					`COMPONENT_AKV9_CLIP_02`, --v6
					`COMPONENT_G17G5MOS_CLIP_04`, -- Unisex
					`COMPONENT_GEN5STEELBUTTON_CLIP_04`, -- Unisex
					`COMPONENT_G22GEN4_CLIP_04`, -- Unisex
					`COMPONENT_G41GEN4_CLIP_04`, -- Unisex
					`COMPONENT_DKGLOCK30_CLIP_04`, -- Unisex
					`COMPONENT_DKGLOCK20_CLIP_04`, --Unisex
				},
				usetime = 1000
			}
		},

		['at_clip_drum_pistol'] = {
			label = 'Pistol Drum Mag',
			type = 'magazine',
			weight = 500,
			client = {
				component = {
					`COMPONENT_GLOCK19P80_CLIP_05`, --v1
					`COMPONENT_DKGLOCK19X_CLIP_05`, --v1
					`COMPONENT_DKGLOCK21_CLIP_05`, --v1
					`COMPONENT_GLOCKP80_CLIP_05`, --v1
					`COMPONENT_DKGLOCK17_CLIP_05`, -- v3
					`COMPONENT_DKGLOCK17X_CLIP_05`, -- v3
					`COMPONENT_DKGLOCK26_CLIP_05`, -- v3
					`COMPONENT_PF940_CLIP_05`, -- v3
					`COMPONENT_FN57_CLIP_03`, --v4
					`COMPONENT_G17GEN5_CLIP_03`, --v4
					`COMPONENT_G19KMR_CLIP_03`, --v4
					`COMPONENT_MANDP9_CLIP_03`, --v4
					`COMPONENT_XDM_CLIP_03`, --v4
					`COMPONENT_TP9SF_CLIP_03`, --V4
					`COMPONENT_G19GRIP_CLIP_04`, --v4
					`COMPONENT_SFN509_CLIP_03`, --v4
					`COMPONENT_G17GB_CLIP_05`, --v6
					`COMPONENT_G18_CLIP_05`, --v6
					`COMPONENT_INCOGNITOG26_CLIP_05`, --v6
					`COMPONENT_CANIKTP9_CLIP_03`, --v6
					`COMPONENT_LLJG17_CLIP_05`, --v6
					`COMPONENT_AKV9_CLIP_03`, --v6
					`COMPONENT_PX4_CLIP_03`, --v6
					`COMPONENT_G17G5MOS_CLIP_05`, -- Unisex
					`COMPONENT_GEN5STEELBUTTON_CLIP_05`, -- Unisex
					`COMPONENT_SPXD9_CLIP_03`, -- Unisex
					`COMPONENT_G22GEN4_CLIP_05`, -- Unisex
					`COMPONENT_G41GEN4_CLIP_05`, -- Unisex
					`COMPONENT_DKGLOCK30_CLIP_05`, -- Unisex
					`COMPONENT_DKGLOCK20_CLIP_05`, --Unisex
				},
				usetime = 1000
			}
		},

		['at_clip_100_pistol'] = {
			label = 'Pistol 100 Rnd Mag',
			type = 'magazine',
			weight = 800,
			client = {
				component = {
					`COMPONENT_GLOCK19P80_CLIP_06`, --v1
					`COMPONENT_DKGLOCK19X_CLIP_06`, --v1
					`COMPONENT_DKGLOCK21_CLIP_06`, --v1
					`COMPONENT_GLOCKP80_CLIP_06`, --v1
					`COMPONENT_DKGLOCK17_CLIP_06`, --v3
					`COMPONENT_DKGLOCK17X_CLIP_06`, --v3
					`COMPONENT_DKGLOCK26_CLIP_06`, --v3
					`COMPONENT_PF940_CLIP_06`, -- v3
					`COMPONENT_G17GEN5_CLIP_04`, --v4
					`COMPONENT_G19KMR_CLIP_04`, --v4
					`COMPONENT_G19GRIP_CLIP_05`, --v4
					`COMPONENT_G17GB_CLIP_06`, --v6
					`COMPONENT_G18_CLIP_06`, --v6
					`COMPONENT_INCOGNITOG26_CLIP_06`, --v6
					`COMPONENT_LLJG17_CLIP_06`, --v6
					`COMPONENT_G17G5MOS_CLIP_06`, -- Unisex
					`COMPONENT_GEN5STEELBUTTON_CLIP_06`, -- Unisex
					`COMPONENT_G22GEN4_CLIP_06`, -- Unisex
					`COMPONENT_G41GEN4_CLIP_06`, -- Unisex
					`COMPONENT_DKGLOCK30_CLIP_06`, -- Unisex
					`COMPONENT_DKGLOCK20_CLIP_06`, --Unisex
				},
				usetime = 1500
			}
		},



		['at_clip_ardrum'] = {
			label = 'AR 50 Rnd Drum',
			type = 'magazine',
			weight = 500,
			client = {
				component = {
					`COMPONENT_BRACEARP_CLIP_03`, --v1
					`COMPONENT_STRAPARP_CLIP_03`, --v1
					`COMPONENT_FN15_CLIP_02`, --v3
					`COMPONENT_DKKELTECPLR_CLIP_03`, --v3
					`COMPONENT_DKMINIARP_CLIP_02`, --v3
					`COMPONENT_AR15PISTOL_CLIP_02`, --v4
					`COMPONENT_FR15_CLIP_02`, --v4
					`COMPONENT_G36_CLIP_02`, --v4
					`COMPONENT_HK417_CLIP_02`, --v4
					`COMPONENT_SIG556_CLIP_02`, --v4
					`COMPONENT_SIGSG552_CLIP_02`, --v4
					`COMPONENT_TX15_CLIP_02`, --v4
					`COMPONENT_4INARP_CLIP_02`, --v6
					`COMPONENT_10INARP_CLIP_02`, --v6
					`COMPONENT_ARCQB_CLIP_02`, --v6
					`COMPONENT_LILARP_CLIP_02`, --v6
					`COMPONENT_LILARP_CLIP_02`, --v6
					`COMPONENT_PDDD11_CLIP_03`, -- DKPDv1
					`COMPONENT_PDDD14_CLIP_03`, -- DKPDv1
					`COMPONENT_PDDD16_CLIP_03`, -- DKPDv1
					`COMPONENT_8INCHARP_CLIP_02`, -- Unisex
					`COMPONENT_GHMICROARP_CLIP_02`, -- Unisex
					`COMPONENT_MICROMCX_CLIP_02`, -- Unisex
					`COMPONENT_MICROREDARP_CLIP_02`, -- Unisex
					`COMPONENT_DKAUG_CLIP_02`, -- Unisex
				},
				usetime = 2500
			}
		},

		['at_stacked_mag_rifle'] = {
			label = '60 Stacked Rifle Mag',
			type = 'magazine',
			weight = 500,
			client = {
				component = {
					`COMPONENT_DKDRACO_CLIP_02`, --v1
					`COMPONENT_DKMICRODRACO_CLIP_02`, --v1
					`COMPONENT_FN15_CLIP_03`, --v1
					`COMPONENT_DKKELTECPLR_CLIP_04`, --v3
					`COMPONENT_DKMINIARP_CLIP_03`, --v3
					`COMPONENT_DKMINIDRACO_CLIP_02`, --v3
					`COMPONENT_AK104_CLIP_03`, --v3
					`COMPONENT_TYPE56_CLIP_03`, --v3
					`COMPONENT_AR15PISTOL_CLIP_03`, --v4
					`COMPONENT_AK74U_CLIP_02`, --v4
					`COMPONENT_FR15_CLIP_03`, --v4
					`COMPONENT_G36_CLIP_03`, --v4
					`COMPONENT_HK417_CLIP_03`, --v4
					`COMPONENT_SIG556_CLIP_03`, --v4
					`COMPONENT_SIGSG552_CLIP_03`, --v4
					`COMPONENT_TX15_CLIP_03`, --v4
					`COMPONENT_M92_CLIP_02`, --v4
					`COMPONENT_4INARP_CLIP_03`, --v6
					`COMPONENT_10INARP_CLIP_03`, --v6
					`COMPONENT_CADRACO_CLIP_02`, --v6
					`COMPONENT_CAMICRODRACO_CLIP_02`, --v6
					`COMPONENT_ARCQB_CLIP_03`, --v6
					`COMPONENT_LILARP_CLIP_03`, --v6
					`COMPONENT_PDDD11_CLIP_04`, -- DKPDv1
					`COMPONENT_PDDD14_CLIP_04`, -- DKPDv1
					`COMPONENT_PDDD16_CLIP_04`, -- DKPDv1
					`COMPONENT_8INCHARP_CLIP_03`, -- Unisex
					`COMPONENT_AKS74_CLIP_02`, -- Unisex
					`COMPONENT_GHMICROARP_CLIP_03`, -- Unisex
					`COMPONENT_MICROMCX_CLIP_03`, -- Unisex
					`COMPONENT_MICROREDARP_CLIP_03`, -- Unisex
					`COMPONENT_DKAUG_CLIP_03`, -- Unisex
				},
				usetime = 2500
			}
		},

		['at_clip_akdrum'] = {
			label = 'AK 73 Rnd Drum',
			type = 'magazine',
			weight = 500,
			client = {
				component = {
					`COMPONENT_DKDRACO_CLIP_03`, --v1
					`COMPONENT_DKMICRODRACO_CLIP_03`, --v1
					`COMPONENT_DKMINIDRACO_CLIP_03`, --v3
					`COMPONENT_AK104_CLIP_04`, --v3
					`COMPONENT_TYPE56_CLIP_04`, --v3
					`COMPONENT_AK74U_CLIP_03`, --v4
					`COMPONENT_M92_CLIP_03`, --v4
					`COMPONENT_CADRACO_CLIP_03`, --v6
					`COMPONENT_CAMICRODRACO_CLIP_03`, --v6
					`COMPONENT_AKS74_CLIP_03`, -- Unisex
				},
				usetime = 2500
			}
		},


		['at_clip_100_rifle'] = {
			label = '100 Rnd Rifle Mag',
			type = 'magazine',
			weight = 800,
			client = {
				component = {
					`COMPONENT_BRACEARP_CLIP_04`, --v1
					`COMPONENT_STRAPARP_CLIP_04`, --v1
					`COMPONENT_FN15_CLIP_04`, --v3
					`COMPONENT_DKKELTECPLR_CLIP_05`, --v3
					`COMPONENT_DKMINIARP_CLIP_04`, --v3
					`COMPONENT_AR15PISTOL_CLIP_04`, --v4
					`COMPONENT_FR15_CLIP_04`, --v4
					`COMPONENT_G36_CLIP_04`, --v4
					`COMPONENT_HK417_CLIP_04`, --v4
					`COMPONENT_SIG556_CLIP_04`, --v4
					`COMPONENT_SIGSG552_CLIP_04`, --v4
					`COMPONENT_TX15_CLIP_04`, --v4
					`COMPONENT_4INARP_CLIP_04`, --v6
					`COMPONENT_10INARP_CLIP_04`, --v6
					`COMPONENT_ARCQB_CLIP_04`, --v6
					`COMPONENT_LILARP_CLIP_04`, --v6
					`COMPONENT_8INCHARP_CLIP_04`, -- Unisex
					`COMPONENT_GHMICROARP_CLIP_04`, -- Unisex
					`COMPONENT_MICROMCX_CLIP_04`, -- Unisex
					`COMPONENT_MICROREDARP_CLIP_04`, -- Unisex
				},
				usetime = 2000
			}
		},

        ['at_scope_medium'] = {
			label = 'Medium Scope',
			type = 'sight',
			weight = 280,
			client = {
				component = {
					`COMPONENT_AKM_SCOPE_01`, --v1
					`COMPONENT_SR25_SCOPE_09`, --v1
					`COMPONENT_MDR2_SCOPE_04`, --v1
					`COMPONENT_AT_SCOPE_MEDIUM_MP7`, --v1
					`COMPONENT_AT_SCOPE_MEDIUM_STRAPARP`, --v1
					`COMPONENT_BANSHEEARP_SCOPE_MEDIUM`, --v3
					`COMPONENT_FN15_SCOPE_MEDIUM`, --v3
					`COMPONENT_MKGSARP_SCOPE_MEDIUM`, --v3
					`COMPONENT_AR15PISTOL_SCOPE_MEDIUM`, --v4
					`COMPONENT_FR15_SCOPE_MEDIUM`, --v4
					`COMPONENT_HK417_SCOPE_MEDIUM`, --v4
					`COMPONENT_TX15_SCOPE_MEDIUM`, --v4
					`COMPONENT_AT_SCOPE_MEDIUM_LILARP`, --v6
					`COMPONENT_AT_SCOPE_MEDIUM_ARCQB`, --v6
					`COMPONENT_AT_SCOPE_MEDIUM_10INARP`, --v6
					`COMPONENT_AT_SCOPE_MEDIUM_PDMPX`, -- DKPDv1
					`COMPONENT_AT_SCOPE_MEDIUM_PDDD11`, -- DKPDv1
					`COMPONENT_AT_SCOPE_MEDIUM_PDDD14`, -- DKPDv1
					`COMPONENT_AT_SCOPE_MEDIUM_PDDD16`, -- DKPDv1
					`COMPONENT_8INCHARP_SCOPE_MEDIUM`, -- Unisex
					`COMPONENT_GHMICROARP_SCOPE_MEDIUM`, -- Unisex
					`COMPONENT_MICROMCX_SCOPE_MEDIUM`, -- Unisex
					`COMPONENT_MICROREDARP_SCOPE_MEDIUM`, -- Unisex
				},
				usetime = 1500
			}
		},

	},



Ammo = {

	['ammo-22'] = {
		label = '.22 Long Rifle',
		weight = 3,
	},

	['ammo-38'] = {
		label = '.38 Long Colt',
		weight = 10,
	},

	['ammo-9'] = {
		label = '9x19mm',
		weight = 8,
	},

	['ammo-40'] = {
		label = '.40 S&W',
		weight = 10,
	},

	['ammo-pd'] = {
		label = 'PD Ammo',
		weight = 10,
	},

	['ammo-44'] = {
		label = '.44 Magnum',
		weight = 16,
	},

	['ammo-45'] = {
		label = '.45 ACP',
		weight = 9,
	},

	['ammo-50'] = {
		label = '.50 AE',
		weight = 19,
	},

	['ammo-57'] = {
		label = '5.7x28mm',
		weight = 8,
	},

	['ammo-flare'] = {
		label = 'Flare',
		weight = 38,
	},

	['ammo-heavysniper'] = {
		label = '.50 BMG',
		weight = 45,
	},

	['ammo-musket'] = {
		label = 'Musket ammo',
		weight = 30,
	},

	['ammo-rifle'] = {
		label = '5.56',
		weight = 4,
	},

	['ammo-rifle2'] = {
		label = '7.62x39',
		weight = 8,
	},

	['ammo-308'] = {
		label = '7.62x51mm',
		weight = 8,
	},

	['ammo-shotgun'] = {
		label = '12 Gauge',
		weight = 38,
	},

	['ammo-sniper'] = {
		label = '7.62 NATO',
		weight = 11,
	},
}