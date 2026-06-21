-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end
----------------------------------------------------------------
-- Customize text ui, notifications, target and more with the --
-- "wasabi_bridge" dependency in the "customize" directory    --
-- "wasabi_bridge/customize/cl_customize.lua"                 --
----------------------------------------------------------------

-------------------------------------------------------------------------------------------------
-- Function for the blood type example in custom parameters for evidence (QBCore Only Example) --
-------------------------------------------------------------------------------------------------
local function GetBloodTypeFromCitizenId(citizenid)
    local bloodtype = lib.callback.await('wasabi_evidence:getBloodType', 100)
    if not bloodtype then return false else return bloodtype end
end

--------------------------------------------------------------------------------
-- Add additional parameters for more information provided in evidence report --
--------------------------------------------------------------------------------
function OpenEvidenceReport(data, openStorage, openHand, printScan) -- Add additional parameters in config to pull here:
    local date, time = lib.callback.await('wasabi_evidence:getDateAndTime', 100, data.time)
    local reportData = Config.EvidenceReportData
    local options, d = {}, nil
    if openStorage then
        options[#options + 1] = {
            title = Strings.go_back,
            event = 'wasabi_evidence:accessEvidenceStorage'
        }
    elseif printScan then
        options[#options + 1] = {
            title = Strings.go_back,
            event = 'wasabi_evidence:fingerprintNearbyPlayer',
            args = openHand
        }
    elseif openHand then
        options[#options + 1] = {
            title = Strings.go_back,
            event = 'wasabi_evidence:accessEvidenceHand',
            args = openHand
        }
    end
    if data.evidence == 'blood' then d = 'blood' elseif data.evidence == 'print' then d = 'print' else d = 'bullet' end
    for i=1, #reportData[d] do
        local e = reportData[d][i]
        if e.parameter == 'name' then
            if d ~= 'blood' then
                if data.prints then
                    options[#options + 1] = {
                        title = e.label,
                        description = data.owner,
                        event = ''
                    }
                else
                    options[#options + 1] = {
                        title = e.label,
                        description = Strings.not_in_system,
                        event = ''
                    }
                end
            else
                options[#options + 1] = {
                    title = e.label,
                    description = data.owner,
                    event = ''
                }
            end
        elseif e.parameter == 'location' then
            options[#options + 1] = {
                title = e.label,
                description = data.street,
                event = ''
            }
        elseif e.parameter == 'date' then
            options[#options + 1] = {
                title = e.label,
                description = date,
                event = ''
            }
        elseif e.parameter == 'time' then
            options[#options + 1] = {
                title = e.label,
                description = time,
                event = ''
            }
        elseif e.parameter == 'plate' then
            options[#options + 1] = {
                title = e.label,
                description = data.plate,
                event = ''
            }
        elseif e.parameter == 'guntype' then
            options[#options + 1] = {
                title = e.label,
                description = data.evidence,
                event = ''
            }
        elseif e.parameter == 'bloodtype' then -- Example of a custom parameter
            -- Example of a custom parameter (Works out of box for QBCore)
            local bloodType = GetBloodTypeFromCitizenId(data.identifier)
            if not bloodType then return end
            options[#options + 1] = { -- This will be the option field shown in context that will be created for parameter
                title = e.label, -- d.label = the label option you defined with your parameter
                description = bloodType,
                event = ''
            }
        elseif e.parameter == 'custom' then -- Example of a custom parameter
            -- Can add some logic here for obtaining information needed
            -- Information in data table:
            --      * 'identifier' (Citizen ID for QBCore / Identifier for ESX)
            --      * 'evidence' (Will return 'blood' for blood evidence or the weapon type of bullet from `configuration/strings.lua`)
            --      * 'coords' (Vector3 of coords where evidence was found)
            --      * 'interior' (Interior ID or 0/nil/false if outside)
            --      * 'time' (os time of server when evidence dropped)
            --      * 'owner' (Character first / last name of who dropped evidence)
            --      * 'street' (Location info of where evidence dropped, street names & area name / see Zones table in `configuration/config.lua`)
            options[#options + 1] = { -- This will be the option field shown in context that will be created for parameter
                title = e.label, -- d.label = the label option you defined with your parameter
                description = data.identifier, -- Example of utilizing the 'data' table
                event = ''
            }
        end
    end
    if Config.BossCanDeleteStorage then
        if wsb.isPlayerBoss() then
            options[#options + 1] = {
                title = Strings.delete_evidence,
                description = (Strings.delete_evidence_desc):format(data.id),
                event = 'wasabi_evidence:deleteEvidence',
                args = data.id
            }
        end
    end
    lib.registerContext({
        id = 'evidence_report',
        title = (Strings.evidence_report):format(data.id),
        options = options
    })
    lib.showContext('evidence_report')
end