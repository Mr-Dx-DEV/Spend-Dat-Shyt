Config.EnableInteractablePositionTool = false -- Enable interactable position tool (for development use only, should not be enabled on live server)

Config.InteractableCommand = "addpoint" -- Interactable position tool command (DEV ONLY, no permissions). Usage: /addpoint [type] (kitchen, sink, shower). Coordinates will be shown in F8

Config.HouseInteractions = {
	-- HouseInteractions:
	-- [houseId]        = house id from database
	-- cookcoords       = kitchen interaction position (vector3)
	-- sinkcoords       = sink interaction positions (multiple entries allowed)
	-- showercoords     = shower interaction positions (multiple entries allowed)

	["896541738"] = { -- house id from database
		cookcoords = {coords = vector3(-800.6628, 186.2149, 72.1054)}, -- kitchen interaction point

		sinkcoords = {
			-- coordswater = water position (effects)
			-- coordsplayer = player position when using sink
			-- heading = player rotation
			-- multiple entries allowed
			{coordswater = vector3(-804.5272, 169.0555, 76.6854), coordsplayer = vector3(-803.6295, 169.4166, 76.2403), heading = 203.0},
		},

		showercoords = {
			-- coordswater = water position (effects)
			-- coordsplayer = player position when using shower
			-- heading = player rotation
			-- multiple entries allowed
			{coordswater = vector3(-810.1580, 175.8692, 78.8095), coordsplayer = vector3(-808.6367, 176.2177, 76.2407), heading = 249.0},
		},
	},
}