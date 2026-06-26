---@param cb fun(mdt?: "police" | "ambulance")
---@param key string
---@param mdt? "police" | "ambulance"
local function Convert(cb, key, mdt)
    local convertName = (mdt and (mdt .. " ") or "") .. key

    debugprint("Converting " .. convertName .. "...")

    cb(mdt)

    debugprint("Converted " .. convertName)
end

---@param database string
function ConvertMDTData(database)
    local rows = MySQL.query.await([[
        SELECT
            TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLLATION_NAME, IS_NULLABLE, COLUMN_DEFAULT
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE
            TABLE_SCHEMA = ?
            AND (TABLE_NAME LIKE 'lbtablet_police_%' OR TABLE_NAME LIKE 'lbtablet_ambulance_%' OR TABLE_NAME LIKE 'lbtablet_chat_%' OR TABLE_NAME LIKE 'lbtablet_mdt_%')
            AND EXTRA LIKE '%on update current_timestamp%'
    ]], { database })

    for i = 1, #rows do
        local row = rows[i]

        MySQL.rawExecute.await(FormatString("ALTER TABLE `{table}` MODIFY COLUMN `{column}` {data_type} {null}",
            {
                table = row.TABLE_NAME,
                column = row.COLUMN_NAME,
                data_type = row.DATA_TYPE,
                null = row.IS_NULLABLE == "NO" and "NOT NULL" or "NULL"
            }
        ))
    end

    Convert(function()
        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_weapons
                (department, serial_number, weapon_name, owner_id)
            SELECT
                'Police', serial_number, weapon_name, owner
            FROM lbtablet_police_weapons
            ON DUPLICATE KEY UPDATE
                serial_number = VALUES(serial_number)
        ]])
    end, "weapons")

    ---@param mdt "police" | "ambulance"
    local function ConvertAccounts(mdt)
        MySQL.rawExecute.await(FormatString([[
            INSERT INTO lbtablet_mdt_employees (id, department, display_name, avatar, callsign)
            SELECT id, '{mdt_id}', display_name, avatar, callsign
            FROM lbtablet_{mdt}_accounts
            ON DUPLICATE KEY UPDATE
                id = VALUES(id)
        ]], {
            mdt_id = mdt == "police" and "Police" or "Ambulance",
            mdt = mdt
        }))
    end

    Convert(ConvertAccounts, "accounts", "police")
    Convert(ConvertAccounts, "accounts", "ambulance")

    ---@param mdt "police" | "ambulance"
    local function ConvertChatRooms(mdt)
        MySQL.rawExecute.await(FormatString([[
            INSERT INTO lbtablet_mdt_chat_rooms (id, department, label, icon, is_private, creator, last_updated)
            SELECT id, '{mdt_id}', label, icon, `private`, creator, last_updated
            FROM lbtablet_chat_rooms
            WHERE terminal_type = '{mdt}'
            ON DUPLICATE KEY UPDATE
                id = VALUES(id)
        ]], {
            mdt_id = mdt == "police" and "Police" or "Ambulance",
            mdt = mdt
        }))
    end

    Convert(ConvertChatRooms, "chats", "police")
    Convert(ConvertChatRooms, "chats", "ambulance")

    Convert(function()
        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_chat_rooms_messages (id, room_id, author, content, attachments, sent_at)
            SELECT id, room_id, author, `message`, attachments, sent_at
            FROM lbtablet_chat_rooms_messages
            ON DUPLICATE KEY UPDATE
                id = VALUES(id)
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_mdt_chat_rooms
            SET last_message_id = (
                SELECT id
                FROM lbtablet_mdt_chat_rooms_messages
                WHERE lbtablet_mdt_chat_rooms_messages.room_id = lbtablet_mdt_chat_rooms.id
                ORDER BY sent_at DESC
                LIMIT 1
            )
        ]])
    end, "chat_messages")

    Convert(function()
        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_chat_rooms_members (room_id, member, notifications)
            SELECT room_id, account, notifications
            FROM lbtablet_chat_rooms_members
            ON DUPLICATE KEY UPDATE
                room_id = VALUES(room_id)
        ]])
    end, "chat_members")

    ---@param mdt "police" | "ambulance"
    local function ConvertTags(mdt)
        MySQL.rawExecute.await(FormatString([[
            ALTER TABLE lbtablet_{mdt}_tags
            ADD COLUMN IF NOT EXISTS new_id INT UNSIGNED DEFAULT NULL AFTER id
        ]], {
            mdt = mdt
        }))

        MySQL.rawExecute.await(FormatString([[
            ALTER TABLE lbtablet_{mdt}_tags
            ADD INDEX IF NOT EXISTS idx_new_id (new_id)
        ]], {
            mdt = mdt
        }))

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_tags
            ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_tags
            ADD INDEX IF NOT EXISTS idx_old_id (old_id)
        ]])

        MySQL.rawExecute.await(FormatString([[
            INSERT IGNORE INTO lbtablet_mdt_tags (old_id, department, tag_name, tag_color, tag_type)
            SELECT id, '{mdt_id}', title, color,
                CASE
                    WHEN `{type_column}` = 'profile' THEN 'users'
                    WHEN `{type_column}` = 'vehicle' THEN 'vehicles'
                    WHEN `{type_column}` = 'property' THEN 'property'
                    WHEN `{type_column}` = 'weapon' THEN 'weapons'
                    WHEN `{type_column}` = 'report' THEN 'reports'
                    WHEN `{type_column}` = 'warrant' THEN 'warrants'
                    WHEN `{type_column}` = 'incident' THEN 'cases'
                    ELSE `{type_column}`
                END
            FROM lbtablet_{mdt}_tags
        ]], {
            mdt_id = mdt == "police" and "Police" or "Ambulance",
            mdt = mdt,
            type_column = mdt == "police" and "type" or "tag_type"
        }))

        MySQL.rawExecute.await(FormatString([[
            UPDATE lbtablet_{mdt}_tags old
            JOIN lbtablet_mdt_tags new ON new.old_id = old.id
            SET old.new_id = new.id
        ]], {
            mdt = mdt
        }))

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_tags
            DROP COLUMN old_id
        ]])
    end

    Convert(ConvertTags, "tags", "police")
    Convert(ConvertTags, "tags", "ambulance")

    ---@param mdt "police" | "ambulance"
    local function ConvertBulletin(mdt)
        MySQL.rawExecute.await(FormatString([[
            INSERT INTO lbtablet_mdt_bulletin (department, title, content, pinned, created_by, created_at)
            SELECT '{mdt_id}', title, content, pinned, created_by, created_at
            FROM lbtablet_{mdt}_bulletin
            ORDER BY created_at ASC
        ]], {
            mdt_id = mdt == "police" and "Police" or "Ambulance",
            mdt = mdt
        }))
    end

    Convert(ConvertBulletin, "bulletin", "police")
    Convert(ConvertBulletin, "bulletin", "ambulance")

    Convert(function()
        MySQL.transaction.await({
            [[
                ALTER TABLE lbtablet_police_offences
                ADD COLUMN IF NOT EXISTS new_id INT UNSIGNED DEFAULT NULL AFTER id
            ]],
            [[
                ALTER TABLE lbtablet_police_offences
                ADD INDEX IF NOT EXISTS idx_new_id (new_id)
            ]],
            [[
                ALTER TABLE lbtablet_police_offences
                ADD COLUMN IF NOT EXISTS new_category_id INT UNSIGNED DEFAULT NULL AFTER category_id
            ]],
            [[
                ALTER TABLE lbtablet_police_offences
                ADD INDEX IF NOT EXISTS idx_new_category_id (new_category_id)
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_categories
                ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_categories
                ADD INDEX IF NOT EXISTS idx_old_id (old_id)
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_items
                ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_items
                ADD INDEX IF NOT EXISTS idx_old_id (old_id)
            ]]
        }, {})

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_catalog_categories (department, old_id, title)
            SELECT 'Police', id, title
            FROM lbtablet_police_offences_categories
            ON DUPLICATE KEY UPDATE
                id = VALUES(id)
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_police_offences old
            JOIN lbtablet_mdt_catalog_categories new ON new.old_id = old.category_id
            SET old.new_category_id = new.id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_catalog_items (department, old_id, category_id, severity, title, content, fine, jail)
            SELECT 'Police', id, new_category_id, class, title, `description`, fine, jail_time
            FROM lbtablet_police_offences
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_police_offences old
            JOIN lbtablet_mdt_catalog_items new ON new.old_id = old.id
            SET old.new_id = new.id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_catalog_categories
            DROP COLUMN old_id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_catalog_items
            DROP COLUMN old_id
        ]])
    end, "catalog", "police")

    Convert(function()
        MySQL.transaction.await({
            [[
                ALTER TABLE lbtablet_ambulance_conditions
                ADD COLUMN IF NOT EXISTS new_id INT UNSIGNED DEFAULT NULL AFTER id
            ]],
            [[
                ALTER TABLE lbtablet_ambulance_conditions
                ADD INDEX IF NOT EXISTS idx_new_id (new_id)
            ]],
            [[
                ALTER TABLE lbtablet_ambulance_conditions
                ADD COLUMN IF NOT EXISTS new_category_id INT UNSIGNED DEFAULT NULL AFTER category_id
            ]],
            [[
                ALTER TABLE lbtablet_ambulance_conditions
                ADD INDEX IF NOT EXISTS idx_new_category_id (new_category_id)
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_categories
                ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_categories
                ADD INDEX IF NOT EXISTS idx_old_id (old_id)
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_items
                ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
            ]],
            [[
                ALTER TABLE lbtablet_mdt_catalog_items
                ADD INDEX IF NOT EXISTS idx_old_id (old_id)
            ]]
        }, {})

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_catalog_categories (department, old_id, title)
            SELECT 'Ambulance', id, title
            FROM lbtablet_ambulance_conditions_categories
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_ambulance_conditions old
            JOIN lbtablet_mdt_catalog_categories new ON new.old_id = old.category_id
            SET old.new_category_id = new.id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_catalog_items (department, old_id, category_id, severity, title, content)
            SELECT 'Ambulance', id, new_category_id, severity, title, ''
            FROM lbtablet_ambulance_conditions
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_ambulance_conditions old
            JOIN lbtablet_mdt_catalog_items new ON new.old_id = old.id
            SET old.new_id = new.id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_catalog_categories
            DROP COLUMN old_id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_catalog_items
            DROP COLUMN old_id
        ]])
    end, "catalog", "ambulance")

    ---@param mdt "police" | "ambulance"
    local function ConvertProfiles(mdt)
        local mdtId = mdt == "police" and "Police" or "Ambulance"

        MySQL.rawExecute.await(FormatString([[
            INSERT INTO lbtablet_mdt_profiles
                (profile_id, department, avatar, profile_type)
            SELECT
                {select_id},
                '{mdt_id}',
                avatar,
                {select_profile_type}

            FROM lbtablet_{mdt}_profiles

            ON DUPLICATE KEY UPDATE
                avatar = VALUES(avatar)
        ]], {
            select_id = mdt == "police" and [[
                CASE
                    WHEN profile_type = 'weapon' THEN REPLACE(id, 'weapon:', '')
                    ELSE id
                END
            ]] or "id",
            select_profile_type = mdt == "police" and "profile_type" or "'player'",
            mdt_id = mdtId,
            mdt = mdt
        }))

        MySQL.rawExecute.await(FormatString([[
            INSERT INTO lbtablet_mdt_profiles_fields
                (profile_id, field_id, field_value)

            SELECT
                mp.id,
                'notes',
                pp.notes

            FROM lbtablet_{mdt}_profiles pp

            INNER JOIN lbtablet_mdt_profiles mp
                ON mp.profile_id = {select_id}
                AND mp.department = '{mdt_id}'
                {join_profile_type}

            WHERE pp.notes != ''

            ON DUPLICATE KEY UPDATE
                field_value = VALUES(field_value)
        ]], {
            select_id = mdt == "police" and [[
                CASE
                    WHEN mp.profile_type = 'weapon' THEN REPLACE(pp.id, 'weapon:', '')
                    ELSE pp.id
                END
            ]] or "pp.id",
            join_profile_type = mdt == "police" and "AND mp.profile_type = pp.profile_type" or "",
            mdt_id = mdtId,
            mdt = mdt
        }))

        if mdt == "police" then
            MySQL.rawExecute.await([[
                INSERT INTO lbtablet_mdt_profiles (profile_id, department, profile_type)
                SELECT
                    pw.serial_number,
                    'Police',
                    'weapon'
                FROM lbtablet_police_weapons pw
                LEFT JOIN lbtablet_mdt_profiles mp
                    ON mp.profile_id = pw.serial_number
                    AND mp.department = 'Police'
                    AND mp.profile_type = 'weapon'
                WHERE mp.id IS NULL
                ON DUPLICATE KEY UPDATE
                    profile_id = VALUES(profile_id)
            ]])
        end

        MySQL.rawExecute.await(FormatString([[
            INSERT INTO lbtablet_mdt_applied_tags
                (tag_id, applied_id, applied_type)

            SELECT
                old_tag.new_id,
                mp.id,
                CASE
                    WHEN mp.profile_type = 'player' THEN 'profile'
                    ELSE mp.profile_type
                END

            FROM lbtablet_{mdt}_profile_tags ppt

            INNER JOIN lbtablet_{mdt}_tags old_tag
                ON old_tag.id = ppt.tag_id

            INNER JOIN lbtablet_mdt_profiles mp
                ON mp.profile_id = {select_id}
                AND mp.department = '{mdt_id}'

            ON DUPLICATE KEY UPDATE
                tag_id = VALUES(tag_id)
        ]], {
            select_id = mdt == "police" and [[
                CASE
                    WHEN mp.profile_type = 'weapon' THEN REPLACE(ppt.id, 'weapon:', '')
                    ELSE ppt.id
                END
            ]] or "ppt.id",
            mdt_id = mdtId,
            mdt = mdt
        }))
    end

    Convert(ConvertProfiles, "profiles", "police")
    Convert(ConvertProfiles, "profiles", "ambulance")

    Convert(function()
        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_profiles_charges
                (profile_id, charge_id)
            SELECT
                mp.id,
                ac.new_id
            FROM lbtablet_ambulance_profile_conditions apc
            INNER JOIN lbtablet_ambulance_conditions ac
                ON ac.id = apc.condition_id
            INNER JOIN lbtablet_mdt_profiles mp
                ON mp.profile_id = apc.profile_id
                AND mp.department = 'Ambulance'
            WHERE
                ac.new_id IS NOT NULL
                AND mp.id IS NOT NULL
        ]])
    end, "ambulance_profile_catalog")

    Convert(function()
        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_police_reports
            ADD COLUMN IF NOT EXISTS new_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_reports
            ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports
                (old_id, department, tab_id, created_by, title, created_at, updated_at)
            SELECT
                id, 'Police', 'reports', created_by, title, created_at, updated_at
            FROM lbtablet_police_reports
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_police_reports old
            JOIN lbtablet_mdt_reports new
                ON new.old_id = old.id
                AND new.department = 'Police'
                AND new.tab_id = 'reports'
            SET old.new_id = new.id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'type', report_type
            FROM lbtablet_police_reports
            WHERE
                report_type != ''
                AND new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'description', `description`
            FROM lbtablet_police_reports
            WHERE `description` != ''
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_photos
                (report_id, field_id, attachment)
            SELECT
                pr.new_id, 'gallery', pra.attachment
            FROM lbtablet_police_reports_attachments pra
            INNER JOIN lbtablet_police_reports pr ON pr.id = pra.report_id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved
                (department, report_id, involved, involvement, profile_type)
            SELECT
                'Police',
                pr.new_id,
                i.involved,
                CASE
                    WHEN i.involvement = 'officer' THEN 'officers'
                    WHEN i.involvement = 'suspect' THEN 'suspects'
                    WHEN i.involvement = 'civilian' THEN 'civilians'
                    WHEN i.involvement = 'weapon' THEN 'weapons'
                    ELSE i.involvement
                END,
                CASE
                    WHEN i.involvement = 'weapon' THEN 'weapon'
                    ELSE 'player'
                END
            FROM lbtablet_police_reports_involved i
            INNER JOIN lbtablet_police_reports pr ON pr.id = i.report_id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_applied_tags
                (tag_id, applied_id, applied_type)
            SELECT
                old_tag.new_id,
                pr.new_id,
                'reports'
            FROM lbtablet_police_reports_tags prt
            INNER JOIN lbtablet_police_reports pr ON pr.id = prt.report_id
            INNER JOIN lbtablet_police_tags old_tag ON old_tag.id = prt.tag_id
        ]])
    end, "police_reports")

    Convert(function()
        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_police_warrants
            ADD COLUMN IF NOT EXISTS new_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_reports
            ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports
                (old_id, department, tab_id, created_by, title, created_at, updated_at)
            SELECT
                id, 'Police', 'warrants', created_by, title, created_at, updated_at
            FROM lbtablet_police_warrants
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_police_warrants old
            JOIN lbtablet_mdt_reports new
                ON new.old_id = old.id
                AND new.department = 'Police'
                AND new.tab_id = 'warrants'
            SET old.new_id = new.id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved
                (department, report_id, involved, involvement, profile_type)
            SELECT
                'Police',
                new_id,
                linked_profile_id,
                'target',
                linked_profile_type
            FROM lbtablet_police_warrants
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'type', warrant_type
            FROM lbtablet_police_warrants
            WHERE
                warrant_type != ''
                AND new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'status', warrant_status
            FROM lbtablet_police_warrants
            WHERE
                warrant_status != ''
                AND new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'priority', priority
            FROM lbtablet_police_warrants
            WHERE
                priority != ''
                AND new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'description', `description`
            FROM lbtablet_police_warrants
            WHERE
                `description` != ''
                AND new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_photos
                (report_id, field_id, attachment)
            SELECT
                pw.new_id, 'gallery', pwa.attachment
            FROM lbtablet_police_warrants_attachments pwa
            INNER JOIN lbtablet_police_warrants pw ON pw.id = pwa.warrant_id
            WHERE pw.new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_applied_tags
                (tag_id, applied_id, applied_type)
            SELECT
                old_tag.new_id,
                pw.new_id,
                'warrants'
            FROM lbtablet_police_warrants_tags pwt
            INNER JOIN lbtablet_police_warrants pw ON pw.id = pwt.warrant_id
            INNER JOIN lbtablet_police_tags old_tag ON old_tag.id = pwt.tag_id
            WHERE
                pw.new_id IS NOT NULL
                AND old_tag.new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_linked_reports
                (report_id, linked_report_id)
            SELECT
                pw.new_id,
                pr.new_id
            FROM lbtablet_police_warrants_linked_reports pwlr

            INNER JOIN lbtablet_police_warrants pw ON pw.id = pwlr.warrant_id
            INNER JOIN lbtablet_police_reports pr ON pr.id = pwlr.report_id
            INNER JOIN lbtablet_mdt_reports pr_new
                ON pr_new.old_id = pr.id
                AND pr_new.department = 'Police'
                AND pr_new.tab_id = 'reports'
            INNER JOIN lbtablet_mdt_reports pw_new
                ON pw_new.old_id = pw.id
                AND pw_new.department = 'Police'
                AND pw_new.tab_id = 'warrants'

            WHERE
                pw.new_id IS NOT NULL
                AND pr.new_id IS NOT NULL

            ON DUPLICATE KEY UPDATE
                report_id = VALUES(report_id)
        ]])
    end, "police_warrants")

    Convert(function()
        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_police_cases
            ADD COLUMN IF NOT EXISTS new_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_reports
            ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports
                (old_id, department, tab_id, created_by, title, created_at, updated_at)
            SELECT
                id, 'Police', 'cases', created_by, title, created_at, updated_at
            FROM lbtablet_police_cases
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_police_cases old
            JOIN lbtablet_mdt_reports new
                ON new.old_id = old.id
                AND new.department = 'Police'
                AND new.tab_id = 'cases'
            SET old.new_id = new.id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'description', `description`
            FROM lbtablet_police_cases
            WHERE `description` != ''
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_photos
                (report_id, field_id, attachment)
            SELECT
                pc.new_id, 'evidence', pce.attachment
            FROM lbtablet_police_cases_evidence pce
            INNER JOIN lbtablet_police_cases pc ON pc.id = pce.case_id

            WHERE pc.new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_applied_tags
                (tag_id, applied_id, applied_type)
            SELECT
                old_tag.new_id,
                pc.new_id,
                'cases'
            FROM lbtablet_police_cases_tags pct
            INNER JOIN lbtablet_police_cases pc ON pc.id = pct.case_id
            INNER JOIN lbtablet_police_tags old_tag ON old_tag.id = pct.tag_id

            WHERE
                pc.new_id IS NOT NULL
                AND old_tag.new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_linked_reports
                (report_id, linked_report_id)
            SELECT
                pc.new_id,
                pr.new_id
            FROM lbtablet_police_cases_linked_reports pclr

            INNER JOIN lbtablet_police_cases pc ON pc.id = pclr.case_id
            INNER JOIN lbtablet_police_reports pr ON pr.id = pclr.report_id
            INNER JOIN lbtablet_mdt_reports pr_new
                ON pr_new.old_id = pr.id
                AND pr_new.department = 'Police'
                AND pr_new.tab_id = 'reports'
            INNER JOIN lbtablet_mdt_reports pc_new
                ON pc_new.old_id = pc.id
                AND pc_new.department = 'Police'
                AND pc_new.tab_id = 'cases'

            WHERE
                pc.new_id IS NOT NULL
                AND pr.new_id IS NOT NULL

            ON DUPLICATE KEY UPDATE
                report_id = VALUES(report_id)
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved
                (department, report_id, involved, involvement, profile_type)
            SELECT
                'Police',
                pr.new_id,
                i.involved,
                CASE
                    WHEN i.involvement = 'vehicle' THEN 'vehicles'
                    WHEN i.involvement = 'officer' THEN 'officers'
                    WHEN i.involvement = 'civilian' THEN 'civilians'
                    WHEN i.involvement = 'weapon' THEN 'weapons'
                    ELSE i.involvement
                END,
                CASE
                    WHEN i.involvement = 'vehicle' THEN 'vehicle'
                    WHEN i.involvement = 'weapon' THEN 'weapon'
                    ELSE 'player'
                END
            FROM lbtablet_police_cases_involved i
            INNER JOIN lbtablet_police_cases pr ON pr.id = i.case_id
            WHERE pr.new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved
                (department, report_id, involved, involvement, profile_type, fine, jail_time, fined, jailed)
            SELECT
                'Police',
                pc.new_id,
                c.id,
                'criminals',
                'player',
                c.fine,
                c.jail_time,
                c.fined,
                c.jailed
            FROM lbtablet_police_cases_criminals c
            INNER JOIN lbtablet_police_cases pc ON pc.id = c.case_id
            WHERE pc.new_id IS NOT NULL
            ON DUPLICATE KEY UPDATE
                involvement = VALUES(involvement),
                profile_type = VALUES(profile_type),
                fine = VALUES(fine),
                jail_time = VALUES(jail_time),
                fined = VALUES(fined),
                jailed = VALUES(jailed)
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved_charges
                (department, involved_id, report_id, involved, involvement, charge_id, charges)
            SELECT
                'Police',
                ri.id,
                pc.new_id,
                ch.criminal,
                'criminals',
                po.new_id,
                ch.charges
            FROM lbtablet_police_cases_charges ch
            INNER JOIN lbtablet_police_cases pc ON pc.id = ch.case_id
            INNER JOIN lbtablet_police_offences po ON po.id = ch.offence_id
            INNER JOIN lbtablet_mdt_reports_involved ri
                ON ri.report_id = pc.new_id
                AND ri.involved = ch.criminal
            WHERE
                pc.new_id IS NOT NULL
                AND po.new_id IS NOT NULL
                AND ri.id IS NOT NULL
            ON DUPLICATE KEY UPDATE
                charges = VALUES(charges)
        ]])

        if GetResourceState("ox_inventory") == "started" or GetResourceState("ox_inventory") == "starting" then
            MySQL.rawExecute.await([[
                UPDATE ox_inventory
                JOIN lbtablet_police_cases pc ON ox_inventory.name = CONCAT('case-', pc.id)
                SET ox_inventory.name = CONCAT('cases-', pc.new_id)
                WHERE pc.new_id IS NOT NULL
            ]])
        elseif GetResourceState("qb-inventory") == "started" or GetResourceState("qb-inventory") == "starting" then
            MySQL.rawExecute.await([[
                UPDATE inventories
                JOIN lbtablet_police_cases pc ON inventories.identifier = CONCAT('case-', pc.id)
                SET inventories.identifier = CONCAT('cases-', pc.new_id)
                WHERE pc.new_id IS NOT NULL
            ]])
        elseif
            (GetResourceState("ps-inventory") == "started" or GetResourceState("ps-inventory") == "starting")
            or (GetResourceState("lj-inventory") == "started" or GetResourceState("lj-inventory") == "starting")
        then
            MySQL.rawExecute.await([[
                UPDATE stashitems
                JOIN lbtablet_police_cases pc ON stashitems.stash = CONCAT('case-', pc.id)
                SET stashitems.stash = CONCAT('cases-', pc.new_id)
                WHERE pc.new_id IS NOT NULL
            ]])
        end
    end, "police_cases")

    Convert(function()
        MySQL.rawExecute.await([[
            INSERT IGNORE INTO lbtablet_mdt_wiretaps
                (department, phone_number, tapped_by, created_at)
            SELECT
                'Police', phone_number, creator_tablet_id, created_at
            FROM lbtablet_police_wiretaps
        ]])

        MySQL.rawExecute.await([[
            INSERT IGNORE INTO lbtablet_mdt_wiretap_subscribers
                (wiretap_id, subscriber_id, phone_number)
            SELECT
                w.id, s.tablet_id, s.phone_number
            FROM lbtablet_police_wiretaps_subscribers s
            INNER JOIN lbtablet_mdt_wiretaps w ON w.phone_number = s.phone_number
            WHERE w.id IS NOT NULL
        ]])
    end, "wiretaps")

    Convert(function()
        MySQL.rawExecute.await([[
            INSERT IGNORE INTO lbtablet_mdt_phone_unlocks
                (phone_number, department, attempts, unlocked, finished_at)
            SELECT
                phone_number, 'Police', attempts, unlocked, finished_at
            FROM lbtablet_police_phone_unlocks
        ]])
    end, "phone_unlocks")

    Convert(function()
        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_jail
                (department, prisoner, reason, original_time, remaining_time, linked_report, jailed_by, jailed_at)
            SELECT
                'Police', jail.prisoner, jail.reason, jail.original_time, jail.jail_time, `case`.new_id, jail.jailed_by, jail.jailed_at
            FROM lbtablet_police_jail jail
            LEFT JOIN lbtablet_police_cases `case` ON `case`.id = jail.related_case
        ]])
    end, "jail")

    Convert(function()
        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_ambulance_reports
            ADD COLUMN IF NOT EXISTS new_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            ALTER TABLE lbtablet_mdt_reports
            ADD COLUMN IF NOT EXISTS old_id INT UNSIGNED DEFAULT NULL AFTER id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports
                (old_id, department, tab_id, created_by, title, created_at, updated_at)
            SELECT
                id, 'Ambulance', 'reports', created_by, title, created_at, updated_at
            FROM lbtablet_ambulance_reports
        ]])

        MySQL.rawExecute.await([[
            UPDATE lbtablet_ambulance_reports old
            JOIN lbtablet_mdt_reports new
                ON new.old_id = old.id
                AND new.department = 'Ambulance'
                AND new.tab_id = 'reports'
            SET old.new_id = new.id
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'type', report_type
            FROM lbtablet_ambulance_reports
            WHERE report_type != ''
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_fields
                (report_id, field_id, field_value)
            SELECT
                new_id, 'description', `description`
            FROM lbtablet_ambulance_reports
            WHERE `description` != ''
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_photos
                (report_id, field_id, attachment)
            SELECT
                ar.new_id, 'gallery', ara.attachment
            FROM lbtablet_ambulance_reports_attachments ara
            INNER JOIN lbtablet_ambulance_reports ar ON ar.id = ara.report_id
            WHERE ar.new_id IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved
                (department, report_id, involved, involvement, profile_type)
            SELECT
                'Ambulance',
                new_id,
                patient,
                'target',
                'player'
            FROM lbtablet_ambulance_reports
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved_charges
                (department, involved_id, report_id, involved, involvement, charge_id)
            SELECT
                'Ambulance',
                ri.id,
                ar.new_id,
                ar.patient,
                'target',
                ac.new_id
            FROM lbtablet_ambulance_reports_conditions rc
            INNER JOIN lbtablet_ambulance_reports ar ON ar.id = rc.report_id
            INNER JOIN lbtablet_ambulance_conditions ac ON ac.id = rc.condition_id
            INNER JOIN lbtablet_mdt_reports_involved ri
                ON ri.report_id = ar.new_id
                AND ri.involved = ar.patient
            WHERE
                ar.new_id IS NOT NULL
                AND ac.new_id IS NOT NULL
                AND ri.id IS NOT NULL
            ON DUPLICATE KEY UPDATE
                charges = VALUES(charges)
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_reports_involved
                (department, report_id, involved, involvement, profile_type)
            SELECT
                'Ambulance',
                ar.new_id,
                doctor.doctor,
                'doctors',
                'player'
            FROM lbtablet_ambulance_reports_doctors doctor
            INNER JOIN lbtablet_ambulance_reports ar ON ar.id = doctor.report_id
            WHERE
                ar.new_id IS NOT NULL
                AND doctor.doctor IS NOT NULL
        ]])

        MySQL.rawExecute.await([[
            INSERT INTO lbtablet_mdt_applied_tags
                (tag_id, applied_id, applied_type)
            SELECT
                old_tag.new_id,
                ar.new_id,
                'reports'
            FROM lbtablet_ambulance_reports_tags art
            INNER JOIN lbtablet_ambulance_reports ar ON ar.id = art.report_id
            INNER JOIN lbtablet_ambulance_tags old_tag ON old_tag.id = art.tag_id
            WHERE
                ar.new_id IS NOT NULL
                AND old_tag.new_id IS NOT NULL
        ]])
    end, "ambulance_reports")

    for i = 1, #rows do
        local row = rows[i]

        MySQL.rawExecute.await(FormatString([[
            ALTER TABLE `{table}`
            MODIFY COLUMN `{column}` {data_type} {null} {default} ON UPDATE CURRENT_TIMESTAMP
        ]], {
            table = row.TABLE_NAME,
            column = row.COLUMN_NAME,
            data_type = row.DATA_TYPE,
            null = row.IS_NULLABLE == "NO" and "NOT NULL" or "NULL",
            default = row.COLUMN_DEFAULT ~= nil and ("DEFAULT " .. row.COLUMN_DEFAULT) or ""
        }))
    end
end
