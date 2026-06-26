function FearXCrafting.Functions.GetPlayerGang(source)
    local success, gangInfo = pcall(function()
        return exports['FearX-Turfs']:GetPlayerGang(source)
    end)
    if success and gangInfo and gangInfo.gang then
        local gangConfig = nil
        pcall(function()
            gangConfig = exports['FearX-Turfs']:GetGangConfig(gangInfo.gang)
        end)
        return {
            name = gangInfo.gang,
            label = gangConfig and gangConfig.label or gangInfo.gang,
            grade = gangInfo.grade or 0,
            gradeLabel = tostring(gangInfo.grade or 0)
        }
    end
    return {
        name = nil,
        label = nil,
        grade = 0,
        gradeLabel = "0"
    }
end
