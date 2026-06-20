Config = {}

-- Framework Configuration
Config.Framework = {
    -- Choose framework: 'standalone', 'esx', 'qbcore', 'none'
    -- 'standalone' uses ox_lib if available
    -- 'esx' uses ESX notifications if available
    -- 'qbcore' uses QBCore notifications if available
    -- 'none' uses only native functions (no dependencies required)
    UseFramework = 'none',
    
    -- If UseFramework is 'standalone', set this to true if you have ox_lib installed
    UseOxLib = false
}

-- Passenger Mode Configuration
Config.PassengerMode = {
    -- Whether a notification should be shown when a passenger attempts to use a restricted control
    NotifyOnDenied = true,
    
    -- Control permissions for passengers
    Permissions = {
        -- Can passengers control doors?
        Doors = true,
        
        -- Can passengers control windows?
        Windows = true,
        
        -- Can passengers control interior lights?
        InteriorLights = true,
        
        -- Can passengers control the engine? (Usually should be false)
        Engine = false,
        
        -- Can passengers control vehicle indicators?
        Indicators = false,
        
        -- Can passengers control hazard lights?
        Hazards = true,
        
        -- Can passengers control parking lights?
        ParkingLights = false,
        
        -- Can passengers view and copy the license plate?
        LicensePlate = true,
        
        -- Can passengers switch seats?
        SeatSwitching = true,
        
        -- Can passengers control neon lights?
        Neon = false
    },
    
    -- Special vehicle types configuration
    SpecialVehicles = {
        -- Example: Police vehicles allow passengers to control more functions
        -- Key should be the vehicle model name
        police = {
            Engine = true,
            Indicators = true,
            ParkingLights = true,
            SeatSwitching = true
        },
        
        police2 = {
            Engine = true,
            Indicators = true,
            ParkingLights = true
        },
        
        police3 = {
            Engine = true,
            Indicators = true,
            ParkingLights = true
        }
        
        -- Add more special vehicles as needed
    }
} 
