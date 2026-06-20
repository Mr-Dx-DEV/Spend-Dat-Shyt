------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOM FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------
-- These functions are called at specific moments during accessory interactions
-- You can customize them to add your own logic (XP rewards, notifications, etc.)

---Called when a player drops an accessory (called once per accessory type)
---@param accessoryType string 'hat' or 'glasses'
---@param reason string 'melee', 'vehicle', 'bone_shot'
function OnDroppingAccessories(accessoryType, reason)
    -- Example: Send a notification
    -- TriggerEvent('chat:addMessage', { args = { 'You lost your ' .. accessoryType .. ' due to ' .. reason } })

    -- Example: Log to console
    -- print('Player dropped ' .. accessoryType .. ' - Reason: ' .. reason)
end

---Called when a player picks up and equips an accessory
---@param accessoryType string 'hat' or 'glasses'
---@param drawableId number The drawable/prop ID that was equipped
---@param textureId number The texture ID that was equipped
function OnEquippingAccessory(accessoryType, drawableId, textureId)
    -- Example: Send a notification
    -- TriggerEvent('chat:addMessage', { args = { 'You picked up ' .. accessoryType } })

    -- Example: Log to console
    -- print('Player picked up ' .. accessoryType .. ' - Drawable ID: ' .. drawableId .. ', Texture ID: ' .. textureId)
end
