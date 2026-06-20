aimstyleUiReady = false
isUIOpen = false
currentVehicle = nil
aimSettingsApplied = false

playerAimSettings = {
  locale = "en",
  allowDriver = true,
  allowBlindfire = true,
  allow1hLongGuns = true,
  allowVanillaAiming = true,
  blockVehClass = { 8, 13, 14, 15, 16 },
  blockForJobs = { "police" },
}

oxAimstyleMenuState = {
  unarmed = { CONFIG.uiText.unarmed[1] },
  handgun = { CONFIG.uiText.handgun[1] },
  rifle = { CONFIG.uiText.rifle[1] },
  selected = { 1, 1, 1, 1 },
  updated = { 0, 0, 0, 0 },
  aimCodes = {
    { "DEFAULT", "EXT_FGUN" },
    { "DEFAULT", "EXT_1H" },
    { "DEFAULT", "EXT_1H" },
  },
  dlc = {},
}

uiButtons = {
  main = {
    { text = CONFIG.uiText.category[1], img = "images/main_unarmed.jpg" },
    { text = CONFIG.uiText.category[2], img = "images/main_pistol.jpg" },
    { text = CONFIG.uiText.category[3], img = "images/test.jpg" },
    { text = CONFIG.uiText.category[4], img = "images/main_smg.jpg" },
  },
  submenu1 = {
    { id = "DEFAULT", text = CONFIG.uiText.unarmed[1], subtext = CONFIG.uiText.unarmedDesc[1], disabled = false, img = "images/main_unarmed.jpg" },
    { id = "EXT_FGUN", text = CONFIG.uiText.unarmed[2], subtext = CONFIG.uiText.unarmedDesc[2], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_BIRD", text = CONFIG.uiText.unarmed[3], subtext = CONFIG.uiText.unarmedDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_SLIDER", text = CONFIG.uiText.unarmed[4], subtext = CONFIG.uiText.unarmedDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_NOHANDS", text = CONFIG.uiText.unarmed[5], subtext = CONFIG.uiText.unarmedDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "INT_SURRENDER", text = CONFIG.uiText.unarmed[6], subtext = CONFIG.uiText.unarmedDesc[3], disabled = true, img = "images/logo_custom.jpg" },
  },
  submenu2 = {
    { id = "DEFAULT", text = CONFIG.uiText.handgun[1], subtext = CONFIG.uiText.handgunDesc[1], disabled = false, img = "images/logo_default.jpg" },
    { id = "EXT_1H", text = CONFIG.uiText.handgun[2], subtext = CONFIG.uiText.handgunDesc[2], disabled = true, img = "images/main_pistol.jpg" },
    { id = "EXT_2H_PISTOL", text = CONFIG.uiText.handgun[3], subtext = CONFIG.uiText.handgunDesc[3], disabled = true, img = "images/test.jpg" },
    { id = "EXT_1H_GANG", text = CONFIG.uiText.handgun[4], subtext = CONFIG.uiText.handgunDesc[3], disabled = true, img = "images/test2.jpg" },
    { id = "EXT_1H_RETRO", text = CONFIG.uiText.handgun[5], subtext = CONFIG.uiText.handgunDesc[3], disabled = true, img = "images/main_pistol.jpg" },
    { id = "EXT_AKIMBO", text = CONFIG.uiText.handgun[6], subtext = CONFIG.uiText.handgunDesc[3], disabled = true, img = "images/test2.jpg" },
    { id = "INT_1H_BLIND", text = CONFIG.uiText.handgun[7], subtext = CONFIG.uiText.handgunDesc[3], disabled = true, img = "images/test.jpg" },
  },
  submenu3 = {
    { id = "DEFAULT", text = CONFIG.uiText.rifle[1], subtext = CONFIG.uiText.rifleDesc[1], disabled = false, img = "images/logo_default.jpg" },
    { id = "EXT_1H", text = CONFIG.uiText.rifle[2], subtext = CONFIG.uiText.rifleDesc[2], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_HIGH", text = CONFIG.uiText.rifle[3], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_LOW", text = CONFIG.uiText.rifle[4], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_OVER", text = CONFIG.uiText.rifle[5], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_GANG", text = CONFIG.uiText.rifle[6], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "INT_2H_BLIND", text = CONFIG.uiText.rifle[7], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
  },
  submenu4 = {
    { id = "DEFAULT", text = CONFIG.uiText.rifle[1], subtext = CONFIG.uiText.rifleDesc[1], disabled = false, img = "images/logo_default.jpg" },
    { id = "EXT_1H", text = CONFIG.uiText.rifle[2], subtext = CONFIG.uiText.rifleDesc[2], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_HIGH", text = CONFIG.uiText.rifle[3], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_LOW", text = CONFIG.uiText.rifle[4], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_OVER", text = CONFIG.uiText.rifle[5], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "EXT_2H_GANG", text = CONFIG.uiText.rifle[6], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
    { id = "INT_2H_BLIND", text = CONFIG.uiText.rifle[7], subtext = CONFIG.uiText.rifleDesc[3], disabled = true, img = "images/logo_custom.jpg" },
  },
}

function ListContainsValue(valueList, targetValue)
  if valueList == nil or #valueList == 0 then
    return false
  end

  for listIndex = 1, #valueList do
    if valueList[listIndex] == targetValue then
      return true
    end
  end

  return false
end

function IsJobAllowedForUI()
  if myJob == nil or playerAimSettings.blockForJobs == nil or #playerAimSettings.blockForJobs == 0 then
    return true
  end

  return not ListContainsValue(playerAimSettings.blockForJobs, myJob)
end

function IsVehicleClassAllowedForUI()
  if currentVehicle == nil or currentVehicle.class == nil then
    return true
  end

  if playerAimSettings.blockVehClass == nil or #playerAimSettings.blockVehClass == 0 then
    return true
  end

  return not ListContainsValue(playerAimSettings.blockVehClass, currentVehicle.class)
end

function IsDriverSeatAllowedForUI()
  if playerAimSettings.allowDriver == false and currentVehicle ~= nil and currentVehicle.seat == -1 then
    return false
  end

  return true
end

function BuildDrivebyCategorySuffix()
  return " (" .. CONFIG.uiText.category[5] .. ")"
end

function PushOxDrivebyStyle(categoryIndex, selectedIndex)
  local aimCodeList = oxAimstyleMenuState.aimCodes[categoryIndex]
  if aimCodeList == nil then
    return
  end

  local aimCode = aimCodeList[selectedIndex]
  if aimCode == nil then
    return
  end

  exports.ENDA:UpdateDrivebyAimingStyle(categoryIndex, aimCode)
end

function ApplyOxAimstyleUpdates()
  if GetResourceState("ENDA") ~= "started" then
    return
  end

  for categoryIndex = 1, 4 do
    if oxAimstyleMenuState.updated[categoryIndex] == 1 then
      if categoryIndex == 4 then
        PushOxDrivebyStyle(3, oxAimstyleMenuState.selected[3])
      else
        PushOxDrivebyStyle(categoryIndex, oxAimstyleMenuState.selected[categoryIndex])
      end

      aimstyleUiReady = false
    end

    oxAimstyleMenuState.updated[categoryIndex] = 0
  end
end

function RegisterOxAimstyleMenu()
  local drivebySuffix = BuildDrivebyCategorySuffix()

  lib.registerMenu({
    id = "aimstyle_menu",
    title = CONFIG.oxMenuTitle,
    position = CONFIG.oxMenuPos,
    onSideScroll = function(categoryIndex, scrollIndex)
      oxAimstyleMenuState.selected[categoryIndex] = scrollIndex
      oxAimstyleMenuState.updated[categoryIndex] = 1
    end,
    onClose = function() end,
    options = {
      {
        label = CONFIG.uiText.category[1] .. drivebySuffix,
        icon = "hand",
        values = oxAimstyleMenuState.unarmed,
        close = false,
        defaultIndex = oxAimstyleMenuState.selected[1],
      },
      {
        label = CONFIG.uiText.category[2] .. drivebySuffix,
        icon = "gun",
        values = oxAimstyleMenuState.handgun,
        close = false,
        defaultIndex = oxAimstyleMenuState.selected[2],
      },
      {
        label = CONFIG.uiText.category[3] .. drivebySuffix,
        icon = "person-rifle",
        values = oxAimstyleMenuState.rifle,
        close = false,
        defaultIndex = oxAimstyleMenuState.selected[3],
      },
      {
        label = CONFIG.uiText.category[4] .. drivebySuffix,
        icon = "person-rifle",
        values = oxAimstyleMenuState.rifle,
        close = false,
        defaultIndex = oxAimstyleMenuState.selected[4],
      },
      {
        label = "UPDATE",
        icon = "rotate",
        description = "Update selected aimstyles",
      },
    },
  }, function(selectedOption)
    if tonumber(selectedOption) == 5 then
      ApplyOxAimstyleUpdates()
    end
  end)

  aimstyleUiReady = true
end

function RegisterOxRadialAimstyles()
  exports("aimstyleHandler", function(menuId, selectionIndex)
    if GetResourceState("ENDA") ~= "started" then
      return
    end

    if menuId == "driveby_unarmed_menu" then
      PushOxDrivebyStyle(1, selectionIndex)
    elseif menuId == "driveby_handgun_menu" then
      PushOxDrivebyStyle(2, selectionIndex)
    elseif menuId == "driveby_shotgun_menu" then
      PushOxDrivebyStyle(3, selectionIndex)
    elseif menuId == "driveby_rifle_menu" then
      PushOxDrivebyStyle(3, selectionIndex)
    end
  end)

  lib.registerRadial({
    id = "driveby_unarmed_menu",
    items = {
      { label = CONFIG.uiText.unarmed[1], icon = "hand-middle-finger", onSelect = "aimstyleHandler" },
      { label = CONFIG.uiText.unarmed[2], icon = "hand-point-right", onSelect = "aimstyleHandler" },
    },
  })

  lib.registerRadial({
    id = "driveby_handgun_menu",
    items = {
      { label = CONFIG.uiText.handgun[1], icon = "gun", onSelect = "aimstyleHandler" },
      { label = CONFIG.uiText.handgun[2], icon = "gun", onSelect = "aimstyleHandler" },
    },
  })

  lib.registerRadial({
    id = "driveby_shotgun_menu",
    items = {
      { label = CONFIG.uiText.rifle[1], icon = "person-rifle", onSelect = "aimstyleHandler" },
      { label = CONFIG.uiText.rifle[2], icon = "person-rifle", onSelect = "aimstyleHandler" },
    },
  })

  lib.registerRadial({
    id = "driveby_rifle_menu",
    items = {
      { label = CONFIG.uiText.rifle[1], icon = "person-rifle", onSelect = "aimstyleHandler" },
      { label = CONFIG.uiText.rifle[2], icon = "person-rifle", onSelect = "aimstyleHandler" },
    },
  })

  lib.registerRadial({
    id = "driveby_menu",
    items = {
      { label = CONFIG.uiText.category[1], icon = "hand", menu = "driveby_unarmed_menu" },
      { label = CONFIG.uiText.category[2], icon = "gun", menu = "driveby_handgun_menu" },
      { label = CONFIG.uiText.category[3], icon = "person-rifle", menu = "driveby_shotgun_menu" },
      { label = CONFIG.uiText.category[4], icon = "person-rifle", menu = "driveby_rifle_menu" },
    },
  })

  lib.addRadialItem({
    {
      id = "aimstyle",
      label = CONFIG.oxMenuTitle,
      icon = "gun",
      menu = "driveby_menu",
    },
  })

  aimstyleUiReady = true
end

function NormalizeNuiLayoutConfig()
  if CONFIG.uiStyle ~= "radial" and CONFIG.uiStyle ~= "grid" and CONFIG.uiStyle ~= "list" then
    CONFIG.uiStyle = "radial"
  end

  if CONFIG.uiPlacement ~= "right" and CONFIG.uiPlacement ~= "left" and CONFIG.uiPlacement ~= "middle" then
    CONFIG.uiPlacement = "right"
  end
end

function OpenAimstyleNui()
  SetNuiFocus(true, true)
  NormalizeNuiLayoutConfig()

  SendNUIMessage({
    action = "SetupOptions",
    config = {
      style = CONFIG.uiStyle,
      place = CONFIG.uiPlacement,
      aiming = playerAimSettings.allowVanillaAiming,
      color = CONFIG.uiColors,
      image = CONFIG.useButtonImages,
      keybind = CONFIG.openUiKeybind,
      selected = playerAimSettings.selected,
    },
    buttons = json.encode(uiButtons),
  })

  isUIOpen = true
  aimstyleUiReady = true
end

function OpenAimstyleUI()
  if (currentVehicle == nil or currentVehicle.id == nil) and not CONFIG.allowOnFoot then
    return
  end

  if not IsJobAllowedForUI() then
    return
  end

  if not IsDriverSeatAllowedForUI() then
    return
  end

  if not IsVehicleClassAllowedForUI() then
    return
  end

  if not CONFIG.useOxLib then
    if IsNuiFocused() then
      return
    end

    if not aimstyleUiReady then
      OpenAimstyleNui()
    else
      SetNuiFocus(true, true)
      isUIOpen = true
      SendNUIMessage({ action = "OpenUI" })
    end
    return
  end

  if not CONFIG.useOxRadial then
    if not aimstyleUiReady then
      RegisterOxAimstyleMenu()
    end

    lib.showMenu("aimstyle_menu")
  end
end

exports("openUI", OpenAimstyleUI)

function CloseAimstyleUI()
  if not CONFIG.useOxLib then
    SetNuiFocus(false, false)
    isUIOpen = false
    SendNUIMessage({ action = "CloseUI" })
  else
    lib.hideMenu("aimstyle_menu")
  end
end

function RegisterAimstyleOpenBindings()
  local keymapCommand = "aimstyle"

  if CONFIG.openUiCommand ~= "none" and CONFIG.openUiCommand ~= "NONE" then
    keymapCommand = CONFIG.openUiCommand
  end

  RegisterCommand(CONFIG.openUiCommand, function()
    if isUIOpen then
      CloseAimstyleUI()
    else
      OpenAimstyleUI()
    end
  end)

  if CONFIG.openUiKeybind ~= "none" and CONFIG.openUiKeybind ~= "NONE" then
    RegisterKeyMapping(keymapCommand, "Open Aimstyle UI", "keyboard", CONFIG.openUiKeybind)
  end

  if CONFIG.openUiCommand == "none" or CONFIG.openUiCommand == "NONE" then
    TriggerEvent("chat:removeSuggestion", "/" .. keymapCommand)
  end
end

RegisterAimstyleOpenBindings()

function FindSubmenuIndexByStyleId(submenuKey, styleId)
  local submenuEntries = uiButtons[submenuKey]

  for entryIndex = 1, #submenuEntries do
    if submenuEntries[entryIndex].id == styleId then
      return entryIndex
    end
  end
end

function ApplyDefaultSelectedIndices()
  if not playerAimSettings.defaultSelected then
    return
  end

  playerAimSettings.selected = {}

  local defaultStyleIds = playerAimSettings.defaultSelected
  local submenuKeys = { "submenu1", "submenu2", "submenu3", "submenu4" }

  for categoryIndex = 1, 4 do
    local selectedIndex = FindSubmenuIndexByStyleId(submenuKeys[categoryIndex], defaultStyleIds[categoryIndex])

    if selectedIndex ~= nil then
      playerAimSettings.selected[tostring(categoryIndex)] = selectedIndex
    end
  end
end

function SyncOxMenuSelectedIndices()
  for categoryIndex = 1, 4 do
    oxAimstyleMenuState.selected[categoryIndex] = tonumber(playerAimSettings.selected[categoryIndex])
  end
end

function DisableVanillaAimOptions()
  if playerAimSettings.selected == nil then
    return
  end

  for categoryIndex = 2, 4 do
    local categoryKey = tostring(categoryIndex)

    if playerAimSettings.selected[categoryKey] == 1 then
      playerAimSettings.selected[categoryKey] = 2
    end
  end

  uiButtons.submenu2[1].disabled = true
  uiButtons.submenu3[1].disabled = true
  uiButtons.submenu4[1].disabled = true

  if CONFIG.useOxLib then
    table.remove(oxAimstyleMenuState.handgun, 1)
    table.remove(oxAimstyleMenuState.rifle, 1)
  end
end

function ApplyPlayerAimSettings()
  if aimSettingsApplied then
    return
  end

  ApplyDefaultSelectedIndices()

  if CONFIG.useOxLib then
    SyncOxMenuSelectedIndices()
  end

  if not playerAimSettings.allowBlindfire then
    table.remove(uiButtons.submenu2, 7)
    table.remove(uiButtons.submenu3, 7)
    table.remove(uiButtons.submenu4, 7)
  end

  if not playerAimSettings.allow1hLongGuns then
    uiButtons.submenu3[2].disabled = true
    uiButtons.submenu4[2].disabled = true
    uiButtons.main[3].disabled = true
    uiButtons.main[4].disabled = true
  end

  if not playerAimSettings.allowVanillaAiming then
    DisableVanillaAimOptions()
  end

  aimSettingsApplied = true
end

AddEventHandler("ENDA_UPDATE_SETTINGS", function(newSettings)
  playerAimSettings = newSettings
  ApplyPlayerAimSettings()
  aimstyleUiReady = false
end)

AddEventHandler("DEA:DLC", function(dlcSlotIndex)
  if not CONFIG.useOxLib then
    uiButtons.submenu1[dlcSlotIndex].disabled = false
    uiButtons.submenu2[dlcSlotIndex].disabled = false
    uiButtons.submenu3[dlcSlotIndex].disabled = false
    uiButtons.submenu4[dlcSlotIndex].disabled = false
  else
    if oxAimstyleMenuState.dlc[dlcSlotIndex] == nil then
      table.insert(oxAimstyleMenuState.unarmed, CONFIG.uiText.unarmed[dlcSlotIndex])
      table.insert(oxAimstyleMenuState.handgun, CONFIG.uiText.handgun[dlcSlotIndex])

      if dlcSlotIndex == 2 and playerAimSettings.allow1hLongGuns then
        table.insert(oxAimstyleMenuState.rifle, CONFIG.uiText.rifle[dlcSlotIndex])
      end

      oxAimstyleMenuState.dlc[dlcSlotIndex] = true
    end

    if CONFIG.useOxRadial and not aimstyleUiReady then
      RegisterOxRadialAimstyles()
    end
  end

  aimstyleUiReady = false
end)

AddEventHandler("ENDA:UpdateJob", function(jobName)
  myJob = jobName

  if isUIOpen and not IsJobAllowedForUI() then
    CloseAimstyleUI()
  end
end)

AddEventHandler("ENDA:EnteredVehicle", function(vehicleId, vehicleClass, vehicleModel, seatIndex)
  currentVehicle = {
    id = vehicleId,
    class = vehicleClass,
    model = vehicleModel,
    seat = seatIndex,
  }

  if isUIOpen then
    if IsVehicleClassAllowedForUI() and IsDriverSeatAllowedForUI() then
      return
    end

    CloseAimstyleUI()
  end
end)

AddEventHandler("ENDA:ExitedVehicle", function()
  currentVehicle = nil

  if isUIOpen and not CONFIG.allowOnFoot then
    CloseAimstyleUI()
  end
end)

AddEventHandler("ENDA:UpdateVehicleSeat", function(seatIndex)
  if currentVehicle ~= nil then
    currentVehicle.seat = seatIndex
  end
end)

RegisterNUICallback("aimstyleSelected", function(selectionData, respond)
  if selectionData.veh == nil or selectionData.veh == true then
    if selectionData.menu ~= nil then
      selectionData.menu = string.sub(selectionData.menu, 8, 9)
      exports.ENDA:UpdateDrivebyAimingStyle(selectionData.menu, selectionData.style)
    end
  elseif selectionData.menu ~= nil then
    if selectionData.style ~= nil then
      exports.ENDA:UpdateAimingStyle(selectionData.style)
    end
  elseif selectionData.style ~= nil then
    exports.ENDA:UpdateWeaponCarryStyle(selectionData.style)
  end

  respond("ok")
end)

RegisterNUICallback("closeUI", function(_, respond)
  SetNuiFocus(false, false)
  isUIOpen = false
  respond("ok")
end)
