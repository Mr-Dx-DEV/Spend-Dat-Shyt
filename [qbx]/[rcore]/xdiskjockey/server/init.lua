CacheMixersMusic = {}
CachePlayingMusic = {}
CachedVolumeMixer = {}
CacheMixersCategories = {}

CreateThread(function()
    for k, v in pairs(Config.MixerList) do
        CachedVolumeMixer[k] = v.defaultVolume
    end
end, "Setting default values to mixer volume cache")

MySQL.ready(function()
    MySQL.Sync.execute([[
        CREATE TABLE IF NOT EXISTS `playlist_mixer` (
            `id` INT(11) NOT NULL AUTO_INCREMENT ,
            `url` TEXT NOT NULL ,
            `name` TEXT NOT NULL ,
            `real_name` TEXT NOT NULL ,
            `time` INT(11) NOT NULL ,
            `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
            `mixer_identifier` TEXT NOT NULL ,
            `added_by` TEXT NOT NULL ,
            `category` VARCHAR(256) NOT NULL DEFAULT 'null',
            `que` tinyint(1) NOT NULL DEFAULT '0',
        PRIMARY KEY (`id`))
    ]], {})

    MySQL.Sync.execute([[
        CREATE TABLE IF NOT EXISTS `categories_mixer` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `identifier` TEXT NOT NULL,
            `category_name` VARCHAR(256) DEFAULT 'list',
            `added_by` TEXT NOT NULL,
        PRIMARY KEY (`id`))
    ]], {})

    MySQL.Async.fetchAll('SELECT * FROM playlist_mixer', {}, function(data)
        if #data ~= 0 then
            for k, v in pairs(data) do
                if not CacheMixersMusic[v.mixer_identifier] then
                    CacheMixersMusic[v.mixer_identifier] = {}
                end

                v.Volume = 0.5
                v.Loop = false
                v.Active = true
                v.Que = v.que

                v.que = nil

                table.insert(CacheMixersMusic[v.mixer_identifier], v)
            end
        end
    end)

    MySQL.Async.fetchAll('SELECT * FROM categories_mixer', {}, function(data)
        if #data ~= 0 then
            for k, v in pairs(data) do
                if not CacheMixersCategories[v.identifier] then
                    CacheMixersCategories[v.identifier] = {}
                end

                table.insert(CacheMixersCategories[v.identifier], {
                    name = v.category_name,
                })
            end
        end
    end)
end)