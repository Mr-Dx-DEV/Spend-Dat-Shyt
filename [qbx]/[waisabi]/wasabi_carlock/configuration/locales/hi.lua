-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not Config.Language then Config.Language = 'en' end
if Config.Language ~= 'hi' then return end

Strings = {

    no_wsb = '^0[^3चेतावनी^0] wasabi_bridge को framework के बाद और/या resource से पहले START नहीं किया गया: %s',
    warning_disabling_metadata = '[^3चेतावनी^0] कोई इन्वेंट्री सिस्टम नहीं मिला, मेटाडेटा कुंजी निष्क्रिय की जा रही हैं।',

    manage_keys = 'कुंजियाँ प्रबंधित करें',
    manage_key = 'कुंजी प्रबंधित करें - %s',
    give_key = 'कुंजी दें',
    remove_key = 'कुंजी हटाएँ',
    are_you_sure = 'क्या आप सुनिश्चित हैं?',
    are_you_sure_desc = 'क्या आप सुनिश्चित हैं कि आप %s प्लेट की कुंजी हटाना चाहते हैं?',

    -- Menu
    player_id = 'खिलाड़ी ID: ',

    -- Notification
    too_far = 'बहुत दूर',
    too_far_desc = 'आप इसे करने के लिए बहुत दूर हैं!',

    no_vehicle_found = 'कोई वाहन नहीं मिला',
    no_vehicle_found_desc = 'कोई भी वाहन पास में नहीं है, जिसके पास आपके पास कुंजी हो!',
    no_vehicle_found_keys_desc = 'पास में कोई वाहन नहीं है जिसके पास आपके पास कुंजी हो!',
    no_vehicle_found_lockpick_desc = 'पास में कोई वाहन नहीं है जिसे आप लॉकपिक कर सकें!',

    no_keys_found = 'कोई कुंजी नहीं मिली',
    no_keys_found_desc = 'आपके पास किसी भी वाहन की कुंजी नहीं है!',

    vehicle_not_locked = 'वाहन अनलॉक किया गया',
    vehicle_not_locked_desc = 'यह वाहन लॉक नहीं लगता',

    vehicle_cant_lockpick = 'लॉकपिक नहीं कर सकते',
    vehicle_cant_lockpick_desc = 'आप इस वाहन को लॉकपिक नहीं कर सकते!',

    success = 'सफलता',
    failed = 'विफल',
    success_lockpick_desc = 'आपने वाहन को सफलतापूर्वक लॉकपिक किया',
    fail_lockpick_desc = 'आप वाहन को लॉकपिक नहीं कर पाए',
    lockpick_broke = 'लॉकपिक टूटा',
    lockpick_broke_desc = 'आपने लॉकपिक को मोड़ दिया',

    cancelled_action = 'कार्य रद्द',
    cancelled_action_desc = 'आपका कार्य रद्द कर दिया गया!',

    search_nothing_found = 'कुछ नहीं मिला',
    search_nothing_found_desc = 'आपने कुछ भी उपयोगी नहीं पाया',
    search_keys_found = 'कुंजी मिली',
    search_keys_found_desc = 'आपने वाहन की कुंजी पाई',
    search_item_found = 'कुछ पाया',
    search_item_found_desc = 'आपने %sx %s पाया!',
    search_money_found = 'पैसे मिले',
    search_money_found_desc = 'आपने $%s पाए',

    handed_keys = 'कुंजी दी गई',
    handed_keys_desc = 'आपको वाहन की कुंजी दी गई!',
    keys_received = 'कुंजी प्राप्त हुई',
    keys_received_desc = 'आपको प्लेट: %s के लिए कुंजी प्राप्त हुई',
    keys_removed = 'कुंजी हटा दी गई',
    keys_removed_desc = 'प्लेट: %s के लिए कुंजी हटा दी गई',

    vehicle_unlocked = 'अनलॉक किया गया',
    vehicle_unlocked_desc = 'आपने अपना वाहन अनलॉक कर लिया',

    vehicle_locked = 'लॉक किया गया',
    vehicle_locked_desc = 'आपने अपना वाहन लॉक कर लिया',

    already_in_vehicle = 'वाहन में',
    already_in_vehicle_desc = 'आप पहले ही एक वाहन में हैं',

    no_one_nearby = 'कोई पास में नहीं',
    no_one_nearby_desc = 'पास में कोई नहीं है जिसे आप कुंजी दे सकें',

    notify_police_notified = 'पुलिस को सूचित किया गया',
    notify_police_notified_desc = 'आपकी गतिविधियों के बारे में पुलिस को सूचित किया गया है।',

    notify_police_notification = 'डिस्पैच',
    notify_police_notification_desc = 'एक नागरिक ने %s के बारे में रिपोर्ट किया है, कृपया मानचित्र जांचें।',

    vehicle_stopped = 'इंजन बंद',
    vehicle_stopped_desc = 'आपने इंजन बंद कर दिया।',

    vehicle_started = 'इंजन चालू',
    vehicle_started_desc = 'आपने इंजन चालू कर दिया।',

    -- Keymapping
    toggle_keymap_desc = 'कार लॉक टॉगल करें',

    -- Blip strings
    blip_hotwire = 'चोरी की गई गाड़ी',
    blip_lockpick = 'लॉकपिक की गई गाड़ी',
    blip_robPed = 'आर्म्ड चोरी',

    -- Crimes
    crime_hotwire = 'वाहन चोरी',
    crime_lockpick = 'कार प्रवेश',
    crime_robPed = 'आर्म्ड चोरी',

    -- Metadata
    vehicle_plate = 'वाहन प्लेट',
}
