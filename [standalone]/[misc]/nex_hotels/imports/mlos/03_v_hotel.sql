-- ═══════════════════════════════════════════════════════════════
-- nex_hotels — V Hotel import
-- ═══════════════════════════════════════════════════════════════
-- MLO-based hotel. Requires the V Hotel MLO add-on (a.k.a.
-- "Vinewood V Hotel") to be installed and streamed by your server.
--
-- Without the MLO, the room interiors will not exist in the world
-- and players will fall through the map when entering rooms.
--
-- Idempotent: safe to re-run. Hotel matched by `name`, rooms
-- matched by (hotel_id, floor_number, room_number).
-- ═══════════════════════════════════════════════════════════════

-- ---------------------------------------------------------------
-- Hotel row
-- ---------------------------------------------------------------
-- Lobby coords: (-1356.621, -1070.591, 7.235888)
-- Ped hash: 848542158 (0x3293B9CE) at (-1357.56, -1069.542, 7.248579, 213.13902)
-- interior_type = 'mlo'; no IPL loading table needed → interior_loading = NULL
-- Exit coords mirror entrance (no separate exit point).

INSERT INTO `nex_hotels` (name, description, image, room_description, room_image,
    blip, entrance_x, entrance_y, entrance_z, entrance_h, exit_x, exit_y, exit_z, exit_h,
    retail_price, ped, interior_type, interior_loading)
VALUES ('V Hotel',
    'V Hotel',
    'https://i.imgur.com/0000000.jpg',
    'A premium hotel suite inside the V Hotel.',
    'https://i.imgur.com/0000000.jpg',
    '{"sprite": 475, "color": 13, "scale": 0.9, "label": "V Hotel"}',
    -1356.621, -1070.591, 7.235888, 0,
    -1356.621, -1070.591, 7.235888, 0,
    60000,
    '{"hash": 848542158, "x": -1357.56, "y": -1069.542, "z": 7.248579, "heading": 213.13902}',
    'mlo',
    NULL)
ON DUPLICATE KEY UPDATE
    description = VALUES(description),
    image = VALUES(image),
    room_description = VALUES(room_description),
    room_image = VALUES(room_image),
    blip = VALUES(blip),
    entrance_x = VALUES(entrance_x), entrance_y = VALUES(entrance_y),
    entrance_z = VALUES(entrance_z), entrance_h = VALUES(entrance_h),
    exit_x = VALUES(exit_x), exit_y = VALUES(exit_y),
    exit_z = VALUES(exit_z), exit_h = VALUES(exit_h),
    retail_price = VALUES(retail_price),
    ped = VALUES(ped),
    interior_type = VALUES(interior_type),
    interior_loading = VALUES(interior_loading);

-- ---------------------------------------------------------------
-- Capture hotel id for the rooms insert
-- ---------------------------------------------------------------
SET @hotel_id := (SELECT id FROM `nex_hotels` WHERE name = 'V Hotel');

-- ---------------------------------------------------------------
-- Rooms (Floor 1 — 3 rooms total)
-- ---------------------------------------------------------------
-- Room 1: standard suite, single door  ('johanni_vhotel_asset_door01')
-- Room 2: standard suite, single door  ('johanni_vhotel_asset_door01')
-- Room 3: penthouse-style, double door (array of two door names)

INSERT INTO `nex_hotel_rooms` (hotel_id, floor_number, room_number, label, price, unlock_price,
    entry_x, entry_y, entry_z, entry_h,
    interior_x, interior_y, interior_z, interior_h, `range`, door_object,
    storage_x, storage_y, storage_z,
    clothing_x, clothing_y, clothing_z,
    safe_x, safe_y, safe_z,
    minibar_x, minibar_y, minibar_z)
VALUES
    (@hotel_id, 1, 1, 'Floor 1 / Room 1', 25000, 10000,
        -1379.53, -1057.034, 7.2446885, 0,
        -1380.112, -1056.286, 7.2446522, 30.981391, 12, '"johanni_vhotel_asset_door01"',
        -1385.195, -1052.218, 7.2446708,
        -1378.74, -1053.834, 7.2446699,
        -1382.246, -1049.724, 7.2757682,
        -1380.121, -1051.266, 7.2446832),
    (@hotel_id, 1, 2, 'Floor 1 / Room 2', 25000, 10000,
        -1373.392, -1053.352, 7.2446527, 0,
        -1373.91, -1052.693, 7.2446427, 32.216014, 12, '"johanni_vhotel_asset_door01"',
        -1376.371, -1052.75, 7.2446608,
        -1377.56, -1050.482, 7.2447471,
        -1375.919, -1046.239, 7.2757811,
        -1372.471, -1049.847, 7.244667),
    (@hotel_id, 1, 3, 'Floor 1 / Room 3', 60000, 10000,
        -1375.621, -1061.304, 7.2446751, 0,
        -1375.174, -1061.98, 7.2446603, 212.72335, 12, '["johanni_vhotel_asset_int_door02_b","johanni_vhotel_asset_int_door02_b"]',
        -1370.608, -1069.621, 7.2446475,
        -1374.867, -1069.216, 7.2446451,
        -1371.642, -1074.312, 7.2769217,
        -1371.399, -1063.712, 7.244657)
ON DUPLICATE KEY UPDATE
    label = VALUES(label),
    price = VALUES(price),
    unlock_price = VALUES(unlock_price),
    entry_x = VALUES(entry_x), entry_y = VALUES(entry_y), entry_z = VALUES(entry_z), entry_h = VALUES(entry_h),
    interior_x = VALUES(interior_x), interior_y = VALUES(interior_y), interior_z = VALUES(interior_z), interior_h = VALUES(interior_h),
    `range` = VALUES(`range`),
    door_object = VALUES(door_object),
    storage_x = VALUES(storage_x), storage_y = VALUES(storage_y), storage_z = VALUES(storage_z),
    clothing_x = VALUES(clothing_x), clothing_y = VALUES(clothing_y), clothing_z = VALUES(clothing_z),
    safe_x = VALUES(safe_x), safe_y = VALUES(safe_y), safe_z = VALUES(safe_z),
    minibar_x = VALUES(minibar_x), minibar_y = VALUES(minibar_y), minibar_z = VALUES(minibar_z);
