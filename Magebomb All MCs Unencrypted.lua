
print("\n \n---------------------------")

------------[SCRIPT]-------------
----[Dont Edit anything Below]---

dofile("../scripts/Magebomb [CONFIG].lua")

if McNames == nil then
	print("Error, File 'Magebomb [CONFIG].lua' missing.")
end

versionNumber = "12.0"

DancerOne = false
DancerTwo = false
DancerThree = false
DancerFour = false
DancerFive = false

IllusionCreature = 'fire elemental'
IllusionStatus = false
FollowStatus = false
CloseFollowStatus = false
pickupRunning = false

OriginalLeaderName = LeaderName
SDRuneID = 3155
GMPID = 238
SDWeight = 0.7
GMPWeight = 3.1
ParaRuneID = 3165
WildRuneID = 3156
WildGrowthID = 2130
MagicRuneID = 3180
MagicWallID = 2129
LadderTries = 0
LastExevo = os.time()
LastPM = os.time()
MakeRunes = false
Park = false
TempLeader = false
TrapStatus = false
LastPara = os.time()
WGDelay = os.time()
BlockedPaths = 0
time = 0
PlayersOnScreen = Self.GetSpectators()
lastFetchSpectators = os.time()
sewerGrateID = 435
timeToTryFloorChange = 7
magicTrainerID = 16202

lastTrapCall = 0
delayBetweenTrapCall = 3
leaveCap = 0 -- for pickup, how much capacity should be left

--trap
whiteSkullID = 3
redSkullID = 4
blackSkullID = 5


-- Variables for zerg
zergFollow = ""
zergRunning = false
emptySpotsToTrash = 27
getInitialPosition = true
currentTrashID = TrashIDOne
elementFieldIDs = { 2118, 2122, 105 }
triggerSpots = {}
	-- 2118 fire
	-- 2122 energy
	-- 105 poison

xScreenWidth = 7
yScreenWidth = 5

-- Variables for custom magic wall traps
trap = {}
trap.triggerPlayers = {}

-- auto SD
autoSDRunning = false

-- paralyze
tempSkulledParaTargets = {}

-- Below names do not need to be changed.
SettingsAllMCs = "Anoyns Magebomb All MCs Settings"
FragReset = 'Frag Helper Leader Reset'		--These Files need to be in your xenobot/settings folder
MC1Leader = 'Frag Helper Leader 1'			--Without these being correct (and you changing the names in them)
MC2Leader = 'Frag Helper Leader 2'			--You will not be able to change the frag leader automatically in game
MC3Leader = 'Frag Helper Leader 3'
MC4Leader = 'Frag Helper Leader 4'			--this is EXTREMELY useful when people kill the leader, your magebombers
MC5Leader = 'Frag Helper Leader 5'			--will fight to the last man!
MC6Leader = 'Frag Helper Leader 6'
MC7Leader = 'Frag Helper Leader 7'	
MC8Leader = 'Frag Helper Leader 8'
MC9Leader = 'Frag Helper Leader 9'
MC10Leader= 'Frag Helper Leader 10'

SettingsSDDisabled = 'Frag Helper SD Disabled'

SettingsManaDisabled = 'Magebomb Mana Disabled'
SettingsManaEnabled = 'Anoyns Magebomb All MCs Settings'

-- Potion friend
manaRequestTimeout = 0

-- Determine if the name is an MC, if it is return their index in mcNames array
-- if it is not an MC, return nil
function checkIfNameIsAnMc( name )
	for i = 1, #McNames do
		if McNames[i] == name then
			return i
		end
	end
	return nil
end

function ResetFollows()
	if myCharacterName == McNames[1] then           --Here we find out what your character is and the order he should follow in.
		DancerOne = true
		FollowInitial = LeaderName				--This is only upon startup, if you change characters you need to restart the script.
		RFollowInitial = McNames[2]
		RFollow2 = McNames[3]
		RFollow3 = McNames[4]
		RFollow4 = McNames[5]
		RFollow5 = McNames[6]
		RFollow6 = McNames[7]
		RFollow7 = McNames[8]
		RFollow8 = McNames[9]
		RFollow9 = McNames[10]
		CFollowInitial = LeaderName
	elseif myCharacterName == McNames[2] then
		DancerTwo = true
		FollowInitial = McNames[1]
		Follow2 = LeaderName
		RFollowInitial = McNames[3]
		RFollow2 = McNames[4]
		RFollow3 = McNames[5]
		RFollow4 = McNames[6]
		RFollow5 = McNames[7]
		RFollow6 = McNames[8]
		RFollow7 = McNames[9]
		RFollow8 = McNames[10]
		CFollowInitial = McNames[1]
		CFollow2 = LeaderName
	elseif myCharacterName == McNames[3] then
		DancerThree = true
		FollowInitial = McNames[2]
		Follow2 = McNames[1]
		Follow3 = LeaderName
		RFollowInitial = McNames[4]
		RFollow2 = McNames[5]
		RFollow3 = McNames[6]
		RFollow4 = McNames[7]
		RFollow5 = McNames[8]
		RFollow6 = McNames[9]
		RFollow7 = McNames[10]
		CFollowInitial = McNames[2]
		CFollow2 = McNames[1]
		CFollow3 = LeaderName
	elseif myCharacterName == McNames[4] then
		DancerFour = true
		FollowInitial = McNames[3]
		Follow2 = McNames[2]
		Follow3 = McNames[1]
		Follow4 = LeaderName
		RFollowInitial = McNames[5]
		RFollow2 = McNames[6]
		RFollow3 = McNames[7]
		RFollow4 = McNames[8]
		RFollow5 = McNames[9]
		RFollow6 = McNames[10]
		CFollowInitial = McNames[3]
		CFollow2 = McNames[2]
		CFollow3 = McNames[1]
		CFollow4 = LeaderName
	elseif myCharacterName == McNames[5] then
		DancerFive = true
		FollowInitial = McNames[4]
		Follow2 = McNames[3]
		Follow3 = McNames[2]
		Follow4 = McNames[1]
		Follow5 = LeaderName
		RFollowInitial = McNames[6]
		RFollow2 = McNames[7]
		RFollow3 = McNames[8]
		RFollow4 = McNames[9]
		RFollow5 = McNames[10]
		CFollowInitial = McNames[4]
		CFollow2 = McNames[3]
		CFollow3 = McNames[2]
		CFollow4 = McNames[1]
		CFollow5 = LeaderName
	elseif myCharacterName == McNames[6] then
		DancerSix = true
		FollowInitial = McNames[5]
		Follow2 = McNames[4]
		Follow3 = McNames[3]
		Follow4 = McNames[2]
		Follow5 = McNames[1]
		Follow6 = LeaderName
		RFollowInitial = McNames[7]
		RFollow3 = McNames[8]
		RFollow3 = McNames[9]
		RFollow4 = McNames[10]
		CFollowInitial = LeaderName
	elseif myCharacterName == McNames[7] then
		DancerSeven = true
		FollowInitial = McNames[6]
		Follow2 = McNames[5]
		Follow3 = McNames[4]
		Follow4 = McNames[3]
		Follow5 = McNames[2]
		Follow6 = McNames[1]
		Follow7 = LeaderName
		RFollowInitial = McNames[8]
		RFollow2 = McNames[9]
		RFollow3 = McNames[10]
		CFollowInitial = McNames[6]
		CFollow2 = LeaderName
	elseif myCharacterName == McNames[8] then
		DancerEight = true
		FollowInitial = McNames[7]
		Follow2 = McNames[6]
		Follow3 = McNames[5]
		Follow4 = McNames[4]
		Follow5 = McNames[3]
		Follow6 = McNames[2]
		Follow7 = McNames[1]
		Follow8 = LeaderName
		RFollowInitial = McNames[9]
		RFollow2 = McNames[10]
		CFollowInitial = McNames[7]
		CFollow2 = McNames[6]
		CFollow3 = LeaderName
	elseif myCharacterName == McNames[9] then
		DancerNine = true
		FollowInitial = McNames[8]
		Follow2 = McNames[7]
		Follow3 = McNames[6]
		Follow4 = McNames[5]
		Follow5 = McNames[4]
		Follow6 = McNames[3]
		Follow7 = McNames[2]
		Follow8 = McNames[1]
		Follow9 = LeaderName
		RFollowInitial = McNames[10]
		CFollowInitial = McNames[8]
		CFollow2 = McNames[7]
		CFollow3 = McNames[6]
		CFollow4 = LeaderName
	elseif myCharacterName == McNames[10] then
		DancerTen = true
		FollowInitial = McNames[9]
		Follow2 = McNames[8]
		Follow3 = McNames[7]
		Follow4 = McNames[6]
		Follow5 = McNames[5]
		Follow6 = McNames[4]
		Follow7 = McNames[3]
		Follow8 = McNames[2]
		Follow9 = McNames[1]
		Follow10 = LeaderName
		CFollowInitial = McNames[9]
		CFollow2 = McNames[8]
		CFollow3 = McNames[7]
		CFollow4 = McNames[6]
		CFollow5 = LeaderName
	else
		fatalErrorMessage("Error, The player you are running this on ('"..Self.Name().."') is not a follower (McNames[1] <-> McNames[10]")
	end
end

-- If an error has caused and the script will not work, this repeats informing the user
function fatalErrorMessage( text )
	while true do
		print(text)
		wait(3000)
	end
end

myCharacterName = Self.Name()
myCharacterIndex = checkIfNameIsAnMc( myCharacterName )

if myCharacterIndex == nil then
	fatalErrorMessage("Error, The player you are running this on ('"..Self.Name().."') is not a follower (McNames[1] <-> McNames[10]")
end

PotionRequestFile = "../Scripts/MB_Communication/PotionRequests"..myCharacterIndex..".txt"
FileToRead = "../Scripts/MB_Communication/MC"..myCharacterIndex..".txt"
StatFile = "../Scripts/MB_Communication/Stat"..myCharacterIndex..".txt"

ResetFollows()

print("Anoyns Magebomb v"..versionNumber)

function createIPC()
	IPCSubscriptions = {}
	--For every client
	for index = 0, 10 do
		if index == myCharacterIndex then
			myIPC = IpcPublisherSocket.New("test-ipc-pub-socket"..index, AvailablePorts[index])
			--leave blank its my IPC
			IPCSubscriptions[index] = 0
		else
			--Create subscriber socket for everyone
			IPCSubscriptions[index] = IpcSubscriberSocket.New("test-ipc-sub-socket"..index, AvailablePorts[index] )
			IPCSubscriptions[index]:AddTopic(myCharacterIndex)
			IPCSubscriptions[index]:AddTopic("noQueue")
			IPCSubscriptions[index]:AddTopic("queue")
		end
	end
end
createIPC()

function disableManaPotions()
	if getCurrentManaPercent() >= ManaPercentRequiredToDisableManas then
		if not manaDisabled then
			manaDisabled = true
			loadSettings(SettingsManaDisabled, "Self Healer")
			print("Mana disabled")
		end
	else
		print("Mana too low to disable mana pots")
	end
end

function enableManaPotions()
	if manaDisabled then
		manaDisabled = false
		loadSettings(SettingsManaEnabled, "Self Healer")
		print("Mana enabled")
	end
end

function followPlayer( player )
	if Self.FollowID() ~= player:ID() then
		player:Follow()
	end
end

