---@param billerIdentifier string
---@param billedIdentifier string
---@param amount number
---@param reason? string
---@return boolean success
function BillPlayer(billerIdentifier, billedIdentifier, amount, reason)
    local senderSource = GetSourceFromIdentifier(billerIdentifier)

    if not senderSource then
        return false
    end

    local playerJob = GetJob(senderSource)

    if not playerJob then
        return false
    end

    if Config.BillingScript == "framework" then
        return FrameworkBillPlayer(billerIdentifier, billedIdentifier, playerJob.name, amount, reason)
    elseif Config.BillingScript == "vivum" then
        local successPromise = promise.new()

        exports["vivum-billing"]:SendInvoice(senderSource, {
            sender = playerJob.name,
            sender_label = playerJob.label,
            recipient = billedIdentifier,
            recipient_label = GetCharacterNameFromIdentifier(billedIdentifier) or "??",
            amount = amount,
            payments_num = 1,
            payments_period = 7,
            summary = reason or playerJob.label
        }, function(res)
            successPromise:resolve(res.status == "OK")
        end)

        return Citizen.Await(successPromise)
    end

    return false
end

local charsetsToCollation = {
    ["UTF8MB4"] = "COLLATE UTF8MB4_UNICODE_CI",
    ["UTF8MB3"] = "COLLATE UTF8MB3_UNICODE_CI",
}

---@param tables { [string]: string }
---@return { [string]: string }
function GetCollationsForTables(tables)
    local collations = {}
    local databaseInfo = MySQL.single.await("SELECT DATABASE() AS `name`, VERSION() as `version`")

    for tableName, _ in pairs(tables) do
        collations[tableName] = ""
    end

    if not databaseInfo or not databaseInfo.name or not databaseInfo.version then
        return collations
    end

    if not databaseInfo.version:find("MariaDB") then
        return collations
    end

    local major, minor, patch = databaseInfo.version:match("(%d+)%.(%d+)%.(%d+)")

    major = major and tonumber(major)
    minor = minor and tonumber(minor)
    patch = patch and tonumber(patch)

    if not major or not minor or not patch then
        return collations
    end

    if major < 10 or (major == 10 and minor < 11) then
        return collations
    end

    local function GetCharset(tableName, columnName)
        local charset = MySQL.scalar.await([[
            SELECT
                CHARACTER_SET_NAME
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE
                TABLE_SCHEMA = ?
                AND TABLE_NAME = ?
                AND COLUMN_NAME = ?
        ]], { databaseInfo.name, tableName, columnName }) or "utf8mb4"

        return string.upper(charset)
    end

    for tableName, column in pairs(tables) do
        local charset = GetCharset(tableName, column)

        if charsetsToCollation[charset] then
            collations[tableName] = charsetsToCollation[charset]
        else
            debugprint("Unknown charset for " .. tableName, "table:", charset)
        end
    end

    return collations
end

local oxLibRequests = {}

RegisterNetEvent("__ox_cb_lb-tablet", function(requestId, ...)
    local promise = oxLibRequests[requestId]

    if not promise then
        return
    end

    oxLibRequests[requestId] = nil
    promise:resolve(...)
end)

function TriggerClientOXLibCallback(callbackName, source, ...)
    local requestId = GenerateString(15)
    local promise = promise.new()

    oxLibRequests[requestId] = promise

    TriggerClientEvent("__ox_cb_" .. callbackName, source, "lb-tablet", requestId, ...)

    SetTimeout(60000, function()
        if oxLibRequests[requestId] then
            oxLibRequests[requestId]:reject("Request timed out")
            oxLibRequests[requestId] = nil
        end
    end)

    return promise
end

local MIME_TYPES <const> = {
    Video = "video/webm",
    Image = "image/webp",
    Audio = "audio/webm;codecs=opus"
}

---@param source number
---@param uploadType "Audio" | "Image" | "Video"
---@return string | { upload: string, result: string } | nil
function GetPresignedUrl(source, uploadType)
    local apiKey = API_KEYS[uploadType]
    local uploadMethod = Config.UploadMethod[uploadType]

    if uploadMethod == "LBPresigned" then
        if GetResourceState("lb-presigned") ~= "started" then
            infoprint("error", "lb-presigned resource is not started. Please start it to use the LBPresigned upload method.")
            return
        end

        local res = exports["lb-presigned"]:GeneratePresignedUrl(MIME_TYPES[uploadType])

        return {
            upload = res.presignedUrl,
            result = res.fileUrl
        }
    elseif uploadMethod == "Qbox" then
        return Citizen.Await(promise.new(function(p)
            PerformHttpRequest("https://api.qbox.re/v1/file/presigned-url", function(status, body, headers, errorData)
                if status ~= 200 then
                    p:resolve()

                    infoprint("error", "Failed to create presigned URL using Qbox")
                    print("Status:", status)
                    print("Body:", body)
                    print("Headers:", json.encode(headers or {}, { indent = true }))

                    if errorData then
                        print("Error:", errorData)
                    end

                    return
                end

                local data = json.decode(body)

                p:resolve(data?.data?.presignedUrl)
            end, "GET", nil, {
                Accept = "application/json",
                authorization = "Bearer " .. apiKey
            })
        end))
    end

    infoprint("warning", "GetPresignedUrl has not been set up. Set it up in lb-tablet/server/custom/functions/functions.lua, or change your upload method to Fivemanage.")
end

---@param mdt string
---@param profileType "vehicle" | "player" | "property" | "weapon"
---@param id any
---@return { [string]: any }
function GetCustomFields(mdt, profileType, id)
    return {}
end

---@param source number
---@param phoneNumber string
function CanWiretapNumber(source, phoneNumber)
    return true
end
