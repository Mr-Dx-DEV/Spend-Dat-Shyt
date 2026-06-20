-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'ko' then return end

Strings = {

    no_wsb = '^0[^3경고^0] wasabi_bridge가 framework 후에/또는 리소스 전에 시작되지 않았습니다: %s',
    warning_disabling_metadata = '[^3경고^0] 인벤토리 시스템을 찾을 수 없습니다. 메타데이터 키를 비활성화합니다.',

    manage_keys = '키 관리',
    manage_key = '키 관리 - %s',
    give_key = '키 주기',
    remove_key = '키 제거',
    are_you_sure = '정말로 제거하시겠습니까?',
    are_you_sure_desc = '차량 번호판 %s의 키를 제거하시겠습니까?',

    -- Menu
    player_id = '플레이어 ID: ',

    -- Notification
    too_far = '너무 멀리 있음',
    too_far_desc = '이 작업을 수행하기에는 너무 멉니다!',

    no_vehicle_found = '차량을 찾을 수 없음',
    no_vehicle_found_desc = '키가 있는 차량이 근처에 없습니다!',
    no_vehicle_found_keys_desc = '키가 있는 차량이 근처에 없습니다!',
    no_vehicle_found_lockpick_desc = '로크픽 할 차량이 근처에 없습니다!',

    no_keys_found = '키가 없습니다',
    no_keys_found_desc = '차량의 키가 없습니다!',

    vehicle_not_locked = '차량 잠금 해제됨',
    vehicle_not_locked_desc = '이 차량은 잠겨 있지 않은 것 같습니다',

    vehicle_cant_lockpick = '로크픽 불가',
    vehicle_cant_lockpick_desc = '이 차량은 로크픽 할 수 없습니다!',

    success = '성공',
    failed = '실패',
    success_lockpick_desc = '차량을 성공적으로 로크픽 했습니다',
    fail_lockpick_desc = '차량을 로크픽하지 못했습니다',
    lockpick_broke = '로크픽이 부러짐',
    lockpick_broke_desc = '로크픽이 부러졌습니다',

    cancelled_action = '작업 취소됨',
    cancelled_action_desc = '작업이 취소되었습니다!',

    search_nothing_found = '아무것도 찾지 못함',
    search_nothing_found_desc = '유용한 것을 찾지 못했습니다',
    search_keys_found = '키 찾음',
    search_keys_found_desc = '차량의 키를 찾았습니다',
    search_item_found = '아이템 찾음',
    search_item_found_desc = '당신은 %sx %s을(를) 찾았습니다!',
    search_money_found = '돈 찾음',
    search_money_found_desc = '당신은 $%s을(를) 찾았습니다',

    handed_keys = '키 전달됨',
    handed_keys_desc = '차량의 키가 전달되었습니다!',
    keys_received = '키 받음',
    keys_received_desc = '차량 번호판: %s에 대한 키를 받았습니다',
    keys_removed = '키 제거됨',
    keys_removed_desc = '차량 번호판: %s에 대한 키가 제거되었습니다',

    vehicle_unlocked = '차량 잠금 해제',
    vehicle_unlocked_desc = '차량의 잠금이 해제되었습니다',

    vehicle_locked = '차량 잠금',
    vehicle_locked_desc = '차량의 잠금이 설정되었습니다',

    already_in_vehicle = '차량 내',
    already_in_vehicle_desc = '이미 차량에 있습니다',

    no_one_nearby = '주변에 아무도 없음',
    no_one_nearby_desc = '주변에 키를 줄 사람이 없습니다',

    notify_police_notified = '경찰에게 알림',
    notify_police_notified_desc = '경찰에게 당신의 행동이 신고되었습니다.',

    notify_police_notification = '배차',
    notify_police_notification_desc = '시민이 %s를 신고했습니다. 지도에서 확인하십시오.',

    vehicle_stopped = '엔진 정지',
    vehicle_stopped_desc = '엔진을 껐습니다.',

    vehicle_started = '엔진 시작',
    vehicle_started_desc = '엔진을 켰습니다.',

    -- Keymapping
    toggle_keymap_desc = '차량 잠금 전환',

    -- Blip strings
    blip_hotwire = '도난 차량',
    blip_lockpick = '로크픽 차량',
    blip_robPed = '무장 강도',

    -- Crimes
    crime_hotwire = '차량 도난',
    crime_lockpick = '차량 침입',
    crime_robPed = '무장 강도',

    -- Metadata
    vehicle_plate = '차량 번호판',
}
