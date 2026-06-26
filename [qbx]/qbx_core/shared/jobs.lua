--- Job names must be lower case (top level table key)
---@type table<string, Job>
return {
    ['unemployed'] = {
        label = 'Civilian',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Freelancer', payment = 10 },
        },
    },

    ['police'] = {
        label = 'SDS PD',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Cadet',          payment = 400 },
            [1] = { name = 'Police Officer',  payment = 600 },
            [2] = { name = 'Senior Officer',   payment = 800 },
            [3] = { name = 'Corporal',       payment = 1000 },
            [4] = { name = 'Sergeant',        payment = 1200 },
            [5] = { name = 'Lieutenant',      payment = 1500 },
            [6] = { name = 'Captain',         payment = 2000 },
            [7] = { name = 'Commander',       payment = 2200 },
            [8] = { name = 'Deputy Chief',    payment = 2500 },
            [9] = { name = 'Assistant Chief', payment = 3000 },
            [10] = { name = 'Chief Of Police', payment = 3500 },
            [11] = { name = 'Commissioner',  isboss = true, bankAuth = false, payment = 4000 },
        },
    },

        ['travorcustoms'] = {
        label = 'Travor Customs',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Apprentice',      payment = 75 },
            [1] = { name = 'Mechanic',        payment = 125 },
            [2] = { name = 'Tuner Specialist',payment = 175 },
            [3] = { name = 'Shop Manager',    payment = 225 },
            [4] = { name = 'Owner', isboss = true, bankAuth = true, payment = 300 },
        },
    },
       ['ghostcustoms'] = {
        label = 'Ghost customs',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Apprentice',      payment = 75 },
            [1] = { name = 'Mechanic',        payment = 125 },
            [2] = { name = 'Tuner Specialist',payment = 175 },
            [3] = { name = 'Shop Manager',    payment = 225 },
            [4] = { name = 'Owner', isboss = true, bankAuth = true, payment = 300 },
        },
    },
    ['ghostauto'] = {
        label = 'Ghost Auto',
        type = 'Dealership',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Apprentice',      payment = 75 },
            [1] = { name = 'Shop Manager',    payment = 225 },
            [2] = { name = 'Owner', isboss = true, bankAuth = true, payment = 300 },
        },
    },
           ['lucks'] = {
        label = 'Lucks bar and lounge',
        type = 'food',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'employee',      payment = 75 },
            [1] = { name = 'bar back',        payment = 125 },
            [2] = { name = 'bartender',payment = 175 },
            [3] = { name = 'cook',    payment = 225 },
            [4] = { name = 'Owner', isboss = true, bankAuth = true, payment = 300 },
        },
    },
  
      ['chicagotint'] = {
        label = 'Chiacgo Paint N Tint',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Apprentice',      payment = 75 },
            [1] = { name = 'Mechanic',        payment = 125 },
            [2] = { name = 'Tuner Specialist',payment = 175 },
            [3] = { name = 'Shop Manager',    payment = 225 },
            [4] = { name = 'Owner', isboss = true, bankAuth = true, payment = 300 },
        },
    },
    ['scammer'] = {
        label = 'Scammer',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Scammer', payment = 0 },
        },
    },

     ['gunplug'] = {
        label = 'Gun Plug',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Gunplug', payment = 0 },
        },
    },

    

     ['attachmentpulg'] = {
        label = 'Attachment Plug',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Attachmentplug', payment = 0 },
        },
    },

    ['moneywash'] = {
        label = 'Money Wash',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Money Washer', payment = 0 },
        },
    },

    ['drugplug'] = {
        label = 'Drug Plug',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Plug', payment = 0 },
        },
    },

    ['ammoplug'] = {
        label = 'Ammo Plug',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Ammo Supplier', payment = 0 },
        },
    },
    
        ['hitplace'] = {
        label = 'Hit Place',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',  payment = 50 },
            [1] = { name = 'Employee', payment = 100 },
            [2] = { name = 'Manager',  payment = 150 },
            [3] = { name = 'Boss',     isboss = true, bankAuth = true, payment = 200 },
        },
    },

     ['tropicalheights'] = {
        label = 'Tropical Heights',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',  payment = 350 },
            [1] = { name = 'Employee', payment = 550 },
            [2] = { name = 'Manager',  payment = 750 },
            [3] = { name = 'Boss',     isboss = true, bankAuth = true, payment = 950 },
             [4] = { name = 'Owner',     isboss = true, bankAuth = true, payment = 1200 },
        },
    },
    
    ['ttmcustoms'] = {
        label = 'TTM Customs',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Trainee',        payment = 75 },
            [1] = { name = 'Street Mechanic',payment = 125 },
            [2] = { name = 'Performance Tech', payment = 175 },
            [3] = { name = 'Shop Supervisor', payment = 225 },
            [4] = { name = 'Owner', isboss = true, bankAuth = true, payment = 300 },
        },
    },

    ['chicago'] = {
        label = 'Chicago Rim Shop',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Trainee',        payment = 75 },
            [1] = { name = 'Street Mechanic',payment = 125 },
            [2] = { name = 'Performance Tech', payment = 175 },
            [3] = { name = 'Shop Supervisor', payment = 225 },
            [4] = { name = 'Owner', isboss = true, bankAuth = true, payment = 300 },
        },
    },

    ['bcso'] = {
        label = 'BCSO',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',    payment = 50 },
            [1] = { name = 'Officer',    payment = 75 },
            [2] = { name = 'Sergeant',   payment = 100 },
            [3] = { name = 'Lieutenant', payment = 125 },
            [4] = { name = 'Chief',      isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['sasp'] = {
        label = 'SASP',
        type = 'leo',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',    payment = 50 },
            [1] = { name = 'Officer',    payment = 75 },
            [2] = { name = 'Sergeant',   payment = 100 },
            [3] = { name = 'Lieutenant', payment = 125 },
            [4] = { name = 'Chief',      isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['ambulance'] = {
        label = 'EMS',
        type = 'ems',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Trainee',       payment = 150 },
            [1] = { name = 'EMT',           payment = 200 },
            [2] = { name = 'Paramedic',     payment = 300 },
            [3] = { name = 'Senior Medic',  payment = 400 },
            [4] = { name = 'Nurse',         payment = 500 },
            [5] = { name = 'Doctor',        payment = 750 },
            [6] = { name = 'Surgeon',       payment = 1000 },
            [7] = { name = 'Head Doctor',   payment = 1500 },
            [8] = { name = 'Deputy Director', payment = 2000 },
            [9] = { name = 'Director',      payment = 2500 },
        },
    },

['realestate'] = {
    label = 'Real Estate',
    type = 'realestate',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        [0] = { name = 'Receptionist',        payment = 300 },
        [1] = { name = 'Examiner',            payment = 500 },
        [2] = { name = 'Real Estate Agent',   payment = 800 },
        [3] = { name = 'Manager',             payment = 1200 },
        [4] = { name = 'Interior Designer',   payment = 1500 },
        [5] = { name = 'Boss', isboss = true, bankAuth = false, payment = 2000 },
    },
},

    ['taxi'] = {
        label = 'Taxi',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',      payment = 50 },
            [1] = { name = 'Driver',       payment = 75 },
            [2] = { name = 'Event Driver', payment = 100 },
            [3] = { name = 'Sales',        payment = 125 },
            [4] = { name = 'Manager',      isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['insurance'] = {
        label = 'Trusted Insurance',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Sales Rep',        payment = 50 },
            [1] = { name = 'Assistant Manager',payment = 75 },
            [2] = { name = 'Manager',          payment = 125 },
            [3] = { name = 'Owner',            isboss = true, bankAuth = true, payment = 150 },
        },
    },
['doj'] = {
    label = 'Department of Justice',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        [0] = { name = 'Probation & Parole', payment = 700 },
        [1] = { name = 'Bailiff',            payment = 750 },
        [2] = { name = 'Clerk of Court',     payment = 850 },
        [3] = { name = 'Madam Clerk',        payment = 1000 },
        [4] = { name = 'Defense Atty',       payment = 1150 },
        [5] = { name = 'ADA',                payment = 1250 },
        [6] = { name = 'DA',                 payment = 1500 },
        [7] = { name = 'Judge',              payment = 2000 },
        [8] = { name = 'Chief Justice',      isboss = true, bankAuth = true, payment = 3000 },
    },
},

    ['billionairecustoms'] = {
        label = 'Billionaire Customs',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Sales Rep', payment = 50 },
            [1] = { name = 'Jeweler',   payment = 75 },
            [2] = { name = 'Manager',   payment = 125 },
            [3] = { name = 'Owner',     isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['bus'] = {
        label = 'Bus',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Driver', payment = 50 },
        },
    },

    ['cardealer'] = {
        label = 'Vehicle Dealer',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',        payment = 50 },
            [1] = { name = 'Showroom Sales', payment = 75 },
            [2] = { name = 'Business Sales', payment = 100 },
            [3] = { name = 'Finance',        payment = 125 },
            [4] = { name = 'Manager',        isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['mechanic'] = {
        label = 'Mechanic',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',     payment = 50 },
            [1] = { name = 'Novice',      payment = 75 },
            [2] = { name = 'Experienced', payment = 100 },
            [3] = { name = 'Advanced',    payment = 125 },
            [4] = { name = 'Manager',     isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['bennysdocks'] = {
        label = 'Bennys Docks',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',     payment = 50 },
            [1] = { name = 'Novice',      payment = 75 },
            [2] = { name = 'Experienced', payment = 100 },
            [3] = { name = 'Manager',     payment = 125 },
            [4] = { name = 'Owner',       isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['bennys'] = {
        label = 'Bennys',
        type = 'mechanic',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',     payment = 50 },
            [1] = { name = 'Novice',      payment = 75 },
            [2] = { name = 'Experienced', payment = 100 },
            [3] = { name = 'Manager',     payment = 125 },
            [4] = { name = 'Owner',       isboss = true, bankAuth = true, payment = 150 },
        },
    },

    ['judge'] = {
        label = 'Honorary',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Judge', payment = 100 },
        },
    },

    ['lawyer'] = {
        label = 'Law Firm',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Associate', payment = 50 },
        },
    },

    ['reporter'] = {
        label = 'Reporter',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Journalist', payment = 50 },
        },
    },

    ['tow'] = {
        label = 'Ghost Towing',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Driver', payment = 500 },
             [1] = { name = 'Owner',       isboss = true, bankAuth = true, payment = 1500 },
        },
    },

    ['garbage'] = {
        label = 'Garbage',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Collector', payment = 50 },
        },
    },

    ['vineyard'] = {
        label = 'Vineyard',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Picker', payment = 50 },
        },
    },

    ['hotdog'] = {
        label = 'Hotdog',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Sales', payment = 50 },
        },
    },

    ['barber'] = {
        label = 'Fade Trap',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Starter Barber',    payment = 50 },
            [1] = { name = 'Experienced Barber',payment = 75 },
            [2] = { name = 'Advanced Barber',   payment = 100 },
            [3] = { name = 'Manager',           payment = 125 },
            [4] = { name = 'Boss',              isboss = true, bankAuth = true, payment = 150 },
        },
    },

     ['gun_smith'] = {
        label = 'Ghost Guns',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Trainee',    payment = 250 },
            [1] = { name = 'Gun smith',payment = 500 },
            [2] = { name = 'Manager', payment = 1500 },
            [3] = { name = 'Owner',   isboss = true, bankAuth = true, payment = 2500 },
        },
    },

    ['beauty'] = {
        label = 'Beauty Trap',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Recruit',     payment = 50 },
        },
    },
    ['fraudster'] = {
        label = 'Scammer',
        defaultDuty = false,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Scammer',     payment = 0 },
        },
    },

    ['powerwashing'] = {
    label = 'Dirty Hose',
    defaultDuty = true,
    offDutyPay = false,
    grades = {
        ['0'] = {
            name = 'Powerwasher',
            payment = 3000,
        },
    },
},

    ['pizza_delivery'] = {
        label = 'Pizza Delivery',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Delivery Driver', payment = 0 },
        },
    },

    ['news_delivery'] = {
        label = 'News Delivery',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'News Carrier', payment = 0 },
        },
    },

    ['mobile_hotdog'] = {
        label = 'Mobile Hotdog',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Vendor', payment = 0 },
        },
    },

    ['forklifter'] = {
        label = 'Forklifter',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Forklift Operator', payment = 0 },
        },
    },

    ['gardener'] = {
        label = 'Gardener',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Gardener', payment = 0 },
        },
    },

    ['trucker'] = {
        label = 'Trucker',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Truck Driver', payment = 0 },
        },
    },

    ['roadhelper'] = {
        label = 'Road Helper',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Road Worker', payment = 0 },
        },
    },

    ['bus_driver'] = {
        label = 'Bus Driver',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Bus Driver', payment = 0 },
        },
    },

    ['fire_department'] = {
        label = 'Fire Department',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Firefighter', payment = 0 },
        },
    },

    ['hunter'] = {
        label = 'Hunter',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Hunter', payment = 0 },
        },
    },

    ['detectorist'] = {
        label = 'Detectorist',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Detectorist', payment = 0 },
        },
    },

    ['project_car'] = {
        label = 'Project Car',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Mechanic', payment = 0 },
        },
    },

    ['diver'] = {
        label = 'Diver',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Diver', payment = 0 },
        },
    },

    ['farmer'] = {
        label = 'Farmer',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Farmer', payment = 0 },
        },
    },

    ['electrician'] = {
        label = 'Electrician',
        defaultDuty = true,
        offDutyPay = false,
        grades = {
            [0] = { name = 'Electrician', payment = 0 },
        },
    },

}