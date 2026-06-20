-- -
--  SERVER COFFEE APP - Grim Development | Love Menu
-- -

local function CleanText(text, maxLen)
    text = tostring(text or '')
    text = text:gsub('^%s+', ''):gsub('%s+$', '')
    if maxLen and #text > maxLen then
        text = text:sub(1, maxLen)
    end
    return text
end

local function NormalizeMediaType(mediaType)
    mediaType = tostring(mediaType or 'none')
    if mediaType ~= 'image' and mediaType ~= 'video' then
        return 'none'
    end
    return mediaType
end

local function IsValidMediaUrl(url)
    url = tostring(url or '')
    if url == '' then return true end
    return url:match('^https?://') ~= nil
end

local function BuildCoffeeFeed()
    local posts = MySQL.query.await([[
        SELECT id, cid, author_name, body, media_url, media_type, created_at
        FROM grim_lm_coffee_posts
        ORDER BY created_at DESC
        LIMIT 40
    ]]) or {}

    for _, post in ipairs(posts) do
        post.comments = MySQL.query.await([[
            SELECT id, author_name, body, created_at
            FROM grim_lm_coffee_comments
            WHERE post_id=?
            ORDER BY created_at ASC
            LIMIT 20
        ]], { post.id }) or {}
    end

    return posts
end

lib.callback.register('grim_lovemenu:sv:getCoffeeFeed', function(source)
    return { posts = BuildCoffeeFeed() }
end)

lib.callback.register('grim_lovemenu:sv:createCoffeePost', function(source, payload)
    local cid = GetPlayerCID(source)
    if not cid then
        return { ok = false, error = 'Missing player id.' }
    end

    payload = payload or {}
    local body = CleanText(payload.body, 400)
    local mediaUrl = CleanText(payload.mediaUrl, 512)
    local mediaType = NormalizeMediaType(payload.mediaType)

    if body == '' then
        return { ok = false, error = 'Post text cannot be empty.' }
    end

    if mediaUrl ~= '' and not IsValidMediaUrl(mediaUrl) then
        return { ok = false, error = 'Media URL must start with http or https.' }
    end

    if mediaUrl == '' then
        mediaType = 'none'
    end

    MySQL.insert.await([[
        INSERT INTO grim_lm_coffee_posts (cid, author_name, body, media_url, media_type)
        VALUES (?, ?, ?, ?, ?)
    ]], {
        cid,
        GetCharName(source),
        body,
        mediaUrl ~= '' and mediaUrl or nil,
        mediaType,
    })

    return { ok = true, posts = BuildCoffeeFeed() }
end)

lib.callback.register('grim_lovemenu:sv:createCoffeeComment', function(source, payload)
    local cid = GetPlayerCID(source)
    if not cid then
        return { ok = false, error = 'Missing player id.' }
    end

    payload = payload or {}
    local postId = tonumber(payload.postId)
    local body = CleanText(payload.body, 250)

    if not postId then
        return { ok = false, error = 'Missing post id.' }
    end

    if body == '' then
        return { ok = false, error = 'Comment cannot be empty.' }
    end

    local exists = MySQL.single.await('SELECT id FROM grim_lm_coffee_posts WHERE id=?', { postId })
    if not exists then
        return { ok = false, error = 'That post no longer exists.' }
    end

    MySQL.insert.await([[
        INSERT INTO grim_lm_coffee_comments (post_id, cid, author_name, body)
        VALUES (?, ?, ?, ?)
    ]], {
        postId,
        cid,
        GetCharName(source),
        body,
    })

    return { ok = true, posts = BuildCoffeeFeed() }
end)
