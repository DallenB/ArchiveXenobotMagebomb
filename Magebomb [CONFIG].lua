



-- add sio at % to config





-- Xenobot Magebomb by anoyn
-- V11.0
-- http://forums.xenobot.net/showthread.php?30000-Magebomb-Combo-Bot-Script

--[[COMMANDS AND DETAILS AT BOTTOM OF PAGE

SETUP:    ----IMPORTANT----
1. Change CONFIG names, names and letter case must be correct

3. Look at commands on bottom of page.

]]
------------[CONFIG]-------------

LeaderName = 'LeaderChar'			--The Character you control.
McNames = {}
McNames[1] = 'Char1'			--Second in Line.
McNames[2] = 'Char2'		--Third in Line.
McNames[3] = 'Char3'		--Fourth in Line.
McNames[4] = 'Char4'
McNames[5] = 'Char5'
McNames[6] = 'Char6'
McNames[7] = 'Char7'
McNames[8] = 'Char8'
McNames[9] = 'Char9'
McNames[10] = 'Char10'

------------[Feel Free to change these]--------------

UseHud = true                -- This and Magebomb Leader.lua must be the same

-- whether mana-friend is on by default (Can be disabled/enabled in command channel 'manafriend off/on')
manaFriendRunning = true

-- Leader specific HUD Settings
function loadLeader()

--Enter the Maximum amount of supplies you carry (So the hud knows when to show green/yellow/orange supply warnings)
	MaxGMP = 150
	MaxSD = 150

	requestManaPotionAtPercent = 50 -- Default 50%  -  At this mana percent, will request to be mana'd by other MC characters
-- Note: Thats only for you, MCs number is configured in their config


	floorFollowRunning = false -- This is the default for whether MCs will automatically follow you up and down stairs
	-- It can be changed ingame also, 'floorfollow off/on'

--You shouldnt need to change dontQueueTheseCommands.
--If you spam these commands, and the script reads them all at once only the last recieved will be ran
--This avoids queing a 10 second command 5x then having to wait 50 seconds.
--Should only be the first word of a command
	dontQueueTheseCommands = { "go", "ladder", "ladder", "hurup", "hurdown", 
		"pickup", "zerg", "dd", "rr", "ll", "uu", "sewer",
		"wg", "dwg", "mw", "ue", "t", "left", "lleft", "right", "rright", 
		"ddown", "down", "rright", "right", "zerg" }

--Hotkeys
	--Hotkey to zerg
	-- and Control = zerg
	-- and Shift = zerg off
	ZergHotkey = Hotkeys.INSERT

	-- Pressing Shift + hotkey will remove
	-- Pressing Control + hotkey will add
	-- Pressing Shift + Control + hotkey will clear
	--Hotkey to change SD
	ChangeAutoSDHotkey = Hotkeys.END

	--Hotkey to change auto para
	ChangeAutoParaHotkey = Hotkeys.PAGEDOWN

	--Hotkey to change trap trigger
	ChangeTriggerHotkey = Hotkeys.PAGEUP

	--Hotkey to change trap trigger
	TempAutoSDPara = Hotkeys.DELETE

	--Hotkey to change trap trigger
	TempAutoSD = Hotkeys.HOME

end

-- All MC Specific Settings
function loadMC()
-- Generic
	WGThrowSeconds = 4   				-- This is how long the MCs will try to throw wild growth runes around enemy players. NOTE: they will not SD while they are WGing. (reccomend 3-5)
	MWThrowSeconds = 4   				-- Same as above for magic walls runes
	UESpell = "exevo gran mas frigo"   	-- the default spell for command 'ue', note you can also change this ingame by saying 'changeue spellname'
	fillManaToPercent = 90				-- Mana percent MCs will stay at while not sding/trapping etc.
--Zerg
	-- The two item IDs that they throw underneath themselves
	TrashIDOne = 3031 -- gold coin
	TrashIDTwo = 3492 -- worm

--Manafriend
	requestManaPotionAtPercent = 45 -- Default 50%  -  At this mana percent, will request to be mana'd by other MC characters
	manaPercentRequiredToPotionFriend = 70 -- Default 70%  -  The percent of mana i need to use potions on another MC client

	ManaPotionID = 238 -- (238 = GMP) This is the ID of the mana potion you use

	-- whether mana-friend is on by default (Can be disabled/enabled in command channel 'manafriend off/on')
	manaFriendRunning = true 

