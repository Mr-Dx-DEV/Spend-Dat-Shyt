local PlateLetters = Config.PlateLetters
local PlateNumbers = Config.PlateNumbers
local PlateUseSpace = Config.PlateUseSpace

local NumberCharset = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }
local LetterCharset = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }

local function GetRandomString(charset, length)
    local str = ''
    if length > 0 then
        for i = 1, length do
            str = str .. charset[math.random(1, #charset)]
        end
    end
    return str
end

local function GetPlateList()
    local plates = {}
    local sql

    if Config.MongoDB then
        local rows = MongoDB:Select("player_vehicles", {})
        for k, v in pairs(rows) do
            plates[v.plate] = true
        end
    else
        if Framework.Active == 2 then
            sql = "SELECT plate FROM player_vehicles"
        else
            sql = "SELECT plate FROM owned_vehicles"
        end
        local data = MySQL.Sync.fetchAll(sql, {})
        for k, v in pairs(data) do
            plates[v.plate] = true
        end
    end
    return plates
end

function VehiclePlate()
    local self = {}
    self.ClaimedPlates = {}
    local existingPlates = nil

    self.GeneratePlate = function()
        if not existingPlates then
            existingPlates = GetPlateList()
        end

        local generatedPlate
        while true do
            Wait(0)
            local letters = GetRandomString(LetterCharset, PlateLetters)
            local numbers = GetRandomString(NumberCharset, PlateNumbers)

            if PlateUseSpace then
                generatedPlate = string.upper(letters .. ' ' .. numbers)
            else
                generatedPlate = string.upper(letters .. numbers)
            end

            if not existingPlates[generatedPlate] and not self.ClaimedPlates[generatedPlate] then
                self.ClaimedPlates[generatedPlate] = true
                break
            end
        end
        return generatedPlate
    end

    self.ResetPlateList = function()
        self.ClaimedPlates = {}
    end

    return self
end