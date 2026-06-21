--[[ =============================================================================

		Project: "Enhanced Native Driveby Animations (ENDA)" v2.1.5
		Copyright � 2020-2025 Delta District (DeltaDistrict.com)

]]-- =============================================================================

CONFIG = {
	-- Currently Available Locales (Add more or edit in ENDA.Locales.lua)
	-- AF, AR, BE, BG, BS, CS, DA, DE, EL, EN, ES, ET, FI, FR, GA, HE, HI, HR, HU, HY, ID, IS, IT, JA, KO, KU, LT, LV, MI, MK, MS, NL, NO, PL, PT, RO, SI, SK, SL, SR, SV, TA, TH, TR, UK, VE, VI, ZH, ZU
	locale = 'en',
	
	-- FRAMEWORK SETTINGS --
	framework = 'qbcore',	-- none, esx, qbcore, qbox, vrp, custom
	disableForJobs = {'police'},	


	-- VEHICLE ENTER/EXIT SETTINGS --
	vehicleCheckScript='none', 		-- none OR custom	(Script which sends client events when entering/exiting vehicles)
	-- (IF custom vehicleCheckScript, input vehicle enter and exit event names here - IGNORE if not using custom vehicle check script)
	customVehicleEnterEvent='none', -- Requires vehicle entity passed as parameter OR table which includes vehicle entity labelled ID such as {id = vehicleEntity}
	customVehicleExitEvent='none', 	-- Requires no parameters
	
	
	-- ANTI-SEAT SHUFFLE SETTINGS --
	useIntegratedAntiShuffle = true, 	-- HIGHLY RECOMMENDED to avoid issues with front passenger (If true, remove other anti-shuffle scripts)
	allowShuffleSpecific = true,		-- This lets players specify a seat index, for example "/shuffle -1" for driver seat (If it is not a standard shuffle then they will be teleported into that seat, if available)
	allowShuffleCommand = 'shuffle', 	-- Optional: Players can use /shuffle to move sideways if seat is free, use 'none' to disable command (REQUIRES useIntegratedAntiShuffle = TRUE)
	allowShuffleKeybind = 'none',		-- Default ('none') keybind to shuffle seats. Set key letter to enable, such as 'B' or 'M'
	
	-- NOTIFICATION SETTINGS --
	useDefaultTipForNotifications=true,
	
	-- TRUE: Notifies player if driveby is disabled for current vehicle or seat
	-- FALSE: Does not notify player if driveby is disabled
	displayNotificationWhenDisabled = true,
	
	
	-- AIMING SETTINGS --
	
	-- TRUE: If vehicle is not found in base game or Vehicle Override list, load the default offset
	-- FALSE: If vehicle is not found, either uses default aiming or disables aiming, depending on other config option settings
	loadDefaultWhenClipsetNotFound = true,
	
	-- ONLY the front passenger uses both hands for different vehicles, most default use left, but it seems many custom use right hand
	defaultHandForFrontPassenger = 0,	-- 0 = left hand	1 = right hand		(ONLY for: loadDefaultWhenClipsetNotFound = TRUE)
	
	-- TRUE: Allow the default gta aiming animations	
	-- FALSE: Disable the default gta aiming unless specified
	allowVanillaAiming = true,
	restrictVanillaAngle = 175.0,		-- Restrict vanilla aiming angle so players can not aim directly behind <180 (Use 0.0 to disable angle restriction)
	
	-- TRUE; Allow custom aiming for all compatible vehicles
	-- FALSE: Only allow custom aiming for specific vehicles listed in Vehicle Override List
	allowCustomAimingForAll = true,
	
	-- TRUE: Disable aiming for ALL cars that are NOT listed in Vehicle Override List
	-- FALSE: ONLY disable cars specifically listed as aiming NONE
	disableAllVehicleAiming = false, -- Overrides all other enable/disable config options
	
	-- Allow default aiming for certain vehicle classes
	allowVanillaAimingByClass = {8, 13, 14, 15, 16}, 	--(Motorcyles 8, Cycles 13, Boats 14, Helicoptors 15, Planes 16)
	
	-- Disable aiming entirely for these vehicle classes 
	disableVehicleAimingByClass = {}, 
	
	-- Allows SMGs, Rifles, and Shotguns to use one handed animations (Only animation available currently) - YOU MUST USE EDITED WEAPONS.META FILES TO ALLOW RIFLES/SHOTGUNS/SMGs -
	allowOneHandedForLongGuns = true,
	
	
	-- QUICK-SWAP SETTINGS --
	allowQuickSwap = true,			-- Command or keybind to quickly switch between current and last aimstyle
	quickSwapCommand = "swapstyle", -- Set to false or 'none' to only use keybind
	quickSwapKeybind = "L",			-- Default (L) keybind to quick swap
	
	
	
	-- DRIVER AIMING --
	-- TRUE: Allow driver to aim from vehicles
	-- FALSE: Disables driver from aiming at all 
	-- (Recommended: TRUE - Use DRIVER CONTROL RESTRICTIONS to restrict gas/steering/speed while aiming)
	allowDriverDriveby = true, 
	
	-- DRIVER CONTROL RESTRICTIONS  --	(Ignore if allowDriverDriveby = false)
	-- 0: Full vehicle controls while aiming		
	-- 1: Limit speed while aiming (Driver is limited from going over set speed if aiming)
	-- 2: Restrict aiming above set speed (Driver will automatically stop aiming if above set speed)
	restrictDriverControls = 1,
	restrictDriverAcceleration = false,	-- Vehicle acceleration disabled while driver is aiming (Requires restrictDriverControls 1 or 2)
	restrictDriverSteering = false,		-- Vehicle steering is disabled while driver is aiming (Requires restrictDriverControls 1 or 2)
	restrictDriverAimingSpeed = 0, 	-- 30 MPH		(Set to 0 to allow any speed)
	
	-- PASSENGER AIMING --
	-- TRUE: Disable aiming above set speed
	-- FALSE: Allow aiming at any speeds
	restrictPassAiming = false,
	restrictPassAimingSpeed = 33.5, 	-- 75 MPH
	
	
	
	-- CAMERA SETTINGS - GENERAL --
	
	swayCamWhileAiming = true,			-- Camera slightly sways while aiming from vehicle
	aimSwayFactorSpeed = true,			-- Adjust sway intensity depending on vehicle speed
	baseAimSwayValue = 1.3,				-- If sway enabled, this is the lowest sway value when not moving (DEFAULT: 1.3)
	shakeCamForRecoil = true,			-- Shake camera when firing a weapon from vehicle
	recoilShakeFactorSpeed = true,		-- Adjust recoil intensity depending on vehicle speed
	
	
	-- CAMERA SETTINGS - CUSTOM FIRST PERSON --
	
	useCustomFirstPersonCam = false, 	-- Recommended TRUE: The default first person camera DOES NOT WORK with custom aiming styles
	firstPersonFOV = 70.0, 				-- First person camera field-of-view when aiming
	fpLookSensitivity = {100, 50},		-- Left/Right Sensitivity, Up/Down Sensitivity
	fpSmoothTransition = false,			-- TRUE: Smooth camera transition	FALSE: Instant camera transition	(DEFAULT: FALSE)
	resetLookWhileDriving = 0,			-- 0: Does not reset look direction		1: Resets look direction for driver only	2: Resets look direction for everyone
	resetLookDelay = 500,				-- Delay time (milliseconds) that the camera is reset after no input
	
	-- 0: Does not force FP camera	 	-- 1: Force FP only while aiming
	-- 2: Force FP always for driver	-- 3: Force FP always for everyone
	forceFirstPerson = 0,
	
	
	-- CAMERA SETTINGS - CUSTOM THIRD PERSON --
	
	useCustomThirdPersonCam = false, 	-- Enables over-the-shoulder action cam while aiming
	thirdPersonFOV = 70.0,				-- Third person camera field-of-view when aiming
	tpSmoothTransition = true,			-- TRUE: Smooth camera transition	FALSE: Instant camera transition 	(DEFAULT: TRUE)
	
	-- 0: Allows players to change zoom while aiming (Default: V)	 	 
	-- 1: Force CLOSE zoom 		2: Force MID zoom 		3: Force FAR zoom
	forceZoomLevel = 0, 
	
	-- TRUE: Force custom cam while aiming (First or Third Person)
	-- FALSE: Allow aiming with default gta vehicle cameras (Unless forceFirstPerson=1)
	forceCustomCameraAiming = false,
	
	
	-- DEV TOOL - Use this to generate seat offsets for add-on vehicles (Use /edatool when enabled)
	enableDevTool = false,
}