-- Automatic Looting of Bodies
	-- lootbodies running will be this on startup, (use lootbodies off/on to change in game)
	lootBodiesRunning = true
	-- Items to take from dead player bodies
	-- Can be item ID (no quotes), and/or item names
	-- Script will tell you if any items are spelt wrong
	itemsToTakeFromBodies = { "Crystal Coin", "boots of haste", "Pair of Soft Boots", "glacial rod", "amulet of loss", "yalahari mask", "Golden helmet", "Golden Legs", "yalahari leg piece", 
	"yalahari armor", "Magic Plate Armor", "Calopteryx Cape", "Crystalline Armor", "Divine Plate", "Ornate Chestplate", "Gill Coat", "Furious Frock", "Master Archer's Armor", 
	"Royal Draken Mail", "Skullcracker Armor", "Gill Legs", "Prismatic Legs", "Grasshopper Legs", "Ornate Legs","Gill Gugel", "Prismatic Helmet", "Depth Galea", "Elite Draken Helmet", 
	"Hat of the Mad", "Jade Hat", "Batwing Hat", "Umbral Master Chopper", "Umbral Master Axe", "Solar Axe", "Crystalline Axe", "Demonwing Axe", "Hellforged Axe", 
	"Umbral Masterblade", "Umbral Master Slayer", "Magic Longsword", "Shiny Blade", "Umbral Slayer", "The Epiphany", "Umbral Master Hammer", "Umbral Master Mace", "Hammer of Prophecy", 
	"Mycological Mace", "Dark Trinity Mace", "Umbral Mace", "Umbral Master Crossbow", "Umbral Master Bow", "Thorn Spitter", "Royal Crossbow", "Umbral Bow", "Mycological Bow",
	"Sneaky Stabber of Eliteness", "Squeezing Gear of Girlpower", "Whacking Driller of Fate" }

	-- These are IDs of dead players (female and male)
	deadPlayerIDs = { 4247, 4240, 4241 }

	--whether to mw on dead bodies that have an item in them
	mwOnDeadBodies = false

	--whether you want to trash on dead bodies 
	trashOnDeadBodies = true

--Paralyze
	paraBreakingSpells = { "exura", "exura gran", "exura vita", "utani hur", "utani gran hur", "exura ico", 
		"utani tempo hur", "utamo tempo san", "exura gran ico", "exura gran san", "exura san" } -- All spells must be in lowercase
	
	minimumManaToParalyze = 1590		-- For addpara, how much mana do they need to cast

--Floorchange
	--Rope id that you want to use
	ropeID = 3003 --(normal rope)

	--UpNonClickIDs is for the bottom of ramps,stairs
	floorUpNonClickIDs = { 855, 5257, 6911, 6909, 6913, 6915, 1947, 1954, 1950, 1952, 1954, 1956, 1958, 1961,
		1962, 1964, 1966, 5259, 5258, 6920, 4729, 4727, 6917, 1369, 17394, 1978 }

	--DownNonClickIDs is for the top of ramps,stairs, holes
	floorDownNonClickIDs = { 469, 5763, 432, 433, 434, 385, 4826, 4825,
		438, 859, 411, 413, 414, 484, 4826, 4823, 595, 600, 601, 5691, 412 }

	--UpClickIDs is for the bottom of ladders, things which are right clicked
	floorUpClickIDs = { 1948, 1968, 5542 }
	--DownClickIDs is for sewer grates, things which are right clicked
	floorDownClickIDs = { 435 }

	--UpRopeIDs are rope spots
	floorUpRopeIDs = { 386 }

--Backup
	BackupEnabled = true --whether you want the backup command to work

--General
	-- When using traps, to ensure the clients are not exhausted from using a potion
	-- potions are disabled for a few seconds. Potions only get disabled if the MCs
	-- Mana is greater than this percent. (Default 55)
	ManaPercentRequiredToDisableManas = 55
end

--Uses these ports to communicate, if one of them is being used by another program on your pc
--You can change it and the script will work as long as what you changed it to is valid
AvailablePorts = { 30124, 30125, 30126, 30127, 30128, 30129, 30130, 30131, 30132, 30133 }
AvailablePorts[0] = 30123

if Self.Name() == LeaderName then
	loadLeader()
else
	loadMC()
