---@param src number Player source
---@param jobName string Job name
---@param grade number Job grade
---@return boolean Success status
function SetPlayerJob(src, jobName, grade)
    if not src or not jobName then
        return false
    end
    return G.Server.SetPlayerJob(src, jobName, grade)
end
