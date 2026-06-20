Config = {}

-- Qbox/QBX + ox_inventory money item + external banking support
Config.Framework = 'qbox'               -- 'qbox' | 'qbx' | 'qbcore' | 'qb' | 'esx' | 'auto'
Config.Banking = 'auto'                 -- 'auto' | 'prism_banking' | 'wasabi_banking' | 'tgg_banking' | 'qs_banking' | 'framework'
Config.BillerCashPercent = 0.20         -- Global fallback if a job does not define commissionPercent
Config.MaxDistance = 3.0
Config.AllowNegativeBank = true         -- If true, billing can overdraw target bank below $0

Config.AllowCustom = true
Config.CustomMin = 1
Config.CustomMax = 250000
Config.MaxCustomDescriptionLength = 80
Config.MaxLineItems = 10               -- max preset/custom line items in one bill

-- Receipt item given to billed player (ox_inventory)
Config.ReceiptItem = 'direct_bill'

-- Cash is an ox_inventory item on your server
Config.CashAsItem = true
Config.CashItemName = 'money'

-- Anti-abuse / restrictions
Config.BlockSelfBilling = true
Config.SubmitCooldownSeconds = 2       -- global per-biller cooldown between bill submissions
Config.RepeatTargetCooldownSeconds = 10 -- same biller -> same target cooldown

