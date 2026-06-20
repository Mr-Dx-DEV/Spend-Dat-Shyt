## DATA/WEAPONS.LUA

-- Pistols --

['WEAPON_1911'] = {
    label = '1911',
    weight = 1100,
    durability = 0.05,
    ammoname = 'ammo-45'
},

['WEAPON_T1911'] = {
    label = 'Tan 1911',
    weight = 1100,
    durability = 0.05,
    ammoname = 'ammo-45'
},

['WEAPON_FN57'] = {
    label = 'FN 57',
    weight = 744,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_MAKAROV'] = {
    label = 'Makarov',
    weight = 730,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_MPSHEILD'] = {
    label = 'MP Shield',
    weight = 600,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_P80'] = {
    label = 'P80',
    weight = 600,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_P226R'] = {
    label = 'P226R',
    weight = 964,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_G2C'] = {
    label = 'Zaurus G2C',
    weight = 610,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_Z17'] = {
    label = 'Zlock 17',
    weight = 625,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_Z19'] = {
    label = 'Zlock 19',
    weight = 670,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_Z19X'] = {
    label = 'Zlock 19X',
    weight = 670,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_Z22'] = {
    label = 'Zlock 22',
    weight = 430,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_Z26VVS'] = {
    label = 'Zlock 26 VVS',
    weight = 740,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_Z43X'] = {
    label = 'Zlock 43X',
    weight = 735,
    durability = 0.05,
    ammoname = 'ammo-9'
},

['WEAPON_BAGZLOCK'] = {
    label = 'Zlock Bag',
    weight = 650,
    durability = 0.05,
    ammoname = 'ammo-9'
},

-- Rifles --

['WEAPON_AR15'] = {
    label = 'AR-15',
    weight = 3400,
    durability = 0.02,
    ammoname = 'ammo-rifle' -- 5.56x45
},

['WEAPON_BLACKARP'] = {
    label = 'Black ARP',
    weight = 3300,
    durability = 0.02,
    ammoname = 'ammo-rifle'
},

['WEAPON_DRACO'] = {
    label = 'Draco',
    weight = 2500,
    durability = 0.02,
    ammoname = 'ammo-rifle2' -- 7.62x39
},

['WEAPON_MK417'] = {
    label = 'MK 417',
    weight = 4500,
    durability = 0.02,
    ammoname = 'ammo-sniper' -- 7.62x51
},

['WEAPON_PDMK33'] = {
    label = 'MK433',
    weight = 3600,
    durability = 0.02,
    ammoname = 'ammo-rifle'
},

['WEAPON_GR300BO'] = {
    label = 'G-Rod 300 Blackout',
    weight = 3000,
    durability = 0.02,
    ammoname = 'ammo-rifle2'
},

-- Melee --

['WEAPON_BOXCUTTER'] = {
    label = 'Box Cutter',
    weight = 200,
    durability = 0.10,
},

['WEAPON_CHAIR'] = {
    label = 'Chair',
    weight = 2000,
    durability = 0.15,
},

['WEAPON_KITCHENKNIFE'] = {
    label = 'Kitchen Knife',
    weight = 350,
    durability = 0.12,
},

['WEAPON_BELT'] = {
    label = 'Belt',
    weight = 150,
    durability = 0.15,
},

-- Machine Guns

['WEAPON_TEC9'] = {
    label = 'TEC-9',
    weight = 1400,
    durability = 0.03,
    ammoname = 'ammo-9'
},

['WEAPON_UZI'] = {
    label = 'Uzi',
    weight = 1520,
    durability = 0.03,
    ammoname = 'ammo-9'
},

['WEAPON_YTASER'] = {
    label = 'Taser',
    weight = 650,
    durability = 0.10,
},

-- Other --

['WEAPON_PDPT870'] = {
    label = 'PT870',
    weight = 3600,
    durability = 0.02,
    ammoname = 'ammo-shotgun' -- 12 gauge
},

['WEAPON_BBGUN'] = {
    label = 'BB Gun',
    weight = 800,
    durability = 0.10,
    ammoname = 'ammo-22' -- ADD YOUR BB AMMO!
},


