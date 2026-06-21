KubiMedicalCustom = KubiMedicalCustom or {}
KubiMedicalCustom.Server = KubiMedicalCustom.Server or {}
KubiMedicalCustom.Client = KubiMedicalCustom.Client or {}

local function safeCall(handler, ...)
    if type(handler) ~= 'function' then
        return nil
    end

    local ok, result = pcall(handler, ...)
    if not ok then
        if Config and Config.Debug then
            print('^1[Kubi Medical]^7 Custom hook error: ' .. tostring(result))
        end
        return nil
    end

    return result
end

function KubiMedicalCustom.CallServerHook(name, ...)
    return safeCall(KubiMedicalCustom.Server and KubiMedicalCustom.Server[name], ...)
end

function KubiMedicalCustom.CallClientHook(name, ...)
    return safeCall(KubiMedicalCustom.Client and KubiMedicalCustom.Client[name], ...)
end

-- ==================================================
-- Custom extension template
-- ==================================================
--
-- Keep all job and vehicle configuration in `config.lua`.
-- Use this file only for optional hooks and third-party integrations.
--
-- Available server hooks:
--   KubiMedicalCustom.Server.IsPlayerDead = function(source)
--       return nil
--   end
--
--   KubiMedicalCustom.Server.RevivePlayer = function(source, requestId)
--       return nil
--   end
--
--   KubiMedicalCustom.Server.CountEMSOnline = function()
--       return nil
--   end
--
--   KubiMedicalCustom.Server.IsEMSJob = function(jobData, source, framework)
--       return nil
--   end
--
-- Available client hooks:
--   KubiMedicalCustom.Client.IsPlayerDead = function()
--       return nil
--   end
--
--   KubiMedicalCustom.Client.ApplyRevive = function(requestId, applyMode, coords)
--       return nil
--   end
--
--   KubiMedicalCustom.Client.OnDeath = function(coords)
--   end
--
--   KubiMedicalCustom.Client.OnRevive = function(coords)
--   end
--
-- Leave every hook as `nil` if you want the core behavior.

