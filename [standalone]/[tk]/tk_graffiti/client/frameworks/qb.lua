if Config.Framework ~= 'qb' then return end

QBCore = exports['qb-core']:GetCoreObject()

TriggerCallback = QBCore.Functions.TriggerCallback

function ShowNotification(text, notifyType)
    if notifyType == 'inform' then notifyType = 'primary' end
    QBCore.Functions.Notify(text, notifyType)
end

function GetIdentifier()
    return QBCore.PlayerData.citizenid
end

function GetCharName()
    return ('%s %s'):format(QBCore?.PlayerData?.charinfo?.firstname , QBCore?.PlayerData?.charinfo?.lastname)
end

function GetDateOfBirth()
    return QBCore?.PlayerData?.charinfo?.birthdate
end

function GetJobName()
    return QBCore.PlayerData.job.name
end

function GetGrade()
    return QBCore.PlayerData.job.grade.level
end

function GetGradeLabel()
    return QBCore.PlayerData.grade.name
end

function GetItemLabel(item)
    return QBCore.Shared.Items?[string.lower(item)]?.label or item
end

function GetItemAmount(item)
    for _,v in pairs(QBCore.Functions.GetPlayerData().items) do
        if v.name == item then
            return v.count or v.amount
        end
    end

    return 0
end

function GetClosestPlayer()
    return QBCore.Functions.GetClosestPlayer()
end

function OpenDialog(label, inputType)
    local input = exports['qb-input']:ShowInput({
        header = label,
        inputs = {
            {
                text = label,
                name = 'value',
                type = inputType,
                isRequired = true,
            },
        }
    })

    return input?.value
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        QBCore.PlayerData = PlayerData
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(Job)
    QBCore.PlayerData.job = Job
end)

CreateThread(function()
    repeat Wait(2000) until QBCore and QBCore.PlayerData and QBCore.PlayerData.job

    frameworkLoaded = true
end)