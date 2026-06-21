-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'tw' then return end

Strings = {

    no_wsb = '^0[^3警告^0] wasabi_bridge 未在框架之後或資源之前啟動: %s',
    warning_disabling_metadata = '[^3警告^0] 找不到庫存系統，禁用元數據鍵。',

    manage_keys = '管理鑰匙',
    manage_key = '管理鑰匙 - %s',
    give_key = '給予鑰匙',
    remove_key = '移除鑰匙',
    are_you_sure = '你確定嗎？',
    are_you_sure_desc = '你確定要移除車牌 %s 的鑰匙嗎？',

    -- Menu
    player_id = '玩家 ID: ',

    -- Notification
    too_far = '太遠了',
    too_far_desc = '你離得太遠，無法進行此操作！',

    no_vehicle_found = '找不到車輛',
    no_vehicle_found_desc = '周圍沒有你擁有鑰匙的車輛！',
    no_vehicle_found_keys_desc = '周圍沒有你擁有鑰匙的車輛！',
    no_vehicle_found_lockpick_desc = '周圍沒有車輛可以鎖開！',

    no_keys_found = '找不到鑰匙',
    no_keys_found_desc = '你沒有任何車輛的鑰匙！',

    vehicle_not_locked = '車輛解鎖',
    vehicle_not_locked_desc = '這輛車似乎沒有被鎖住',

    vehicle_cant_lockpick = '無法鎖開',
    vehicle_cant_lockpick_desc = '你無法鎖開這輛車！',

    success = '成功',
    failed = '失敗',
    success_lockpick_desc = '你成功鎖開了車輛',
    fail_lockpick_desc = '你未能鎖開車輛',
    lockpick_broke = '鎖開工具損壞',
    lockpick_broke_desc = '你弄壞了鎖開工具',

    cancelled_action = '操作已取消',
    cancelled_action_desc = '你的操作已被取消！',

    search_nothing_found = '未找到任何東西',
    search_nothing_found_desc = '你什麼有用的東西也沒找到',
    search_keys_found = '找到鑰匙',
    search_keys_found_desc = '你找到車輛的鑰匙',
    search_item_found = '找到物品',
    search_item_found_desc = '你找到 %sx %s！',
    search_money_found = '找到錢',
    search_money_found_desc = '你找到 $%s',

    handed_keys = '鑰匙已交付',
    handed_keys_desc = '你已獲得車輛鑰匙！',
    keys_received = '鑰匙已接收',
    keys_received_desc = '你已收到車牌: %s 的鑰匙',
    keys_removed = '鑰匙已移除',
    keys_removed_desc = '車牌: %s 的鑰匙已被移除',

    vehicle_unlocked = '解鎖',
    vehicle_unlocked_desc = '你已經解鎖你的車輛',

    vehicle_locked = '鎖定',
    vehicle_locked_desc = '你已經鎖定你的車輛',

    already_in_vehicle = '已在車內',
    already_in_vehicle_desc = '你已經在一輛車內',

    no_one_nearby = '附近沒有人',
    no_one_nearby_desc = '周圍沒有人可以給鑰匙',

    notify_police_notified = '警方已通知',
    notify_police_notified_desc = '警方已被通知你的行為。',

    notify_police_notification = '調度',
    notify_police_notification_desc = '有市民報告了 %s，在該區域檢查地圖。',

    vehicle_stopped = '引擎停止',
    vehicle_stopped_desc = '你已關閉引擎。',

    vehicle_started = '引擎啟動',
    vehicle_started_desc = '你已啟動引擎。',

    -- Keymapping
    toggle_keymap_desc = '切換車輛鎖定',

    -- Blip strings
    blip_hotwire = '被盜車輛',
    blip_lockpick = '鎖開車輛',
    blip_robPed = '武裝搶劫',

    -- Crimes
    crime_hotwire = '車輛盜竊',
    crime_lockpick = '車輛入室盜竊',
    crime_robPed = '武裝搶劫',

    -- Metadata
    vehicle_plate = '車輛號牌',
}