## COMPTONENTS 

		['at_flashlight'] = {
			label = 'Tactical Flashlight',
			weight = 120,
			type = 'flashlight',
			client = {
				component = {
					`COMPONENT_AT_AR_FLSH`,
					`COMPONENT_AT_AR_FLSH_REH`,
					`COMPONENT_AT_PI_FLSH`,
					`COMPONENT_AT_PI_FLSH_02`,
					`COMPONENT_AT_PI_FLSH_03`,
				    `COMPONENT_AT_PI_PDT19_FLSH`,
					`COMPONENT_AT_AR_PDMK417_FLSH`,	-- pd
				},
				usetime = 2500
			}
		},

		['at_suppressor_light'] = {
			label = 'Suppressor',
			weight = 280,
			type = 'muzzle',
			client = {
				component = {
					`COMPONENT_AT_PI_SUPP`,
					`COMPONENT_AT_PI_SUPP_02`,
					`COMPONENT_CERAMICPISTOL_SUPP`,
					`COMPONENT_PISTOLXM3_SUPP`,
					`COMPONENT_AT_PI_PDT19_SUPP`,
				},
				usetime = 2500
			}
		},

		['at_clip_extended_pistol'] = {
			label = 'Extended Pistol Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_APPISTOL_CLIP_02`,
					`COMPONENT_CERAMICPISTOL_CLIP_02`,
					`COMPONENT_COMBATPISTOL_CLIP_02`,
					`COMPONENT_HEAVYPISTOL_CLIP_02`,
					`COMPONENT_PISTOL_CLIP_02`,
					`COMPONENT_PISTOL_MK2_CLIP_02`,
					`COMPONENT_PISTOL50_CLIP_02`,
					`COMPONENT_SNSPISTOL_CLIP_02`,
					`COMPONENT_SNSPISTOL_MK2_CLIP_02`,
					`COMPONENT_VINTAGEPISTOL_CLIP_02`,
                    `COMPONENT_TECPISTOL_CLIP_02`,
					`COMPONENT_PDT19_CLIP_02`,
				},
				usetime = 2500
			}
		},

		['at_clip_extended_rifle'] = {
			label = 'Extended Rifle Clip',
			type = 'magazine',
			weight = 280,
			client = {
				component = {
					`COMPONENT_ADVANCEDRIFLE_CLIP_02`,
					`COMPONENT_ASSAULTRIFLE_CLIP_02`,
					`COMPONENT_ASSAULTRIFLE_MK2_CLIP_02`,
					`COMPONENT_BULLPUPRIFLE_CLIP_02`,
					`COMPONENT_BULLPUPRIFLE_MK2_CLIP_02`,
					`COMPONENT_CARBINERIFLE_CLIP_02`,
					`COMPONENT_CARBINERIFLE_MK2_CLIP_02`,
					`COMPONENT_COMPACTRIFLE_CLIP_02`,
					`COMPONENT_HEAVYRIFLE_CLIP_02`,
					`COMPONENT_MILITARYRIFLE_CLIP_02`,
					`COMPONENT_SPECIALCARBINE_CLIP_02`,
					`COMPONENT_SPECIALCARBINE_MK2_CLIP_02`,
					`COMPONENT_TACTICALRIFLE_CLIP_02`,
					`COMPONENT_CARBINERIFLE_BOXMAG`,
					`COMPONENT_PDMK417_CLIP_02`,
				},
				usetime = 2500
			}
		},

		['at_scope_small'] = {
			label = 'Small Scope',
			type = 'sight',
			weight = 280,
			client = {
				component = {
					`COMPONENT_AT_SCOPE_SMALL`,
					`COMPONENT_AT_SCOPE_SMALL_02`,
					`COMPONENT_AT_SCOPE_SMALL_MK2`,
					`COMPONENT_AT_SCOPE_SMALL_SMG_MK2`,
					`COMPONENT_AT_PDT19_SCOPE_SMALL`,
				},
				usetime = 2500
			}
		},

		['at_scope_medium'] = {
			label = 'Medium Scope',
			type = 'sight',
			weight = 280,
			client = {
				component = {
					`COMPONENT_AT_SCOPE_MEDIUM`,
					`COMPONENT_AT_SCOPE_MEDIUM_MK2`,
					`COMPONENT_AT_PDMK417_SCOPE_MEDIUM`,
				},
				usetime = 2500
			}
		},