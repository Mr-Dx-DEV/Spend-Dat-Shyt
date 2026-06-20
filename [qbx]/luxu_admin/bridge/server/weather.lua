local weather = {}
function weather.SetTime(hour, minute)
    if (GetResourceState("Renewed-Weathersync") == "started") then
        GlobalState.currentTime = {
            hour = hour,
            minute = minute,
        }
    elseif (GetResourceState("cd_easytime") == "started") then
        exports['cd_easytime']:forceUpdate({ hours = hour, minutes = minute })
    elseif (GetResourceState("qb-weathersync") == "started") then
        exports["qb-weathersync"]:setTime(hour, minute)
    elseif (GetResourceState("") == "started") then
        exports['av_weather']:updateTime(hour, minute, false, true)
    elseif GetResourceState("vSync") == "started" then
        ExecuteCommand(("time %d %d"):format(hour, minute))
    else
        --TODO: Implement internal system
    end
end

function weather.SetWeather(weather)
    if GetResourceState('Renewed-Weathersync') == "started" then
        exports["qb-weathersync"]:setWeather(weather)
    elseif GetResourceState('cd_easytime') == "started" then
        exports['cd_easytime']:forceUpdate({ weather = weather, instantweather = true })
    elseif GetResourceState('qb-weathersync') == "started" then
        exports["qb-weathersync"]:setWeather(weather)
    elseif GetResourceState("vSync") == "started" then
        ExecuteCommand(("weather %s"):format(weather))
    else
        --TODO: Implement internal system
    end
end

function weather.FreezeTime()
    if (GetResourceState("Renewed-Weathersync") == "started") then
        exports["qb-weathersync"]:setTimeFreeze();
    elseif (GetResourceState("cd_easytime") == "started") then
        local data = exports['cd_easytime']:GetWeather()
        local status = not data.freeze
        exports['cd_easytime']:forceUpdate({ freeze = status })
    elseif (GetResourceState("qb-weathersync") == "started") then
        exports["qb-weathersync"]:setTimeFreeze();
    elseif GetResourceState("vSync") == "started" then
        ExecuteCommand("freezetime")
    else
        --TODO: Implement internal system
    end
end

function weather.SetBlackout(state)
    if (GetResourceState("Renewed-Weathersync") == "started") then
        exports["qb-weathersync"]:setBlackout(state)
    elseif (GetResourceState("cd_easytime") == "started") then
        exports['cd_easytime']:forceUpdate({ blackout = state })
    elseif (GetResourceState("qb-weathersync") == "started") then
        exports["qb-weathersync"]:setBlackout(state)
    elseif (GetResourceState("av_weather") == "started") then
        exports['av_weather']:setBlackout(state)
    elseif GetResourceState("vSync") == "started" then
        ExecuteCommand("blackout")
    else
        --TODO: Implement internal system
    end
end

return weather
