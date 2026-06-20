-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'cn' then return end

Strings = {

    no_wsb = '^0[^3警告^0] wasabi_bridge 未在框架启动后和资源之前启动: %s',
    warning_disabling_metadata = '[^3警告^0] 未找到库存系统，禁用元数据键。',

    manage_keys = '管理钥匙',
    manage_key = '管理钥匙 - %s',
    give_key = '给钥匙',
    remove_key = '移除钥匙',
    are_you_sure = '你确定吗？',
    are_you_sure_desc = '你确定要移除车牌 %s 的钥匙吗？',

    -- Menu
    player_id = '玩家 ID: ',

    -- Notification
    too_far = '太远了',
    too_far_desc = '你离得太远，无法执行此操作！',

    no_vehicle_found = '未找到车辆',
    no_vehicle_found_desc = '周围没有你有钥匙的车辆！',
    no_vehicle_found_keys_desc = '没有附近的车辆你有钥匙！',
    no_vehicle_found_lockpick_desc = '没有车辆可以开锁！',

    no_keys_found = '未找到钥匙',
    no_keys_found_desc = '你没有任何车辆的钥匙！',

    vehicle_not_locked = '车辆解锁',
    vehicle_not_locked_desc = '此车辆似乎没有锁定',

    vehicle_cant_lockpick = '无法开锁',
    vehicle_cant_lockpick_desc = '你不能开锁这个车辆！',

    success = '成功',
    failed = '失败',
    success_lockpick_desc = '你成功地开锁了车辆',
    fail_lockpick_desc = '你未能开锁车辆',
    lockpick_broke = '开锁工具弯曲',
    lockpick_broke_desc = '你把开锁工具弄弯了',

    cancelled_action = '操作已取消',
    cancelled_action_desc = '你的操作已被取消！',

    search_nothing_found = '什么也没找到',
    search_nothing_found_desc = '你没找到有用的东西',
    search_keys_found = '找到钥匙',
    search_keys_found_desc = '你找到了车辆的钥匙',
    search_item_found = '找到物品',
    search_item_found_desc = '你找到了 %sx %s！',
    search_money_found = '找到了钱',
    search_money_found_desc = '你找到了 $%s',

    handed_keys = '已交钥匙',
    handed_keys_desc = '你已获得车辆钥匙！',
    keys_received = '已接收钥匙',
    keys_received_desc = '你收到了车牌: %s 的钥匙',
    keys_removed = '钥匙已移除',
    keys_removed_desc = '车牌 %s 的钥匙已被移除',

    vehicle_unlocked = '已解锁',
    vehicle_unlocked_desc = '你已解锁你的车辆',

    vehicle_locked = '已锁定',
    vehicle_locked_desc = '你已锁定你的车辆',

    already_in_vehicle = '已经在车内',
    already_in_vehicle_desc = '你已经在一辆车里',

    no_one_nearby = '没有人附近',
    no_one_nearby_desc = '周围没有人可以给钥匙',

    notify_police_notified = '已通知警方',
    notify_police_notified_desc = '警方已被通知你的行动。',

    notify_police_notification = '调度',
    notify_police_notification_desc = '市民报告了 %s 在该地区，请检查地图。',

    vehicle_stopped = '引擎已停止',
    vehicle_stopped_desc = '你已关闭引擎。',

    vehicle_started = '引擎已启动',
    vehicle_started_desc = '你已启动引擎。',

    -- Keymapping
    toggle_keymap_desc = '切换车锁',

    -- Blip strings
    blip_hotwire = '被盗车辆',
    blip_lockpick = '开锁车辆',
    blip_robPed = '武装抢劫',

    -- Crimes
    crime_hotwire = '车辆盗窃',
    crime_lockpick = '撬车',
    crime_robPed = '武装抢劫',

    -- Metadata
    vehicle_plate = '车辆牌照',
}