-- Jobs that can bill + reasons
-- NOTE: society should be the account/job name your banking or management resource expects.
Config.Jobs = {
    -- === EMERGENCY SERVICES ===
    police = {
        label = 'Police Department',
        society = 'police',
        commissionPercent = 0.60,
        maxAmount = 500000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            -- Traffic
            { label = 'Speeding (5-10 mph over)', amount = 500 },
            { label = 'Speeding (11-20 mph over)', amount = 1000 },
            { label = 'Speeding (21-30 mph over)', amount = 1500 },
            { label = 'Speeding (31+ mph over)', amount = 10000 },
            { label = 'Reckless Driving', amount = 2500 },
            { label = 'Failure to Stop (Stop Sign/Light)', amount = 2500 },
            { label = 'Illegal U-turn', amount = 1000 },
            { label = 'Illegal Window Tint', amount = 1000 },
            { label = 'Driving without Headlights', amount = 1250 },
            { label = 'Operating Vehicle without License', amount = 500 },

            -- General
            { label = 'Disorderly Conduct', amount = 2000 },
            { label = 'Public Intoxication', amount = 2500 },
            { label = 'Loitering', amount = 750 },
            { label = 'Illegal Parking', amount = 500 },
            { label = 'Obstructing Traffic', amount = 1000 },
            { label = 'Failure to Yield to Emergency Vehicle', amount = 1000 },

            -- Weapons & Crimes
            { label = 'Brandishing a Firearm', amount = 20000 },
            { label = 'Resisting Arrest', amount = 3000 },
            { label = 'Fleeing & Eluding', amount = 1250 },
            { label = 'Vandalism (Under $500)', amount = 2000 },
            { label = 'Breaking and Entering', amount = 1500 },

            -- Narcotics
            { label = 'Possession of Narcotics', amount = 5000 },
            { label = 'Drug Distribution / Intent to Distribute', amount = 5000 },
            { label = 'Drug Cultivation and Manufacturing', amount = 10000 },
        }
    },

    ambulance = {
        label = 'EMS',
        society = 'ambulance',
        commissionPercent = 0.60,
        maxAmount = 100000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Bandages (1)', amount = 1000 },
            { label = 'Heal Treatment', amount = 10000 },
            { label = 'Revival Treatment', amount = 20000 },
            { label = 'Physical Therapy', amount = 30000 },
            { label = 'Plastic Surgery', amount = 50000 },
        }
    },

    -- === MECHANIC SHOPS ===
    mechanic = {
        label = 'Mechanic',
        society = 'mechanic',
        commissionPercent = 0.50,
        maxAmount = 50000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Basic Repair', amount = 1500 },
            { label = 'Full Vehicle Repair', amount = 3500 },
            { label = 'Towing Service', amount = 2500 },
            { label = 'Custom Work / Performance', amount = 5000 },
        }
    },

    travorcustoms = {
        label = 'Travor Customs',
        society = 'travorcustoms',
        commissionPercent = 0.50,
        maxAmount = 75000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Vehicle Repair', amount = 2000 },
            { label = 'Performance Upgrade', amount = 8000 },
            { label = 'Custom Paint / Wrap', amount = 5000 },
            { label = 'Tuning Package', amount = 12000 },
        }
    },

    ghostcustoms = {
        label = 'Ghost Customs',
        society = 'ghostcustoms',
        commissionPercent = 0.50,
        maxAmount = 75000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Vehicle Repair', amount = 2000 },
            { label = 'Performance Upgrade', amount = 8000 },
            { label = 'Custom Paint / Wrap', amount = 5000 },
        }
    },

    ttmcustoms = {
        label = 'TTM Customs',
        society = 'ttmcustoms',
        commissionPercent = 0.50,
        maxAmount = 60000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Street Mechanic Work', amount = 2500 },
            { label = 'Performance Tech Work', amount = 6000 },
        }
    },

    chicago = {
        label = 'Chicago Rim Shop',
        society = 'chicago',
        commissionPercent = 0.50,
        maxAmount = 50000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Rim / Tire Work', amount = 3000 },
            { label = 'Full Custom Rim Package', amount = 15000 },
        }
    },

    bennys = {
        label = 'Bennys',
        society = 'bennys',
        commissionPercent = 0.50,
        maxAmount = 80000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Custom Work', amount = 5000 },
            { label = 'Full Vehicle Customization', amount = 25000 },
        }
    },

    bennysdocks = {
        label = 'Bennys Docks',
        society = 'bennysdocks',
        commissionPercent = 0.50,
        maxAmount = 80000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Dockside Repair', amount = 4000 },
            { label = 'Boat / Vehicle Work', amount = 8000 },
        }
    },

    chicagotint = {
        label = 'Chicago Paint N Tint',
        society = 'chicagotint',
        commissionPercent = 0.50,
        maxAmount = 40000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Window Tint', amount = 2500 },
            { label = 'Full Paint Job', amount = 12000 },
        }
    },

    -- === OTHER LEGAL JOBS ===
    realestate = {
        label = 'Real Estate',
        society = 'realestate',
        commissionPercent = 0.40,
        maxAmount = 100000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Property Viewing Fee', amount = 500 },
            { label = 'Contract / Closing Fee', amount = 2500 },
            { label = 'Interior Design Consultation', amount = 5000 },
        }
    },

    taxi = {
        label = 'Taxi',
        society = 'taxi',
        commissionPercent = 0.30,
        maxAmount = 5000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Taxi Ride', amount = 150 },
            { label = 'Event Driver Service', amount = 500 },
        }
    },

    tow = {
        label = 'Ghost Towing',
        society = 'tow',
        commissionPercent = 0.50,
        maxAmount = 15000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Towing Service', amount = 2500 },
            { label = 'Impound Release Fee', amount = 5000 },
        }
    },

    bus = {
        label = 'Bus',
        society = 'bus',
        commissionPercent = 0.30,
        maxAmount = 2000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Bus Ride', amount = 50 },
        }
    },

    cardealer = {
        label = 'Vehicle Dealer',
        society = 'cardealer',
        commissionPercent = 0.40,
        maxAmount = 100000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Vehicle Purchase Fee', amount = 500 },
            { label = 'Business Sales Fee', amount = 1500 },
        }
    },

    insurance = {
        label = 'Trusted Insurance',
        society = 'insurance',
        commissionPercent = 0.40,
        maxAmount = 50000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Insurance Claim Processing', amount = 2500 },
            { label = 'Policy Setup Fee', amount = 1500 },
        }
    },

    -- === GOVERNMENT / LEGAL ===
    doj = {
        label = 'Department of Justice',
        society = 'doj',
        commissionPercent = 0.30,
        maxAmount = 250000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Court Filing Fee', amount = 2500 },
            { label = 'Legal Processing Fee', amount = 5000 },
            { label = 'Probation Supervision Fee', amount = 3000 },
        }
    },

    lawyer = {
        label = 'Law Firm',
        society = 'lawyer',
        commissionPercent = 0.50,
        maxAmount = 100000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Legal Consultation', amount = 5000 },
            { label = 'Court Representation Fee', amount = 15000 },
        }
    },

    judge = {
        label = 'Judge',
        society = 'judge',
        commissionPercent = 0.30,
        maxAmount = 100000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Court Fine', amount = 5000 },
        }
    },

    -- === SERVICE JOBS ===
    barber = {
        label = 'Fade Trap',
        society = 'barber',
        commissionPercent = 0.60,
        maxAmount = 5000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Haircut', amount = 150 },
            { label = 'Beard Trim', amount = 100 },
            { label = 'Full Grooming Package', amount = 400 },
        }
    },

    beauty = {
        label = 'Beauty Trap',
        society = 'beauty',
        commissionPercent = 0.60,
        maxAmount = 3000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Basic Service', amount = 200 },
        }
    },

    reporter = {
        label = 'Reporter',
        society = 'reporter',
        commissionPercent = 0.40,
        maxAmount = 5000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'News Article / Coverage', amount = 1500 },
        }
    },

    -- === ILLEGAL / SPECIAL JOBS (Limited Billing) ===
    hitplace = {
        label = 'Hit Place',
        society = 'hitplace',
        commissionPercent = 0.50,
        maxAmount = 50000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Service Fee', amount = 5000 },
        }
    },

    tropicalheights = {
        label = 'Tropical Heights',
        society = 'tropicalheights',
        commissionPercent = 0.40,
        maxAmount = 30000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'VIP Service Fee', amount = 2500 },
        }
    },

    gun_smith = {
        label = 'Ghost Guns',
        society = 'gun_smith',
        commissionPercent = 0.50,
        maxAmount = 50000,
        requireOnDuty = false,
        minGrade = 0,
        reasons = {
            { label = 'Custom Work Fee', amount = 10000 },
        }
    },

    -- Add more jobs below if needed (scammer, drugplug, etc. usually shouldn't bill)
}
