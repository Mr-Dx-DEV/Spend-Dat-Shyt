local function tableExists(name)
    local result = MySQL.scalar.await("SHOW TABLES LIKE ?", {name})
    return result ~= nil
end

CreateThread(function()
    if Config.AutoImportSQL then
        if not tableExists("g_multijob") then
            MySQL.query.await([[
                CREATE TABLE `g_multijob` (
                `identifier` VARCHAR(64) NOT NULL COLLATE 'utf8mb4_general_ci', 
                `job` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci', 
                `grade` INT(11) NOT NULL DEFAULT '0', 
                PRIMARY KEY (`identifier`, `job`) USING BTREE
                ) COLLATE = 'utf8mb4_general_ci' ENGINE = InnoDB;
            ]])
            print("^2[g-multijob] Created table: g_multijob^0")
        end
    end
end)
