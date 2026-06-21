Config = {}

Config.Locale = 'en'

Config.Storage = {
    mode = 'metadata', 
    database = {
        table = 'mi_outfitbag_data'
    }
}


Config.Interaction = 'qb-target'
Config.DrawTextDistance = 2.0
Config.DrawTextKeyOpen = 38 
Config.DrawTextKeyPickup = 47 



Config.BagItems = {
    ['outfitbag'] = { capacity = 5, model = 'xm_prop_x17_bag_01a' }, 
    ['outfitbag_small'] = { capacity = 3, model = 'xm_prop_x17_bag_01a' },
    ['outfitbag_med'] = { capacity = 6, model = 'xm_prop_x17_bag_01a' },
    ['outfitbag_big'] = { capacity = 10, model = 'xm_prop_x17_bag_01a' },
}

Config.AnimDict = 'pickup_object'
Config.AnimName = 'pickup_low'
Config.JobBagCapacity = 10 
Config.Debug = false



Config.RummageAnim = true


Config.PreviewTick = 25 
Config.PreviewOutline = false 


Config.JobBagDisablePickup = true

Config.SaveOutfitData = function()
    if GetResourceState('illenium-appearance') == 'started' then
        TriggerServerEvent('illenium-appearance:server:saveAppearance', exports['illenium-appearance']:getPedAppearance(PlayerPedId()))
    elseif GetResourceState('fivem-appearance') == 'started' then
        TriggerServerEvent('fivem-appearance:server:saveAppearance', exports['fivem-appearance']:getPedAppearance(PlayerPedId()))
    elseif GetResourceState('qb-clothing') == 'started' then
        TriggerServerEvent('qb-clothing:saveSkin', true)
    end
end

Config.NudeClothing = {
    male = {
        shoes = 34,
        pants = 61,
        top = 15,
        under = 15,
        torso = 15,
        mask = 0
    },
    female = {
        shoes = 35,
        pants = 15,
        top = 15,
        under = 15,
        torso = 15,
        mask = 0
    }
}



Config.JobBagClientFallback = true
Config.JobBagSpawnDistance = 20.0



Config.JobPresets = {
    ['police'] = {
        default = {
            {
                label = 'Patrol Uniform',
                appearance = nil
            }
        },
        grades = {
            [0] = {
                { label = 'Cadet', appearance = nil }
            },
            [1] = {
                { label = 'Officer', appearance = nil }
            },
            [2] = {
                { label = 'Sergeant', appearance = nil }
            },
            [3] = {
                {
                    label = 'SWAT Gear',
                    appearance = { 
                        male = {
                            components = {
                                { component_id = 1, drawable = 0, texture = 0 },  
                                { component_id = 3, drawable = 30, texture = 0 }, 
                                { component_id = 4, drawable = 35, texture = 0 }, 
                                { component_id = 6, drawable = 24, texture = 0 }, 
                                { component_id = 8, drawable = 15, texture = 0 }, 
                                { component_id = 9, drawable = 16, texture = 0 }, 
                                { component_id = 10, drawable = 0, texture = 0 }, 
                                { component_id = 11, drawable = 50, texture = 0 } 
                            },
                            props = {
                                { prop_id = 0, drawable = -1, texture = 0 }, 
                                { prop_id = 1, drawable = -1, texture = 0 }  
                            }
                        },
                        female = {
                            components = {
                                { component_id = 1, drawable = 0, texture = 0 },  
                                { component_id = 3, drawable = 30, texture = 0 }, 
                                { component_id = 4, drawable = 35, texture = 0 }, 
                                { component_id = 6, drawable = 24, texture = 0 }, 
                                { component_id = 8, drawable = 15, texture = 0 }, 
                                { component_id = 9, drawable = 16, texture = 0 }, 
                                { component_id = 10, drawable = 0, texture = 0 }, 
                                { component_id = 11, drawable = 50, texture = 0 } 
                            },
                            props = {
                                { prop_id = 0, drawable = -1, texture = 0 }, 
                                { prop_id = 1, drawable = -1, texture = 0 }  
                            }
                        }
                    }
                }
            }
        }
    },
    ['ambulance'] = {
        default = {
            { label = 'Medic Gear', appearance = nil }
        },
        grades = {
            [0] = {
                { label = 'EMT', appearance = nil }
            },
            [1] = {
                {
                    label = 'Paramedic',
                    appearance = {
                        male = {
                            components = {
                                { component_id = 1, drawable = 0, texture = 0 },   
                                { component_id = 3, drawable = 37, texture = 0 },  
                                { component_id = 4, drawable = 35, texture = 0 },  
                                { component_id = 5, drawable = 0, texture = 0 },   
                                { component_id = 6, drawable = 24, texture = 0 },  
                                { component_id = 7, drawable = 126, texture = 0 }, 
                                { component_id = 8, drawable = 15, texture = 0 },  
                                { component_id = 9, drawable = 0, texture = 0 },   
                                { component_id = 10, drawable = -1, texture = 0 },  
                                { component_id = 11, drawable = 13, texture = 0 }  
                            },
                            props = {}
                        }
                    }
                }
            },
            [2] = {
                { label = 'Doctor', appearance = nil }
            }
        }
    }
}




Config.JobBagLocations = {
    ['police'] = {
        { coords = vector4(454.8250, -993.8671, 30.1545, 189.9646) } 
    },
    ['ambulance'] = {
        { coords = vec4(308.71, -598.12, 42.29, 249.05) } 
    }
}
