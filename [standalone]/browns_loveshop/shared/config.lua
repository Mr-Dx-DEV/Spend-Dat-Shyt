-- ⚠️⚠️ATTENTION⚠️⚠️  --
-- PLEAAAASEEEEE READ THE config.shop AREA CAREFULYYYYYY OR YOUR ECONOMY WILL BREAK!!!!!!!!!!!!
config                = {}

config.framework      = 'qbox'          -- 'esx', 'qbcore', or 'qbox'
config.inventory      = 'ox_inventory' -- 'ox_inventory, 'qb-inventory' or 'qs-inventory'
config.target         = 'ox_target'    -- 'ox_target', 'qb-target' or 'qtarget'

config.genderSettings = {
    OnlyFemaleCanSellBouquet    = false, -- make it to where only females can sale the chocolate strawberry bouquets?
    OnlyFemaleCanEatBouquet     = false, -- make it to where only females can eat the chocolate strawberry bouquets?
    OnlyFemaleCanOpenGiftBox    = false, -- make it to where only females can open a gift box ?
    OnlyFemaleCanRedeemGiftCard = false, -- make it to where only females can redeem gift cards?
    OnlyMaleCanUseShop          = false, -- make it to where only males can access the lover shop (as they are the ones who should be buying the gifts for females)
    OnlyMaleCanPropose          = false, -- make it to where only a male can propose to someone with a promise ring
}

config.bouquet        = {

    healthBuff = {
        enable = true, -- enable health buff when eating the chocolate strawberry bouquet?
        amount = 40    -- amount of health to give
    },
    hungerBuff = {
        enable = true, -- enable hunger buff when eating the chocolate strawberry bouquet?
        amount = 40    -- amount of hunger to give
    },
    thirstBuff = {
        enable = true, -- enable thirst buff when eating the chocolate strawberry bouquet?
        amount = 40    -- amount of thirst to give
    },

    sellPrice  = 1000, -- how much do you make per bouquet sold.
    maxSell    = 5     -- max amount of bouquets you can sell per transaction (do not set this shit to 0 lol)
}

-- a list of ped models that will come up to buy chocolate strawberry bouquets
config.dealerPeds     = {
    'a_f_m_soucentmc_01',
    'a_f_m_soucent_01',
    'a_f_m_soucent_02',
    'a_f_m_fatbla_01',
    'a_f_y_clubcust_01',
    'a_f_y_clubcust_02',
    'a_f_y_clubcust_03',
    'a_f_y_femaleagent',
    'a_f_y_fitness_02',
    'a_f_y_hippie_01',
}


config.shop = {

    -- enable this if you want to make the shop player owned
    -- this will make to where only those who have the job can access the shop
    jobOnly         = {
        enable = true,
        jobName = 'loveshop'
    },

    storeLocation   = vec4(-557.9102, 187.6767, 72.5627, 266.5486),
    blip            = {
        enable = true,       -- should we enable the blip?
        sprite = 621,        -- https://docs.fivem.net/docs/game-references/blips/#blips
        color  = 46,         -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        scale  = 0.5,        -- 0.1 - 1.0
        label  = 'Love Shop' -- name of the blip
    },

    shopPed         = {
        enable = true, -- enable shop ped? (if not you will just target an empty space instead of a ped at the storelocation coords)
        pedModel = 'a_f_m_beach_01'
    },

    -- these are individually sold items
    -- by default its just the proposal ring
    individualItems = {
        {                                    -- promise ring (THIS ITEM SHOULD NEVER GO IN A GIFT BUNDLE)
            name  = 'promise_ring_case',     -- item name
            label = 'Proposal Promise Ring', -- item label
            image = 'promise_ring_case.png', -- image for the item (should be placed in 'dist' folder)
            price = 10000                    -- price to buy the item
        }
    },


    -- gift bundles are a list of items that will be placed in a gift box
    -- when you open the gift box you get all of the items in the box,
    -- it will also prompt you with an option to add a custom love note when purchasing (required)
    -- so when the person who is receiving the gift opens the box they will see the love note
    giftBundles = {
        -- FOR EACH GIFT BOX PLEASE MAKE SURE THE AMOUNT IT COST TO PURCHASE IS
        -- EQUAL OR MORE THAN THE AMOUNT THAT PLAYERS WILL MAKE FROM SELLING BOUQUETS OR REDEEMING GIFT CARDS IN THE BUNDLE
        -- OTHERWISE -> INFINITE MONEY GLITCH LOL
        -- KEEP IN MIND THE ITEM IN THE ITEMS LIST NAMED 'chocolate_strawberry_bouquet' IS SELLABLE
        -- ADJUST THE PRICE OF IT IN config.bouquet 'sellPrice' ABOVE TO MAKE SURE
        -- SELLING THE AMOUNT OF BOUQUETS YOU GET IN THE BUNDLE DOESENT MAKE YOU MORE THAN
        -- THE PRICE OF BUYING THE BUNDLE
        -- ALSO MAKE SURE THAT THE VALUE OF THE GIFT CARD COMBINED WITH THE AMOUNT OF MONEY
        -- YOU SHOULD GET FOR SELLING EACH BOUQUET IN THE BUNDLE DOESENT MAKE YOU MORE
        -- THAN THE COST OF THE BUNDLE ITSELF OR ELSE -- ONCE AGAIN -> INFINITE MONEY GLITCH LOL
        SweetheartGiftBox = {

            price = 1000,                                       -- price to buy the bundle
            items = {                                            -- list of items in the bundle
                {
                    name   = 'chocolate_strawberry_bouquet',     -- item name
                    label  = 'Chocolate Srawberry Bouquet',      -- item label
                    image  = 'chocolate_strawberry_bouquet.png', -- image for the item (should be placed in 'dist' folder)
                    amount = 5,
                },
                {
                    name   = 'lovers_gift_card',     -- special gift card item name
                    label  = 'Lovers Gift Card',     -- item label
                    image  = 'lovers_gift_card.png', -- image for the item (should be placed in 'dist' folder)
                    amount = 1,
                    -- value only works for the special gift card item
                    value  = 500 -- value of the gift card, when they use it it will redeem this value in cash.
                }
            }
        },

        DevotionGiftBox = {
            price = 2500,
            items = {
                {
                    name   = 'chocolate_strawberry_bouquet',
                    label  = 'Chocolate Srawberry Bouquet',
                    image  = 'chocolate_strawberry_bouquet.png',
                    amount = 20,
                },
                {
                    name   = 'lovers_gift_card',
                    label  = 'Lovers Gift Card',
                    image  = 'lovers_gift_card.png',
                    amount = 1,
                    value  = 5000
                }
            }
        },

        PassionGiftBox = {
            price = 5000,
            items = {
                {
                    name   = 'chocolate_strawberry_bouquet',
                    label  = 'Chocolate Srawberry Bouquet',
                    image  = 'chocolate_strawberry_bouquet.png',
                    amount = 40,
                },
                {
                    name   = 'lovers_gift_card',
                    image  = 'lovers_gift_card.png',
                    label  = 'Lovers Gift Card',
                    amount = 1,
                    value  = 10000
                }
            }
        },

        EternalGiftBox = {
            price = 10000,
            items = {
                {
                    name   = 'chocolate_strawberry_bouquet',
                    label  = 'Chocolate Srawberry Bouquet',
                    image  = 'chocolate_strawberry_bouquet.png',
                    amount = 75,
                },
                {
                    name   = 'lovers_gift_card',
                    image  = 'lovers_gift_card.png',
                    label  = 'Lovers Gift Card',
                    amount = 1,
                    value  = 25000
                }
            }
        },

    },
}
