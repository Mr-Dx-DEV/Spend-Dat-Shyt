Config = {}

-- Specify the framework being used ('ESX' or 'QBCore')
Config.Framework = 'QBCore' -- or 'QBCore'
Config.UseOxTargetForNpc = true -- set to false to not use Target
Config.SneakerPhoneItem = 'shoe_phone' -- Don't change this.


-- Add as many as you want, 22 By default.
Config.DeliveryLocations = {
    { x = 373.8328, y = 427.9720, z = 145.6843 }, 
    { x = 315.6384, y = 501.9844, z = 153.1798 },  
    { x = 128.2986, y = 566.0015, z = 183.9800 }, 
    { x = -516.7256, y = 433.3788, z = 97.8078 },  
    { x = -968.6490, y = 436.8183, z = 80.5717 },  
    { x = -1052.1809, y = 432.2358, z = 77.0639 },  
    { x = -1122.7089, y = 485.7752, z = 82.1607 },  
    { x = -728.7547, y = -879.7343, z = 22.7109 }, 
    { x = 443.2751, y = -1707.2467, z = 29.7086 },  
    { x = 1229.2198, y = -725.3958, z = 60.7989 },  
    { x = 1251.2645, y = -621.3680, z = 69.4132 }, 
    { x = 952.6441, y = -252.3502, z = 67.9664 },  
    { x = -448.8238, y = -132.6289, z = 39.0829 },  
    { x = -534.3204, y = -166.3404, z = 38.3248 }, 
    { x = -1098.2153, y = -346.1143, z = 37.8035 }, 
    { x = -716.3690, y = -864.7014, z = 23.1834 },  
    { x = -668.2289, y = -971.5549, z = 22.3408 }, 
    { x = -706.1187, y = -1036.4200, z = 16.4240 },  
    { x = -986.5771, y = -1199.3740, z = 6.0735 },  
    { x = -1126.1855, y = -1171.8801, z = 2.3576},  
    { x = -1122.2983, y = -1046.33421, z = 2.1504 }, 
    { x = -1351.0392, y = -1128.5168, z = 4.1545 },  
    { x = -1269.7740, y = -1296.4608, z = 4.0042 }

}

-- Define required items for delivery and their prices (ENSURE TO CHANGE PRICES TO YOUR SERVER!)
Config.RequiredItems = {
    { name = 'sky_gliders_plus', rewardRange = { min = 240, max = 360 } },
    { name = 'breeze_bangs', rewardRange = { min = 260, max = 390 } },
    { name = 'tiger_mediums', rewardRange = { min = 248, max = 372 } },
    { name = 'galaxy_x', rewardRange = { min = 196, max = 294 } },
    { name = 'sky_walkers', rewardRange = { min = 148, max = 222 } },
    { name = 'sky_pilots', rewardRange = { min = 204, max = 306 } },
    { name = 'sky_flyers', rewardRange = { min = 204, max = 306 } },
    { name = 'sky_gliders', rewardRange = { min = 204, max = 306 } },
    { name = 'fastrunner_2000', rewardRange = { min = 204, max = 306 } },
    { name = 'speedster_300', rewardRange = { min = 204, max = 306 } },
        { name = 'runner_prime', rewardRange = { min = 204, max = 306 } },
    { name = 'breeze_95s', rewardRange = { min = 204, max = 306 } },
    { name = 'breeze_100s', rewardRange = { min = 204, max = 306 } },
    { name = 'breeze_90s', rewardRange = { min = 204, max = 306 } },
    { name = 'sky_walkers_red', rewardRange = { min = 204, max = 306 } },
    { name = 'shadow_yellows', rewardRange = { min = 204, max = 306 } },
    { name = 'shadow_yellows_verified', rewardRange = { min = 204, max = 306 } }
}
