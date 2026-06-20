--[[

Use this file to create custom callbacks for the client defined logic in the custom_functions/client.lua file.

---@param source number
---@vararg any
RegisterAddonCallback("name",function(source, ...)
    -- Your code here
end)


]]



RegisterAddonCallback("custom_button_1", function(source, target, argument1)
    print("custom_button_1: source:", source)
    print("custom_button_1: target:", target)
    print("custom_button_1: argument1:", argument1)

    return true
end)

--- Offline Addon Callback: paired with a `type = "offline_button"` addon in client.lua
--- target is { charId, uniqueId, name, identifiers } - the player is NOT in the server.
--- Always validate inputs and enforce permissions/duty before mutating data.
RegisterOfflineAddonCallback("example_offline_button", function(source, target)
    print("example_offline_button: staff source:", source)
    print("example_offline_button: target charId:", target.charId, "uniqueId:", target.uniqueId)
    -- e.g. MySQL.update.await('DELETE FROM inventory WHERE charId = ?', { target.charId })
    return true
end)

--- Custom Statistic Blocks

RegisterAddonStatisticBlocksCallback("test_block_1", function(source)
    return {
        title = "Test Title",
        value = 100,
        description = "Test Description",
        formatToCash = true -- if you want the value to be formatted to cash, set this to true, make the value a number
    }
end)