function createItemIDsToTakeFromBodies()
	itemIDsToTakeFromBodies = {}
	for f = 1, #itemsToTakeFromBodies do

		if  type(itemsToTakeFromBodies[f]) == "string" then
			local id = Item.GetID( itemsToTakeFromBodies[f] )
			if id == 0 then
				print("Error, '"..itemsToTakeFromBodies[f].."' in itemsToTakeFromBodies is not a valid item Name (Not spelled correctly or dosent exist)")
			else
				itemIDsToTakeFromBodies[#itemIDsToTakeFromBodies + 1] = id
			end
		else
			itemIDsToTakeFromBodies[#itemIDsToTakeFromBodies + 1] = itemsToTakeFromBodies[f]
		end
	end
end
createItemIDsToTakeFromBodies()

function FollowPeople(module)
	FollowID = Self.FollowID()
	if CloseFollowStatus == true then								--This function controls 2 line following, it will always follow in the order it should.
		updateSpectators()										--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if CFollowInitial == PlayersOnScreen[i]:Name() then
				if CFollowInitial == LeaderName and Park then
					Self.StopFollow()
					break
				else
					if PlayersOnScreen[i]:ID() ~= FollowID then
	        			followPlayer( PlayersOnScreen[i] )
		        		break
		        	end
		       	end
		    elseif CFollow2 ~= nil and CFollow2 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, CFollowInitial, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif CFollow3 ~= nil and CFollow3 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, CFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, CFollow2, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif CFollow4 ~= nil and CFollow4 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, CFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, CFollow2, "_name")) and not (table.contains(PlayersOnScreen, CFollow3, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif CFollow5 ~= nil and CFollow5 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, CFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, CFollow2, "_name")) and not (table.contains(PlayersOnScreen, CFollow3, "_name")) and not (table.contains(PlayersOnScreen, CFollow4, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    end
		end
	elseif RFollowStatus == true then 								--This function controls reverse 1 follows 2 ect. following, it will always follow in the order it should.
		updateSpectators()										--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if RFollowInitial == PlayersOnScreen[i]:Name() then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow2 ~= nil and RFollow2 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow3 ~= nil and RFollow3 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow4 ~= nil and RFollow4 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) and not (table.contains(PlayersOnScreen, RFollow3, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow5 ~= nil and RFollow5 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) and not (table.contains(PlayersOnScreen, RFollow3, "_name")) and not (table.contains(PlayersOnScreen, RFollow4, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow6 ~= nil and RFollow6 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) and not (table.contains(PlayersOnScreen, RFollow3, "_name")) and not (table.contains(PlayersOnScreen, RFollow4, "_name")) and not (table.contains(PlayersOnScreen, RFollow5, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow7 ~= nil and RFollow7 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) and not (table.contains(PlayersOnScreen, RFollow3, "_name")) and not (table.contains(PlayersOnScreen, RFollow4, "_name")) and not (table.contains(PlayersOnScreen, RFollow5, "_name"))  and not (table.contains(PlayersOnScreen, RFollow6, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow8 ~= nil and RFollow8 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) and not (table.contains(PlayersOnScreen, RFollow3, "_name")) and not (table.contains(PlayersOnScreen, RFollow4, "_name")) and not (table.contains(PlayersOnScreen, RFollow5, "_name"))  and not (table.contains(PlayersOnScreen, RFollow6, "_name")) and not (table.contains(PlayersOnScreen, RFollow7, "_name"))  then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow9 ~= nil and RFollow9 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) and not (table.contains(PlayersOnScreen, RFollow3, "_name")) and not (table.contains(PlayersOnScreen, RFollow4, "_name")) and not (table.contains(PlayersOnScreen, RFollow5, "_name"))  and not (table.contains(PlayersOnScreen, RFollow6, "_name")) and not (table.contains(PlayersOnScreen, RFollow7, "_name")) and not (table.contains(PlayersOnScreen, RFollow8, "_name"))  then
		        followPlayer( PlayersOnScreen[i] )
		    elseif RFollow10 ~= nil and RFollow10 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, RFollowInitial, "_name")) and not (table.contains(PlayersOnScreen, RFollow2, "_name")) and not (table.contains(PlayersOnScreen, RFollow3, "_name")) and not (table.contains(PlayersOnScreen, RFollow4, "_name")) and not (table.contains(PlayersOnScreen, RFollow5, "_name"))  and not (table.contains(PlayersOnScreen, RFollow6, "_name")) and not (table.contains(PlayersOnScreen, RFollow7, "_name")) and not (table.contains(PlayersOnScreen, RFollow8, "_name")) and not (table.contains(PlayersOnScreen, RFollow9, "_name"))   then
		        followPlayer( PlayersOnScreen[i] )
		    end
		end
	elseif FollowStatus == true and not TempLeader then					--This function controls following, it will always follow in the order it should.
		updateSpectators()										--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if FollowInitial == PlayersOnScreen[i]:Name() then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif Follow2 ~= nil and Follow2 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif Follow3 ~= nil and Follow3 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    	break
		    elseif Follow4 ~= nil and Follow4 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) and not (table.contains(PlayersOnScreen, Follow3, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    	break
		    elseif Follow5 ~= nil and Follow5 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) and not (table.contains(PlayersOnScreen, Follow3, "_name")) and not (table.contains(PlayersOnScreen, Follow4, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		    	break
		    elseif Follow6 ~= nil and Follow6 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) and not (table.contains(PlayersOnScreen, Follow3, "_name")) and not (table.contains(PlayersOnScreen, Follow4, "_name")) and not (table.contains(PlayersOnScreen, Follow5, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
				break		    
		    elseif Follow7 ~= nil and Follow7 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) and not (table.contains(PlayersOnScreen, Follow3, "_name")) and not (table.contains(PlayersOnScreen, Follow4, "_name")) and not (table.contains(PlayersOnScreen, Follow5, "_name"))  and not (table.contains(PlayersOnScreen, Follow6, "_name")) then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif Follow8 ~= nil and Follow8 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) and not (table.contains(PlayersOnScreen, Follow3, "_name")) and not (table.contains(PlayersOnScreen, Follow4, "_name")) and not (table.contains(PlayersOnScreen, Follow5, "_name"))  and not (table.contains(PlayersOnScreen, Follow6, "_name")) and not (table.contains(PlayersOnScreen, Follow7, "_name"))  then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif Follow9 ~= nil and Follow9 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) and not (table.contains(PlayersOnScreen, Follow3, "_name")) and not (table.contains(PlayersOnScreen, Follow4, "_name")) and not (table.contains(PlayersOnScreen, Follow5, "_name"))  and not (table.contains(PlayersOnScreen, Follow6, "_name")) and not (table.contains(PlayersOnScreen, Follow7, "_name")) and not (table.contains(PlayersOnScreen, Follow8, "_name"))  then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    elseif Follow10 ~= nil and Follow10 == PlayersOnScreen[i]:Name() and not (table.contains(PlayersOnScreen, FollowInitial, "_name")) and not (table.contains(PlayersOnScreen, Follow2, "_name")) and not (table.contains(PlayersOnScreen, Follow3, "_name")) and not (table.contains(PlayersOnScreen, Follow4, "_name")) and not (table.contains(PlayersOnScreen, Follow5, "_name"))  and not (table.contains(PlayersOnScreen, Follow6, "_name")) and not (table.contains(PlayersOnScreen, Follow7, "_name")) and not (table.contains(PlayersOnScreen, Follow8, "_name")) and not (table.contains(PlayersOnScreen, Follow9, "_name"))   then
		        followPlayer( PlayersOnScreen[i] )
		        break
		    end
		end
	end
	local FollowDelay = 600
	--reduce the follow delay if not following
	if( FollowID == 0 ) then
		FollowDelay = 200
	end
	module:Delay(FollowDelay) -- milliseconds to wait between checking who to follow
end

Module.New('Person to follow: ', FollowPeople)

--[[
    Auto Healer
    Version 1.02
    Created by Syntax
    [Edits made by Anoyn]
]]
local config = {								--This Controls healing friendly players, it you want to add a friend just add in
    WhiteList = {LeaderName, McNames[1], McNames[2], McNames[3], McNames[4], McNames[5], McNames[6], McNames[7], McNames[8], McNames[9], McNames[10]},     --McNames[4], "Bob"}
    healWhiteList = true, -- heal players specified in the whitelist
    
    range = 8, -- max distance to heal players
    mana = 140, -- minimum mana needed to cast
    health = 65, -- % of friend's health to heal at
    
    method = "exura sio"
}

local function sio(name)
    if(Self.Mana() >= config.mana)then
        Self.Say("exura sio \""..name)
        sleep(math.random(200,600))
    end
end

function removePlayerFromTable( tableToRemoveFrom, name )
	local wasFound = false
	if name ~= nil then
		for i = 0, #tableToRemoveFrom, 1 do
			if( name == tableToRemoveFrom[i] ) then
				print("Removing '"..tableToRemoveFrom[i].."'")
				table.remove(tableToRemoveFrom, i)
				wasFound = true
				break
			end
		end
	end
	return wasFound
end

Module.New('IPCChecker', function(IPCChecker)
	--For each IPC
	for i = 0, #IPCSubscriptions do
		if i ~= myCharacterIndex then

			local latestCommand = nil
			local hasMessage, topic, data = IPCSubscriptions[i]:Recv()
		    while (hasMessage) do
				--Check topic
		        if topic == "noQueue" then
		        	--Command from leader
		        	latestCommand = data
		        elseif topic == "queue" then
		    		commandRecieved( data )

		        elseif tonumber(topic) ~= nil and tonumber(topic) == myCharacterIndex then
		        	--Potion request
		        	potionRequested( data )
		        end
		        hasMessage, topic, data = IPCSubscriptions[i]:Recv()
		    end
		    if( latestCommand ~= nil ) then
		    	commandRecieved( latestCommand )
		    end
		end
	end
end)

autoSD = {
	BlackList = {},
	xRange = 7,
	yRange = 5
}

trapconfig = {								
    BlackList = {},     --McNames[4], "Bob"}
    range = 6, -- max distance
}

paraconfig = {								
    BlackList = {},     --McNames[4], "Bob"}
}

