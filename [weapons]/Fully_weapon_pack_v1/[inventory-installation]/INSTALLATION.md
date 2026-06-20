## [Installation]
- Put the "Fully_weapon_pack_v1" folder into your "resources" folder and then ensure Fully_weapon_pack_v1 -- ⚠️PLEASE READ⚠️; Requires "Fully_weapon_pack_v1" to work properly.

# (THREE EASY STEPS)

# STEP 1: ADD IMAGES TO INVENTORY   ■   [ox_inventory/web/images]                                     
# STEP 2: ADD FIRST CODE LIST TO    ■   [ox_inventory/data/weapons.lua]                               ■  under the | Weapons =     
# STEP 3: ADD SECOND CODE LIST TO   ■   [ox_inventory/data/weapons.lua]                               ■  replace the items under the  Components = 




## Fully Weapon Pack V1 ox_inventory\data\weapons.lua



```lua
	-- Fully Weapon Pack V1
		['WEAPON_DRACULA'] = {
            label = 'Dracula',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-rifle2'
        },

		['WEAPON_DRACOCUSTOM'] = {
            label = 'Draco Custom',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-rifle2'
        },

		['WEAPON_C39CUSTOM'] = {
            label = 'C39 Custom',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-rifle2'
        },

		['WEAPON_DARCBINARY'] = {
            label = 'Drac Binary',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-rifle2'
        },

		['WEAPON_G29'] = {
            label = 'Glock 29',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_MPFRT'] = {
            label = 'M&P 9 FRT',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_G31INCOGNITO'] = {
            label = 'Glock 31 Incognito',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_G27S'] = {
            label = 'G27 Incognito',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_G26GEN4'] = {
            label = 'G26 Gen4 Custom',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_G23GEN5'] = {
            label = 'Glock 23 Gen5',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_G19GEN5'] = {
            label = 'Glock 19 Gen5',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_G19GEN4'] = {
            label = 'Glock 19 Gen4',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },

		['WEAPON_300BLKCHIMI'] = {
			label = 'Chimi 300blk',
			weight = 1400,
			durability = 0.1,
			ammoname = 'ammo-rifle',
		},

		['WEAPON_GLDARPS'] = {
			label = 'Micro GOLD',
			weight = 1400,
			durability = 0.1,
			ammoname = 'ammo-rifle',
		},

		['WEAPON_MICROREDARP'] = {
			label = 'Micro red arp',
			weight = 1400,
			durability = 0.1,
			ammoname = 'ammo-rifle',
		},

		['WEAPON_REDTACAR'] = {
			label = 'Skel Red PDW',
			weight = 1400,
			durability = 0.1,
			ammoname = 'ammo-rifle',
		},

		['WEAPON_FRTARP'] = {
			label = 'Frt Arp',
			weight = 1400,
			durability = 0.1,
			ammoname = 'ammo-rifle',
		},

		['WEAPON_SLVPR'] = {
			label = 'Custom 2 tone arp',
			weight = 1400,
			durability = 0.1,
			ammoname = 'ammo-rifle',
		},

		['WEAPON_19XC'] = {
            label = 'Glock 19x Custom',
            weight = 1,
            durability = 0.05,
            ammoname = 'ammo-9'
        },	
```



⦿ This Includes Attachment codes



```lua
--- 	Fully Weapon Pack V1


        ['w_ar_darcbinary_mag2'] = {
			label = '60rnd Mag Drac',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_DARCBINARY_CLIP_02`
				},
				usetime = 2500
			}
		},

		['w_ar_darcbinary_mag3'] = {
			label = '60rnd Windowed Mag Drac',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_DARCBINARY_CLIP_03`
				},
				usetime = 2500
			}
		},

		['w_ar_darcbinary_mag4'] = {
			label = '60rnd Drum Mag Drac',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_DARCBINARY_CLIP_04`
				},
				usetime = 2500
			}
		},

		['w_ar_darcbinary_mag5'] = {
			label = '30rnd Banana Mag Drac',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_DARCBINARY_CLIP_05`
				},
				usetime = 2500
			}
		},

		['w_ar_frtarp_mag2'] = {
			label = '40rnd Mag AR',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_FRTARP_CLIP_02`
				},
				usetime = 2500
			}
		},

		['w_ar_frtarp_mag3'] = {
			label = '60rnd Windowed Mag AR',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_FRTARP_CLIP_03`
				},
				usetime = 2500
			}
		},

		['w_ar_frtarp_mag4'] = {
			label = '60rnd Drum Mag AR',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_FRTARP_CLIP_04`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag1'] = {
			label = 'Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_01`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag2'] = {
			label = '24rnd Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_02`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag3'] = {
			label = '33rnd Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_03`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag4'] = {
			label = 'Kriss Vector 40rnd Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_04`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag5'] = {
			label = 'Kriss Vector White 40rnd Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_05`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag6'] = {
			label = 'Clear Drum 50rnd Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_06`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag7'] = {
			label = 'Drum 50rnd Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_07`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag8'] = {
			label = '33rnd Windowed Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_08`
				},
				usetime = 2500
			}
		},

		['w_pi_19xcustom_mag9'] = {
			label = 'Clear Drum 100rnd Mag',
			weight = 120,
			type = 'cargador',
			client = {
				component = {
					`COMPONENT_19XC_CLIP_09`
				},
				usetime = 2500
			}
		},