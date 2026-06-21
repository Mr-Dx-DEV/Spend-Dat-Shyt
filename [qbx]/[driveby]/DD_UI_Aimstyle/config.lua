--[[ =============================================================================

		Project: "Delta Enhanced Aiming UI (DEA UI)" v1.0.5
		Copyright � 2020-2025 Delta District (deltadistrict.com)

]]-- =============================================================================

CONFIG = {
	-- GENERAL SETTINGS
	openUiCommand = 'aimstyle',		-- Command to open the aimstyle UI (Default: 'aimstyle' - Set to 'none' or 'NONE' for no command)
	openUiKeybind = 'G',			-- Keybind to open the aimstyle UI (Default: 'G' - Set to 'none' or 'NONE' for no keybind)
	closeOnSelect = false,			-- This will auto-close the UI when an aimstyle is selected, users will have to re-open to change multiple weapon aimstyles
	allowOnFoot = true,				-- This will allow the UI to be opened while on foot, outside vehicle
	
	-- OX_LIB SETTINGS
	useOxLib = false,				-- Uses ox_lib menu instead of custom UI
	useOxRadial = false,			-- Whether it uses ox radial menu or regular list style menu
	oxMenuPos = 'top-right',		-- Menu position for ox_lib menu (Ignore if using radial)
	oxMenuTitle = 'Driveby Style',	-- Menu title for ox_lib menu
	
	-- VISUAL SETTINGS
	uiStyle = 'radial',				-- radial, grid, list
	uiPlacement = 'middle',			-- left, right, middle ( ONLY for uiStyle = 'list' )
	useButtonImages = true,			-- buttons use images for the backgrounds
	
	uiColors = {
		default = { 
			text="white", subtext='white', border="black", 
			background="rgba(0, 0, 0, 0.35)" 
		},
		hover = { 
			text="pink", subtext='pink', border="pink", 
			background="rgba(250, 50, 50, 0.85)" 
		},
		selected = { 
			text="pink", subtext='pink', border="red", 
			background="rgba(150, 0, 0, 0.85)" 
		},
	},
	
	uiText = {
		category = {'UNARMED', 'HANDGUN', 'SHOTGUN', 'RIFLE / SMG', 'DRIVEBY'},
	
		unarmed = {"Default", "FingerGun", "Big Bird", "Slider", "No Hands", "Surrender"},
		unarmedDesc = {"Original interior bird", "Exterior point / aim", "Coming Soon"},
		
		handgun = {"Default", "One-Hand", "Two-Hand", "Sideways", "Retro", "Duel-Wield", "One-Hand Blind"},
		handgunDesc = {"Original interior aim", "Custom exterior aim", "Coming Soon"},
		
		rifle = {"Default", "One-Hand", "Two-Hand", "Hipfire", "Overhead", "Sideways", "Blindfire"},
		rifleDesc = {"Original interior aim", "Custom exterior aim", "Coming Soon"},
	}
}



--[[	PRESET UI COLOR THEMES


	-- GREEN Highlight
	
		hover = { 
			text="lightgreen", border="lightgreen", 
			background="rgba(50, 250, 50, 0.85)" 
		},
		selected = { 
			text="lightgreen", border="green", 
			background="rgba(0, 150, 0, 0.85)" 
		},



	-- BLUE Highlight

		hover = { 
			text="lightblue", border="lightblue", 
			background="rgba(50, 50, 250, 0.85)" 
		},
		selected = { 
			text="lightblue", border="blue", 
			background="rgba(0, 0, 150, 0.85)" 
		},



	-- PURPLE Highlight
	
		hover = { 
			text="plum", border="plum", 
			background="rgba(250, 50, 250, 0.85)" 
		},
		selected = { 
			text="plum", border="purple", 
			background="rgba(150, 0, 150, 0.85)" 
		},
		
		
		
	-- RED Highlight (Default)
	
		hover = { 
			text="pink", border="pink", 
			background="rgba(250, 50, 50, 0.85)" 
		},
		selected = { 
			text="pink", border="red", 
			background="rgba(150, 0, 0, 0.85)" 
		},
]]