return {
    defaultStressRelief = {
        min = 0,
        max = 4
    },
    ---@class anim
    ---@field clip string
    ---@field dict string
    ---@field flag number

    ---@class prop
    ---@field model string
    ---@field bone number
    ---@field pos vector3
    ---@field rot vector3

    ---@class stressRelief
    ---@field min number
    ---@field max number

    ---@class consumable
    ---@field min number
    ---@field max number
    ---@field anim anim?
    ---@field prop table?
    ---@field stressRelief table?

    ---@class consumableAlcohol : consumable
    ---@field alcoholLevel number?

    consumables = {
        ---@type table<string, consumable>
        food = {
            sandwich = {
                min = 35,
                max = 54,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
            tosti = {
                min = 40,
                max = 50,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
            twerks_candy = {
                min = 35,
                max = 54,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
            snikkel_candy = {
                min = 40,
                max = 50,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
        },

        --Add this code below in qbx-smallresources/qbx_consumables/config.lua
sdft_meatfree = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_heartstopper = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_bleeder = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_moneyshot = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_torpedo = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_fries = {
    min = 20,
    max = 30,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_hotdog = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_sausagedog = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_pretzel = {
    min = 20,
    max = 30,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_minipretzels = {
    min = 20,
    max = 30,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_roastednuts = {
    min = 20,
    max = 30,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_burger = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_megacheese = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_doubleburger = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_kingsizeburger = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_baconburger = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_pizzaslice = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_donut = {
    min = 20,
    max = 30,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_taco_carneasada = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_taco_elpastor = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_burrito_carneasada = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_burrito_elpastor = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_torta_carneasada = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_torta_elpastor = {
    min = 40,
    max = 50,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_quesadilla = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_tostada = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},


--Add this code below in qbx-smallresources/qbx_consumables/config.lua
sdft_milkshake = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
sdft_smoothie = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},

--Add this code below in qbx-smallresources/qbx-consumables/config.lua
["sdam_shine_apple"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_pear"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_peach"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_cherries"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_plum"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_banana"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_apricot"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_mango"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_strawberry"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_blueberry"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_grape"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_pineapple"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_orange"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_raspberry"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_blackberry"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},
["sdam_shine_kiwi"] = {
    min = 30,
    max = 40,
    stressRelief = {
        min = 1,
        max = 4
    },
},


        ---@type table<string, consumable>
        drink = {
            water_bottle = {
                min = 35,
                max = 54,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
            kurkakola = {
                min = 35,
                max = 54,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
            coffee = {
                min = 40,
                max = 50,
                anim = {
                    clip = 'idle_c',
                    dict = 'amb@world_human_drinking@coffee@male@idle_a',
                    flag = 49
                },
                prop = {
                    model = 'p_amb_coffeecup_01',
                    bone = 28422,
                    pos = {x = 0.0, y = 0.0, z = 0.0},
                    rot = {x = 0.0, y = 0.0, z = 0.0}
                },
                stressRelief = {
                    min = -10,
                    max = -1
                },
            },
        },

        ---@type table<string, consumableAlcohol>
        alcohol = {
            whiskey = {
                min = 20,
                max = 30,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
            beer = {
                min = 30,
                max = 40,
                stressRelief = {
                    min = 1,
                    max = 4
                },
                alcoholLevel = 0.25
            },
            vodka = {
                min = 20,
                max = 40,
                stressRelief = {
                    min = 1,
                    max = 4
                },
            },
        },
    },
}