lastExhaustAction = 0
lastManaPotionSelf = 0
delayToUseManaPotion = 1
secondsAfterLastActionToUseMP = 6
Module.New('CheckFriend', function(Mod)					--This function checks your teammates health, if your friends health is below
	local currentTime = os.time()
	if ParaStatus then
		tempSkulledParaTargets = {}
	end

	local alreadyUsedParalyze = false
    updateSpectators()  		--60% and your health is above 80% you will heal them.
    for i = 1, #PlayersOnScreen do
        creature = PlayersOnScreen[i]
        if (creature:isValid() and creature:isOnScreen() and creature:isVisible() and creature:isAlive()) then
            local name = creature:Name()
            if (table.find(config.WhiteList, name, false) and config.healWhiteList) then
                if(creature:DistanceFromSelf() <= config.range) and (creature:HealthPercent() <= config.health)then
                    if (Self.Health()*100)/Self.MaxHealth() > 80 then
                        sio(name)
                    end
                end
            end
            if TrapStatus and table.find(trapconfig.BlackList, name, false)then
                if(creature:DistanceFromSelf() <= trapconfig.range) then
					if Self.ItemCount(WildRuneID) > 0 or DancerOne then
						updateSpectators()
						for i = 1, #PlayersOnScreen do	
							if name == PlayersOnScreen[i]:Name() then
								if currentTime - WGDelay > 10 then
									pos = PlayersOnScreen[i]:Position()
									if DancerOne and Self.ItemCount(ParaRuneID) > 0 and currentTime - LastPara > 2 then
										Self.UseItemWithCreature(ParaRuneID, PlayersOnScreen[i]:ID())
										alreadyUsedParalyze = true
										LastPara = currentTime
									end
									if Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
								    if Map.IsTileWalkable(pos.x + 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x +1, pos.y, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x +1, pos.y, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
								    if Map.IsTileWalkable(pos.x, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y - 1, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x, pos.y - 1, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
								    if Map.IsTileWalkable(pos.x, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y + 1, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x, pos.y + 1, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
									if Map.IsTileWalkable(pos.x - 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y + 1, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y + 1, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
								    if Map.IsTileWalkable(pos.x - 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y - 1, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y - 1, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
								    if Map.IsTileWalkable(pos.x + 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y + 1, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y + 1, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
								    if Map.IsTileWalkable(pos.x + 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y - 1, pos.z).id ~= WildGrowthID then
								        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y - 1, pos.z)
								    else
								    	BlockedPaths = BlockedPaths + 1
								    end
								    if BlockedPaths >= 8 then
								    	WGDelay = currentTime
								    end
								    BlockedPaths = 0
									lastExhaustAction = currentTime
								end
							end
						end
					end
                end
            end
            if ParaStatus and not alreadyUsedParalyze then 
				local playerSkull = creature:Skull()
            	if Self.ItemCount(ParaRuneID) > 0 then
            		if table.find(paraconfig.BlackList, name, false) then 
            			paralyzeTarget( creature )
                
					elseif paraTargetSkulls and (playerSkull == whiteSkullID or playerSkull == redSkullID or playerSkull == blackSkullID ) then
						paralyzeTarget( creature )
						table.insert( tempSkulledParaTargets, creature:Name() )
						
					end
				end
            end

            --autosd
            if autoSDRunning and #autoSD.BlackList > 0 then
                -- MCs who para will go here 
                if ParaStatus and currentTime - lastTimeSeeingParaTarget >= paraInactivitySecondsToEnableSD and Self.ItemCount(ParaRuneID) > 0 and table.find(autoSD.BlackList, name, false) then
                	local myPos = Self.Position()
                	local targetPos = creature:Position()
                	local xDistance = math.abs( myPos.x - targetPos.x )
                	local yDistance = math.abs( myPos.y - targetPos.y )
                	if xDistance <= autoSD.xRange and yDistance <= autoSD.yRange then
                		Self.UseItemWithCreature(SDRuneID, creature:ID())
                	end
                --Other MCs go here
                elseif not ParaStatus and table.find(autoSD.BlackList, name, false) then
                	local myPos = Self.Position()
                	local targetPos = creature:Position()
                	local xDistance = math.abs( myPos.x - targetPos.x )
                	local yDistance = math.abs( myPos.y - targetPos.y )
                	if xDistance <= autoSD.xRange and yDistance <= autoSD.yRange then
                		Self.UseItemWithCreature(SDRuneID, creature:ID())
                	end
                end
            end

            local currentTime = currentTime
            if getCurrentManaPercent() < fillManaToPercent and currentTime - lastExhaustAction > secondsAfterLastActionToUseMP and Self.ItemCount(ManaPotionID) > 0 and
            	currentTime - lastManaPotionSelf > delayToUseManaPotion then  
            	Self.UseItemWithMe(ManaPotionID)
            	lastManaPotionSelf = currentTime
            end
        end
    end
    -- reset the para toggle (they get off count if only one sees the para cancel spell)
	if DancerOne and currentTime - lastTimeSeeingParaTarget >= 5 then
		myTurnToPara = true
	elseif DancerSix and currentTime - lastTimeSeeingParaTarget >= 5 then
		myTurnToPara = false
	end
end)

forceOpenBP = true
Module.New('backPackOpener', function(backPackOpener)
	if #Container.GetAll() < 1 or forceOpenBP then
		forceOpenBP = false
 		Self.CloseContainers()
		wait(Self.Ping() + 100)
		Self.OpenMainBackpack(false)
		wait(Self.Ping() + 100)
		mainBP = Container.GetLast()
		bpsOpen = 1
	end
	backPackOpener:Delay(5000)
end)

Module.New('UtevoResIna', function(UtevoResIna)
	if IllusionStatus == true then
		if Self.CanCastSpell('exura') then
			Self.Say("Utevo res ina \""..IllusionCreature)
		elseif Self.CanCastSpell('exura') then
			Self.Say("Utevo res ina \""..IllusionCreature)
		else
			Self.Say("Utevo res ina \""..IllusionCreature)
		end
	end
	UtevoResIna:Delay(60000)
end)

Module.New('Food', function(Food)
	if Self.ItemCount(3607) > 0 or Self.ItemCount(3585) > 0 or Self.ItemCount(3601) > 0 or Self.ItemCount(3582) > 0 or 
		Self.ItemCount(3600) > 0 or Self.ItemCount(3577) > 0 or Self.ItemCount(3592) > 0 or Self.ItemCount(3725) > 0 then
	else
		if Self.CanCastSpell('exevo pan') and Self.Soul()>5 and os.time() - LastExevo > 10 and Self.Cap() > 20 then
			Self.Say('exevo pan')
			LastExevo = os.time()
		end
	end
	if MakeRunes and os.time() - LastExevo > 3 and (Self.Mana() / Self.MaxMana() * 100) > 90 and Self.Soul() > 6 then
		if Self.ItemCount(3147) < 1 then
			Self.Say('adori blank')
		elseif DancerOne then
			Self.Say("adana ani")
		else
			Self.Say('adevo grav vita')
		end
	end
	Food:Delay(10000)
end)

Module.New('manaFriend', function(manaFriend)
	if manaFriendRunning and os.time() -  manaRequestTimeout <= 2 and getCurrentManaPercent() > manaPercentRequiredToPotionFriend then
		updateSpectators( true )
		for i = 1, #PlayersOnScreen do
			if manaRequesteeName == PlayersOnScreen[i]:Name() then
				if getDistance( Self.Position(), PlayersOnScreen[i]:Position() ) == 1 then
					Self.UseItemWithCreature(ManaPotionID, PlayersOnScreen[i]:ID() )
				end
			end
		end
	end
	manaFriend:Delay(500)
end)

function paralyzeTarget( creature )
	lastTimeSeeingParaTarget = os.time()
	alreadyUsedParalyze = true
	lastExhaustAction = os.time()

	--Dont use mana on friend MC
	manaRequestTimeout = 0

	if os.time() - LastPara >= 1 and Self.Mana() > minimumManaToParalyze then
		
		--temp disable potting teammates
		if not SDDisabled then
			loadSettings(SettingsSDDisabled, "Combo Options")

			SDDisabled = true
		end


		if DancerTwo or DancerSeven then
			disableManaPotions()

			Self.UseItemWithCreature(ParaRuneID, creature:ID())
			print("Paralyzing")
			LastPara = os.time()
			enableManaPotions()
		end

	end

end

function openNextBackpack( container )
    for spot = container:ItemCount() - 1, 0, -1 do
        if Item.isContainer(container:GetItemData(spot).id) then
            container:UseItem(spot, true)
            return true
        end
    end
end

function waitForAllPositonsBeforeWave( wave )
	skipThisWave = false
	if wave > 1 then

		--waitForPositionToBeBlocked returns whether to skip waiting for this wave
		if not waitForPositionToBeBlocked( firstMWs[1], 1 ) then
			if not waitForPositionToBeBlocked( firstMWs[2], 1 ) then
				waitForPositionToBeBlocked( firstMWs[3], 1 )
			end
		end

		if wave > 2 then
			if not waitForPositionToBeBlocked( secondMWs[1], 2 ) then
				skipThisWave = waitForPositionToBeBlocked( secondMWs[2], 2 )
			end
		end
	end

end

function blockAllPositionsStartingAtWave( wave, useWG )

	if wave == 1 then
		--6,2,9,7 use this
		if DancerOne or DancerFour or DancerSeven or DancerTen then
			blockPositionWithRune( firstMWs[1] )
			blockPositionWithRune( firstMWs[2] )
			blockPositionWithRune( firstMWs[3] )

		elseif DancerTwo or DancerFive or DancerEight then
			blockPositionWithRune( firstMWs[2] )
			blockPositionWithRune( firstMWs[3] )
			blockPositionWithRune( firstMWs[1] )

		elseif DancerThree or DancerSix or DancerNine then
			blockPositionWithRune( firstMWs[3] )
			blockPositionWithRune( firstMWs[1] )
			blockPositionWithRune( firstMWs[2] )

		end

		if DancerOne or DancerThree or DancerFive or DancerSeven or DancerNine then
			blockPositionWithRune( secondMWs[1] )
			blockPositionWithRune( secondMWs[2] )
		else
			blockPositionWithRune( secondMWs[2] )
			blockPositionWithRune( secondMWs[1] )
		end

		if DancerOne or DancerFour or DancerSeven or DancerTen then
			blockPositionWithRune( thirdMWs[1] )
			blockPositionWithRune( thirdMWs[2] )
			blockPositionWithRune( thirdMWs[3], useWG )

		elseif DancerTwo or DancerFive or DancerEight then
			blockPositionWithRune( thirdMWs[2] )
			blockPositionWithRune( thirdMWs[3], useWG )
			blockPositionWithRune( thirdMWs[1] )

		elseif DancerThree or DancerSix or DancerNine then
			blockPositionWithRune( thirdMWs[3], useWG )
			blockPositionWithRune( thirdMWs[1] )
			blockPositionWithRune( thirdMWs[2] )
		end


	elseif wave == 2 then
		if DancerOne or DancerThree or DancerFive or DancerSeven or DancerNine then
			blockPositionWithRune( secondMWs[1] )
			blockPositionWithRune( secondMWs[2] )
		else
			blockPositionWithRune( secondMWs[2] )
			blockPositionWithRune( secondMWs[1] )
		end

		if DancerOne or DancerFour or DancerSeven or DancerTen then
			blockPositionWithRune( thirdMWs[1] )
			blockPositionWithRune( thirdMWs[2] )
			blockPositionWithRune( thirdMWs[3], useWG )

		elseif DancerTwo or DancerFive or DancerEight then
			blockPositionWithRune( thirdMWs[2] )
			blockPositionWithRune( thirdMWs[3], useWG )
			blockPositionWithRune( thirdMWs[1] )

		elseif DancerThree or DancerSix or DancerNine then
			blockPositionWithRune( thirdMWs[3], useWG )
			blockPositionWithRune( thirdMWs[1] )
			blockPositionWithRune( thirdMWs[2] )
		end


	elseif wave == 3 then
		if DancerOne or DancerFour or DancerSeven or DancerTen then
			blockPositionWithRune( thirdMWs[1] )
			blockPositionWithRune( thirdMWs[2] )
			blockPositionWithRune( thirdMWs[3], useWG )

		elseif DancerTwo or DancerFive or DancerEight then
			blockPositionWithRune( thirdMWs[2] )
			blockPositionWithRune( thirdMWs[3], useWG )
			blockPositionWithRune( thirdMWs[1] )

		elseif DancerThree or DancerSix or DancerNine then
			blockPositionWithRune( thirdMWs[3], useWG )
			blockPositionWithRune( thirdMWs[1] )
			blockPositionWithRune( thirdMWs[2] )
		end
	end

end

function checkIfWaveStarted( wave )
	local z = Self.Position().z
	if wave == 2 then
		if MagicWallID == Map.GetTopUseItem(secondMWs[1].x, secondMWs[1].y, z).id then
			return true
		end

		if MagicWallID == Map.GetTopUseItem(secondMWs[2].x, secondMWs[2].y, z).id then	
			return true
		end

	elseif wave == 3 then
		if MagicWallID == Map.GetTopUseItem(thirdMWs[1].x, thirdMWs[1].y, z).id then
			return true
		end

		if MagicWallID == Map.GetTopUseItem(thirdMWs[2].x, thirdMWs[2].y, z).id then
			return true
		end

		if WildGrowthID == Map.GetTopUseItem(thirdMWs[3].x, thirdMWs[3].y, z).id then
			return true
		end
	else
		print("unexpected checkIfWaveStarted Error.")
	end
end

function waitForPositionToBeBlocked( pos, wave )
	pos.z = Self.Position().z

	local itemID = Map.GetTopUseItem(pos.x, pos.y, pos.z).id

	while (itemID == 0 or Map.IsTileWalkable(pos.x, pos.y, pos.z) ) and (os.time()-StartTime)<WGThrowSeconds and itemID ~= WildGrowthID do
		itemID = Map.GetTopUseItem(pos.x, pos.y, pos.z).id

		if itemID == 0 then
			print("The square is offscreen, enable checking for next way")
			if checkIfWaveStarted( wave + 1 ) then
				print("The part is offscreen, but second/third got mwed. so skipping offscreen.")
				return true
			end
		end
    end
    return false
end

function blockPositionWithRune( pos, useWG )
	local desiredID
	local itemIDToUse

	pos.z = Self.Position().z

	if useWG then
		desiredID = WildGrowthID
		itemIDToUse = WildRuneID
	else
		desiredID = MagicWallID
		itemIDToUse = MagicRuneID
	end

	local itemID = Map.GetTopUseItem(pos.x, pos.y, pos.z).id
	while (itemID == 0 or Map.IsTileWalkable(pos.x, pos.y, pos.z)) and (os.time()-StartTime)<WGThrowSeconds and itemID ~= WildGrowthID do
   		Self.UseItemWithGround(itemIDToUse, pos.x, pos.y, pos.z)
		itemID = Map.GetTopUseItem(pos.x, pos.y, pos.z).id
    end
end

function stopFollowModules()
	zergRunning = false
	RFollowStatus = false
	FollowStatus = false
	CloseFollowStatus = false
end

lootBodiesPickupTries = 0
lootBodiesPickupTriesBeforeThrowing = 4
Module.New('lootBodies', function(lootBodies)
	local myPos = Self.Position()
	if lootBodiesRunning and #itemIDsToTakeFromBodies > 0 then
		for x = -1, 1 do
			for y = -1, 1 do
				local floorID = Map.GetTopUseItem( myPos.x + x, myPos.y + y, myPos.z )
				if table.find( deadPlayerIDs, floorID.id ) then
					if bodyContainer == nil or not bodyContainer:isOpen() then
						Self.UseItemFromGround( myPos.x + x, myPos.y + y, myPos.z )

						if trashOnDeadBodies then
			        		local haveSecondIDTrash = Self.ItemCount(TrashIDTwo) > 0
							if( currentTrashID == TrashIDTwo and haveSecondIDTrash ) then
								Self.FastDropItem( myPos.x + x, myPos.y + y, myPos.z, currentTrashID, 1)
								currentTrashID = TrashIDOne
							else
								Self.FastDropItem( myPos.x + x, myPos.y + y, myPos.z, currentTrashID, 1)
								currentTrashID = TrashIDTwo
							end
						end

						wait(250)

						for i = 0, #Container.GetIndexes() - 1 do
					        local c = Container.GetFromIndex(i)
				      		if c:isOpen() and c:Name():find("Dead") then
				      			print("Body open")
				        		bodyContainer = c

				        		if mwOnDeadBodies and bodyContainer:ItemCount() > 0 then
				        			Self.UseItemWithGround(MagicRuneID, myPos.x + x, myPos.y + y, myPos.z)
				        		end
				        		
								bpsOpen = 2
								break
				        	end
					    end
					end
				end

				if bodyContainer ~= nil and bodyContainer:isOpen() then
		        	--check for loot
		        	nothingFound = true
		        	for s = 0, bodyContainer:ItemCount() - 1 do
		        		local item = bodyContainer:GetItemData(s)
		        		if table.find( itemIDsToTakeFromBodies, item.id ) then

		        			if lootBodiesPickupTries >= lootBodiesPickupTriesBeforeThrowing then
		        				lootBodiesPickupTries = 0
		        				--throw to leader, cant pickup

		        				updateSpectators()
								for i = 1, #PlayersOnScreen do 							
									if LeaderName == PlayersOnScreen[i]:Name() then
										throwPos = PlayersOnScreen[i]:Position()
			        					Self.PrivateMessage(LeaderName, "Catch! Throwing "..Item.GetName(item.id).." under you!")
									end
								end

		        				bodyContainer:MoveItemToGround( s, throwPos.x, throwPos.y, throwPos.z, 100)
		        				



		        			else
			        			local beforeCount = countAmountOfItemInMainBP( item.id )
			        			bodyContainer:MoveItemToContainer( s, mainBP:Index(), math.min( mainBP:ItemCount() + 1), mainBP:ItemCapacity() - 1 )
			        			wait(250)
			        			local afterCount = countAmountOfItemInMainBP( item.id )
			        			nothingFound = false

			        			if afterCount > beforeCount then
			        				if not itemsTaken then
			        					lootMessage = Item.GetName(item.id)
			        				else
			        					lootMessage = lootMessage..", "..Item.GetName(item.id)
			        				end

			        				itemsTaken = true
			        				lootBodiesPickupTries = 0
			        			else
			        				lootBodiesPickupTries = lootBodiesPickupTries + 1
			        			end

			        		end
			        		break
		        		end
		        	end

		        	if nothingFound then
			        	if not openNextBackpack( bodyContainer ) then
			        		bodyContainer:Close()
						    bpsOpen = 1
						    
			        		-- if Self.ItemCount(TrashIDTwo) > 0 then
			        		-- 	Self.FastDropItem( myPos.x + x, myPos.y + y, myPos.z, TrashIDTwo, 1)
			        		-- elseif Self.ItemCount(TrashIDOne) > 0 then
			        		-- 	Self.FastDropItem( myPos.x + x, myPos.y + y, myPos.z, TrashIDOne, 1)
			        		-- end

			        		if itemsTaken then
			        			Self.PrivateMessage(LeaderName, "Looted "..lootMessage.." from player.")
			        		end
			        		itemsTaken = false

			        	end
			        end

				end
			end
		end
	end
	lootBodies:Delay(400)
end)

function countAmountOfItemInMainBP( itemID )
	local amount = 0

	if mainBP ~= nil and mainBP:isOpen() then
		for q = 0, mainBP:ItemCount() - 1 do
			local beforeitem = mainBP:GetItemData(q)
			if beforeitem.id == itemID then
				amount = amount + beforeitem.count
			end
		end
		return amount

	else
		return 0
	end
end

function getCurrentManaPercent()
	return math.floor(( Self.Mana() * 100 ) / Self.MaxMana())
end

function dynamicWallTrap( trap_number )
	if trap_number ~= nil then
		if trap[trap_number] ~= nil then
			-- loop from 0 to total size of trap positions
			local amountOfTrapPositions = trap[trap_number][0]
			StartTime = os.time()
			
			if amountOfTrapPositions > 0 then
				disableManaPotions()

				-- If we only have one location to throw, skip choosing a row.
				if amountOfTrapPositions > 1 then	
								
					-- Throw initial spots, do not check if taken since only throw once

					if trap[trap_number][myCharacterIndex] ~= nil then
						local FloorID = Map.GetTopUseItem(trap[trap_number][myCharacterIndex][0], trap[trap_number][myCharacterIndex][1], trap[trap_number][myCharacterIndex][2] ).id
						if FloorID ~= MagicWallID and FloorID ~= WildGrowthID and FloorID ~= 0 then
							Self.UseItemWithGround(trap[trap_number][myCharacterIndex][3], trap[trap_number][myCharacterIndex][0], trap[trap_number][myCharacterIndex][1], trap[trap_number][myCharacterIndex][2])
						end
					end
				end
				-- Continue throwing
				while os.time() - StartTime < 3 do
					for trap_position = 1, amountOfTrapPositions do
						if trap[trap_number][trap_position] ~= nil then
							local FloorID = Map.GetTopUseItem(trap[trap_number][trap_position][0], trap[trap_number][trap_position][1], trap[trap_number][trap_position][2] ).id
							if FloorID ~= MagicWallID and FloorID ~= WildGrowthID and FloorID ~= 0 then
								Self.UseItemWithGround(trap[trap_number][trap_position][3], trap[trap_number][trap_position][0], trap[trap_number][trap_position][1], trap[trap_number][trap_position][2])
							end
						end
					end
				end
				enableManaPotions()	
			end
		end
	end
end

function commandRecieved( text )
	local message = string.lower(text)
	local setting_cmd = string.match(text, "(%a+)")
	local setting_value = string.sub(text, 5)

	if setting_cmd == 'wg' then
		setting_value = string.sub(text, 4)
		updateSpectators()
		for i = 1, #PlayersOnScreen do	
			if setting_value == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				StartTime = os.time()
				if DancerOne then
					if Self.ItemCount(ParaRuneID) > 0 then
						Self.UseItemWithCreature(ParaRuneID, PlayersOnScreen[i]:ID())
					else
						while Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds do
				       		Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y, pos.z)
				    	end
					end
				elseif DancerTen then
					while Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y, pos.z)
				    end
				elseif DancerSix or DancerFive then
					while Map.IsTileWalkable(pos.x + 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x +1, pos.y, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y, pos.z)
				    end
				elseif DancerTwo then
					while Map.IsTileWalkable(pos.x, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y - 1, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x, pos.y - 1, pos.z)
				    end
				elseif DancerThree then
					while Map.IsTileWalkable(pos.x, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y + 1, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x, pos.y + 1, pos.z)
				    end
				elseif DancerFour then
					while Map.IsTileWalkable(pos.x - 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y + 1, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y + 1, pos.z)
				    end
				elseif DancerSeven then
					while Map.IsTileWalkable(pos.x - 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y - 1, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y - 1, pos.z)
				    end
				elseif DancerEight then
					while Map.IsTileWalkable(pos.x + 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y + 1, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y + 1, pos.z)
				    end
				elseif DancerNine then
					while Map.IsTileWalkable(pos.x + 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y - 1, pos.z).id ~= WildGrowthID and (os.time()-StartTime)<WGThrowSeconds  do
				        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y - 1, pos.z)
				    end 
				end
				while ((os.time()-StartTime)<WGThrowSeconds) do
					pos = PlayersOnScreen[i]:Position()
					if Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y, pos.z)
				    end
				    if Map.IsTileWalkable(pos.x + 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x +1, pos.y, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x +1, pos.y, pos.z)
				    end
				    if Map.IsTileWalkable(pos.x, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y - 1, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x, pos.y - 1, pos.z)
				    end
				    if Map.IsTileWalkable(pos.x, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y + 1, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x, pos.y + 1, pos.z)
				    end
					if Map.IsTileWalkable(pos.x - 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y + 1, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y + 1, pos.z)
				    end
				    if Map.IsTileWalkable(pos.x - 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y - 1, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y - 1, pos.z)
				    end
				    if Map.IsTileWalkable(pos.x + 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y + 1, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y + 1, pos.z)
				    end
				    if Map.IsTileWalkable(pos.x + 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y - 1, pos.z).id ~= WildGrowthID then
				        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y - 1, pos.z)
				    end 
				end
			end
		end
	elseif setting_cmd == 'mwhole' then
		local ShortText = string.sub(text, 8)
		local setting_value = string.match(ShortText, '([%a -]*)')
		local wgSpot = string.match(ShortText, '[%a -]*/[%d.]*/([%a]*)')

		local time = string.match(ShortText, '%d+')
		-- this will trigger if someone said "dwg name" 
		-- but wasnt running the leader scipt so no time was appended (crash script)
		if time ~= nil and setting_value ~= nil and wgSpot ~= nil then
			time = tonumber(time)
			updateSpectators( true )
			for i = 1, #PlayersOnScreen do	
				if setting_value == PlayersOnScreen[i]:Name() then
					disableManaPotions()
					while os.time() < time do
						wait(10)
					end
					local pos = PlayersOnScreen[i]:Position()
					StartTime = os.time()


					firstMWs = {}
					secondMWs = {}
					thirdMWs = {}

					firstMWs[1] = {}
					firstMWs[2] = {}
					firstMWs[3] = {}
					secondMWs[1] = {}
					secondMWs[2] = {}
					thirdMWs[1] = {}
					thirdMWs[2] = {}
					thirdMWs[3] = {}

					local foundDirection
					if wgSpot == "up" then
						foundDirection = true

						firstMWs[1].x = pos.x - 1
						firstMWs[1].y = pos.y + 1
						
						firstMWs[2].x = pos.x
						firstMWs[2].y = pos.y + 1
						
						firstMWs[3].x = pos.x + 1
						firstMWs[3].y = pos.y + 1

						-------------------
						secondMWs[1].x = pos.x - 1
						secondMWs[1].y = pos.y
						
						secondMWs[2].x = pos.x + 1
						secondMWs[2].y = pos.y

						--------------------
						thirdMWs[1].x = pos.x - 1
						thirdMWs[1].y = pos.y - 1
						
						thirdMWs[2].x = pos.x + 1
						thirdMWs[2].y = pos.y - 1
						
						thirdMWs[3].x = pos.x
						thirdMWs[3].y = pos.y - 1

					elseif wgSpot == "left" then
						foundDirection = true

						firstMWs[1].x = pos.x + 1
						firstMWs[1].y = pos.y - 1
						
						firstMWs[2].x = pos.x + 1
						firstMWs[2].y = pos.y
						
						firstMWs[3].x = pos.x + 1
						firstMWs[3].y = pos.y + 1

						-------------------
						secondMWs[1].x = pos.x
						secondMWs[1].y = pos.y - 1
						
						secondMWs[2].x = pos.x
						secondMWs[2].y = pos.y + 1

						--------------------
						thirdMWs[1].x = pos.x - 1
						thirdMWs[1].y = pos.y - 1
						
						thirdMWs[2].x = pos.x - 1
						thirdMWs[2].y = pos.y + 1
						
						thirdMWs[3].x = pos.x - 1
						thirdMWs[3].y = pos.y
					elseif wgSpot == "right" then
						foundDirection = true

						firstMWs[1].x = pos.x - 1
						firstMWs[1].y = pos.y - 1
						
						firstMWs[2].x = pos.x - 1
						firstMWs[2].y = pos.y
						
						firstMWs[3].x = pos.x - 1
						firstMWs[3].y = pos.y + 1

						-------------------
						secondMWs[1].x = pos.x
						secondMWs[1].y = pos.y - 1
						
						secondMWs[2].x = pos.x
						secondMWs[2].y = pos.y + 1

						--------------------
						thirdMWs[1].x = pos.x + 1
						thirdMWs[1].y = pos.y - 1
						
						thirdMWs[2].x = pos.x + 1
						thirdMWs[2].y = pos.y + 1
						
						thirdMWs[3].x = pos.x + 1
						thirdMWs[3].y = pos.y

					elseif wgSpot == "down" then
						foundDirection = true

						firstMWs[1].x = pos.x - 1
						firstMWs[1].y = pos.y - 1
						
						firstMWs[2].x = pos.x
						firstMWs[2].y = pos.y - 1
						
						firstMWs[3].x = pos.x + 1
						firstMWs[3].y = pos.y - 1

						-------------------
						secondMWs[1].x = pos.x - 1
						secondMWs[1].y = pos.y
						
						secondMWs[2].x = pos.x + 1
						secondMWs[2].y = pos.y

						--------------------
						thirdMWs[1].x = pos.x - 1
						thirdMWs[1].y = pos.y + 1
						
						thirdMWs[2].x = pos.x + 1
						thirdMWs[2].y = pos.y + 1
						
						thirdMWs[3].x = pos.x
						thirdMWs[3].y = pos.y + 1
						
					else
						print("No wg spot")
					end

					if foundDirection then
						if DancerOne and Self.ItemCount(ParaRuneID) > 0 then
							Self.UseItemWithCreature(ParaRuneID, PlayersOnScreen[i]:ID())
						--,,,,,,9
						elseif DancerSix then
							blockPositionWithRune( firstMWs[1] )
							blockAllPositionsStartingAtWave( 1, true )

						elseif DancerTwo or DancerNine then
							blockPositionWithRune( firstMWs[2] )
							blockAllPositionsStartingAtWave( 1, true )

						elseif DancerSeven then
							blockPositionWithRune( firstMWs[3] )
							blockAllPositionsStartingAtWave( 1, true )

						elseif DancerEight then
							waitForAllPositonsBeforeWave( 2 )
							blockPositionWithRune( secondMWs[1] )
							blockAllPositionsStartingAtWave( 2, true )

						elseif DancerThree then
							waitForAllPositonsBeforeWave( 2 )
							blockPositionWithRune( secondMWs[2] )
							blockAllPositionsStartingAtWave( 2, true )

						elseif DancerFour then
							waitForAllPositonsBeforeWave( 3 )
							blockPositionWithRune( thirdMWs[1] )
							blockAllPositionsStartingAtWave( 3, true )

						elseif DancerFive then
							waitForAllPositonsBeforeWave( 3 )
							blockPositionWithRune( thirdMWs[3], true )
							blockAllPositionsStartingAtWave( 3, true )

						elseif DancerTen then
							waitForAllPositonsBeforeWave( 3 )
							blockPositionWithRune( thirdMWs[2] )
							blockAllPositionsStartingAtWave( 3, true )
						end

					end

					enableManaPotions()
				end
			end
		end

	elseif setting_cmd == 'mw' then
		local ShortText = string.sub(text, 4)
		local setting_value = string.match(ShortText, '([%a -]*)')
		local wgSpot = string.match(ShortText, '[%a -]*/[%d.]*/([%a]*)')

		local time = string.match(ShortText, '%d+')
		-- this will trigger if someone said "dwg name" 
		-- but wasnt running the leader scipt so no time was appended (crash script)
		if time ~= nil and setting_value ~= nil and wgSpot ~= nil then
			time = tonumber(time)
			--print("setting command = dwg\nPlayer Name = "..setting_value.."\nTime = "..time)
			updateSpectators( true )
			for i = 1, #PlayersOnScreen do	
				if setting_value == PlayersOnScreen[i]:Name() then
					disableManaPotions()
					while os.time() < time do
						wait(10)
					end
					local pos = PlayersOnScreen[i]:Position()
					StartTime = os.time()


					firstMWs = {}
					secondMWs = {}
					thirdMWs = {}

					firstMWs[1] = {}
					firstMWs[2] = {}
					firstMWs[3] = {}
					secondMWs[1] = {}
					secondMWs[2] = {}
					thirdMWs[1] = {}
					thirdMWs[2] = {}
					thirdMWs[3] = {}

					local foundDirection
					if wgSpot == "up" then
						foundDirection = true

						firstMWs[1].x = pos.x - 1
						firstMWs[1].y = pos.y + 1
						
						firstMWs[2].x = pos.x
						firstMWs[2].y = pos.y + 1
						
						firstMWs[3].x = pos.x + 1
						firstMWs[3].y = pos.y + 1

						-------------------
						secondMWs[1].x = pos.x - 1
						secondMWs[1].y = pos.y
						
						secondMWs[2].x = pos.x + 1
						secondMWs[2].y = pos.y

						--------------------
						thirdMWs[1].x = pos.x - 1
						thirdMWs[1].y = pos.y - 1
						
						thirdMWs[2].x = pos.x + 1
						thirdMWs[2].y = pos.y - 1
						
						thirdMWs[3].x = pos.x
						thirdMWs[3].y = pos.y - 1

					elseif wgSpot == "left" then
						foundDirection = true

						firstMWs[1].x = pos.x + 1
						firstMWs[1].y = pos.y - 1
						
						firstMWs[2].x = pos.x + 1
						firstMWs[2].y = pos.y
						
						firstMWs[3].x = pos.x + 1
						firstMWs[3].y = pos.y + 1

						-------------------
						secondMWs[1].x = pos.x
						secondMWs[1].y = pos.y - 1
						
						secondMWs[2].x = pos.x
						secondMWs[2].y = pos.y + 1

						--------------------
						thirdMWs[1].x = pos.x - 1
						thirdMWs[1].y = pos.y - 1
						
						thirdMWs[2].x = pos.x - 1
						thirdMWs[2].y = pos.y + 1
						
						thirdMWs[3].x = pos.x - 1
						thirdMWs[3].y = pos.y
					elseif wgSpot == "right" then
						foundDirection = true

						firstMWs[1].x = pos.x - 1
						firstMWs[1].y = pos.y - 1
						
						firstMWs[2].x = pos.x - 1
						firstMWs[2].y = pos.y
						
						firstMWs[3].x = pos.x - 1
						firstMWs[3].y = pos.y + 1

						-------------------
						secondMWs[1].x = pos.x
						secondMWs[1].y = pos.y - 1
						
						secondMWs[2].x = pos.x
						secondMWs[2].y = pos.y + 1

						--------------------
						thirdMWs[1].x = pos.x + 1
						thirdMWs[1].y = pos.y - 1
						
						thirdMWs[2].x = pos.x + 1
						thirdMWs[2].y = pos.y + 1
						
						thirdMWs[3].x = pos.x + 1
						thirdMWs[3].y = pos.y

					elseif wgSpot == "down" then
						foundDirection = true

						firstMWs[1].x = pos.x - 1
						firstMWs[1].y = pos.y - 1
						
						firstMWs[2].x = pos.x
						firstMWs[2].y = pos.y - 1
						
						firstMWs[3].x = pos.x + 1
						firstMWs[3].y = pos.y - 1

						-------------------
						secondMWs[1].x = pos.x - 1
						secondMWs[1].y = pos.y
						
						secondMWs[2].x = pos.x + 1
						secondMWs[2].y = pos.y

						--------------------
						thirdMWs[1].x = pos.x - 1
						thirdMWs[1].y = pos.y + 1
						
						thirdMWs[2].x = pos.x + 1
						thirdMWs[2].y = pos.y + 1
						
						thirdMWs[3].x = pos.x
						thirdMWs[3].y = pos.y + 1
						
					else
						print("No wg spot")
					end

					if foundDirection then
						if DancerOne and Self.ItemCount(ParaRuneID) > 0 then
							Self.UseItemWithCreature(ParaRuneID, PlayersOnScreen[i]:ID())

						elseif DancerSix then
							blockPositionWithRune( firstMWs[1] )
							blockAllPositionsStartingAtWave( 1 )

						elseif DancerTwo or DancerNine then
							blockPositionWithRune( firstMWs[2] )
							blockAllPositionsStartingAtWave( 1 )

						elseif DancerSeven then
							blockPositionWithRune( firstMWs[3] )
							blockAllPositionsStartingAtWave( 1 )

						elseif DancerEight then
							waitForAllPositonsBeforeWave( 2 )
							blockPositionWithRune( secondMWs[1] )
							blockAllPositionsStartingAtWave( 2 )

						elseif DancerThree then
							waitForAllPositonsBeforeWave( 2 )
							blockPositionWithRune( secondMWs[2] )
							blockAllPositionsStartingAtWave( 2 )

						elseif DancerFour then
							waitForAllPositonsBeforeWave( 3 )
							blockPositionWithRune( thirdMWs[1] )
							blockAllPositionsStartingAtWave( 3 )

						elseif DancerFive then
							waitForAllPositonsBeforeWave( 3 )
							blockPositionWithRune( thirdMWs[3] )
							blockAllPositionsStartingAtWave( 3 )

						elseif DancerTen then
							waitForAllPositonsBeforeWave( 3 )
							blockPositionWithRune( thirdMWs[2] )
							blockAllPositionsStartingAtWave( 3 )
						end

					end

					enableManaPotions()
				end
			end
		end

	elseif setting_cmd == 'dwg' then
		local ShortText = string.sub(text, 5)
		local setting_value = string.match(ShortText, "([%a '-]*)")

		local time = string.match(ShortText, '%d+')
		-- this will trigger if someone said "dwg name" 
		-- but wasnt running the leader scipt so no time was appended (crash script)
		if time ~= nil and setting_value ~= nil then
			time = tonumber(time)
			updateSpectators( true )
			for i = 1, #PlayersOnScreen do	
				if setting_value == PlayersOnScreen[i]:Name() then
					disableManaPotions()
					while os.time() < time do
						wait(10)
					end
					pos = PlayersOnScreen[i]:Position()
					StartTime = os.time()
					if DancerOne then
						if Self.ItemCount(ParaRuneID) > 0 then
							Self.UseItemWithCreature(ParaRuneID, PlayersOnScreen[i]:ID())
						else
							local itemID = Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id
							while Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					       		Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y, pos.z)
								itemID = Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id
					    	end
						end
					elseif DancerTen then
						local itemID = Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id
						while Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
							print("THROWING, "..itemID)
					        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y, pos.z)
							itemID = Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id
					    end
					elseif DancerSix or DancerFive then
						local itemID = Map.GetTopUseItem(pos.x +1, pos.y, pos.z).id
						while Map.IsTileWalkable(pos.x + 1, pos.y, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y, pos.z)
							itemID = Map.GetTopUseItem(pos.x +1, pos.y, pos.z).id
					    end
					elseif DancerTwo then
						local itemID = Map.GetTopUseItem(pos.x, pos.y - 1, pos.z).id
						while Map.IsTileWalkable(pos.x, pos.y - 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					        Self.UseItemWithGround(WildRuneID, pos.x, pos.y - 1, pos.z)
					       	itemID = Map.GetTopUseItem(pos.x, pos.y - 1, pos.z).id
					    end
					elseif DancerThree then
						local itemID = Map.GetTopUseItem(pos.x, pos.y + 1, pos.z).id
						while Map.IsTileWalkable(pos.x, pos.y + 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					        Self.UseItemWithGround(WildRuneID, pos.x, pos.y + 1, pos.z)
					        itemID = Map.GetTopUseItem(pos.x, pos.y + 1, pos.z).id
					    end
					elseif DancerFour then
						local itemID = Map.GetTopUseItem(pos.x - 1, pos.y + 1, pos.z).id
						while Map.IsTileWalkable(pos.x - 1, pos.y + 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y + 1, pos.z)
					        itemID = Map.GetTopUseItem(pos.x - 1, pos.y + 1, pos.z).id
					    end
					elseif DancerSeven then
						local itemID = Map.GetTopUseItem(pos.x - 1, pos.y - 1, pos.z).id
						while Map.IsTileWalkable(pos.x - 1, pos.y - 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y - 1, pos.z)
					        itemID = Map.GetTopUseItem(pos.x - 1, pos.y - 1, pos.z).id
					    end
					elseif DancerEight then
						local itemID = Map.GetTopUseItem(pos.x + 1, pos.y + 1, pos.z).id
						while Map.IsTileWalkable(pos.x + 1, pos.y + 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y + 1, pos.z)
					        itemID = Map.GetTopUseItem(pos.x + 1, pos.y + 1, pos.z).id
					    end
					elseif DancerNine then
						local itemID = Map.GetTopUseItem(pos.x + 1, pos.y - 1, pos.z).id
						while Map.IsTileWalkable(pos.x + 1, pos.y - 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 and (os.time()-StartTime)<WGThrowSeconds  do
					        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y - 1, pos.z)
					        itemID = Map.GetTopUseItem(pos.x + 1, pos.y - 1, pos.z).id
					    end 
					end

					while ((os.time()-StartTime)<WGThrowSeconds) do
						pos = PlayersOnScreen[i]:Position()
						local itemID = Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id
						if Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y, pos.z)
					    end
					    itemID = Map.GetTopUseItem(pos.x +1, pos.y, pos.z).id
					    if Map.IsTileWalkable(pos.x + 1, pos.y, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x +1, pos.y, pos.z)
					    end
					    itemID = Map.GetTopUseItem(pos.x, pos.y - 1, pos.z).id
					    if Map.IsTileWalkable(pos.x, pos.y - 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x, pos.y - 1, pos.z)
					    end
					    itemID = Map.GetTopUseItem(pos.x, pos.y + 1, pos.z).id
					    if Map.IsTileWalkable(pos.x, pos.y + 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x, pos.y + 1, pos.z)
					    end
					    itemID = Map.GetTopUseItem(pos.x - 1, pos.y + 1, pos.z).id
						if Map.IsTileWalkable(pos.x - 1, pos.y + 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y + 1, pos.z)
					    end
					    itemID = Map.GetTopUseItem(pos.x - 1, pos.y - 1, pos.z).id
					    if Map.IsTileWalkable(pos.x - 1, pos.y - 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x - 1, pos.y - 1, pos.z)
					    end
					    itemID = Map.GetTopUseItem(pos.x + 1, pos.y + 1, pos.z).id
					    if Map.IsTileWalkable(pos.x + 1, pos.y + 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y + 1, pos.z)
					    end
					    itemID = Map.GetTopUseItem(pos.x + 1, pos.y - 1, pos.z).id
					    if Map.IsTileWalkable(pos.x + 1, pos.y - 1, pos.z) and itemID ~= WildGrowthID and itemID ~= 0 then
					        Self.UseItemWithGround(WildRuneID, pos.x + 1, pos.y - 1, pos.z)
					    end 
					end

					enableManaPotions()
				end
			end
		end

	elseif setting_cmd == 'ue' then
		time = string.sub(text, 4)
		if time ~= nil then
			time = tonumber(time)
			if time ~= nil then
				while os.time() < time do
					wait(50)
				end
				Self.Say(UESpell)
				Self.Say(UESpell)
			end
		end
	elseif setting_cmd == 't' then
		lastTrapCall = os.time()
		local trap_number = string.match(text, "%a+% +(%d+)")
		dynamicWallTrap( trap_number )
	elseif setting_cmd == 'floorchange' then
		local floorStartTime = os.time()
		local leaderPos = {
			x = tonumber(string.match(text, "%a+% +(%d+)")),
			y = tonumber(string.match(text, "%a+% +%d+ +(%d+)")),
			z = tonumber(string.match(text, "%a+% +%d+ +%d+ +(%d+)")),
			newZ = tonumber(string.match(text, "%a+% +%d+ +%d+ +%d+ +(%d+)"))
		}
		if leaderPos.x ~= nil and leaderPos.y ~= nil and leaderPos.z ~= nil and leaderPos.newZ ~= nil then
			local myPos = Self.Position()
			if myPos.z == leaderPos.z then
				if myPos.z < leaderPos.newZ then
					while Self.FollowID() ~= 0 and getDistance( myPos, leaderPos ) > 4 and os.time() - floorStartTime <= timeToTryFloorChange do
						wait(200)
					end

					local spotToMoveTo = findFloorChangePosition( false, leaderPos )
					if spotToMoveTo ~= nil then
						moveToFloorChange( spotToMoveTo )
					end
				else
					while Self.FollowID() ~= 0 and getDistance( myPos, leaderPos ) > 4 and os.time() - floorStartTime <= timeToTryFloorChange do
						wait(200)
					end

					local spotToMoveTo = findFloorChangePosition( true, leaderPos )
					if spotToMoveTo ~= nil then
						moveToFloorChange( spotToMoveTo )
					end
				end
			end
		else
			print("Invalid floorchange format")
			print(text)
		end
	elseif message == 'left' then
		Self.Step(WEST)
		Self.Step(WEST)
	elseif message == 'right' then
		Self.Step(EAST)
		Self.Step(EAST)
	elseif message == 'down' then
		Self.Step(SOUTH)
		Self.Step(SOUTH)
	elseif message == 'up' then
		Self.Step(NORTH)
		Self.Step(NORTH)
	elseif message == 'lleft' then
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
		Self.Step(WEST)
		wait(100)
	elseif message == 'rright' then
		Self.Step(EAST)
		wait(100)
		Self.Step(EAST)
		wait(100)
		Self.Step(EAST)
		wait(100)
		Self.Step(EAST)
		wait(100)
		Self.Step(EAST)
		wait(100)
		Self.Step(EAST)
		wait(100)
		Self.Step(EAST)
		wait(100)
	elseif message == 'ddown' then
		Self.Step(SOUTH)
		wait(100)
		Self.Step(SOUTH)
		wait(100)
		Self.Step(SOUTH)
		wait(100)
		Self.Step(SOUTH)
		wait(100)
		Self.Step(SOUTH)
		wait(100)
		Self.Step(SOUTH)
		wait(100)
		Self.Step(SOUTH)
		wait(100)
		Self.Step(SOUTH)
		wait(100)
	elseif message == 'uup' then
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
		Self.Step(NORTH)
		wait(100)
	elseif message == 'follow on' then
		stopFollowModules()
		FollowStatus = true
	elseif message == 'follow off' then
		stopFollowModules()
		Self.StopFollow()
	elseif message == 'rfollow on' then
		stopFollowModules()
		Self.StopFollow()
		RFollowStatus = true
	elseif message == 'rfollow off' then
		stopFollowModules()
		Self.StopFollow()
	elseif message == '2follow off' then
		stopFollowModules()
		Self.StopFollow()
	elseif message == '2follow on' then
		Park = off
		stopFollowModules()
		Self.StopFollow()
		CloseFollowStatus = true
	elseif message == 'u' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		for i = 1, #PlayersOnScreen do	
			if LeaderName == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x, pos.y-1, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x+1, pos.y-1, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x-1, pos.y-1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x+2, pos.y-1, pos.z)
				elseif DancerFive or DancerSix then
					Self.UseItemWithGround(3180, pos.x-2, pos.y-1, pos.z)
				end
			end
		end
	elseif message == 'd' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		for i = 1, #PlayersOnScreen do	
			if LeaderName == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x, pos.y+1, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x+1, pos.y+1, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x-1, pos.y+1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x+2, pos.y+1, pos.z)
				elseif DancerFive or DancerSix then
					Self.UseItemWithGround(3180, pos.x-2, pos.y+1, pos.z)
				end
			end
		end
	elseif message == 'r' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		for i = 1, #PlayersOnScreen do	
			if LeaderName == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x+1, pos.y, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x+1, pos.y+1, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x+1, pos.y-1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x+1, pos.y+2, pos.z)
				elseif DancerFive or DancerSix then
					Self.UseItemWithGround(3180, pos.x+1, pos.y-2, pos.z)
				end
			end
		end
	elseif message == 'l' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		for i = 1, #PlayersOnScreen do	
			if LeaderName == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x-1, pos.y, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x-1, pos.y+1, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x-1, pos.y-1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x-1, pos.y+2, pos.z)
				elseif DancerFive or DancerSix then
					Self.UseItemWithGround(3180, pos.x-1, pos.y-2, pos.z)
				end
			end
		end
	elseif message == 'd' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		for i = 1, #PlayersOnScreen do	
			if LeaderName == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x, pos.y+1, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x+1, pos.y+1, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x-1, pos.y+1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x+2, pos.y+1, pos.z)
				elseif DancerFive or DancerSix then
					Self.UseItemWithGround(3180, pos.x-2, pos.y+1, pos.z)
				end
			end
		end
	elseif message == 'uu' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		if DancerFive == true then
			pos = Self.Position()
			Self.UseItemWithGround(3180, pos.x, pos.y-1, pos.z)
		end
		for i = 1, #PlayersOnScreen do	
			if McNames[5] == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x-2, pos.y-1, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x+2, pos.y-1, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x-1, pos.y-1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x+1, pos.y-1, pos.z)
				end
			end
		end
	elseif message == 'dd' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		if DancerFive == true then
			pos = Self.Position()
			Self.UseItemWithGround(3180, pos.x, pos.y-1, pos.z)
		end
		for i = 1, #PlayersOnScreen do	
			if McNames[5] == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x-2, pos.y+1, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x+2, pos.y+1, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x-1, pos.y+1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x+1, pos.y+1, pos.z)
				end
			end
		end
	elseif message == 'rr' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		if DancerFive == true then
			pos = Self.Position()
			Self.UseItemWithGround(3180, pos.x+1, pos.y, pos.z)
		end
		for i = 1, #PlayersOnScreen do	
			if McNames[5] == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x+1, pos.y-2, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x+1, pos.y+2, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x+1, pos.y-1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x+1, pos.y+1, pos.z)
				end
			end
		end
	elseif message == 'll' and Self.ItemCount(3180) > 0 then
		updateSpectators()
		if DancerFive == true then
			pos = Self.Position()
			Self.UseItemWithGround(3180, pos.x-1, pos.y, pos.z)
		end
		for i = 1, #PlayersOnScreen do	
			if McNames[5] == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if DancerOne or DancerTen then
					Self.UseItemWithGround(3180, pos.x-1, pos.y-2, pos.z)
				elseif DancerTwo or DancerNine then
					Self.UseItemWithGround(3180, pos.x-1, pos.y+2, pos.z)
				elseif DancerThree or DancerEight then
					Self.UseItemWithGround(3180, pos.x-1, pos.y-1, pos.z)
				elseif DancerFour or DancerSeven then
					Self.UseItemWithGround(3180, pos.x-1, pos.y+1, pos.z)
				end
			end
		end
	elseif message == 'park on' then
		Park = true
		if DancerOne or DancerSix then
			Self.StopFollow()
		end
	elseif message == 'park off' then
		Park = false
	elseif message == 'manafriend off' then
		manaFriendRunning = false
	elseif message == 'manafriend on' then
		manaFriendRunning = true		
	elseif message == 'faceup' then
		Self.Turn(NORTH)
		Self.Turn(NORTH)
	elseif message == 'facedown' then
		Self.Turn(SOUTH)
		Self.Turn(SOUTH)
	elseif message == 'faceright' then
		Self.Turn(EAST)
		Self.Turn(EAST)
	elseif message == 'faceleft' then
		Self.Turn(WEST)
		Self.Turn(WEST)
	elseif setting_cmd == 'mw' then
		if Self.ItemCount(MagicRuneID) > 0 then
			setting_value = string.sub(text, 4)
			updateSpectators( true )
			for i = 1, #PlayersOnScreen do	
				if setting_value == PlayersOnScreen[i]:Name() then
					pos = PlayersOnScreen[i]:Position()
					StartTime = os.time()
					while ((os.time()-StartTime)<MWThrowSeconds ) do
						if Map.IsTileWalkable(pos.x - 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x -1, pos.y, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x - 1, pos.y, pos.z)
					    end
						if Map.IsTileWalkable(pos.x - 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y + 1, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x - 1, pos.y + 1, pos.z)
					    end
					    if Map.IsTileWalkable(pos.x - 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x - 1, pos.y - 1, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x - 1, pos.y - 1, pos.z)
					    end
					    if Map.IsTileWalkable(pos.x + 1, pos.y, pos.z) and Map.GetTopUseItem(pos.x +1, pos.y, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x +1, pos.y, pos.z)
					    end
					    if Map.IsTileWalkable(pos.x + 1, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y + 1, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x + 1, pos.y + 1, pos.z)
					    end
					    if Map.IsTileWalkable(pos.x + 1, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x + 1, pos.y - 1, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x + 1, pos.y - 1, pos.z)
					    end
					    if Map.IsTileWalkable(pos.x, pos.y - 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y - 1, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x, pos.y - 1, pos.z)
					    end
					    if Map.IsTileWalkable(pos.x, pos.y + 1, pos.z) and Map.GetTopUseItem(pos.x, pos.y + 1, pos.z).id ~= MagicWallID then
					        Self.UseItemWithGround(MagicRuneID, pos.x, pos.y + 1, pos.z)
					    end
					end
				end
			end
		end
	elseif setting_cmd == 'hurup' then
		setting_value = string.sub(text, 7)
		FollowStatus = false
		CloseFollowStatus = false
		RFollowStatus = false
		Self.StopFollow()
		oldpos = Self.Position()
		pos = Self.Position()
		if setting_value == "u" then
			Self.Turn(NORTH)
		elseif setting_value == "d" then
			Self.Turn(SOUTH)
		elseif setting_value == "r" then
			Self.Turn(EAST)
		elseif setting_value == "l" then
			Self.Turn(WEST)
		end
		while oldpos.z == pos.z do
			if LadderTries >6 then
				print('ladder failed')
				LadderTries = 0
				break
			end
			if oldpos.z ~= pos.z then
				print('ladder succesful')
				LadderTries = 0
				break
			end
			Self.Say('exani hur \"up')
			wait(200)
			LadderTries = LadderTries + 1
			pos = Self.Position()
		end
	elseif setting_cmd == 'hurdown' then
		setting_value = string.sub(text, 9)
		FollowStatus = false
		CloseFollowStatus = false
		Self.StopFollow()
		oldpos = Self.Position()
		pos = Self.Position()
		if setting_value == "u" then
			Self.Turn(NORTH)
		elseif setting_value == "d" then
			Self.Turn(SOUTH)
		elseif setting_value == "r" then
			Self.Turn(EAST)
		elseif setting_value == "l" then
			Self.Turn(WEST)
		end
		while oldpos.z == pos.z do
			if LadderTries >6 then
				print('ladder failed')
				FollowStatus = true
				LadderTries = 0
				break
			end
			if oldpos.z ~= pos.z then
				print('ladder succesful')
				FollowStatus = true
				LadderTries = 0
				break
			end
			Self.Say('exani hur \"down')
			wait(300)
			LadderTries = LadderTries + 1
			pos = Self.Position()
		end
	elseif message == 'pickup' then
		Map.PickupItem(Self.Position().x, Self.Position().y, Self.Position().z, "", 19, 100)
	elseif setting_cmd == 'pickup' then
		setting_value = string.sub(text, 8)
		print(setting_value)
		if string.match(text, "off") then
			pickupRunning = false
		elseif string.match(text, "cap") then
			leaveCap = string.match(text, '%d+')
			if leaveCap ~= nil then
				haveAmount = nil
				print("Turning on pickup, time = '"..leaveCap)
				pickupRunning = true
				pickupStartTime = os.time()
			end
		elseif string.match(text, "have") then
			havePickupTries = 0
			haveID = string.match(text, "%a+ %a+ %d+ (%d+)")
			haveAmount = string.match(text, "%a+ %a+ (%d+) %d+")
			if haveAmount ~= nil and haveID ~= nil then
				haveID = tonumber(haveID)
				haveAmount = tonumber(haveAmount)
				leaveCap = nil
				pickupRunning = true
				pickupStartTime = os.time()
			end
		end
	elseif message == 'reset warnings' then
		SoulSent = false
	elseif message == 'status' then
		local SDCount = Self.ItemCount(3155)
		local FoodCount = Self.ItemCount(3607) + Self.ItemCount(3585) + Self.ItemCount(3601) + Self.ItemCount(3582)
			  + Self.ItemCount(3600) + Self.ItemCount(3577) + Self.ItemCount(3592) + Self.ItemCount(3725)
		local MWCount = Self.ItemCount(MagicRuneID)
		local WGCount = Self.ItemCount(WildRuneID) 
		local GMPCount= Self.ItemCount(ManaPotionID)
		if DancerOne then
			ParaCount = Self.ItemCount(ParaRuneID)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points, and '..ParaCount..' Paralyze Runes\'s,')
		elseif DancerTwo then
			wait(200)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerThree then
			wait(400)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerFour then
			wait(600)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerFive then
			wait(800)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerSix then
			wait(1000)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerSeven then
			wait(1200)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerEighth then
			wait(1400)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerNine then
			wait(1600)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		elseif DancerTen then
			wait(1800)
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		else 
			Self.PrivateMessage(LeaderName, 'I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
		end
	elseif message == 'local status' then
		local SDCount = Self.ItemCount(3155)
		local FoodCount = Self.ItemCount(3607) + Self.ItemCount(3585) + Self.ItemCount(3601) + Self.ItemCount(3582)
						  + Self.ItemCount(3600) + Self.ItemCount(3577) + Self.ItemCount(3592) + Self.ItemCount(3725)
		local MWCount = Self.ItemCount(MagicRuneID)
		local WGCount = Self.ItemCount(WildRuneID) 
		local GMPCount= Self.ItemCount(238)
		Self.Say('I have '..SDCount..' SD\'s, '..MWCount..' Magic Wall Rune\'s, '..WGCount..' Wild Growth Rune\'s, '..GMPCount..' Mana Pot\'s, '..FoodCount..' Food Item\'s and '..Self.Soul()..' Soul Points.')
	elseif message == 'ladder' then
		updateSpectators()											--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if LeaderName == PlayersOnScreen[i]:Name() then
				local pos = PlayersOnScreen[i]:Position()

				local WasTrue = true
				if FollowStatus == true then
					WasTrue = true
				else
					WasTrue = false
				end
				FollowStatus = false
				CloseFollowStatus = false
				Self.StopFollow()
				wait(100)
				local mypos = Self.Position()
				while mypos.z == pos.z do
					if LadderTries >4 then
						print('ladder failed')
						LadderTries = 0
						break
					end
					mypos = Self.Position()
					if mypos.z ~= pos.z then
						print('ladder succesful')
						LadderTries = 0
						break
					end
					Self.UseLever(pos.x, pos.y, pos.z)
					wait(800)
					LadderTries = LadderTries + 1
				end
				if WasTrue == true then
					FollowStatus = true
				end
			end
		end

	elseif message == 'ladder self' then
		local pos = Self.Position()
		Self.UseLever(pos.x, pos.y, pos.z)
		wait(300)

	elseif message == 'sewer' then
		updateSpectators()											--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if LeaderName == PlayersOnScreen[i]:Name() then
				local pos = PlayersOnScreen[i]:Position()

				local WasTrue = true
				if FollowStatus == true then
					WasTrue = true
				else
					WasTrue = false
				end
				FollowStatus = false
				CloseFollowStatus = false
				Self.StopFollow()
				wait(100)
				local mypos = Self.Position()
				while mypos.z == pos.z do
					if LadderTries >4 then
						print('sewer failed')
						LadderTries = 0
						break
					end
					mypos = Self.Position()
					if mypos.z ~= pos.z then
						print('sewer succesful')
						LadderTries = 0
						break
					end
						
					floorID = Map.GetTopUseItem(pos.x, pos.y, pos.z).id
					if floorID ~= sewerGrateID then
						floorID = Map.GetTopUseItem(pos.x, pos.y, pos.z).id
						Map.MoveItem(pos.x, pos.y, mypos.x, mypos.y, 100)
						wait(400)
					else
						Self.UseLever(pos.x, pos.y, pos.z)
						wait(500)
					end
					LadderTries = LadderTries + 1
				end

				if WasTrue == true then
					FollowStatus = true
				end
			end
		end
	elseif message == 'go up' then
		updateSpectators()					--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if LeaderName == PlayersOnScreen[i]:Name() then
				print("Found leader")
				local pos = PlayersOnScreen[i]:Position()
				pos.y = pos.y-1
				local WasTrue = true
				if FollowStatus == true then
					WasTrue = true
				else
					WasTrue = false
				end
				FollowStatus = false
				CloseFollowStatus = false
				Self.StopFollow()
				wait(100)
				local mypos = Self.Position()
				while mypos.z == pos.z do
					print('trying to get down ladder attempt '..LadderTries+1)
					Self.UseLever(pos.x, pos.y, pos.z)
					wait(1200)
					mypos = Self.Position()
					LadderTries = LadderTries + 1
					if mypos.z == pos.z then
						print("On same floor")

						if mypos.x == pos.x and mypos.y == pos.y then
							break
						end

						if mypos.x == pos.x+1 and mypos.y == pos.y-1 then
							Self.Step(SOUTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y+1 then
							Self.Step(NORTHEAST)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y+1 then
							Self.Step(NORTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y-1 then
							Self.Step(SOUTHEAST)
						elseif mypos.x == pos.x and mypos.y == pos.y-1 then
							Self.Step(SOUTH)
						elseif mypos.x == pos.x and mypos.y == pos.y+1 then
							Self.Step(NORTH)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y then
							Self.Step(WEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y then
							Self.Step(EAST)
						end
					else
						LadderTries = 0
						print('ladder succesful')
						break
					end
					if LadderTries >5 then
						LadderTries = 0
						print('ladder failed')
						break
					end
				end
				if WasTrue == true then
					FollowStatus = true
				end
			end
		end
	elseif message == 'go down' then
		updateSpectators()											--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if LeaderName == PlayersOnScreen[i]:Name() then
				local pos = PlayersOnScreen[i]:Position()
				pos.y = pos.y+1
				local WasTrue = true
				if FollowStatus == true then
					WasTrue = true
				else
					WasTrue = false
				end
				FollowStatus = false
				CloseFollowStatus = false
				Self.StopFollow()
				wait(100)
				local mypos = Self.Position()
				while mypos.z == pos.z do
					print('trying to get down ladder attempt '..LadderTries+1)
					Self.UseLever(pos.x, pos.y, pos.z)
					wait(1200)
					mypos = Self.Position()
					LadderTries = LadderTries + 1
					if mypos.z == pos.z then

						if mypos.x == pos.x and mypos.y == pos.y then
							break
						end

						if mypos.x == pos.x+1 and mypos.y == pos.y-1 then
							Self.Step(SOUTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y+1 then
							Self.Step(NORTHEAST)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y+1 then
							Self.Step(NORTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y-1 then
							Self.Step(SOUTHEAST)
						elseif mypos.x == pos.x and mypos.y == pos.y-1 then
							Self.Step(SOUTH)
						elseif mypos.x == pos.x and mypos.y == pos.y+1 then
							Self.Step(NORTH)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y then
							Self.Step(WEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y then
							Self.Step(EAST)
						end
					else
						LadderTries = 0
						print('ladder succesful')
						break
					end
					if LadderTries >5 then
						LadderTries = 0
						print('ladder failed')
						break
					end
					wait(1000)
				end
				if WasTrue == true then
					FollowStatus = true
				end
			end
		end
	elseif message == 'go right' then
		updateSpectators()											--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if LeaderName == PlayersOnScreen[i]:Name() then
				local pos = PlayersOnScreen[i]:Position()
				pos.x = pos.x+1
				local WasTrue = true
				if FollowStatus == true then
					WasTrue = true
				else
					WasTrue = false
				end
				FollowStatus = false
				CloseFollowStatus = false
				Self.StopFollow()
				wait(100)
				local mypos = Self.Position()
				while mypos.z == pos.z do
					print('trying to get down ladder attempt '..LadderTries+1)
					Self.UseLever(pos.x, pos.y, pos.z)
					wait(1200)
					mypos = Self.Position()
					LadderTries = LadderTries + 1
					if mypos.z == pos.z then

						if mypos.x == pos.x and mypos.y == pos.y then
							break
						end

						if mypos.x == pos.x+1 and mypos.y == pos.y-1 then
							Self.Step(SOUTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y+1 then
							Self.Step(NORTHEAST)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y+1 then
							Self.Step(NORTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y-1 then
							Self.Step(SOUTHEAST)
						elseif mypos.x == pos.x and mypos.y == pos.y-1 then
							Self.Step(SOUTH)
						elseif mypos.x == pos.x and mypos.y == pos.y+1 then
							Self.Step(NORTH)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y then
							Self.Step(WEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y then
							Self.Step(EAST)
						end
					else
						print('ladder succesful')
						LadderTries = 0
						break
					end
					if LadderTries >5 then
						print('ladder failed')
						LadderTries = 0
						break
					end
				end
				if WasTrue == true then
					FollowStatus = true
				end
			end
		end
	elseif message == 'go left' then
		updateSpectators()											--For example if you lose the person you are supposed to be following it will follow the next person.
		for i = 1, #PlayersOnScreen do 									--If a person higher on the list re-enters the screen it will automatically change to follow them.
			if LeaderName == PlayersOnScreen[i]:Name() then
				local pos = PlayersOnScreen[i]:Position()
				pos.x = pos.x-1
				local WasTrue = true
				if FollowStatus == true then
					WasTrue = true
				else
					WasTrue = false
				end
				FollowStatus = false
				CloseFollowStatus = false
				Self.StopFollow()
				wait(100)
				local mypos = Self.Position()
				while mypos.z == pos.z do
					print('trying to get to square attempt '..LadderTries+1)
					Self.UseLever(pos.x, pos.y, pos.z)
					wait(1200)
					mypos = Self.Position()
					LadderTries = LadderTries + 1
					if mypos.z == pos.z then

						if mypos.x == pos.x and mypos.y == pos.y then
							break
						end

						if mypos.x == pos.x+1 and mypos.y == pos.y-1 and mypos.z == pos.z  then
							Self.Step(SOUTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y+1 and mypos.z == pos.z  then
							Self.Step(NORTHEAST)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y+1 and mypos.z == pos.z  then
							Self.Step(NORTHWEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y-1 and mypos.z == pos.z  then
							Self.Step(SOUTHEAST)
						elseif mypos.x == pos.x and mypos.y == pos.y-1 and mypos.z == pos.z  then
							Self.Step(SOUTH)
						elseif mypos.x == pos.x and mypos.y == pos.y+1 and mypos.z == pos.z  then
							Self.Step(NORTH)
						elseif mypos.x == pos.x+1 and mypos.y == pos.y and mypos.z == pos.z  then
							Self.Step(WEST)
						elseif mypos.x == pos.x-1 and mypos.y == pos.y and mypos.z == pos.z then
							Self.Step(EAST)
						end
					else
						print('go succesful')
						LadderTries = 0
						break
					end
					if LadderTries > 5 then
						print('go failed')
						LadderTries = 0
						break
					end
				end
				if WasTrue == true then
					FollowStatus = true
				end
			end
		end
	elseif message == 'food' then
		updateSpectators()					--throws food under player
		for i = 1, #PlayersOnScreen do 							
			if LeaderName == PlayersOnScreen[i]:Name() then
				pos = PlayersOnScreen[i]:Position()
				if Self.ItemCount(3607) > 0 then
					Self.DropItem(pos.x, pos.y, pos.z, 3607, 1) 
				elseif Self.ItemCount(3585) > 0 then
					Self.DropItem(pos.x, pos.y, pos.z, 3585, 1) 
				elseif Self.ItemCount(3601) > 0 then
					Self.DropItem(pos.x, pos.y, pos.z, 3601, 1) 
				elseif Self.ItemCount(3582) > 0 then
					Self.DropItem(pos.x, pos.y, pos.z, 3582, 1) 
				elseif Self.ItemCount(3600) > 0 then
					Self.DropItem(pos.x, pos.y, pos.z, 3600, 1) 
				elseif Self.ItemCount(3577) > 0 then
					Self.DropItem(pos.x, pos.y, pos.z, 3577, 1) 
				elseif Self.ItemCount(3592) > 0 then
					Self.DropItem(pos.x, pos.y, pos.z, 3592, 1) 
				end
			end
		end
	elseif setting_cmd == 'changeue' then
		setting_value = string.sub(text, 10)
		UESpell = setting_value
		if DancerOne then
			Self.PrivateMessage(LeaderName, 'UE spell is now '..UESpell)
		end
	elseif setting_cmd == 'trap' then
		local trap_number = string.match(text, "%a+ (%d+)")
		local trap_Postfix = string.match(text, "%a+ (%a+)")
		local cmd_type = string.match(text, "%a+ %d+ (%a+)")
		if cmd_type ~= nil and trap_number ~= nil then
			if( cmd_type == "clear" ) then
				trap[trap_number] = nil
			else
				local temp = nil
				if( cmd_type == "remove" ) then-- there wont be a 'mw' 'trigger' or 'wg' parameter
					temp = {
						x = tonumber(string.match(text, "%a+% +%d+% +%a+% +(%d+)")),
						y = tonumber(string.match(text, "%a+% +%d+% +%a+% +%d+ (%d+)")),
						z = tonumber(string.match(text, "%a+% +%d+% +%a+% +%d+ %d+ (%d+)")),
					}
				elseif( cmd_type == "add" ) then -- will be 'mw' 'trigger' or 'wg' paramter in message
					temp = {
						x = tonumber(string.match(text, "%a+% +%d+% +%a+% +%a+% +(%d+)")),
						y = tonumber(string.match(text, "%a+% +%d+% +%a+% +%a+% +%d+ (%d+)")),
						z = tonumber(string.match(text, "%a+% +%d+% +%a+% +%a+% +%d+ %d+ (%d+)")),
					}
				end
				if( temp.x ~= nil and temp.y ~= nil and temp.z ~= nil ) then
					if( cmd_type == "remove" ) then
						--loop thruogh all existing spots in the current trap_number
						-- if the x, y, and z are the same, remove the element.
						if( trap[trap_number] ~= nil ) then
							local removeTrapIndex
							for removeTrapIndex = 1, trap[trap_number][0] do
								if trap[trap_number][removeTrapIndex] ~= nil then
									if trap[trap_number][removeTrapIndex][0] == temp.x and trap[trap_number][removeTrapIndex][1] == temp.y and trap[trap_number][removeTrapIndex][2] == temp.z then
										table.remove(trap[trap_number], removeTrapIndex )
										trap[trap_number][0] = trap[trap_number][0] - 1
										break
									end
								end
							end

							--remove trigger
							print(#triggerSpots.." trigger spots")
							for removeTrapIndex = 1, #triggerSpots do
								if triggerSpots[ removeTrapIndex ] ~= nil then
									if triggerSpots[ removeTrapIndex ].x == temp.x and triggerSpots[ removeTrapIndex ].y == temp.y and triggerSpots[ removeTrapIndex ].z == temp.z then
										table.remove(triggerSpots, removeTrapIndex)
									end
								end
							end
						end
					elseif( cmd_type == "add" ) then
						local rune_type = string.match(text, "%a+ %d+ %a+ (%a+)")
						if rune_type ~= nil and (rune_type == "wg" or rune_type == "mw" or rune_type == "trigger") then
							if ( trap[trap_number] == nil ) then
								-- will trigger if its the first time trap_number has been added
								trap[trap_number] = {}
								trap[trap_number][0] = 0 -- trap_number][0] - holds a number with the amount of positions in the trap
							end
							trap[trap_number][0] = trap[trap_number][0] + 1
							local newTrapIndex = trap[trap_number][0]
							trap[trap_number][newTrapIndex] = { }
							trap[trap_number][newTrapIndex][0] = temp.x -- represents x
							trap[trap_number][newTrapIndex][1] = temp.y -- represents y
							trap[trap_number][newTrapIndex][2] = temp.z -- represents z
							if rune_type == "wg" then
								trap[trap_number][newTrapIndex][3] = WildRuneID 
							elseif rune_type == "mw" then
								trap[trap_number][newTrapIndex][3] = MagicRuneID
							elseif rune_type == "trigger" then
								local newIndex = #triggerSpots + 1
								triggerSpots[ newIndex ] = {}
								triggerSpots[ newIndex ].x = temp.x
								triggerSpots[ newIndex ].y = temp.y
								triggerSpots[ newIndex ].z = temp.z
								triggerSpots[ newIndex ].trapNumber = trap_number

							else
								print("err, invalid rune_type :"..rune_type)
							end
						end
					end
				else
					print("Error: trap Position was not formatted correctly")
				end
			end
		elseif trap_Postfix ~= nil and trap_Postfix == "trigger" then
			local trap_Trigger_Postfix = string.match(text, "%a+ %a+ (%a+)")
			if trap_Trigger_Postfix ~= nil then
				if trap_Trigger_Postfix == "on" then
					watchingTriggers = true
				elseif trap_Trigger_Postfix == "off" then
					watchingTriggers = false
				elseif trap_Trigger_Postfix == "add" then

					local setting_name = string.match( text, "%a* %a* %a* ([%a -]*)")
					if setting_name ~= nil then
						if setting_name == "skull" or setting_name == "skulls" then
							trap.triggerOnSkulls = true
						else
							table.insert(trap.triggerPlayers, setting_name)
						end
					end

				elseif trap_Trigger_Postfix == "remove" then
					local setting_name = string.match( text, "%a* %a* %a* ([%a -]*)")
					if setting_name ~= nil then
						if setting_name == "skull" or setting_name == "skulls" then
							trap.triggerOnSkulls = false
						else
							removePlayerFromTable( trap.triggerPlayers, setting_name )
						end
					end

				elseif trap_Trigger_Postfix == "clear" then
					trap.triggerPlayers = {}
					trap.triggerOnSkulls = false
				end
			end

			-- local setting_name = string.match( text, "%a* %a* ([%a -]*)")
			-- 	if setting_name ~= nil then
			-- 		removePlayerFromTable( autoSD.BlackList, setting_name )
			-- 	end
			-- elseif setting_value == 'add' then
			-- 	local setting_name = string.match( text, "%a* %a* ([%a -]*)")
			-- 	if setting_name ~= nil then
			-- 		table.insert( autoSD.BlackList, setting_name )
			-- 	end
			-- elseif setting_value == 'clear' then
			-- 	autoSD.BlackList = {}
		

		end
	elseif setting_cmd == 'travel' then
		setting_value = string.sub(text, 8)
		CloseFollowStatus = false
		FollowStatus = false
		RFollowStatus = false
		Self.SayToNpc({"hi", setting_value, "yes"}, 100)
	elseif setting_cmd == 'zerg' then
		setting_value = string.sub(text, 6)
		if setting_value == "off" then
			zergRunning = false
			Self.StopFollow()
		else
			CloseFollowStatus = false
			FollowStatus = false
			RFollowStatus = false
			Self.StopFollow()
			getInitialPosition = true
			zergFollow = setting_value
			zergRunning = true
			emptySpotsToTrash = 27
		end
		
	elseif message == 'autosd off' then
		autoSDRunning = false

	elseif message == 'autosd on' then
		autoSDRunning = true

	elseif setting_cmd == 'autosd' then
		setting_value = string.match( message, "%a+ (%a*)")
		if setting_value ~= nil then
			if setting_value == 'remove' then
				local setting_name = string.match( text, "%a* %a* ([%a '-]*)")
				if setting_name ~= nil then
					removePlayerFromTable( autoSD.BlackList, setting_name )
				end
			elseif setting_value == 'add' then
				local setting_name = string.match( text, "%a* %a* ([%a '-]*)")
				if setting_name ~= nil then
					table.insert( autoSD.BlackList, setting_name )
				end
			elseif setting_value == 'clear' then
				autoSD.BlackList = {}
			end
		end

	elseif message == 'heal' then
		Self.Say('exura gran mas res')

	elseif setting_cmd == 'heal' then
		setting_value = string.match( message, "%a+ (%a*)")
		if setting_value ~= nil then
			if setting_value == 'remove' then
				local setting_name = string.match( text, "%a* %a* ([%a '-]*)")
				if setting_name ~= nil then
					removePlayerFromTable( config.WhiteList, setting_name )
				end
			elseif setting_value == 'add' then
				local setting_name = string.match( text, "%a* %a* ([%a '-]*)")
				if setting_name ~= nil then
					if DancerOne then
						Self.PrivateMessage(setting_name, 'You will be healed when your hp is below 70%.')
					end
					table.insert(config.WhiteList, setting_name )
				end
			elseif setting_value == "clear" then
				config.WhiteList = {LeaderName, McNames[1], McNames[2], McNames[3], McNames[4], McNames[5], McNames[6], McNames[7], McNames[8], McNames[9], McNames[10]}
				if DancerOne then
					Self.PrivateMessage(LeaderName, 'Heal list has been reset to just Leader and MCs.')
				end
			end
		end

	elseif setting_cmd == 'addtrap' then
		setting_value = string.sub(text, 9)
		table.insert(trapconfig.BlackList, setting_value)
		if DancerOne then
			Self.PrivateMessage(LeaderName, 'Added '..setting_value..' to Trap List.')
		end

	elseif setting_cmd == 'removetrap' then
		setting_value = string.sub(text, 12)
		removePlayerFromTable( trapconfig.BlackList, setting_value )
	
	elseif message == 'lootbodies on' then
		print("lootbodies on")
		lootBodiesRunning = true

	elseif message == 'lootbodies off' then
		print("lootbodies off")
		lootBodiesRunning = false

	elseif message == 'para on' then
		--only these 4 paralyze
		if DancerTwo or DancerSeven or DancerOne or DancerSix then
			ParaStatus = true
		end

	elseif message == 'para off' then
		ParaStatus = false

	elseif setting_cmd == 'para' then
		setting_value = string.match( message, "%a+ (%a*)")
		if setting_value ~= nil then
			if setting_value == 'remove' then
				local setting_name = string.match( text, "%a* %a* ([%a -']*)")
				if setting_name ~= nil then
					if setting_name == "skull" or setting_name == "skulls" then
						paraTargetSkulls = false
					else
						removePlayerFromTable( paraconfig.BlackList, setting_name )
					end
				end
			elseif setting_value == 'add' then
				local setting_name = string.match( text, "%a* %a* ([%a -']*)")
				if setting_name ~= nil then
					if setting_name == "skull" or setting_name == "skulls" then
						paraTargetSkulls = true
					else
						table.insert(paraconfig.BlackList, setting_name)
					end
				end
			elseif setting_value == 'clear' then
				paraconfig.BlackList = {}
				paraTargetSkulls = false
			end
		end
	elseif message == 'cleartrap' then
		paraconfig.BlackList = {}
		if DancerOne then
			Self.PrivateMessage(LeaderName, 'Cleared all entries from wg trap list.')
		end
	elseif message == 'autotrap on' then
		TrapStatus = true
		if DancerOne then
			Self.PrivateMessage(LeaderName, 'Auto-Trap on.')
		end
	elseif message == 'autotrap off' then
		TrapStatus = false
		if DancerOne then
			Self.PrivateMessage(LeaderName, 'Auto-Trap off.')
		end
	
	elseif message == 'fire' then
		if Self.ItemCount(3192) > 0 then
			pos = Self.Position()
			Self.UseItemWithGround(3192, pos.x, pos.y, pos.z)
		end
	elseif message == 'pz' then
		if Self.isPzLocked() then
			Self.PrivateMessage(LeaderName, 'I am PZ Locked.')
		end 

	elseif setting_cmd == 'say' then
		if setting_value == "exani tera" then
			local curPos = Self.Position()
			local numTries = 0
			while numTries < 4 and Self.Position().z == curPos.z do
				Self.Say("exani tera")
				wait( 500 )
				numTries = numTries + 1
			end
		else 
			Self.Say(setting_value)
		end

	elseif setting_cmd == 'saynpc' then
		Self.SayToNpc(  setting_value )

	elseif setting_cmd == 'yell' then 
		Self.Yell(setting_value)
	elseif setting_cmd == 'outfit' then
		if setting_value == "off" then
			IllusionStatus = false 
		else
			IllusionStatus = true
			local Tries = 0
			local Casted = false
			setting_value = string.sub(text, 8)
			IllusionCreature = setting_value
			while Tries < 9 and Casted == false do
				if Self.Cast('utevo res ina \"'..setting_value) then
					print("Casted")
					Casted = true
				else
					print("Not casted")
					wait(400)
					Tries = Tries + 1
				end
			end
		end
	elseif message == 'summon' then
		Self.Say('utevo res \"'..IllusionCreature)
	elseif message == 'follow me' then
		stopFollowModules()
		updateSpectators()					--throws food under player
		for i = 1, #PlayersOnScreen do 							
			if LeaderName == PlayersOnScreen[i]:Name() then
				PlayersOnScreen[i]:Follow()
				break
			end
		end
	elseif message == 'rune on' then
		MakeRunes = true
	elseif message == 'rune off' then
		MakeRunes = false
	elseif message == 'dance on' then
		Module.Start("Turn")
	elseif message == 'dance off' then
		Module.Stop("Turn")

	elseif setting_cmd == 'throw' then
		setting_amount, setting_value = string.match(text, "%a+ (%d+) (%d+)")
		setting_value = tonumber(setting_value)
		setting_amount = tonumber(setting_amount)
		if setting_value ~= nil and setting_amount ~= nil then
			print("id = '"..setting_value.."', amount = '"..setting_amount.."'")
			updateSpectators()					--throws food under player
			for i = 1, #PlayersOnScreen do 							
				if LeaderName == PlayersOnScreen[i]:Name() then
					pos = PlayersOnScreen[i]:Position()
					Self.DropItem(pos.x, pos.y, pos.z, setting_value, setting_amount )
					break
				end
			end
		end

	elseif message == 'xlog' then
		wait(100)
		os.exit()
	elseif message == 'magic trainer' then
		local trainerStartTime = os.time()
		while os.time() - trainerStartTime < 5 do 
			local myPos = Self.Position()
			for x = -2, 2 do
				for y = -2, 2 do
					item = Map.GetTopUseItem(myPos.x + x, myPos.y + y, myPos.z)
					if item.id == magicTrainerID then
						Self.UseLever(myPos.x + x, myPos.y + y, myPos.z)
					end
				end
			end
		end
	elseif setting_cmd == 'load' then
		local setting_value = string.sub(text, 6)
		loadSettings(setting_value, "All")
	elseif message == 'apes' then
		loadSettings("Banuta Apes", "All")
	elseif message == 'thelost' then
		loadSettings("theLost", "All")
	elseif message == 'parcel' then
		loadSettings("zRandom", "All")
	elseif message == 'reload script' then
		loadSettings("Anoyns Magebomb All MCs Settings", "All")
	end
end


function getPlayerByName( name )
	for i = 1, #PlayersOnScreen do
		if PlayersOnScreen[i]:Name() == name then
			return PlayersOnScreen[i]
		end
	end
	return nil
end

if DancerOne then
	myTurnToPara = true
else
	myTurnToPara = false
end

lastTimeSeeingParaTarget = 0
LocalSpeechProxy.OnReceive("LocalProxy", function(proxy, mtype, speaker, level, text)

	if ParaStatus and (DancerOne or DancerSix) and ( table.find(paraconfig.BlackList, speaker, false) or table.find( tempSkulledParaTargets, speaker, false) ) then

		--temp disable potting teammates
		manaRequestTimeout = 0

		lastTimeSeeingParaTarget = os.time()
		if Self.Mana() > minimumManaToParalyze and Self.ItemCount(ParaRuneID) > 0 then
			local loweredText = string.lower(text)
			if table.find(paraBreakingSpells, loweredText, false) or string.find(loweredText, "exura sio\"") then

				-- toggle between who should para
				if myTurnToPara then
					disableManaPotions()
					myTurnToPara = false
					updateSpectators( true )
					local player = getPlayerByName( speaker )

					if player ~= nil then
						Self.UseItemWithCreature(ParaRuneID, player:ID())
					end
					enableManaPotions()
				else
					myTurnToPara = true
				end
			end
		end
	elseif text == 'backup' then
		if BackupEnabled then
			if speaker == myCharacterName then
				TempLeader = true
				LeaderName = 'DontFollow'
				ResetFollows()
				Module.Stop("Commands")
				CommandChannel = Channel.Open("[Commands]", onSpeakCommandChannel, onCloseCommandChannel)
			elseif speaker == OriginalLeaderName then
				TempLeader = false
				LeaderName = OriginalLeaderName
				ResetFollows()
				loadSettings(FragReset, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[1] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC1Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[2] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC2Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[3] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC3Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[4] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC4Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[5] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC5Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[6] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC6Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[7] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC7Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[8] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC8Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[9] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC9Leader, "Combo Options")
				Module.Start("Commands")
			elseif speaker == McNames[10] then
				TempLeader = false
				LeaderName = speaker
				ResetFollows()
				loadSettings(MC10Leader, "Combo Options")
				Module.Start("Commands")
			end
		end
	end
end)

watchingTriggers = true
Module.New('WatchTriggers', function(WatchTriggers)
	if watchingTriggers and ( #trap.triggerPlayers > 0 or trap.triggerOnSkulls ) and os.time() - lastTrapCall > delayBetweenTrapCall then
		updateSpectators()					--throws ape fur loot at player
		for i = 1, #PlayersOnScreen do
			local playerSkull = PlayersOnScreen[i]:Skull()
			if table.find( trap.triggerPlayers, PlayersOnScreen[i]:Name() ) or ( trap.triggerOnSkulls and ( playerSkull == whiteSkullID or playerSkull == redSkullID or playerSkull == blackSkullID ) ) then
				local playerPos = PlayersOnScreen[i]:Position()

				--Player found, check if position matches any traps

				for f = 1, #triggerSpots do
					if triggerSpots[f].x == playerPos.x and triggerSpots[f].y == playerPos.y and triggerSpots[f].z == playerPos.z then
						lastTrapCall = os.time()
						publishMessage( "cmd", "t "..triggerSpots[f].trapNumber )
						dynamicWallTrap( triggerSpots[f].trapNumber )
					end
				end

			end
		end
	end
end)


if DancerOne or DancerTwo or DancerSix or DancerSeven then
	paraInactivitySecondsToEnableSD = 2

	Module.New('ParaInactivity', function(ParaInactivity)
		if (not ParaStatus or os.time() - lastTimeSeeingParaTarget >= paraInactivitySecondsToEnableSD) and SDDisabled then
			SDDisabled = false

			print("Target off screen (2 secs) OR Para Stopped!, activating SD~~~~~~~~~~~~")
			--enable sd
			loadSettings(FragReset, "Combo Options")
		end
		ParaInactivity:Delay(1000)
	end)
end

havePickupTries = 0
havePickupTriesBeforeCancel = 4
lastPickup = 0
Module.New('Pickup', function(Pickup)
	--pickup will stay on for 3 minutes after turned on, but if it picks up supplies it wont turn off for another two minutes
	if pickupRunning then
		if os.time() - pickupStartTime > 60000 * 3 and os.time() - lastPickup > 60000 * 2 then -- * minutes
			pickupRunning = false
			print("Pickup shut off from inactivity")
		elseif leaveCap ~= nil then
			local curPos = Self.Position()
			local itemUnder = Map.GetTopUseItem(curPos.x, curPos.y, curPos.z).id
			if itemUnder == GMPID or itemUnder == SDRuneID then
				local itemWeight
				if itemUnder == GMPID then
					itemWeight = GMPWeight
				else
					itemWeight = SDWeight
				end
				local numToTake = math.floor((Self.Cap() - leaveCap) / itemWeight)
				if numToTake > 0 then
					Map.PickupItem(curPos.x, curPos.y, curPos.z, "", 19, numToTake)
					lastPickup = os.time()
				else
					local nextInLineName = RFollowInitial
					if nextInLineName == nil then
						nextInLineName = LeaderName
					end
					updateSpectators()					--throws ape fur loot at player
					for i = 1, #PlayersOnScreen do
						if nextInLineName == PlayersOnScreen[i]:Name() then
							local toPos = PlayersOnScreen[i]:Position()
							Map.MoveItem(curPos.x, curPos.y, toPos.x, toPos.y, 100)
							lastPickup = os.time()
							break
						end
					end
				end
			end
		elseif haveAmount ~= nil and haveID ~= nil then
			local curPos = Self.Position()
			local itemUnder = Map.GetTopUseItem(curPos.x, curPos.y, curPos.z).id
			if itemUnder == haveID then
				local currentlyHave = Self.ItemCount(haveID)
				if currentlyHave < haveAmount and havePickupTries <= havePickupTriesBeforeCancel then
					havePickupTries = havePickupTries + 1
					Map.PickupItem(curPos.x, curPos.y, curPos.z, "", 19, haveAmount - currentlyHave )
					lastPickup = os.time()
				else
					local nextInLineName = RFollowInitial
					if nextInLineName == nil then
						nextInLineName = LeaderName
					end
					updateSpectators()					--throws ape fur loot at player
					for i = 1, #PlayersOnScreen do
						if nextInLineName == PlayersOnScreen[i]:Name() then
							local toPos = PlayersOnScreen[i]:Position()
							Map.MoveItem(curPos.x, curPos.y, toPos.x, toPos.y, 100)
							lastPickup = os.time()
							break
						end
					end
				end
			end
		end
	end
	Pickup:Delay(350)
end)

Module.New('Turn', function(Turn)
	if step == 1 then
		Self.Turn(EAST)
		step = step + 1
	elseif step == 2 then
		Self.Turn(SOUTH)
		step = step + 1
	elseif step == 3 then
		Self.Turn(WEST)
		step = step + 1
	elseif step == 4 then
		Self.Turn(NORTH)
		step = 1
	else
		step = 1
	end
end)
Module.Stop("Turn")

function findFloorChangePosition( goUp, position )
	for x = -1, 1 do
		for y = -1, 1 do
			if goUp then
				local positionData = Map.GetTopUseItem( position.x + x, position.y + y, position.z )
				-- check for stairs/ramps
				if table.contains( floorUpNonClickIDs, positionData.id ) then
					position.x = position.x + x
					position.y = position.y + y
					position.click = false
					return position
				end
				-- check for ladders/clickables
				if table.contains( floorUpClickIDs, positionData.id ) then
					position.x = position.x + x
					position.y = position.y + y
					position.click = true
					return position
				end
				-- check for exani tera, rope hole
				if table.contains( floorUpRopeIDs, positionData.id ) then
					print("Found rope spot")
					position.x = position.x + x
					position.y = position.y + y
					position.rope = true
					return position
				end
			else
				local positionData = Map.GetTopUseItem( position.x + x, position.y + y, position.z )
				-- check for stairs/ramps
				-- positionData.id = tostring(positionData.id)
				if table.contains( floorDownNonClickIDs, positionData.id ) then
					position.x = position.x + x
					position.y = position.y + y
					position.click = false
					return position
				end
				-- check for ladders/clickables
				if table.contains( floorDownClickIDs, positionData.id ) then
					position.x = position.x + x
					position.y = position.y + y
					position.click = true
					return position
				end
			end
		end
	end
	return nil
end

	tryFloorChangeForSeconds = 12
function moveToFloorChange( spotToMoveTo, rightClick )
	startTime = os.time()
	while os.time() - startTime <= tryFloorChangeForSeconds and Self.Position().z ~= spotToMoveTo.newZ do
		local myPos = Self.Position()
		local distance = getDistance( spotToMoveTo, myPos )
		if distance >= 16 then
			print("Too far, cancelling command")
		elseif distance <= 2 and spotToMoveTo.rope and Self.ItemCount( ropeID ) > 0 then
			--use rope
			Self.UseItemWithGround(ropeID, spotToMoveTo.x , spotToMoveTo.y , spotToMoveTo.z )
		elseif distance == 0 and spotToMoveTo.rope then
			Self.Say("exani tera")
		elseif distance == 1 and not spotToMoveTo.click then
			stepToPosition( spotToMoveTo )
		elseif distance == 1 and spotToMoveTo.rope then
			stepToPosition( spotToMoveTo )
		elseif distance <= 2 and spotToMoveTo.rope then
			Self.UseItemWithGround(ropeID, spotToMoveTo.x , spotToMoveTo.y , spotToMoveTo.z )
		elseif distance <= 2 then
			Self.UseLever(spotToMoveTo.x, spotToMoveTo.y, spotToMoveTo.z)
		elseif Self.FollowID() == 0 then
			Self.UseLever(spotToMoveTo.x, spotToMoveTo.y, spotToMoveTo.z)
		end
		wait(250)
	end
end

function updateSpectators( forceUpdate )
	if forceUpdate or os.time() - lastFetchSpectators > .5 then
		PlayersOnScreen = Self.GetSpectators()
		lastFetchSpectators = os.time()
	end
end

function findAdjacentMcs()
	local adjacentMcs = {}
	updateSpectators( true )
	for i = 1, #PlayersOnScreen do
		if PlayersOnScreen[i]:Name() ~= myCharacterName then
			local mcNamesIndexOfPlayer = checkIfNameIsAnMc( PlayersOnScreen[i]:Name() )
			if mcNamesIndexOfPlayer ~= nil then
				if getDistance( Self.Position(), PlayersOnScreen[i]:Position() ) == 1 then
					-- insert the index of the MC as in the mcNames table
					table.insert( adjacentMcs, mcNamesIndexOfPlayer )
				end
			end
		end
	end
	return adjacentMcs
end

Module.New('potionRequester', function(potionRequester)
	if manaFriendRunning then
		local percent = getCurrentManaPercent()
		if percent < requestManaPotionAtPercent then
			local mcsNearIndexes = findAdjacentMcs()
			for i = 1, #mcsNearIndexes do
				--Topic, message
				--First is MC index, 
				publishMessage( mcsNearIndexes[i], percent .. "/" .. myCharacterName )
			end
		end
	end
	potionRequester:Delay(500)
end)

function potionRequested( text )
	if manaFriendRunning then

		local tempManaRequesteeManaPercent = string.match(text, "(%d*)")
		local tempManaRequesteeName = string.match(text, "%d*/([%a -]*)")

		if tempManaRequesteeManaPercent ~= nil and tempManaRequesteeName ~= nil then
			updateSpectators( true )
			for i = 1, #PlayersOnScreen do
				if tempManaRequesteeName == PlayersOnScreen[i]:Name() then
					if getDistance( Self.Position(), PlayersOnScreen[i]:Position() ) == 1 then
						manaRequesteeManaPercent = string.match(text, "(%d*)")
						manaRequesteeName = string.match(text, "%d*/([%a -]*)")
						manaRequestTimeout = os.time()
						break
					end
				end
			end
		end
	end
end

Module.Stop("Turn")

lastAdjacentFollow = 0
followingAdjacentPlayer = false
Module.New('ZergModule', function(ZergModule)
	if zergRunning then
		updateSpectators()
		fieldContainer = nil
		field = nil
    	for i = 1, #PlayersOnScreen do
    		--Find the player to zerg 									
			if zergFollow == PlayersOnScreen[i]:Name() then
				targetPos = PlayersOnScreen[i]:Position()
				--Get the position of target when first started. This is used to stop when target moves too far
	        	if( getInitialPosition ) then
					initialPosition = targetPos
					getInitialPosition = false
				--Check if the target has moved too far and should stop zerging
	        	elseif( getDistance( initialPosition, targetPos ) > 5 ) then
	        		-- the target has moved more than 5 squares
	        		zergRunning = false
	        		Self.StopFollow()
	        		break
	        	end

	        	-- Check if target is surrounded
	        	local surrounded = checkIfPlayerSurrounded( targetPos )

	        	local distanceToTarget = getDistance( Self.Position(), targetPos )
	        	--if not surrounded or im beside target
	        	if not surrounded or distanceToTarget == 1 then
		        	-- Follow the target
		            followPlayer( PlayersOnScreen[i] )
		            followingAdjacentPlayer = false
		        elseif not followingAdjacentPlayer or (distanceToTarget > 2 and os.time() - lastAdjacentFollow >= 1 ) or Self.FollowID() == 0 then
		        	local foundFollow = false
		        	-- Target is surrounded, follow someone who isnt an MC
		        	for x = 1, #PlayersOnScreen do
		        		local checkingPlayer = PlayersOnScreen[x]:Position()
		        		-- If the player is beside target, and not an MC
		        		if getDistance( targetPos, checkingPlayer ) == 1 and checkIfNameIsAnMc( PlayersOnScreen[x]:Name() ) == nil then
		        			local checkingPlayerSurrounded = checkIfPlayerSurrounded( checkingPlayer )
		        			if not checkingPlayerSurrounded then
		        				followPlayer( PlayersOnScreen[x] )
		        				followingAdjacentPlayer = true
		        				foundFollow = true
		        				lastAdjacentFollow = os.time()
		        				break		
		        			end
		        		end
		        	end

		        	-- Target is surrounded, follow an MC
		        	if not foundFollow then
		        		for x = 1, #PlayersOnScreen do
			        		local checkingPlayer = PlayersOnScreen[x]:Position()
			        		-- If the player is beside target, and not an MC
			        		if getDistance( targetPos, checkingPlayer ) == 1 then
			        			local checkingPlayerSurrounded = checkIfPlayerSurrounded( checkingPlayer )
			        			if not checkingPlayerSurrounded then
			        				followPlayer( PlayersOnScreen[x] )
			        				followingAdjacentPlayer = true
		        					lastAdjacentFollow = os.time()
			        				break		
			        			end
			        		end
			        	end
		        	end
		        end

	            -- IF beside target start trashing under self
	            if distanceToTarget == 1 then
	            	local startPos = Self.Position()
            		fieldContainer = Container.GetLast()
            		--Open browse field
            		if( #Container.GetAll() < bpsOpen + 1 ) then
            			
            			field = Self.BrowseField(startPos.x, startPos.y, startPos.z)
            			fieldContainer = Container.GetLast()
            			browsePos = Self.Position()
            		end
            		if browsePos == nil then
            			fieldContainer:Close()
            			field = Self.BrowseField(startPos.x, startPos.y, startPos.z)
            			wait(100)
            			fieldContainer = Container.GetLast()
            			browsePos = Self.Position()
            		end
            		if (startPos.x ~= browsePos.x or startPos.y ~= browsePos.y) then
            			fieldContainer:Close()
            			wait(100)
            			field = Self.BrowseField(startPos.x, startPos.y, startPos.z)
            			fieldContainer = Container.GetLast()
            			browsePos = Self.Position()
            		end
            		
            		-- Check if someone threw fire over the trash
					local itemUnderSelf = Map.GetTopUseItem(browsePos.x, browsePos.y, browsePos.z)
            		if table.find( elementFieldIDs, itemUnderSelf.id ) then
						emptySpotsToTrash = fieldContainer:EmptySlots() - 4
					end

            		if ( fieldContainer:EmptySlots() >= emptySpotsToTrash ) then
            			throwTrashUnderSelf()
            		end
	            end
	        end
		end
	end	
end)

function throwTrashUnderSelf()
	local myPos = Self.Position()
	if( currentTrashID == TrashIDTwo ) then
		Self.FastDropItem(myPos.x, myPos.y, myPos.z, TrashIDTwo, 1)
		currentTrashID = TrashIDOne
	else
		Self.FastDropItem(myPos.x, myPos.y, myPos.z, TrashIDOne, 1)
		currentTrashID = TrashIDTwo
	end
end

-- Variables passed in are tables with an .x and .y
function getDistance( PositionOne, PositionTwo )
	local xDistance = math.abs(PositionOne.x - PositionTwo.x )
	local yDistance = math.abs(PositionOne.y - PositionTwo.y )
	if xDistance > yDistance then
		return xDistance
	else
		return yDistance
	end
end

function Self.FastDropItem(x, y, z, itemid, count)
	itemid = Item.GetItemIDFromDualInput(itemid)
    local cont = Container.GetFirst()
    count = count or -1 -- either all or some
    while (cont:isOpen() and (count > 0 or count == -1)) do
        local offset = 0
        for spot = 0, cont:ItemCount() do
            local item = cont:GetItemData(spot - offset)
            if (item.id == itemid) then
                local compareCount = cont:CountItemsOfID(itemid) -- save the current count of this itemid to compare later
                local toMove = math.min((count ~= -1) and count or 100, item.count) -- move either the count or the itemcount whichever is lower (if count is -1 then try 100)
                cont:MoveItemToGround(spot - offset, x, y, z, toMove)
                wait(300)
                if (compareCount > cont:CountItemsOfID(itemid)) then -- previous count was higher, that means we were successful
                    if(toMove == item.count)then -- if the full stack was moved, offset
                        offset = offset + 1
                    else
                        return true -- only part of the stack was needed, we're done.
                    end
                    if (count ~= -1) then -- if there was a specified limit, we need to honor it.
                        count = (count - toMove)
                    end
                end
            end
        end
        cont = cont:GetNext()
    end
end

function publishMessage( topic, message )
	myIPC:PublishMessage(topic, message)
end

if UseHud then
	Module.New('FeedHud', function(FeedHud)
		local percent = string.format("%.f", getCurrentManaPercent() )
		local SDCount = Self.ItemCount(3155)
		local GMPCount= Self.ItemCount(238)

		local FeedText = myCharacterIndex .. "/" .. percent.."/"..SDCount.."/"..GMPCount

		publishMessage( 0, FeedText )
	end)
end

function stepToPosition( pos )
	local myPos = Self.Position()
	if myPos.x == pos.x+1 and myPos.y == pos.y-1 then
		Self.Step(SOUTHWEST)
	elseif myPos.x == pos.x-1 and myPos.y == pos.y+1 then
		Self.Step(NORTHEAST)
	elseif myPos.x == pos.x+1 and myPos.y == pos.y+1 then
		Self.Step(NORTHWEST)
	elseif myPos.x == pos.x-1 and myPos.y == pos.y-1 then
		Self.Step(SOUTHEAST)
	elseif myPos.x == pos.x and myPos.y == pos.y-1 then
		Self.Step(SOUTH)
	elseif myPos.x == pos.x and myPos.y == pos.y+1 then
		Self.Step(NORTH)
	elseif myPos.x == pos.x+1 and myPos.y == pos.y then
		Self.Step(WEST)
	elseif myPos.x == pos.x-1 and myPos.y == pos.y then
		Self.Step(EAST)
	end
end

function checkIfPlayerSurrounded( playerPosition )
	local surrounded = true
	for x = -1, 1 do
		for y = -1, 1 do
			if y ~= 0 or x ~= 0 then
				local mapID = Map.GetTopTargetObject(playerPosition.x + x, playerPosition.y + y, playerPosition.z).id
				-- If it is not a player and walkable
				if mapID ~= 99 and Map.IsTileWalkable(playerPosition.x + x, playerPosition.y + y, playerPosition.z) then
					surrounded = false
					break
				end
			end
		end
	end
	return surrounded
end

function onSpeakCommandChannel(channel, text)
	channel:SendYellowMessage('You: ', text)
	publishMessage( "noQueue", text )
end		

function onCloseCommandChannel(channel, text)
	print('[Battle Control Offline]')
	channel:SendOrangeMessage("[Battle Control Offline]", "")
end