end

--[[
 Version History:

v1.0
 'backup' - the MCS will change the combo leader to whoever says backup IF you have followed step 2 in settings and BackupEnabled = true
 'ladder' - Script will right click your position. (do not move script delay can be up to 2 sec)
 'local' status' - says item counts in local chat
 'status' - private messages item count
 'go right/up/left/down' - will right click square to the direction you intended, then step onto it
 'hurup/hurdown u/r/l/d' - faces the direction told and hurs up/down
 'food' - throws food underneath you
 'travel CITY' - >>> hi, CITY, yes. in NPC chat
 'heal add PLAYERNAME' - Requires correct Capitilization, Player will be healed via exura sio
 'heal remove PLAYERNAME' - remove the player from being healed
 'heal clear' - removes all players from healing list, excluding MCs
 'heal' - all MCS say exura gran mas res
 'yell WORDS'
 'say WORDS'
 'outfit CREATURE'
 'outfit off' - will stop outfit
 'summon' - will summon whatever outfit they are currently as.
 'rfollow on/off' - follow goes backwards ( only useful if you can control last dancer (lead))
 '2follow on/off' - they make 2 lines of 5
 'follow on/off' - they make a large line of 10
 'd/r/l/u' - mwalls down/right/left/up of your position
 'dd/ll/rr/uu' - mwalls down/right/left/up of MC Fives Position: useful for blocking path behind you.
 'mw PLAYERNAME' - Mwalls around a player (Capitilization REQUIRED) (DWG is faster)
 'wg PLAYERNAME' - WGwalls around a player (Capitilization REQUIRED) 
 'faceup/faceright/facedown/faceup' - they change direction
 'right/left/up/down' - moves one square in direction
 'rright/lleft/uup/ddown' - moves multiple times in direction
 'fire' - MC's use firebomb runes on themselves once.

v2.0
 Automatic WG trap as soon as a specific player enters screen
 		'addtrap PLAYERNAME' Adds PLAYERNAME to the autotrap list
 		'removetrap PLAYERNAME' removes player from autotrap list
 		'autotrap on' Turns on autotrap (Basically all players on traplist will be WG permanently)
 		'autotrap off' Turns autotrap off

v3.0
 Delayed/Timed Wild Growth player trap, surrounds a player in WG runes
 		'dwg PLAYERNAME' (delayed wild growth), an improved version of 'wg' that is slightly delayed so all MC's fire at the same time instead of as soon as they recieve order
 
 Delay/Timed UE
 		'ue'  Synchronized UE default spell is: UESpell = "exevo gran mas frigo"
 		'changeue SPELLNAME'  changes the spell cast when 'ue' is ordered. 

v4.0
 Automatic Paralyze ( First MC will spam para on anyone on the list who is on screen )
 		'para add PLAYERNAME' Adds PLAYERNAME to the paralyze list
 		'para remove PLAYERNAME' removes player from the paralyze list
 		'para clear' Remove all players from the list
 		'para on'
 		'para off'

v5.0
 Dyanmic Wall trap layouts, created in Magebomb channel
 		'trap 1 add mw' Adds MW to your current position to trap 1
 		'trap 1 add wg' Adds MW to your current position to trap 1
 		'trap 1 remove' removes your current position  from trap 1
 		'trap 1 clear' Clears all positions from trap 1.

 Zerg, MCs will follow the player and trash underneath themselves, if target goes 5 squares it stops
		'Zerg PLAYERNAME'
		'Zerg off'

v6.0
 Dynamic Wall trap layouts now allow for MW and WG
 		'trap 1 add mw' Adds MW to your current position to trap 1
 		'trap 1 add wg' Adds MW to your current position to trap 1

v7.0
 MCs will now mana potion other MCs and Leader when they are low on mana
 		'manafriend off' to disable
 		'manafriend on' to enable (on by default)

 Paralyze improved, is now used by MCOne, MCTwo, MCSix, MCSeven, instantly paralyzes after target casts para-breaking spell

 Pickup GMP and SD to specific capacity
 		'pickup cap [capacity]' MCs will take GMP and SDs from underneath them. Once they have the specified capacity left they throw spares down the line. 
 		(Throw items under first MC) Ex: pickup cap 50

 Pickup a specific amount of items 
		'pickup have [amount] [item ID]' 
		MCs will take specified item id from under them until they have the specified amount. 
 		Once they have the specified amount they throw spares down the line. (Throw items under first MC) Ex: pickup cap 50

 Throw an amount of an item under leader
		'throw [Amount] [Item ID]'

 AutoSD will SD specific players on screen.
		'autosd on' to enable
		'autosd off' to disable
		'autosd add playerName' to start targeting a player
		'autosd remove playerName' to stop targeting a player
		'autosd clear' removes all previously added players.

 Added list of commands in game
 		'help' To list all commands
		'help para' to get help about a specific command

 Improved Zerg
		If the target is surrounded, MCs not adjacent to the target will 
  	follow a character who is beside the target. Will follow non-MC 
		adjacent characters before MCs 

 Improved Dynamic Wall trap layouts
		The first 10 spots added now have a designated shooter
		For this reason, it is much faster.

 Added In-Game help
 		'help' to see all help commands available'
 		'help follow', 'help trap', 'help autosd' etc.

v8.0
 Zerg will now stack more trash if a fire/energy/poison field is used on them

 Added more floor change IDs (ladders, stairs)

 MCs will now loot bodies taking item IDs/Names from itemsToTakeFromBodies in config.
 If MC does not have enough cap or bp space will throw to leader. After body is looted MC will msg leader with 
 a list of items picked up
 	lootbodies on/off 

 Added ability to trigger Dynamic Wall Traps automatically when a specific player walks on a 'trigger' square
 	trap 1 add trigger - Will add a trigger on the spot you are standing on
	trap trigger on/off - Stop/Start watching for players to stand on trigger (On by default)
	trap trigger add PLAYER - if this player steps on any trigger spots for ALL traps, the corresponding trap will activate
	trap trigger remove PLAYER - Remove previously added player

v9.0
	Magic Wall player trap, surrounds a player in MW runes
		mw - Will surround a target in magic walls
		mwhole - will surround a target in magic walls, 
			the wall closest to leader will be a Wild Growth wall.

	Frag helpers are now automatically setup when leader script is started
		It sets the Frag helper for Frag Helper 1-10, Leader Reset and All MCs.xbst
		to the names in the leader config file.
		
	SDs and/or GMPs are disabled automatically for the following commands so that the MC is not exhausted.
		- Mana potions are disabled while Trap is triggered
		- Mana potions are disabled while Magic Wall and Wild Growth traps are running
		- Mana potions and SDs are disabled for MCs who paralyze(1,2,5,6) if a paralyze target was seen recently
		Mana potions will not be disabled if the MCs percent of mana is below 'ManaPercentRequiredToDisableManas' in config
 
 	Fixed script getting stuck while MCs try to follow leader up/down floors.

v10.0
	Integrated AutoSD and Paralyze to work together
		You can now run both at the same time, if paralyzing MCs havent seen para target recently they 
		will autosd, otherwise they will paralyze.

	Added functionality to automatically target skulled players in Trap and Paralyze
		trap add skulls -- If a skulled player walks on a trigger spot, use the trap
		trap remove skulls
		para add skulls -- If a skulled player is on screen, paralyze them
		para remove skulls

	'ladder self'
		MCs will right click under themselves.

	'sewer'
		MCs will search undernearth leader for a sewer. Moving up to 5 trash items then using sewer.

v11.0
	Switched from file i/o communication to IPC. 
		Commands should have less delay now.
		HUD is updated faster now.
	
	Queing Commands
		Commands that take time to perform cannot be queued.
		Commands that are fast can.

	Merged Configs into one file.

	Fill mana during inaction
		If the MC is not doing anything it will top off its mana.
		That way when action happens it wont be fighting exhaust with the built in healer at 60% etc.

	Added hotkeys to change players in AutoSD, AutoPara and Trap Triggers.
		Insert + Control to zerg
		Insert + Shift to stop zerging

		To change AutoSD use End
		To change AutoPara use Page Down
		To change Trap Trigger use Page Up

		Shift + hotkey will remove
	 	Control + hotkey will add
		Shift + Control + hotkey will clear list

		Home will add/remove last targetted player to AutoSD

		Delete will add/remove last targeted player to AutoSD and AutoPara
		
v12.0
	Fixed .xbst loading popup asking to overwrite with old version of the script
	Script files are no longer encrypted and can be modified
	The script is now end of life and free for everyone
			
]]