Config = {}
Config.Chains = {
    ["prop_chain"] = { -- item name
        label = "Prop Chain", -- item label that will show on the context menu
        prop = "snipe_chain", -- prop name
        category = "gang",
        bone = 10706, -- bone on which the chain will be attached
        offset = vec3(-0.03, -0.01, -0.02), -- offset of the chain
        rotation = vec3(-9.0, -22.0, -165.0), -- rotation of the chain
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 5000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        offsets = { -- offsets for different infused items particle effects
            ["diamond"] = vec3(0.0,  -0.2 , -0.1), -- offset for diamond
            ["ruby"] = vec3(0.0,  -0.15 , -0.1), -- offset for ruby
        },
        craftItems = { -- items required for crafting
            ["diamond"] = { -- item name
                label = "Diamond", -- label to show on ui
                amount = 1, -- amount required
            },
            ["ruby"] = { -- item name
                label = "Ruby", -- label to show on ui
                amount = 1, -- amount required
            },
        }
    },

    ["coskii_chain"] = { -- item name
        label = "Coskii Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 282, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
      ["bigluck_chain"] = { -- item name
        label = "Luck Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 281, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
    ["badluck_chain"] = { -- item name
        label = "Bad Luck Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 279, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
     ["enforcer5_chain"] = { -- item name
        label = "Enforcer 5", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 376, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
     ["zone6_chain"] = { -- item name
        label = "Zone 6 Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 271, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
     ["ed_chain"] = { -- item name
        label = "Ed Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 267, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
    ["finesse_family_chain"] = { -- item name
        label = "Finesse Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 277, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
     ["scoe_chain"] = { -- item name
        label = "Scoe Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 278, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
     ["k3_chain"] = { -- item name
        label = "K3 Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 273, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
     ["preme_chain"] = { -- item name
        label = "Preme Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 275, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },

     ["riq_chain"] = { -- item name
        label = "Riq Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 272, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },

    ["babyrich_chain"] = { -- item name
        label = "Babyrich Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 280, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },

     ["opm_chain"] = { -- item name
        label = "OPM Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 270, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },

     ["773ja_chain"] = { -- item name
        label = "773 Ja Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 268, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },

     ["jeff_chain"] = { -- item name
        label = "Jeff Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 269, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
    ["perk_chain"] = { -- item name
        label = "Perk Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 67, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },

     ["k4_chain"] = { -- item name
        label = "K4 Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "jewellery-store-1", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 500000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        -- componentId = 8, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 79, texture = 0}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
             },
        }
    },
    
   --[[["test_chain"] = { -- item name
        label = "Test Chain", -- item label that will show on the context menu
        drawable = true, -- if the chain is clothing item
        category = "business",
        shopType = "mask-store", -- shoptype is taken from locations.lua (if no shoptype is defined, it will show the item in every shop)
        itemPrice = 5000, -- price of the item if the shop allows buying (if not defined, it will set the Config.DefaultPrice value which is in config.lua)
        componentId = 1, -- (you can now overwrite the component Id) (by default its 7, but you can set the value here)
        clothing = {
            ["mp_m_freemode_01"] = {drawable = 345, texture = 2}, -- texture and drawable if its a male ped model
        },
        -- if offsets are commented, item wont have the option to add infused items
        -- offsets = { -- offsets for different infused items particle effects
        --     ["diamond"] = vec3( 0.0, 0.08, 0.34), -- offset for diamond
        --     ["ruby"] = vec3(0.0, 0.14, 0.36),   -- offset for ruby
        -- },
        craftItems = {
            ["diamond"] = {
                label = "Diamond",
                amount = 1,
            },
            ["ruby"] = {
                label = "Ruby",
                amount = 1,
            },
        }
    },]]
}