-- TO ENABLE RIFLES/SHOTGUNS/SMGs IN VEHICLE, YOU MUST USE EDITED WEAPONS.META FILES

-- WEAPON GROUP: Determines which UI weapon category is used for animations
-- RECOIL: When shakeCamForRecoil is enabled, jolts camera depending on recoil amount
ENDA_DrivebyWeapons = {
	-- WEAPON_NAME				WEAPON GROUP,	RECOIL,	  ALLOW-DRIVER
	
	-- RichMIll Weapon Pack V3 (OX Install.lua) --
	[`WEAPON_RMBINARYDRACO`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_RM4FTARP`] = 			{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_RMDRACOPISTOL2`] = 	{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_RM78INARCS`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_RM4INCHARP3`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_RM4INCHARP2`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_RM7INCHARPCUSTOM`] = 	{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_RMG27GFLEX`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMFN57`] = 			{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG17GENCS`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMGHOSTPI`] = 			{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG34GEN4SW`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG19XSW`] = 			{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG23GEN5SW`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG19GEN4SW`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG40INCOGNITO2`] = 	{`GROUP_PISTOL`, 0.40},
	[`WEAPON_RMG17CAMOGEN5`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG17GEN3V2`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG45GEN5`] = 			{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG17GEN4CUSTOM`] = 	{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG21GEN4CUSTOM`] = 	{`GROUP_PISTOL`, 0.45},
	[`WEAPON_RMPSADAGSW2`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMG20GEN5SWITCH2`] = 	{`GROUP_PISTOL`, 0.40},
	[`WEAPON_RMG38CUSTOM`] = 		{`GROUP_PISTOL`, 0.45},
	[`WEAPON_RMG40CSTM2`] = 		{`GROUP_PISTOL`, 0.40},
	[`WEAPON_RMP89`] = 				{`GROUP_PISTOL`, 0.45},
	[`WEAPON_RMMKVPSTL`] = 			{`GROUP_PISTOL`, 0.45},
	[`WEAPON_RMSIGSAUERV1`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMSPRINGCAT`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_RMREVOLVER`] = 		{`GROUP_PISTOL`, 0.50},
	
	-- DEFAULT HANDGUNS --
	[`WEAPON_STUNGUN`] = 		{`GROUP_PISTOL`, 0.10},
	[`WEAPON_STUNGUN_MP`] = 	{`GROUP_PISTOL`, 0.10},
	[`WEAPON_FLAREGUN`] = 		{`GROUP_PISTOL`, 0.20},
	[`WEAPON_PISTOL`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_PISTOL_MK2`] = 	{`GROUP_PISTOL`, 0.35},
	[`WEAPON_PISTOLXM3`] = 		{`GROUP_PISTOL`, 0.35},
	[`WEAPON_COMBATPISTOL`] = 	{`GROUP_PISTOL`, 0.35},
	[`WEAPON_SNSPISTOL`] = 		{`GROUP_PISTOL`, 0.30},
	[`WEAPON_SNSPISTOL_MK2`] = 	{`GROUP_PISTOL`, 0.30},
	[`WEAPON_VINTAGEPISTOL`] = 	{`GROUP_PISTOL`, 0.25},
	[`WEAPON_CERAMICPISTOL`] = 	{`GROUP_PISTOL`, 0.25},
	[`WEAPON_GADGETPISTOL`] = 	{`GROUP_PISTOL`, 0.35},
	[`WEAPON_HEAVYPISTOL`] = 	{`GROUP_PISTOL`, 0.45},
	[`WEAPON_PISTOL50`] = 		{`GROUP_PISTOL`, 0.50},
	[`WEAPON_DOUBLEACTION`] = 	{`GROUP_PISTOL`, 0.30},
	[`WEAPON_REVOLVER`] = 		{`GROUP_PISTOL`, 0.50},
	[`WEAPON_REVOLVER_MK2`] = 	{`GROUP_PISTOL`, 0.50},
	[`WEAPON_NAVYREVOLVER`] = 	{`GROUP_PISTOL`, 0.50},
	[`WEAPON_APPISTOL`] = 		{`GROUP_PISTOL`, 0.35},
	
	-- DEFAULT SMGs --
	[`WEAPON_SMG`] = 			{`GROUP_SMG`,	 0.50},
	[`WEAPON_SMG_MK2`] =		{`GROUP_SMG`,	 0.50},
	[`WEAPON_ASSAULTSMG`] = 	{`GROUP_SMG`,	 0.50},
	[`WEAPON_COMBATPDW`] = 		{`GROUP_SMG`,	 0.50},
	[`WEAPON_GUSENBERG`] = 		{`GROUP_SMG`,	 0.75},
	[`WEAPON_MICROSMG`] = 		{`GROUP_PISTOL`, 0.30},
	[`WEAPON_MINISMG`] = 		{`GROUP_PISTOL`, 0.30},
	[`WEAPON_TECPISTOL`] = 		{`GROUP_PISTOL`, 0.30},
	[`WEAPON_MACHINEPISTOL`] = 	{`GROUP_PISTOL`, 0.30},
	
	-- DEFAULT SHOTGUNS --
	[`WEAPON_PUMPSHOTGUN`] = 	{`GROUP_SHOTGUN`, 1.00, false},
	[`WEAPON_PUMPSHOTGUN_MK2`]= {`GROUP_SHOTGUN`, 1.00, false},
	[`WEAPON_BULLPUPSHOTGUN`] = {`GROUP_SHOTGUN`, 1.00, false},
	[`WEAPON_COMBATSHOTGUN`] = 	{`GROUP_SHOTGUN`, 1.00, false},
	[`WEAPON_ASSAULTSHOTGUN`] = {`GROUP_SHOTGUN`, 1.20, false},
	[`WEAPON_HEAVYSHOTGUN`] = 	{`GROUP_SHOTGUN`, 1.20, false},
	[`WEAPON_AUTOSHOTGUN`] = 	{`GROUP_SHOTGUN`, 1.35, false},
	[`WEAPON_DBSHOTGUN`] = 		{`GROUP_PISTOL`,  1.35, false},
	[`WEAPON_SAWNOFFSHOTGUN`] = {`GROUP_PISTOL`,  1.35, false},
	
	-- DEFAULT RIFLES --
	[`WEAPON_ASSAULTRIFLE`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_ASSAULTRIFLE_MK2`]=	{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_CARBINERIFLE`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_CARBINERIFLE_MK2`]=	{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_SPECIALCARBINE`] = 	{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_SPECIALCARBINE_MK2`] =	{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_BULLPUPRIFLE`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_BULLPUPRIFLE_MK2`] = 	{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_BATTLERIFLE`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_HEAVYRIFLE`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_MILITARYRIFLE`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_TACTICALRIFLE`] = 		{`GROUP_RIFLE`,  0.75, false},
	[`WEAPON_COMPACTRIFLE`] = 		{`GROUP_PISTOL`, 0.75, false},
	
	-- DEFAULT THROWN --
	[`WEAPON_BALL`] = 				{`GROUP_UNARMED`, 0.0},
	[`WEAPON_SNOWBALL`] = 			{`GROUP_UNARMED`, 0.0},
	[`WEAPON_FLARE`] = 				{`GROUP_UNARMED`, 0.0},
	[`WEAPON_MOLOTOV`] = 			{`GROUP_UNARMED`, 0.0},
	[`WEAPON_BZGAS`] = 				{`GROUP_UNARMED`, 0.0},
	[`WEAPON_SMOKEGRENADE`] = 		{`GROUP_UNARMED`, 0.0},
	[`WEAPON_GRENADE`] = 			{`GROUP_UNARMED`, 0.0},
	[`WEAPON_PIPEBOMB`] = 			{`GROUP_UNARMED`, 0.0},
	[`WEAPON_STICKYBOMB`] = 		{`GROUP_UNARMED`, 0.0},
	[`WEAPON_PROXMINE`] = 			{`GROUP_UNARMED`, 0.0},
	[`WEAPON_ACIDPACKAGE`] = 		{`GROUP_UNARMED`, 0.0},
}


