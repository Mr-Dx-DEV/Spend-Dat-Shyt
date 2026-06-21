endaSettingsSynced = false
endaDlcQueuedOnStart = false

function ApplyENDA01DeltaDLC()
  if GetResourceState("ENDA") ~= "started" then
    endaSettingsSynced = false
    endaDlcQueuedOnStart = false
    return
  end

  local endaExport = exports.ENDA
  local packHash = 436780603
  local clipOptions = { label = "EXT_FGUN", clip = "p2x" }

  endaExport:UpdateDeltaDLC(packHash, "UNARMED_00", 1, clipOptions)

  clipOptions = { label = "EXT_1H", clip = "p2x" }
  for handgunSlot = 2, 4 do
    endaExport:UpdateDeltaDLC(packHash, "HANDGUN_00", handgunSlot, clipOptions)
  end
end

Citizen.CreateThread(function()
  Citizen.Wait(2500)

  if not endaSettingsSynced then
    endaDlcQueuedOnStart = true
    ApplyENDA01DeltaDLC()
  end

  TriggerEvent("DEA:DLC", 2)
end)

AddEventHandler("ENDA_UPDATE_SETTINGS", function()
  if not endaDlcQueuedOnStart then
    endaSettingsSynced = true
    ApplyENDA01DeltaDLC()
  else
    endaDlcQueuedOnStart = false
  end

  TriggerEvent("DEA:DLC", 2)
end)
