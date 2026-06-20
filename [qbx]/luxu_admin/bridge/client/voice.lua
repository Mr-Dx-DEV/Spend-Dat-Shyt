---@class VoiceHandler
local voiceHandler = {}

local voiceScript = 'pma-voice'

---@param id number channel id
function voiceHandler.joinCall(id)
      if voiceScript == 'pma-voice' then
            exports['pma-voice']:setCallChannel(id)
      elseif voiceScript == 'mumble-voip' then
            exports['mumble-voip']:SetCallChannel(id)
      elseif voiceScript == 'saltychat' then
            TriggerServerEvent('luxu_admin:server:setCallChannel', id)
            --- Check bridge/server/voice.lua
      end
end

function voiceHandler.leaveCall()
      if voiceScript == 'pma-voice' then
            exports['pma-voice']:setCallChannel(0)
      elseif voiceScript == 'mumble-voip' then
            exports['mumble-voip']:SetCallChannel(0)
      elseif voiceScript == 'saltychat' then
            TriggerServerEvent('luxu_admin:server:leaveCall')
            --- Check bridge/server/voice.lua
      end
end

function voiceHandler.isPlayerTalking()
      return NetworkIsPlayerTalking(PlayerId())
end

--- Auto Checker

local voiceScripts = {
      'pma-voice',
      'mumble-voip',
      'saltychat',
}

AddEventHandler('onResourceStart', function(r)
      if r ~= GetCurrentResourceName() then return end

      for _, resourceName in pairs(voiceScripts) do
            if GetResourceState(resourceName) == 'started' then
                  voiceScript = resourceName
                  return
            end
      end

      local autoDetectorEvent

      autoDetectorEvent = AddEventHandler('onResourceStart', function(resource)
            for _, resourceName in pairs(voiceScripts) do
                  if resource == resourceName then
                        voiceScript = resourceName
                        RemoveEventHandler(autoDetectorEvent)
                        return
                  end
            end
      end)
end)

return voiceHandler