-- ENDA_VehicleOverrides Parameters

-- SEATS: Use devtool to generate specific seat offset code or use keywords below:
		-- NONE - Disables aiming entirely for this seat
		-- GTA - Uses standard gta interior aiming animations
		-- COPY - Copies seat offset from existing vehicle (MUST either be a base vehicle OR you must specify which vehicle to copy from) 
		-- DEFAULT - Uses the default offset for custom aiming (Only use for testing, use devtool to get specific offset code)
		-- (Seat Order: Driver, Front Passenger, Rear Passenger (behind driver), Rear Passenger (behind front passenger))
		
-- COPY: Use vehicle name `VehicleName` to copy entire layout from an existing vehicle

-- HAND: Which hand does FRONT PASSENGER aim with (left=0, Right=1) - If not specified, defaults to left handed

ENDA_VehicleOverrides = {
	[`banshee`] =	{seats={'NONE','NONE'}}, 					-- EXAMPLE: Aiming disabled using "NONE" for both seats
	[`buffalo`] =	{copy=`buffalo`},							-- EXAMPLE: Layout copied from default vehicle
	[`22gWAGON`] =	{copy=`buffalo`},
	
	[`vehicle1`] = 	{seats={'DEFAULT','DEFAULT'}}, 				-- EXAMPLE: Left Handed front passenger (2-seats)
	[`vehicle2`] = 	{seats={'DEFAULT','DEFAULT'},hand=1}, 		-- EXAMPLE: Right Handed front passenger (2-seats)
	
	[`vehicle3`] = 	{seats={'NONE','NONE','NONE','NONE'}}, 		-- EXAMPLE: All seats disabled (4-seats)
	[`vehicle4`] = 	{seats={'NONE','NONE','DEFAULT','DEFAULT'}},-- EXAMPLE: Front seats disabled, using custom aiming w/ default offset for rear (4-seats)
	
	[`baseVehicle`] = 	{seats={'GTA','GTA','COPY','COPY'}}, 					-- EXAMPLE: Front seats using default gta interior aiming, rear using custom offsets from base vehicle (Does not need copy option, since it's default)
	[`baseVehicle2`] =	{seats={'GTA','COPY','NONE','NONE'}},					-- EXAMPLE: Driver uses standard gta aiming, front passenger uses custom aiming, rear seats disabled
	[`customVehicle`] =	{seats={'GTA','GTA','COPY','COPY'}, copy=`buffalo`},	-- EXAMPLE: Front seats using default gta interior aiming, rear using custom offsets from specified base vehicle (Needs copy option, since its custom, to specify which vehicle to copy seats from)
	
	-- OPTIONAL PRESET: Disables driver and rear seats for most police vehicles
	[`fbi`] = 	{seats={'NONE','COPY','COPY','COPY'}},
	[`fbi2`] = 	{seats={'NONE','COPY','COPY','COPY'}},
	[`police`] =  {seats={'NONE','COPY','NONE','NONE'}},
	[`police2`] = {seats={'NONE','COPY','NONE','NONE'}},
	[`police3`] = {seats={'NONE','COPY','NONE','NONE'}},
	[`police4`] = {seats={'NONE','COPY','COPY','COPY'}},
	[`police5`] = {seats={'NONE','COPY','NONE','NONE'}},
	[`policet`] = {seats={'NONE','COPY','NONE','NONE'}},
	[`sheriff`] = {seats={'NONE','COPY','NONE','NONE'}},
	[`sheriff2`] = {seats={'NONE','COPY','NONE','NONE'}},
	[`policeold1`] = {seats={'NONE','COPY','NONE','NONE'}}, 				
	[`policeold2`] = {seats={'NONE','COPY','NONE','NONE'}}, 
	[`polcaracara`] = {seats={'NONE','COPY','NONE','NONE'}},
	[`polcoquette4`] = {seats={'NONE','COPY'}},
	[`poldorado`] =	 {seats={'NONE','COPY','NONE','NONE'}},	
	[`poldominator10`] = {seats={'NONE','COPY'}}, 
	[`polfaction2`] = {seats={'NONE','COPY'}},	
	[`polgauntlet`] = {seats={'NONE','COPY'}}, 					
	[`polgreenwood`] = {seats={'NONE','COPY','NONE','NONE'}}, 
	[`polimpaler5`] =  {seats={'NONE','COPY','NONE','NONE'}},		
	[`polimpaler6`] =  {seats={'NONE','COPY','NONE','NONE'}}, 
	[`polterminus`] = {seats={'NONE','NONE','NONE','NONE'}},
}
