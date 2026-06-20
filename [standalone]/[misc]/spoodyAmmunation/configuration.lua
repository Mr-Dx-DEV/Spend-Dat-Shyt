QBCore = exports['qb-core']:GetCoreObject()

function GroupDigits(number)
    local left, num, right = string.match(number,'^([^%d]*%d)(%d*)(.-)$')

    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

Configuration = {
    ---@param title? string
    ---@param message string
    ---@param type? 'warning' | 'error' | 'success' | 'inform'
    Notify = function(title, message, type)
        lib.notify({
            title = title or 'Weapon Shops',
            description = message,
            type = type or 'inform',
            duration = 5000,
            position = 'top'
        })
    end,

    Settings = {
        Debug = true, --- Enable debug mode? if you are experiencing bugs or any issues, please enable this for easier solution.

        Blips = {
            Hash = 110, --- What hash should the script use for blips?
        },

        InventoryImagePath = 'nui://ox_inventory/web/images/', --- What path should the script use for inventory images? (Important for images)

        Automation = {
            Job = {
                Create = true, --- Automatically create gunstore jobs into the database? [ESX ONLY]
            },
        },

        --- Munitions are paid shipments that allow weapons to be constructed and crafted.
        --- Depending on each weapon, the amount of munitions required is different.
        Munitions = {
            Max = 250, --- Maximum amount of munitions that can be stored in the shop.
            PricePerMunition = 2500, --- Price per munition
        },

        Interactions = {
            Timers = {
                WipeTable = 5000, --- 5 Seconds to wipe the table cleanup
                SetupCraft = 14000, --- 14 Seconds to setup the crafting
                WeaponCraft = 30000, --- 30 Seconds (per weapon)
            }
        },

        --- MAX: 3 Grades for 1 job
        --- Don't remove or add grades, just edit the existing ones.
        Grades = {
            [1] = {
                label = "Gun Smith", --- Grade label
                hash = "gun_smith", --- Grade hash
                base_salary = 500, --- Base salary
            },

            [2] = {
                label = "Manager", --- Grade label
                hash = "manager", --- Grade hash
                base_salary = 1500, --- Base salary
            },

            [3] = {
                label = "Owner", --- Grade label
                hash = "owner", --- Grade hash
                base_salary = 2500, --- Base salary
            }
        },

        --- Important for firing and hiring employees.
        Player = {
            UnemployedJob = 'unemployed', --- Unemployed job name
            UnemployedGrade = 0, --- Unemployed job grade
        },

        GunLicense = {
            Require = false, --- Require a gun license to access a gun store UI?
            Item = 'gunlicense', --- [if enabled] Item name of the gun license
            AllowPurchase = true, --- [if enabled] Allow the player to purchase the gun license from the gun store?
            PurchasePrice = 50000, --- [if enabled] The price of the gun license 
        },

        Admin = {
            Enabled = true, --- Enable admin menu?
            Command = 'gunstores', --- Command to open admin menu
            Permission = 'ammunation.opencreator', --- Ace Permission
        },

        Commands = {
            Delete = 'deletegunstore', --- Server Side Command Only (console)
            Refresh = 'refreshgunstores', --- Server Side Commad Only (console)
        }
    },

    --- NOTICE: You cannot edit or create new categories, you can only insert the specified weapons into them.
    Weapons = {
        ['Rifles'] = {
            ['WEAPON_GLDARPS'] = {
                label = 'GLD AR',
                licensedPrice = 200000, --- Price to purchase a license to sell this weapon
                minimumPrice = 50000, --- Minimum Price to be set by the job manager
                requiredMunitions = 5, --- Required Munitions to craft this weapon
                minCraft = 1, --- Minimum amount of weapons that can be crafted at once
                maxCraft = 3, --- Maximum amount of weapons that can be crafted at once
            },

       
        },

        ['Pistols'] = {
            ['WEAPON_G23GEN5'] = {
                label = 'Glock 23 Gen5',
                licensedPrice = 200000,
                minimumPrice = 50000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

             ['WEAPON_GHOST'] = {
                label = 'GHOST GLOCK',
                licensedPrice = 200000,
                minimumPrice = 50000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

              ['WEAPON_PISTOL_MK2'] = {
                label = 'MK2 PISTOL',
                licensedPrice = 200000,
                minimumPrice = 50000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

        },

        ['SMGs'] = {
           
        },

        --- UPDATE: Melees is now "Extras"! Add any extras that should be on weapons here! (Ammo, Attach, Knives, etc)
        ['Extras'] = {
            -- 🔪 Melee
            ['WEAPON_KNIFE'] = {
                label = 'Knife',
                craftType = 'extra', -- faster craft
                licensedPrice = 200000,
                minimumPrice = 50000,
                requiredMunitions = 5,
                minCraft = 1,
                maxCraft = 3,
            },

             ['WEAPON_CHAIR'] = {
                label = 'Knife',
                craftType = 'extra', -- faster craft
                licensedPrice = 200000,
                minimumPrice = 50000,
                requiredMunitions = 5,
                minCraft = 1,
                maxCraft = 3,
            },

            -- 🔫 Ammo
            ['ammo-9-box'] = {
                label = '9mm Ammo Box',
                craftType = 'extra', -- faster craft
                licensedPrice = 1500,
                minimumPrice = 50,
                requiredMunitions = 1,
                minCraft = 5,
                maxCraft = 90,
            },

           
            ['ammo-rifle-box'] = {
                label = '556 Box',
                craftType = 'extra',
                licensedPrice = 2200,
                minimumPrice = 700,
                requiredMunitions = 2,
                minCraft = 5,
                maxCraft = 35,
            },

             ['ammo-htip'] = {
                label = 'HOLLOW TIP',
                craftType = 'extra',
                licensedPrice = 2200,
                minimumPrice = 700,
                requiredMunitions = 2,
                minCraft = 5,
                maxCraft = 35,
            },

           
        },
    },
}

Locales = {
    ['Titles'] = {
        ['TITLE_GENERAL'] = 'Ammunation',
        ['TITLE_SALE_COMPLETED'] = 'Sale Completed',
        ['TITLE_PRODUCT_MANAGER'] = 'Product Manager',
        ['TITLE_MUNITIONS_SHIPMENT'] = 'Munitions Shipment',
        ['TITLE_POINT_MANAGER'] = 'Point Manager',
        ['TITLE_EMPLOYEE'] = 'Employee',
        ['TITLE_GUNSHOP_CREATOR'] = 'Shop Creator',
        ['TITLE_ERROR'] = 'Error',
        ['TITLE_SUCCESS'] = 'Success',
        ['TITLE_MANAGER_EMPLOYEE'] = 'Employee Manager',
        ['TITLE_FINANCE_MANAGER'] = "Finance Manager",
    },

    ['Notification'] = {
        ['NOTIFICATION_NO_GUN_LICENSE']      = "You need a gun license to access this store.",
        ['NOTIFICATION_GUN_LICENSE_PURCHASED'] = "You have successfully purchased a gun license!",
        ['NOFICATION_SALE_COMPLETED'] = 'Your purchase at %s was completed successfully!',
        ['NOTIFICATION_PRODUCT_PRICE_UPDATED'] = "Product price has been updated successfully!",
        ['NOTIFICATION_PRODUCT_REMOVED'] = "Product has been removed successfully!",
        ['NOTIFICATION_PRODUCT_REMOVED_FAIL'] = "Failed to remove product!",
        ['NOTIFICATION_POINT_CREATED'] = "Point has been created successfully!",
        ['NOTIFICATION_POINT_DELETED'] = "Point has been deleted successfully!",
        ['NOTIFICATION_MUNITIONS_ORDERED'] = "Munitions shipment has been ordered successfully! it is available immediately.",
        ['NOTIFICATION_CRAFTED'] = "You have crafted %sx %s!",
        ['NOTIFICATION_INSUFFICIENT_MUNITIONS'] = "You don't have enough munitions to craft this weapon!",
        ['NOTIFICATION_STOCK_FAILED_FETCH'] = "Failed to fetch stock, please add products to your stock via product manager.",
        ['NOTIFICATION_CLOCKIN_REQUIRED'] = "You must clock in first!",
        ['NOTIFICATION_CLOCKED_IN'] = "You have clocked in!",
        ['NOTIFICATION_CLOCKED_OUT'] = "You have clocked out!",
        ['NOTIFICATION_GUNSHOP_CREATED'] = "Successfully created %s as a weapon shop!",
        ['NOTIFICATION_SAVED_POINT'] = "Successfully saved %s point!",
        ['NOTIFICATION_PLAYER_NOT_FOUND'] = "Player not found!",
        ['NOTIFICATION_BALANCE_INSUFFICIENT'] = "You do not have enough money to purchase these items!",
        ['NOTIFICATION_STOCK_INSUFFICIENT'] = "Not enough stock or failed to update store stock.",
        ['NOTIFICATION_TRANSACTION_ROLLED_BACK'] = "Failed to add items to your inventory. Transaction rolled back.",
        ['NOTIFICATION_PRICE_BELOW_MIN'] = "Price is below the minimum price limit.",
        ['NOTIFICATION_PRICE_SAME'] = "Price is the same as the current price.",
        ['NOTIFICATION_PRICE_UPDATE_FAIL'] = "Failed to update product price.",
        ['NOTIFICATION_POINT_CREATE_FAIL'] = "Failed to create point.",
        ['NOTIFICATION_POINT_DELETE_FAIL'] = "Failed to delete point.",
        ['NOTIFICATION_VAULT_INSUFFICIENT'] = "This shop does not have enough money in its vault to order this amount of munitions.",
        ['NOTIFICATION_STORAGE_INSUFFICIENT'] = "This shop does not have enough space to order this amount of munitions.",
        ['NOTIFICATION_AUTHORIZED'] = "You are not authorized to perform this action.",
        ['NOTIFICATION_WEAPON_INVALID_DATA'] = "Invalid weapon data provided.",
        ['NOTIFICATION_SHOP_FINANCE_FAILED'] = "Failed to fetch shop finance data.",
        ['NOTIFICATION_SHOP_VAULT_INSUFFICIENT'] = "This shop does not have enough money in its vault to order this amount of munitions.",
        ['NOTIFICATION_WEAPON_ALREADY_EXISTS'] = "This weapon is already in the database under %ss.",
        ['NOTIFICATION_WEAPON_ADDED_SUCCESS'] = "Weapon added successfully to %ss.",
        ['NOTIFICATION_PROMPT_ACCEPTED'] = "%s has accepted your hire request! (%s)",
        ['NOTIFICATION_PROMPT_REJECTED'] = "%s has rejected your hire request!",
        ['NOTIFICATION_PROMP_HIRED'] = "You were hired to %s (%s)",
        ['NOTIFICATION_JOB_POS_CHANGED'] = "Your position has been set to %s!",
        ['NOTIFICATION_JOB_SET_PLAYER'] = "Successfully set %s to %s!",
        ['NOTIFICATION_JOB_FIRED'] = "Successfully fired %s!",
        ['NOTIFICATION_PLAYER_NOT_EXISTS'] = "Player does not exist in-game.",
        ['NOTIFICATION_PLAYER_ALREADY_HIRED'] = "This player is already hired!",
        ['NOTIFICATION_INVALID_NUMBER'] = "Invalid number received.",
        ['NOTIFICATION_BALANCE_WITHDRAW_FAILED'] = "Failed to withdraw; you don't have enough money to do this action.",
        ['NOTIFICATION_BALANCE_DEPO_SUCCESS'] = "You have successfully deposited $%s into this business!",
        ['NOTIFICATION_WITHDRAW_FAILED_FETCH'] = "Failed to withdraw; could not fetch finances.",
        ['NOTIFICATION_WITHDRAW_SUCCESS'] = "You have successfully withdrew $%s from this business!",
        ['NOTIFICATION_FAILED_FETCH_MUNITION'] = "Failed to fetch munitions.",
        ['NOTIFICATION_INSUFFICIENT_MUNITIONS_SHOP'] = "There are not enough munitions in stock.",
        ['NOTIFICATION_UPDATE_MUNITIONS_SUCCESS'] = "Successfully updated munitions for shop: %s",
        ['NOTIFICATION_STORE_DELETED'] = "Store succesfully deleted!",
        ['NOTIFICATION_STORE_DELETED_FAIL'] = "Failed to delete store; contact a developer.",
        ['NOTIFICATION_STORE_LOCATION_UPDATE'] = "Store location succesfully updated!",
        ['NOTIFICATION_SHOPID_INVALID'] = "Shop ID can only contain letters and underscores. No numbers, spaces, or special characters allowed.",
        ['NOTIFICATION_SHOPID_EXISTS'] = "This weaponshop already exists.",
        ['NOTIFICATION_SHOP_DOESNT_EXIST'] = "No shops exist in the database.",
        ['NOTIFICATION_TOO_FAR'] = 'You cannot create a point further than 35 meters from your start location.',
    },

    ['Text UI'] = {
        ['TEXT_CLOCK_IN'] = "Clock In",
        ['TEXT_CLOCK_OUT'] = "Clock Out",
        ['TEXT_OPEN_SHOP'] = "Open Gun Shop"
    },

    ['Other'] = {
        ['NEW_SHOP_POINT'] = "New Shop Point",
        ['GENERAL_POINT'] = "Point",
        ['GENERAL_POINT_NAME'] = "New %s Point"
    }
}

RegisterNetEvent('spoodyAmmunation:notify', function(title, message, type)
    return Configuration.Notify(title, message, type)
end)