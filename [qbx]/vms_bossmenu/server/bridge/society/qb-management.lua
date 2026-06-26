if Config.Core ~= "QB-Core" then
    return
end

library.RegisterCallback('qb-bossmenu:server:GetEmployees', function(source, cb, jobname)
	local src = source
	local Player = SV.getPlayer(src)

	if jobname ~= Player.PlayerData.job.name then
		return
	end

	local employees = {}

	local players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%" .. jobname .. "%'", {})

	if players[1] ~= nil then
		for _, value in pairs(players) do
			local Target = Core.Functions.GetPlayerByCitizenId(value.citizenid) or Core.Functions.GetOfflinePlayerByCitizenId(value.citizenid)

			if Target and Target.PlayerData.job.name == jobname then
				local isOnline = Target.PlayerData.source
				employees[#employees + 1] = {
					empSource = Target.PlayerData.citizenid,
					grade = Target.PlayerData.job.grade,
					isboss = Target.PlayerData.job.isboss,
					name = (isOnline and '🟢 ' or '❌ ') .. Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname
				}
			end
		end
		table.sort(employees, function(a, b)
			return a.grade.level > b.grade.level
		end)
	end
	cb(employees)
end)

library.RegisterCallback('qb-gangmenu:server:GetEmployees', function(source, cb, gangname)
	local src = source
	local Player = SV.getPlayer(src)

	local employees = {}
	
	local players = MySQL.query.await("SELECT * FROM `players` WHERE `gang` LIKE '%" .. gangname .. "%'", {})

	if players[1] ~= nil then
		for _, value in pairs(players) do
			local Target = Core.Functions.GetPlayerByCitizenId(value.citizenid) or Core.Functions.GetOfflinePlayerByCitizenId(value.citizenid)
			
			if Target then
				local isOnline = Target.PlayerData.source
				employees[#employees + 1] = {
					empSource = Target.PlayerData.citizenid,
					grade = Target.PlayerData.gang.grade,
					isboss = Target.PlayerData.gang.isboss,
					name = (isOnline and '🟢 ' or '❌ ') .. Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname
				}
			end
		end
	end
	cb(employees)
end)