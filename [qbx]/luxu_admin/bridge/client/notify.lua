---@alias NotifyType 'info' | 'success' | 'warning'  | 'error'
---@alias NotifyData { title: string, description: string, duration?: number, type?: NotifyType }

local defaultType = "info"
local playSound = true
local defaultDuration = 3000

local notifies = {
      ["ox_lib"] = function(title, description, duration, notifyType)
            if notifyType == "info" then
                  ---@diagnostic disable-next-line: cast-local-type
                  notifyType = "inform"
            end
            exports.ox_lib:notify({
                  title = title,
                  description = description,
                  duration = duration,
                  type = notifyType
            })
      end,
      ["okokNotify"] = function(title, description, duration, notifyType)
            exports['okokNotify']:Alert(title, description, duration, notifyType, playSound)
      end,
      ["mythic_notify"] = function(title, description, duration, notifyType)
            if notifyType ~= "error" and notifyType ~= "success" then
                  ---@diagnostic disable-next-line: cast-local-type
                  notifyType = "inform"
            end
            exports['mythic_notify']:DoHudText(notifyType, title)
      end,
      ["is_ui"] = function(title, description, duration, notifyType)
            exports["is_ui"]:Notify(title, description, duration, notifyType)
      end
}


---@param title string
---@param description string
---@param duration? number
---@param notifyType? NotifyType
local function notify(title, description, duration, notifyType)
      duration = duration or defaultDuration
      notifyType = notifyType or defaultType

      local notifyScript = Config.notify and Config.notify.script or "ox_lib"

      if notifyScript == "auto" then
            for resource, notifyFunction in pairs(notifies) do
                  if GetResourceState(resource) == 'started' then
                        notifyFunction(title, description, duration, notifyType)
                        return
                  end
            end
            --Fallback to ox_lib
            notifies["ox_lib"](title, description, duration, notifyType)
      elseif notifies[notifyScript] and GetResourceState(notifyScript) == 'started' then
            notifies[notifyScript](title, description, duration, notifyType)
      else
            notifies["ox_lib"](title, description, duration, notifyType)
      end
end

return { notify = notify }
