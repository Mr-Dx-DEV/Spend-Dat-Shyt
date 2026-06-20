-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'jp' then return end

Strings = {

    no_wsb = '^0[^3警告^0] wasabi_bridge はフレームワークの後、またはリソースの前に開始されていません: %s',
    warning_disabling_metadata = '[^3警告^0] インベントリシステムが見つかりませんでした。メタデータキーを無効にします。',

    manage_keys = 'キーの管理',
    manage_key = 'キー管理 - %s',
    give_key = 'キーを渡す',
    remove_key = 'キーを削除',
    are_you_sure = '本当に削除してもよいですか？',
    are_you_sure_desc = 'ナンバープレート %s のキーを削除してもよいですか？',

    -- Menu
    player_id = 'プレイヤーID: ',

    -- Notification
    too_far = '遠すぎる',
    too_far_desc = 'これを実行するには遠すぎます！',

    no_vehicle_found = '車両が見つかりません',
    no_vehicle_found_desc = 'あなたが鍵を持っている車両は近くにありません！',
    no_vehicle_found_keys_desc = 'あなたが鍵を持っている車両は近くにありません！',
    no_vehicle_found_lockpick_desc = 'ロックピックする車両は近くにありません！',

    no_keys_found = '鍵が見つかりません',
    no_keys_found_desc = '車両の鍵を持っていません！',

    vehicle_not_locked = '車両が解除されました',
    vehicle_not_locked_desc = 'この車両はロックされていないようです',

    vehicle_cant_lockpick = 'ロックピックできません',
    vehicle_cant_lockpick_desc = 'この車両はロックピックできません！',

    success = '成功',
    failed = '失敗',
    success_lockpick_desc = '車両をロックピックしました',
    fail_lockpick_desc = '車両のロックピックに失敗しました',
    lockpick_broke = 'ロックピックが壊れました',
    lockpick_broke_desc = 'ロックピックが壊れました',

    cancelled_action = 'アクションがキャンセルされました',
    cancelled_action_desc = 'アクションがキャンセルされました！',

    search_nothing_found = '何も見つかりませんでした',
    search_nothing_found_desc = '有用なものは見つかりませんでした',
    search_keys_found = '鍵が見つかりました',
    search_keys_found_desc = '車両の鍵が見つかりました',
    search_item_found = 'アイテムが見つかりました',
    search_item_found_desc = '%sx %s を見つけました！',
    search_money_found = 'お金が見つかりました',
    search_money_found_desc = '$%s を見つけました',

    handed_keys = 'キーが渡されました',
    handed_keys_desc = '車両のキーが渡されました！',
    keys_received = 'キーを受け取った',
    keys_received_desc = 'ナンバープレート %s のキーを受け取りました',
    keys_removed = 'キーが削除されました',
    keys_removed_desc = 'ナンバープレート %s のキーが削除されました',

    vehicle_unlocked = '解除されました',
    vehicle_unlocked_desc = '車両が解除されました',

    vehicle_locked = 'ロックされました',
    vehicle_locked_desc = '車両がロックされました',

    already_in_vehicle = '車両内',
    already_in_vehicle_desc = 'すでに車両に乗っています',

    no_one_nearby = '近くに誰もいません',
    no_one_nearby_desc = 'キーを渡せる人が近くにいません',

    notify_police_notified = '警察に通知されました',
    notify_police_notified_desc = 'あなたの行動が警察に通知されました。',

    notify_police_notification = '警察への通知',
    notify_police_notification_desc = '市民が %s を報告しました。マップを確認してください。',

    vehicle_stopped = 'エンジン停止',
    vehicle_stopped_desc = 'エンジンを停止しました。',

    vehicle_started = 'エンジン開始',
    vehicle_started_desc = 'エンジンを開始しました。',

    -- Keymapping
    toggle_keymap_desc = '車両ロック切り替え',

    -- Blip strings
    blip_hotwire = '盗難車両',
    blip_lockpick = 'ロックピックされた車両',
    blip_robPed = '武装強盗',

    -- Crimes
    crime_hotwire = '車両盗難',
    crime_lockpick = '車両侵入',
    crime_robPed = '武装強盗',

    -- Metadata
    vehicle_plate = '車両ナンバープレート',
}
