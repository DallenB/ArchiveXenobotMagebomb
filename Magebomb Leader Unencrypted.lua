print("\n \n---------------------------")

dofile("../scripts/Magebomb [CONFIG].lua")

if McNames == nil then
	print("Error, File 'Magebomb [CONFIG].lua' missing.")
end

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

HUDTimes = {}
for x = 1, 10 do
	table.insert(HUDTimes, 0)
end

--[[SCRIPT]]

versionNumber = "12.0"

myCharacterIndex = 0

-- colors

Color = {
	Green = {r=1, g=255, b=1},
	Yellow = {r=255, g=255, b=0},
	Orange = {r=255, g=145, b=0},
	Red = {r=228, g=0, b=0},
	Default = {r=172, g=172, b=172},
	White = {r=255, g=255, b=255}
}

--Potion variables
myCharacterName = Self.Name()

-- Para, autosd
AutoParaNames = { }
AutoSDNames = { }
TriggerNames = { }

print("Anoyns Magebomb v"..versionNumber)

function fatalErrorMessage( text )
	while true do
		print("[Fatal Error]: "..text)
		wait(3000)
	end
end

function updateXBSTFiles()
	print("Automatically updating 11 Frag Helpers settings/xbst to match LeaderName and MCNames, for change to take effect reload MC settings")

	updateXBST( "../Settings/"..SettingsAllMCs..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..LeaderName.."\"/>" )

	updateXBST( "../Settings/"..FragReset..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..LeaderName.."\"/>" )

	updateXBST( "../Settings/"..MC1Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[1].."\"/>" )

	updateXBST( "../Settings/"..MC2Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[2].."\"/>" )

	updateXBST( "../Settings/"..MC3Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[3].."\"/>" )

	updateXBST( "../Settings/"..MC4Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[4].."\"/>" )

	updateXBST( "../Settings/"..MC5Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[5].."\"/>" )

	updateXBST( "../Settings/"..MC6Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[6].."\"/>" )

	updateXBST( "../Settings/"..MC7Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[7].."\"/>" )

	updateXBST( "../Settings/"..MC8Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[8].."\"/>" )

	updateXBST( "../Settings/"..MC9Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[9].."\"/>" )

	updateXBST( "../Settings/"..MC10Leader..".xbst", 
		"<control name=\"ComboShotLeader\" value=\"", 
		"<control name=\"ComboShotLeader\" value=\""..McNames[10].."\"/>" )
end

function updateXBST( fileLocation, lineToReplace, replaceLineWith )

	local lines = {}
	local restOfFile
	local replaced = false

	local file = io.open( fileLocation, "r") --Read.

	if file ~= nil then
		for line in file:lines() do
			if string.find( line, lineToReplace ) then
				lines[#lines + 1] = replaceLineWith
				replaced = true
				restOfFile = file:read("*a")
				break
			else
				lines[#lines + 1] = line
			end
		end	
		file:close()

		if replaced then
			--Now modify the file
			file = io.open( fileLocation, "w") --write the file.
			for i, line in ipairs(lines) do
			  file:write(line, "\n")
			end
			file:write(restOfFile)
			file:close()
		else
			print("Error updating XBST, line to replace not found")
		end
	else
		print("Error updating XBST, File not found. Redownload Settings XBST.")
	end

	return replaced
end
updateXBSTFiles()

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
			if index == 0 then
				IPCSubscriptions[index]:AddTopic("cmd")
			end
		end
	end
end
createIPC()

--startup stuff ends here

if not Hotkeys.Register(ChangeAutoSDHotkey) then
    print("Failed to register ChangeAutoSDHotkey %d", value)
end

if not Hotkeys.Register(ChangeAutoParaHotkey) then
    print("Failed to register ChangeAutoParaHotkey %d", value)
end

if not Hotkeys.Register(ChangeTriggerHotkey) then
    print("Failed to register ChangeTriggerHotkey %d", value)
end

if not Hotkeys.Register(ZergHotkey) then
    print("Failed to register ZergHotkey %d", value)
end

if not Hotkeys.Register(TempAutoSDPara) then
    print("Failed to register TempAutoSDPara %d", value)
end

if not Hotkeys.Register(TempAutoSD) then
    print("Failed to register TempAutoSD %d", value)
end
 
autoSDRunning = false
autoParaRunning = false
tempAutoSDRunning = false
tempAutoSDParaRunning = false
lastTargetAdded = ''
function pressHandler(key, control, shift)
	--These hotkeys so far are dependant on a target name
    if lastTargetName ~= nil then
    	if key == TempAutoSD then
    		if not control and not shift then
    			local sameTarget = lastTargetAdded == lastTargetName
    			if tempAutoSDRunning and sameTarget then
    				--turn off
    				local command = "autosd remove " .. lastTargetName
    				publishMessage("queue", command)
        			autoSDRemove(command)
	        		tempAutoSDRunning = false
    			else
    				--new target,remove old one
    				if not sameTarget and lastTargetAdded ~= '' then
	    				local command = "autosd remove " .. lastTargetAdded
	    				publishMessage("queue", command)
		        		autoSDRemove(command)
    				end
    				--turn on
    				local command = "autosd add " .. lastTargetName
    				publishMessage("queue", command)
        			autoSDAdd(command) 
    				if not autoSDRunning then
    					publishMessage("queue", "autosd on")
    					autoSDSetRunning(true)
    				end
    				tempAutoSDRunning = true
	        		lastTargetAdded = lastTargetName
    			end 

    		end
    	elseif key == TempAutoSDPara then
    		if not control and not shift then
    			local sameTarget = lastTargetAdded == lastTargetName
    			if tempAutoSDParaRunning and sameTarget then
    				--turn off
    				local command2 = "para remove " .. lastTargetName
    				local command = "autosd remove " .. lastTargetName
    				publishMessage("queue", command2)
    				publishMessage("queue", command)
	        		autoParaRemove(command2)
	        		autoSDRemove(command)
	        		tempAutoSDParaRunning = false
    			else
    				--new target,remove old one
    				if not sameTarget and lastTargetAdded ~= '' then
	    				local command2 = "para remove " .. lastTargetAdded
	    				local command = "autosd remove " .. lastTargetAdded
	    				publishMessage("queue", command2)
	    				publishMessage("queue", command)
		        		autoParaRemove(command2)
		        		autoSDRemove(command)
    				end
    				--turn on
    				local command2 = "para add " .. lastTargetName
    				local command = "autosd add " .. lastTargetName
    				publishMessage("queue", command2)
    				publishMessage("queue", command)
        			autoParaAdd(command2)
        			autoSDAdd(command) 
    				if not autoSDRunning then
    					publishMessage("queue", "autosd on")
    					autoSDSetRunning(true)
    				end
    				if not autoParaRunning then
    					publishMessage("queue", "para on")
    					autoParaSetRunning(true)
    				end
    				tempAutoSDParaRunning = true
	        		lastTargetAdded = lastTargetName
    			end 

    		end
        elseif key == ChangeAutoSDHotkey then
        	if shift and control then
        		local command = "autosd clear"
        		print("AutoSD cleared" )
				publishMessage( "queue", command)
        		autoSDClear() 
				CommandChannel:SendYellowMessage('You', command)
        	elseif shift then
        		local command = "autosd remove " .. lastTargetName
        		print("AutoSD removing " .. lastTargetName )
				publishMessage( "queue", command)
        		autoSDRemove(command)
				CommandChannel:SendYellowMessage('You', command)
        	elseif control then
        		local command = "autosd add " .. lastTargetName
        		print("AutoSD adding " .. lastTargetName )
				publishMessage( "queue", command)
        		autoSDAdd(command)
				CommandChannel:SendYellowMessage('You', command)
        	end
        elseif key == ChangeAutoParaHotkey then
        	if shift and control then
        		local command = "para clear"
        		print("Para cleared" )
				publishMessage( "queue", command)
        		autoParaClear()
				CommandChannel:SendYellowMessage('You', command)
        	elseif shift then
        		local command = "para remove " .. lastTargetName
        		print("Para removing " .. lastTargetName )
				publishMessage( "queue", command)
        		autoParaRemove(command)
				CommandChannel:SendYellowMessage('You', command)
        	elseif control then
        		local command = "para add " .. lastTargetName
        		print("Para adding " .. lastTargetName )
				publishMessage( "queue", command)
        		autoParaAdd(command)
				CommandChannel:SendYellowMessage('You', command)
        	end
        elseif key == ChangeTriggerHotkey then
			if shift and control then
				local command = "trap trigger clear"
        		print("Trap Trigger cleared" )
				publishMessage( "queue", command)
        		TriggerClear()
				CommandChannel:SendYellowMessage('You', command)
        	elseif shift then
				local command = "trap trigger remove " .. lastTargetName
        		print("Trap Trigger removing " .. lastTargetName )
				publishMessage( "queue", command)
        		TriggerRemove(command)
				CommandChannel:SendYellowMessage('You', command)
        	elseif control then
				local command = "trap trigger add " .. lastTargetName
        		print("Trap Trigger adding " .. lastTargetName )
				publishMessage( "queue", command)
        		TriggerAdd(command)
				CommandChannel:SendYellowMessage('You', command)
        	end
        elseif key == ZergHotkey then
        	if shift then
        		local command = "zerg off"
        		print("Zerg off")
				publishMessage( "queue", "zerg off" )
				CommandChannel:SendYellowMessage('You', "zerg off")
        	elseif control then
        		local command = "zerg " .. lastTargetName
        		print("Zerging " .. lastTargetName )
				publishMessage( "noQueue", command )
				CommandChannel:SendYellowMessage('You', command)
        	end
        end
    end
end
Hotkeys.AddPressHandler(pressHandler)

	function getXAndYDistance( playerPosition, myPosition )
	local distance = {}
	if playerPosition.x ~= nil and playerPosition.y ~= nil and myPosition.x ~= nil and myPosition.y ~= nil then
		distance.x = playerPosition.x - myPosition.x
		distance.y = playerPosition.y - myPosition.y
		return distance
	else
		print("player positon passed not complete. (x,y)")
	end
end

function onSpeakCommandChannel(channel, text)
	local setting_cmd = string.match(text, "(%a+)")
	local resultMessage = "Incorrect format, Example: trap 1 add, trap 1 remove or trap 1 clear"

	if setting_cmd ~= nil then
		outputCommand = true
		setting_cmd = string.lower(setting_cmd)
		if setting_cmd == "dwg" or setting_cmd == 'ue' then
			text = text.."/"..(os.time()+1.5)
			channel:SendYellowMessage('You', text)
		elseif setting_cmd == "mw" or setting_cmd == "mwhole" then
			local ShortText
			if setting_cmd == "mw" then
				ShortText = string.sub(text, 4)
			elseif setting_cmd == "mwhole" then
				ShortText = string.sub(text, 8)
			else
				print("Err, setting_cmd wrong")
			end
			
			playerName = string.match(ShortText, '([%a -]*)')
			print("'"..playerName.."'")
			text = text.."/"..(os.time()+1.5)

			local targetFound = false
			local PlayersOnScreen = Self.GetSpectators()
			for i = 1, #PlayersOnScreen do
				if playerName == PlayersOnScreen[i]:Name() then
					print("Player found")
					

					local myPos = Self.Position()
					local distance = getXAndYDistance( PlayersOnScreen[i]:Position(), myPos )

					if math.abs(distance.x) > math.abs(distance.y) then
						--target horizontal
						if distance.x < 0 then
							--target to left
							print("Target to left")
							text = text.."/right"
							targetFound = true
						else
							--target to right
							print("Target to right")
							text = text.."/left"
							targetFound = true
						end
					else
						--target vertical
						if distance.y < 0 then
							--target above
							print("Target above")
							text = text.."/down"
							targetFound = true
						else
							print("Target below")
							text = text.."/up"
							targetFound = true
						end
					end

				end
			end

			if not targetFound then
				channel:SendYellowMessage('You', text)
				channel:SendOrangeMessage('Script', "Target has to be onscreen to use mw." )

			else
				channel:SendYellowMessage('You', text)
			end

		elseif setting_cmd == "manafriend off" then
			manaFriendRunning = false
			channel:SendYellowMessage('You', text)
		elseif setting_cmd == "manafriend on" then
			manaFriendRunning = true
			channel:SendYellowMessage('You', text)
			--supply [AMOUNT] [ITEM_ID]
		elseif setting_cmd == "supply" then
			channel:SendYellowMessage('You', text)
		
			supplyID = string.match(text, "%a+ %d+ (%d+)")
			supplyAmount = string.match(text, "%a+ (%d+) %d+")
			if supplyID ~= nil and supplyAmount ~= nil then
				supplyAmount = tonumber(supplyAmount)
				supplyID = tonumber(supplyID)
				
				PlayersOnScreen = Self.GetSpectators()
				for i = 1, #PlayersOnScreen do
					if McNames[1] == PlayersOnScreen[i]:Name() then
						local toPos = PlayersOnScreen[i]:Position()
						Self.DropItem(toPos.x, toPos.y, toPos.z, supplyID, supplyAmount)
						return true
					end
				end
				
				--supplyAmountLeft = supplyAmount
				--supplyRunning = true
				--supplyFailCount = 0
				--supplyBuying = false
				--supplyStartCount = Self.ItemCount(supplyID)
				--channel:SendYellowMessage('Script', "Throwing " .. supplyAmount .. " of " .. supplyAmount .. ".")
			else
				channel:SendYellowMessage('Script', "Invalid syntax, Example: supply [AMOUNT] [ITEMID]")
			end
			
		elseif setting_cmd == "buysupply" then
			channel:SendYellowMessage('You', text)
		
			supplyID = string.match(text, "%a+ %d+ (%d+)")
			supplyAmount = string.match(text, "%a+ (%d+) %d+")
			if supplyID ~= nil and supplyAmount ~= nil then
				supplyAmount = tonumber(supplyAmount)
				supplyAmountLeft = supplyAmount
				supplyID = tonumber(supplyID)
				supplyRunning = true
				supplyFailCount = 0
				supplyBuying = true
				Self.SayToNpc({"hi", "trade"}, 100)
				channel:SendYellowMessage('Script', "Buying and throwing " .. supplyAmount .. " of " .. supplyAmount .. ".")
				wait(1200)
			else
				channel:SendYellowMessage('Script', "Invalid syntax, Example: buysupply [AMOUNT] [ITEMID]")
			end
			
		elseif setting_cmd == 'trap' then
			local cmd_type = string.match(text, "%a+ %d+ (%a+)")
			local trap_Postfix = string.match(text, "%a+ (%a+)")
			local trap_number = string.match(text, "%a+ (%d+)")
			if cmd_type ~= nil and trap_number ~= nil then
				local pos = Self.Position()
				if ( cmd_type == "add" ) then
					local rune_type = string.match(text, "%a+ %d+ %a+ (%a+)")
					if rune_type == nil then --verifaciton fixed 
						print("This was rune type....."..rune_type)
						resultMessage = "Incorrect format, Example: trap 1 add mw, trap 1 add wg, trap 1 add trigger, trap 1 remove or trap 1 clear"
					elseif rune_type == "wg" then
						resultMessage = "Added current position to trap "..trap_number.."  as Wild Growth. ( X="..pos.x..", Y="..pos.y..", Z="..pos.z.." )"
						text = text.." "..pos.x.." "..pos.y.." "..pos.z
					elseif rune_type == "mw" then
						resultMessage = "Added current position to trap "..trap_number.." as Magic Wall. ( X="..pos.x..", Y="..pos.y..", Z="..pos.z.." )"
						text = text.." "..pos.x.." "..pos.y.." "..pos.z
					elseif rune_type == "trigger" then
						resultMessage = "Added current position to trap "..trap_number.."  as a trigger. ( X="..pos.x..", Y="..pos.y..", Z="..pos.z.." )"
						text = text.." "..pos.x.." "..pos.y.." "..pos.z
					end
				elseif ( cmd_type == "remove") then
					resultMessage = "Removing current position from trap "..trap_number..". ( X="..pos.x..", Y="..pos.y..", Z="..pos.z.." )"
					text = text.." "..pos.x.." "..pos.y.." "..pos.z
				elseif ( cmd_type == "clear" ) then
					resultMessage =  "Cleared all spots from trap "..trap_number.."."
				end

			elseif trap_Postfix ~= nil and trap_Postfix == "trigger" then
				local trap_Trigger_Postfix = string.match(text, "%a+ %a+ (%a+)")
				if trap_Trigger_Postfix ~= nil then
					if trap_Trigger_Postfix == "on" then
						resultMessage = "Triggers on"
						TriggerSetRunning( true )
					elseif trap_Trigger_Postfix == "off" then
						resultMessage = "Triggers off"
						TriggerSetRunning( false )
					elseif trap_Trigger_Postfix == "add" then
						TriggerAdd( text )

					elseif trap_Trigger_Postfix == "remove" then
						TriggerRemove( text )

					elseif trap_Trigger_Postfix == "clear" then
						resultMessage = "All players have been removed from trigger watch"
						TriggerClear()
					end
				end
			else
				resultMessage = "Incorrect format, Example: trap 1 add mw, trap 1 add wg, trap 1 add trigger, trap 1 remove or trap 1 clear"
			end
			channel:SendYellowMessage('You', text)
			channel:SendOrangeMessage('Script', resultMessage )


		elseif setting_cmd == 'help' then
			local setting_value = string.sub(text, 6)
			channel:SendYellowMessage('You', text)
			tryHelp( setting_value )

		elseif setting_cmd == 'autosd' then
			setting_value = string.match( text, "%a+ (%a*)")
			if setting_value ~= nil then
				if setting_value == "on" then
					autoSDSetRunning( true )

				elseif setting_value == "off" then
					autoSDSetRunning( false )

				elseif setting_value == 'remove' then
					autoSDRemove( text )

				elseif setting_value == 'add' then
					autoSDAdd( text )

				elseif setting_value == 'clear' then
					autoSDClear()

				end
			end
			channel:SendYellowMessage('You', text)

		elseif setting_cmd == 'para' then
			setting_value = string.match( text, "%a+ (%a*)")
			if setting_value ~= nil then
				if setting_value == "on" then
					autoParaSetRunning( true )

				elseif setting_value == "off" then
					autoParaSetRunning( false )

				elseif setting_value == 'remove' then
					autoParaRemove( text )

				elseif setting_value == 'add' then
					autoParaAdd( text )

				elseif setting_value == 'clear' then
					autoParaClear()

				end
			end
			channel:SendYellowMessage('You', text)
		elseif setting_cmd == "floorfollow" then
			outputCommand = false
			setting_value = string.match( text, "%a+ (%a*)")
			if setting_value ~= nil then
				if setting_value == "on" then
					print("Floor following enabled")
					oldPos = Self.Position()
					floorFollowRunning = true

				elseif setting_value == "off" then
					print("Floor following disabled")
					floorFollowRunning = false
				end
			end
			channel:SendYellowMessage('You', text)

		else
			channel:SendYellowMessage('You', text)
		end

		if outputCommand then
			local firstWord = string.match( text, "(%a+)")
			if firstWord ~= nil then
	 			if table.contains( dontQueueTheseCommands, firstWord ) then 
					publishMessage( "noQueue", text )
	 			else
					publishMessage( "queue", text )
	 			end
	 		end
		end
	end
	
end

-- TRIGGER HUD FUNCTIONS
function TriggerSetRunning( running )
	if UseHud then
		if running then
			HUD.RunningModules.Trigger:SetTextColor(Color.Green.r,Color.Green.g,Color.Green.b)
			HUD.RunningModules.TriggerTargets:SetTextColor(Color.Green.r,Color.Green.g,Color.Green.b)
		else
			HUD.RunningModules.Trigger:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
			HUD.RunningModules.TriggerTargets:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		end
	end
end

function TriggerRemove( text )
	local text = string.match( text, "%a* %a* %a* ([%a -]*)")
	if text ~= nil then
		-- if removed successfully
		if removePlayerFromTable( TriggerNames, text ) then
			if UseHud then
				local finalString = ""
				for i = 1, #TriggerNames do
					finalString = finalString..TriggerNames[i]..", "
				end
				HUD.RunningModules.TriggerTargets:SetText(finalString)
			end
		end
	end
end

function TriggerAdd( text )
	local text = string.match( text, "%a* %a* %a* ([%a -]*)")
	if text ~= nil and not isPlayerInTable(TriggerNames, text) then
		table.insert(TriggerNames, text)
		if UseHud then
			local finalString = ""
			for i = 1, #TriggerNames do
				if i == 1 then
					finalString = finalString..TriggerNames[i]
				else
					finalString = finalString..", "..TriggerNames[i]
				end
			end
			HUD.RunningModules.TriggerTargets:SetText(finalString)
		end
	end
end

function TriggerClear()
	TriggerNames = {}
	if UseHud then
		HUD.RunningModules.TriggerTargets:SetText("")
	end
end

-- AUTO SD HUD FUNCTIONS
function autoSDSetRunning( running )
	autoSDRunning = running
	if UseHud then
		if running then
			HUD.RunningModules.AutoSD:SetTextColor(Color.Green.r,Color.Green.g,Color.Green.b)
			HUD.RunningModules.AutoSDTargets:SetTextColor(Color.Green.r,Color.Green.g,Color.Green.b)
		else
			HUD.RunningModules.AutoSD:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
			HUD.RunningModules.AutoSDTargets:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		end
	end
end

function autoSDRemove( text )
	local name = string.match( text, "%a* %a* ([%a '-]*)")
	if name ~= nil then
		-- if removed successfully
		if removePlayerFromTable( AutoSDNames, name ) then
			if UseHud then
				local finalString = ""
				for i = 1, #AutoSDNames do
					finalString = finalString..AutoSDNames[i]..", "
				end
				HUD.RunningModules.AutoSDTargets:SetText(finalString)
			end
		end
	end
end

function autoSDAdd( text )
	local name = string.match( text, "%a* %a* ([%a '-]*)")
	if name ~= nil and not isPlayerInTable(AutoSDNames, name) then
		table.insert(AutoSDNames, name)
		if UseHud then
			local finalString = ""
			for i = 1, #AutoSDNames do
				if i == 1 then
					finalString = finalString..AutoSDNames[i]
				else
					finalString = finalString..", "..AutoSDNames[i]
				end
			end
			HUD.RunningModules.AutoSDTargets:SetText(finalString)
		end
	end
end

function autoSDClear()
	AutoSDNames = {}
	if UseHud then
		HUD.RunningModules.AutoSDTargets:SetText("")
	end
end

--AUTO PARA HUD FUNCTIONS
function autoParaSetRunning( running )
	autoParaRunning = running
	if UseHud then
		if running then
			HUD.RunningModules.AutoPara:SetTextColor(Color.Green.r,Color.Green.g,Color.Green.b)
			HUD.RunningModules.AutoParaTargets:SetTextColor(Color.Green.r,Color.Green.g,Color.Green.b)
		else
			HUD.RunningModules.AutoPara:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
			HUD.RunningModules.AutoParaTargets:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		end
	end
end

function autoParaRemove( text )
	local name = string.match( text, "%a* %a* ([%a -']*)")
	if name ~= nil then
		-- if removed successfully
		if removePlayerFromTable( AutoParaNames, name ) then
			if UseHud then
				resetParaHudText()
			end
		end
	end
end

function autoParaAdd( text )
	local name = string.match( text, "%a* %a* ([%a -']*)")
	if name ~= nil and not isPlayerInTable(AutoParaNames, name) then
		table.insert(AutoParaNames, name)
		if UseHud then
			resetParaHudText()
		end
	end
end

function resetParaHudText()
	if UseHud then
		local finalString = ""
		for i = 1, #AutoParaNames do
			if i == 1 then
				finalString = finalString..AutoParaNames[i]
			else
				finalString = finalString..", "..AutoParaNames[i]
			end
		end
		HUD.RunningModules.AutoParaTargets:SetText(finalString)
	end
end

function autoParaClear()
	AutoParaNames = {}
	if UseHud then
		resetParaHudText()
	end
end

--AutoTrap Functions
function isPlayerInTable( tableToCheck, name )
	local wasFound = false
	if name ~= nil then
		for i = 0, #tableToCheck, 1 do
			if( name == tableToCheck[i] ) then
				table.remove(tableToCheck, i)
				wasFound = true
				break
			end
		end
	end
	return wasFound
end

function removePlayerFromTable( tableToRemoveFrom, name )
	local wasFound = false
	if name ~= nil then
		for i = 0, #tableToRemoveFrom, 1 do
			if( name == tableToRemoveFrom[i] ) then
				table.remove(tableToRemoveFrom, i)
				wasFound = true
				break
			end
		end
		if not wasFound then
			print( "Player "..name.." not found.")
		end
	end
	return wasFound
end

function writeToCommandChannel( text )
	CommandChannel:SendOrangeMessage('Script', text )
end

function onCloseCommandChannel(channel, text)
	print('[Reopening Channel]')
	CommandChannel = Channel.Open("[Commands]", onSpeakCommandChannel, onCloseCommandChannel)
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

function findAdjacentMcs()
	local adjacentMcs = {}
	PlayersOnScreen = Self.GetSpectators()
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

function getCurrentManaPercent()
	return math.floor(( Self.Mana() * 100 ) / Self.MaxMana())
end

Module.New('IPCChecker', function(IPCChecker)
	--For each IPC
	for i = 0, #IPCSubscriptions do
		if i ~= myCharacterIndex then
			local hasMessage, topic, data = IPCSubscriptions[i]:Recv()
		    while (hasMessage) do
		        --Only have the stat topic, so every one will be a good update

	        	if UseHud then
					UpdateHud(data)
				end
				hasMessage, topic, data = IPCSubscriptions[i]:Recv()
		    end
		end
	end
end)

--Throw supply to first MC
--Returns true if attempted throw
function supplyThrow()
	--Get position of first MC
	PlayersOnScreen = Self.GetSpectators()
	for i = 1, #PlayersOnScreen do
		if McNames[1] == PlayersOnScreen[i]:Name() then
			local toPos = PlayersOnScreen[i]:Position()
			Self.DropItem(toPos.x, toPos.y, toPos.z, supplyID, supplyAmountLeft)
			return true
		end
	end
	return false
end

supplyBuyingAmount = 0
supplyFailLimit = 6
Module.New('supplyMCs', function(supplyMCs)
	if supplyRunning then
		if supplyBuying then
			if supplyFailCount > supplyFailLimit then
				writeToCommandChannel("Supply failed, Sent " .. supplyAmount - supplyAmountLeft .. " of " .. supplyAmount .. " successfully.")
				writeToCommandChannel("Ensure NPC trade window open, clear throwing path to first MC, bought items are in visible window, enough money and enough capacity for one stack.")
				supplyRunning = false
			--If just bought, throw
			elseif supplyJustBought then
				if Self.ItemCount(supplyID) > beforeSupplyAmount then
					--Successfully bought, throw
					beforeSupplyAmount =  Self.ItemCount(supplyID)
					if supplyThrow() then
						supplyJustThrew = true -- check if threw next time
						supplyJustBought = false
					else
						supplyFailCount = supplyFailCount + 1
						--Did not find position to throw to, repeat supplyJustBought
					end
					
					
				else -- Did not buy any more, add fail count
					supplyFailCount = supplyFailCount + 1
					supplyJustBought = false -- try buying next time
				end	
			--else Check if more to buy
			elseif supplyAmountLeft > 0 then
				--if coming back from throw
				local supplyTryBuying = true
				if supplyJustThrew then
					if Self.ItemCount(supplyID) <= beforeSupplyAmount - supplyBuyingAmount then
						supplyAmountLeft = supplyAmountLeft - supplyBuyingAmount
						supplyJustThrew = false
					else -- throw failed
						supplyTryBuying = false
						supplyFailCount = supplyFailCount + 1
					end
				end
				--Make sure we still need to buy more...
				if supplyTryBuying and supplyAmountLeft > 0 then
					--Buy stack of item
					beforeSupplyAmount = Self.ItemCount(supplyID)
					supplyBuyingAmount = supplyAmountLeft < 100 and supplyAmountLeft or 100
					Self.ShopBuyItem(supplyID, supplyBuyingAmount) 
					supplyJustBought = true
				end
				
			else --done
				supplyRunning = false
				writeToCommandChannel("Supply complete.")
				print("Supply complete.")
			end
			
		end
	else
	--Todo
		supplyRunning = false
	end
	supplyMCs:Delay(200)
end)

function publishMessage( topic, message )
	myIPC:PublishMessage(topic, message)
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

function updateTargetID()
    local curTargetID = Self.TargetID()
    if( curTargetID ~= 0 and lastTargetID ~= curTargetID ) then
        local enemyCreature = Creature.New(curTargetID) 
        if( enemyCreature:isPlayer() ) then
            lastTargetID = curTargetID
            lastTargetName = enemyCreature:Name()
        end
    end
end

oldPos = Self.Position()
Module.New('floorChangeChecker', function(floorChangeChecker)
	if floorFollowRunning then
		local newPos = Self.Position()
		if oldPos.z > newPos.z and getDistance( oldPos, newPos ) <= 5 then
			publishMessage( "queue", "floorchange "..oldPos.x.." "..oldPos.y.." "..oldPos.z.." "..newPos.z )
		
		elseif oldPos.z < newPos.z and getDistance( oldPos, newPos ) <= 5 then
			publishMessage( "queue", "floorchange "..oldPos.x.." "..oldPos.y.." "..oldPos.z.." "..newPos.z )
		
		end
		oldPos = Self.Position()
	end

	updateTargetID()

	floorChangeChecker:Delay(300)
end)

CommandChannel = Channel.Open("[Commands]", onSpeakCommandChannel, onCloseCommandChannel)

function tryHelp( setting_value )
	--added 
	if setting_value == nil or setting_value == "" then
		writeToCommandChannel("'help' say 'help COMMAND'. Available help postfixes are { backup, ladder, lootbodies, go right, hurup, food, travel, ladder, ladder self, heal add, heal remove, heal, yell, say, outfit, summon")
		writeToCommandChannel(" rfollow, follow, 2follow, d, dd, faceright, right, rright, fire, addtrap, removetrap, autotrap, para add, para remove, para, para clear, wg, dwg, mw, mwhole, ue, changeue,")
		writeToCommandChannel(" trap, trap add, trap remove, trap clear, trap trigger, t, zerg, status, manafriend, autosd, autosd add, autosd remove, autosd clear, pickup, pickup have, pickup cap, reload script, throw, buysupply }")
	elseif setting_value == "backup" then
		writeToCommandChannel("'backup' changes the Combo leader to whoever says 'backup'. Note: You have to change the frag leader files for this to work (Read setup)")
	elseif setting_value == "ladder" then
		writeToCommandChannel("'ladder' All MCs will right click the square the leader is standing on. Works with ladders, sewers etc.")
	elseif setting_value == "ladder self" then
		writeToCommandChannel("'ladder self' All MCs will right click the square they are standing on. Works with ladders, sewers etc.")
	elseif setting_value == "status" or setting_value =='local status' then
		writeToCommandChannel("'status' Clients will message with their item counts. (Was added before HUD)")
	elseif setting_value == "go right" or setting_value == "go left" or setting_value == "go up" or setting_value == "go down"then
		writeToCommandChannel("'go DIRECTION' MCs will move to the square beside you (up/down/right/left). Use for going down stairs, holes etc.")
	elseif setting_value == "hurup" or setting_value == "hurdown" then
		writeToCommandChannel("'hurup u' Clients will hur up or down, and face the direction u/r/l/d")
	elseif setting_value == "food" then
		writeToCommandChannel("'food' MCs will throw food under leader")
	elseif setting_value == "lootbodies" then
		writeToCommandChannel("'lootbodies' MCs will loot player bodies by default, Disable/Enable with lootbodies on/off")
	elseif setting_value == "throw" then
		writeToCommandChannel("'throw' MCs will throw a choosen amount of an item ID under the leader. Ex: 'throw 50 3155' will throw 50 3155(SDs)")
	elseif setting_value == "travel" then
		writeToCommandChannel("'travel' ex: 'travel thais', clients will say 'hi', 'CITY', 'yes'")
	elseif setting_value == "heal add" then
		writeToCommandChannel("'heal add' ex: heal add playerName' MCs will exura sio any players added.")
	elseif setting_value == "heal remove" then
		writeToCommandChannel("'heal remove' ex: 'heal remove playerName' MCs will stop sioing the player specified.")
	elseif setting_value == "'heal'" then
		writeToCommandChannel("'heal' MCs cast exura gran mas res, Note: for automatic sios see, help 'heal remove', 'heal add'")
	elseif setting_value == "yell" then
		writeToCommandChannel("'yell' MCs will yell specified text")
	elseif setting_value == "say" then
		writeToCommandChannel("'say' MCs will say specified text")
	elseif setting_value == "outfit" then
		writeToCommandChannel("'MCs will utevo res ina to specified monster. 'off' to stop illusion")
	elseif setting_value == "summon" then
		writeToCommandChannel("'summon' MCs will summon last outfit creature")
	elseif setting_value == "rfollow" then
		writeToCommandChannel("'rfollow' MCs will form a backwards line, with the last McName leading and first McName at the end. ex: 'rfollow on/off'")
	elseif setting_value == "follow" then
		writeToCommandChannel("'follow' MCs will form a line following the leader. ex: 'follow on/off'")
	elseif setting_value == "2follow" then
		writeToCommandChannel("'2follow' MCs will form two lines following the leader. ex: '2follow on/off'")
	elseif setting_value == "d" or setting_value == "u" or setting_value == "l" or setting_value == "r" then
		writeToCommandChannel("'d/r/l/u' MCs will Magic wall to specific direction of player. d = Down, r = Right etc.")
	elseif setting_value == "dd" then
		writeToCommandChannel("'dd/rr/ll/uu' MCs will Magic Wall to specific direction of Fifth MC. dd = Down, rr = Right etc.")
	elseif setting_value == "wg" then
		writeToCommandChannel("'wg' MCs will wild growth wall around the specified player. Ex: 'wg playerName' Note: dwg does this better")
	elseif setting_value == "faceright" or setting_value == "faceleft" or setting_value == "faceup" or setting_value == "facedown" then
		writeToCommandChannel("'facedirection' MCs will turn to the direction.")
	elseif setting_value == "right" or setting_value == "left" or setting_value == "down" or setting_value == "up" then
		writeToCommandChannel("'direction' MCs will move one square in the direction.")
	elseif setting_value == "rright" or setting_value == "lleft" or setting_value == "ddown" or setting_value == "uup" then
		writeToCommandChannel("'direction' MCs will move multiple squares in the direction.")
	elseif setting_value == "fire" then
		writeToCommandChannel("'fire' MCs will use a firebomb rune on themselves.")
	elseif setting_value == "addtrap" then
		writeToCommandChannel("'addtrap' add a player to the WG trap list. Ex: 'addtrap PlayerName'")
	elseif setting_value == "removetrap" then
		writeToCommandChannel("'removetrap' removes a player from the WG trap list. Ex: 'removetrap PlayerName")
	elseif setting_value == "autotrap" then
		writeToCommandChannel("'autotrap' a Wild growth trap that spams at specific players on screen. Ex: trap on/off. To add/remove (help addtrap, help removetrap)")
	elseif setting_value == "para add" then
		writeToCommandChannel("'para add' add a player to the paralyze list. Ex: 'para add PlayerName'")
	elseif setting_value == "para remove" then
		writeToCommandChannel("'para remove' removes a player from the paralyze list. Ex: 'para remove PlayerName")
	elseif setting_value == "para clear" then
		writeToCommandChannel("'para clear' removes all players from the paralyze list. Ex: 'para clear")
	elseif setting_value == "para" then
		writeToCommandChannel("'para' A list of players to paralyze when they are on screen. Ex: para on/off. To add/remove (help para add, help para remove, help para clear)")
	elseif setting_value == "dwg" then
		writeToCommandChannel("'dwg' (Delayed Wild Growth) Waits 2 seconds (To coordinate between MCs) then casts wild growth runes around the specified player. Ex: 'dwg playerName'")
	elseif setting_value == "mw" then
		writeToCommandChannel("'mw' (Delayed Magic Wall) Waits 2 seconds (To coordinate between MCs) then casts magic wall runes around the specified player. Ex: 'mw playerName'")
		writeToCommandChannel("To use mw successfully you should be between MCs and target and all mcs can see all 9 squares surrounding the target.")
	elseif setting_value == "mwhole" then
		writeToCommandChannel("'mwhole' (Delayed Magic Wall with WG hole) Waits 2 seconds (To coordinate between MCs) then casts magic wall runes around the specified player, the spot closest to leader will be WG instead of MW (To shoot through). Ex: 'mwhole playerName'")
		writeToCommandChannel("To use mwhole successfully you should be between MCs and target and all mcs can see all 9 squares surrounding the target.")
	elseif setting_value == "ue" then
		writeToCommandChannel("'ue' Clients wait 2 seconds then cast a UE at the same time. (to change UE 'changeue spellName)")
	elseif setting_value == "changeue" then
		writeToCommandChannel("'ue' Change the ue spell. Ex: 'changeue exevo gran mas frigo'. (To cast say 'ue')")
	elseif setting_value == "autosd" then
		writeToCommandChannel("'autosd' MCs will SD targets constantly. autosd on/off. (See autosd remove, autosd add, autosd clear")
	elseif setting_value == "autosd clear" then
		writeToCommandChannel("'autosd' All targets previously added to autosd are removed.")
	elseif setting_value == "autosd add" then
		writeToCommandChannel("'autosd add' Add a player to the autosd list. Ex: 'autosd add playerName'")
	elseif setting_value == "autosd remove" then
		writeToCommandChannel("'autosd remove' Remove a player to the autosd list. Ex: 'autosd remove playerName'")
	elseif setting_value == "trap" then
		writeToCommandChannel("'trap' Setup positions for MCs to WG or MW on command. (see help trap add, help trap remove, help trap clear)")
	elseif setting_value == "trap add" then
		writeToCommandChannel("'trap add' Add the spot you are standing on to be trapped. You can have multiple traps setup and specify the trap type Ex: 'trap 1 add mw', 'trap 2 add wg' or 'trap 2 add trigger' (to launch trap say 't 1' where 1 is the trap number you added them too.)")
	elseif setting_value == "trap trigger" then
		writeToCommandChannel("'trap trigger' Traps can trigger automatically when specified players walk over a trigger spot. Ex: 'trap trigger on/off, 'trap trigger add PLAYER', trap trigger remove PLAYER")
	elseif setting_value == "t" then
		writeToCommandChannel("'t' launch a specific trap after you have added spots to it. Ex: 't 1' or 't 2'")
	elseif setting_value == "trap remove" then
		writeToCommandChannel("'trap remove' Removes the current position from the specified trap Ex: 'trap 1 remove'")
	elseif setting_value == "trap clear" then
		writeToCommandChannel("'trap clear' Removes all spots previously added to the trap number. Ex: 'trap 1 clear'")
	elseif setting_value == "zerg" then
		writeToCommandChannel("'zerg' MCs will follow the specified player and throw garbage (Worms and Gold Coins by default) under themselves. Ex: 'zerg playerName' and 'zerg off'")
	elseif setting_value == "manafriend" then
		writeToCommandChannel("'manafriend' MCs will use mana potions on eachother when one MCs mana is low. On by default. Ex: 'manafriend on/off'")
	elseif setting_value == "pickup" then
		writeToCommandChannel("'pickup' Units pickup item underneath them. Also see 'help pickup have' and 'help pickup cap'")
	elseif setting_value == "pickup have" then
		writeToCommandChannel("'pickup have' MCs will pickup the specified amount of items from undernearth them. When they have enough they will pass the items down the line. (Throw supplies under first MC)")
		writeToCommandChannel("To start, pickup have [AMOUNT] [ITEM_ID] Ex: 'pickup have 50 3035 will take 50 of item 3035 underneath them")
	elseif setting_value == "pickup cap" then
		writeToCommandChannel("'pickup have' MCs will pickup GMP and SDs from undernearth them. When they have under the capacity specified to leave they will pass the items down the line. (Throw supplies under first MC)")
		writeToCommandChannel("To start, pickup cap [CAP TO LEAVE] Ex: 'pickup cap 50 will take GMP and SD underneath them until they have 50 cap.")
	elseif setting_value == "reload script" then
		writeToCommandChannel("The settings and script will be reloaded. (Note: Will only work if script is currently running)")
	elseif setting_value == "buysupply" then
		writeToCommandChannel("Automatically buy X amount of an item from an NPC and throws it under the first MC. To use stand beside NPC and have clear throwing path to the first MC. ")
		writeToCommandChannel("Correct format is, buysupply [AMOUNT] [ITEMID]. For example, to buy 1200 GMPs would be buysupply 1200 238")
	end
end

function resetHUDForMC( MCNumber)
	if MCNumber == 1 then
		HUD.MCMana.MC1.EndBorder:SetText("")

		HUD.MCMana.MC1.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC1.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC1.SDs:SetText("##") 
		HUD.MCSupplies.MC1.GMPs:SetText("##")
		
		HUD.MCSupplies.MC1.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC1.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 2 then
		HUD.MCMana.MC2.EndBorder:SetText("")

		HUD.MCMana.MC2.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC2.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC2.SDs:SetText("##") 
		HUD.MCSupplies.MC2.GMPs:SetText("##")

		HUD.MCSupplies.MC2.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC2.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 3 then
		HUD.MCMana.MC3.EndBorder:SetText("")

		HUD.MCMana.MC3.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC3.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC3.SDs:SetText("##") 
		HUD.MCSupplies.MC3.GMPs:SetText("##")

		HUD.MCSupplies.MC3.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC3.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 4 then
		HUD.MCMana.MC4.EndBorder:SetText("")

		HUD.MCMana.MC4.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC4.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC4.SDs:SetText("##") 
		HUD.MCSupplies.MC4.GMPs:SetText("##")

		HUD.MCSupplies.MC4.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC4.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 5 then
		HUD.MCMana.MC5.EndBorder:SetText("")

		HUD.MCMana.MC5.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC5.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC5.SDs:SetText("##") 
		HUD.MCSupplies.MC5.GMPs:SetText("##")

		HUD.MCSupplies.MC5.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC5.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 6 then
		HUD.MCMana.MC6.EndBorder:SetText("")

		HUD.MCMana.MC6.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC6.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC6.SDs:SetText("##") 
		HUD.MCSupplies.MC6.GMPs:SetText("##")

		HUD.MCSupplies.MC6.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC6.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 7 then
		HUD.MCMana.MC7.EndBorder:SetText("")

		HUD.MCMana.MC7.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC7.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC7.SDs:SetText("##") 
		HUD.MCSupplies.MC7.GMPs:SetText("##")

		HUD.MCSupplies.MC7.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC7.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 8 then
		HUD.MCMana.MC8.EndBorder:SetText("")

		HUD.MCMana.MC8.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC8.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC8.SDs:SetText("##") 
		HUD.MCSupplies.MC8.GMPs:SetText("##")

		HUD.MCSupplies.MC8.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC8.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 9 then
		HUD.MCMana.MC9.EndBorder:SetText("")

		HUD.MCMana.MC9.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC9.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC9.SDs:SetText("##") 
		HUD.MCSupplies.MC9.GMPs:SetText("##")

		HUD.MCSupplies.MC9.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC9.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	elseif MCNumber == 10 then
		HUD.MCMana.MC10.EndBorder:SetText("")

		HUD.MCMana.MC10.Amount:SetText('                OFFLINE')
		HUD.MCMana.MC10.Amount:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC10.SDs:SetText("##") 
		HUD.MCSupplies.MC10.GMPs:SetText("##")

		HUD.MCSupplies.MC10.SDs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
		HUD.MCSupplies.MC10.GMPs:SetTextColor(Color.Default.r,Color.Default.g,Color.Default.b)
	end
end

TimeBeforeAssumingOffline = 6
Module.New('HUDTimer', function(HUDTimer)
	for i = 1, #HUDTimes do
		-- 0 represents offline
		if HUDTimes[i] ~= 0 and os.time() - HUDTimes[i] >= TimeBeforeAssumingOffline then 
			HUDTimes[i] = 0
			resetHUDForMC( i )
		end
	end
	HUDTimer:Delay(1000)
end)

if UseHud then
		HUD =
		{
			Title = HUD.New(10, 20, "Anoyns Magebomb v"..versionNumber, 30, 144, 255),
			ManaHeader = HUD.New(10, 40, 'MANA', Color.Orange.r,Color.Orange.g,Color.Orange.b),

			MCMana =
			{
				MC1 =
				{
					EndBorder = HUD.New(57, 60, '', 0,0,0),
					Name = HUD.New(10, 60, 'MC1', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 60, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC2 =
				{
					EndBorder = HUD.New(57, 75, '', 0,0,0),
					Name = HUD.New(10, 75, 'MC2', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 75, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC3 =
				{
					EndBorder = HUD.New(57, 90, '', 0,0,0),
					Name = HUD.New(10, 90, 'MC3', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 90, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC4 =
				{
					EndBorder = HUD.New(57, 105, '', 0,0,0),
					Name = HUD.New(10, 105, 'MC4', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 105, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC5 =
				{
					EndBorder = HUD.New(57, 120, '', 0,0,0),
					Name = HUD.New(10, 120, 'MC5', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 120, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC6 =
				{
					EndBorder = HUD.New(57, 135, '', 0,0,0),
					Name = HUD.New(10, 135, 'MC6', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 135, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC7 =
				{
					EndBorder = HUD.New(57, 150, '', 0,0,0),
					Name = HUD.New(10, 150, 'MC7', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 150, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC8 =
				{
					EndBorder = HUD.New(57, 165, '', 0,0,0),
					Name = HUD.New(10, 165, 'MC8', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 165, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC9 =
				{
					EndBorder = HUD.New(57, 180, '', 0,0,0),
					Name = HUD.New(10, 180, 'MC9', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 180, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC10 =
				{
					EndBorder = HUD.New(57, 195, '', 0,0,0),
					Name = HUD.New(10, 195, 'MC10', Color.White.r,Color.White.g,Color.White.b),
					Amount = HUD.New(60, 195, '                OFFLINE', Color.Default.r,Color.Default.g,Color.Default.b)
				},
			},
			SuppliesHeader = HUD.New(10, 215, 'SUPPLIES           (SD  | GMP)', Color.Orange.r,Color.Orange.g,Color.Orange.b),
			MCSupplies =
			{
				MC1 =
				{
					Name = HUD.New(10, 230, 'MC1', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 230, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 230, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 230, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC2 =
				{
					Name = HUD.New(10, 245, 'MC2', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 245, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 245, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 245, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC3 =
				{
					Name = HUD.New(10, 260, 'MC3', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 260, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 260, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 260, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC4 =
				{
					Name = HUD.New(10, 275, 'MC4', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 275, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 275, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 275, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC5 =
				{
					Name = HUD.New(10, 290, 'MC5', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 290, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 290, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 290, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC6 =
				{
					Name = HUD.New(10, 305, 'MC6', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 305, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 305, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 305, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC7 =
				{
					Name = HUD.New(10, 320, 'MC7', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 320, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 320, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 320, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC8 =
				{
					Name = HUD.New(10, 335, 'MC8', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 335, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 335, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 335, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC9 =
				{
					Name = HUD.New(10, 350, 'MC9', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 350, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 350, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 350, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
				MC10 =
				{
					Name = HUD.New(10, 365, 'MC10', Color.White.r,Color.White.g,Color.White.b),
					SDs = HUD.New(100, 365, '##', Color.Default.r,Color.Default.g,Color.Default.b),
					Slash = HUD.New(125, 365, '|', Color.Orange.r,Color.Orange.g,Color.Orange.b),
					GMPs = HUD.New(137, 365, '##', Color.Default.r,Color.Default.g,Color.Default.b)
				},
			},
			RunningModules = {
				AutoSD = HUD.New(82, 395, 'Auto-SD', Color.Default.r, Color.Default.g, Color.Default.b),
				AutoSDTargets = HUD.New(10, 410, '', Color.Default.r, Color.Default.g, Color.Default.b),
				
				AutoPara = HUD.New(82, 430, 'Paralyze', Color.Default.r, Color.Default.g, Color.Default.b),
				AutoParaTargets = HUD.New(10, 445, '', Color.Default.r, Color.Default.g, Color.Default.b),

				Trigger = HUD.New(68, 465, 'Trap Trigger', Color.Green.r,Color.Green.g,Color.Green.b),
				TriggerTargets = HUD.New(10, 480, '', Color.Green.r,Color.Green.g,Color.Green.b)
			},
		}
else
	print("Hud disabled in config")
end

function checkIfNameIsAnMc( name )
	for i = 1, #McNames do
		if McNames[i] == name then
			return i
		end
	end
	return nil
end

function UpdateHud( TextIn )
	if TextIn ~= "" then
		local MCNumber, Percentage2, SDs2, GMPs2 = string.match(TextIn, "(%d+)/(%d+)/(%d+)/(%d+)")

		MCNumber = tonumber(MCNumber)
		Percentage2 = tonumber(Percentage2)
		SDs2 = tonumber(SDs2)
		GMPs2 = tonumber(GMPs2)

		-- set last time heard from client
		HUDTimes[MCNumber] = os.time()

		local Bars = Percentage2 / 2

		local ManaColor = GetManaColor(Percentage2)

		local GMPText = ""
		local i = 0
		while i <= Bars do
			GMPText = GMPText.."l"
			i = i + 1
		end

		local SDColor = GetSDColor(SDs2)
		local GMPColor = GetGMPColor(GMPs2)
		
		local createBoundaryLine

		if HUDTimes[MCNumber] == 0 then
			createBoundaryLine = true
		end

		if MCNumber == 1 then
			HUD.MCMana.MC1.Amount:SetText(GMPText)
			HUD.MCMana.MC1.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC1.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC1.GMPs:SetText(GMPs2)
			
			HUD.MCSupplies.MC1.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC1.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)

			if createBoundaryLine then
				HUD.MCMana.MC1.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 2 then
			HUD.MCMana.MC2.Amount:SetText(GMPText)
			HUD.MCMana.MC2.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC2.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC2.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC2.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC2.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)

			if createBoundaryLine then
				HUD.MCMana.MC2.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 3 then
			HUD.MCMana.MC3.Amount:SetText(GMPText)
			HUD.MCMana.MC3.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC3.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC3.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC3.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC3.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)

			if createBoundaryLine then
				HUD.MCMana.MC3.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 4 then
			HUD.MCMana.MC4.Amount:SetText(GMPText)
			HUD.MCMana.MC4.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC4.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC4.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC4.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC4.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)
		
			if createBoundaryLine then
				HUD.MCMana.MC4.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 5 then
			HUD.MCMana.MC5.Amount:SetText(GMPText)
			HUD.MCMana.MC5.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC5.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC5.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC5.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC5.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)
		
			if createBoundaryLine then
				HUD.MCMana.MC5.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 6 then
			HUD.MCMana.MC6.Amount:SetText(GMPText)
			HUD.MCMana.MC6.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC6.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC6.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC6.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC6.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)
		
			if createBoundaryLine then
				HUD.MCMana.MC6.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 7 then
			HUD.MCMana.MC7.Amount:SetText(GMPText)
			HUD.MCMana.MC7.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC7.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC7.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC7.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC7.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)
		
			if createBoundaryLine then
				HUD.MCMana.MC7.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 8 then
			HUD.MCMana.MC8.Amount:SetText(GMPText)
			HUD.MCMana.MC8.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC8.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC8.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC8.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC8.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)
		
			if createBoundaryLine then
				HUD.MCMana.MC8.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 9 then
			HUD.MCMana.MC9.Amount:SetText(GMPText)
			HUD.MCMana.MC9.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC9.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC9.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC9.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC9.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)
			
			if createBoundaryLine then
				HUD.MCMana.MC9.EndBorder:SetText('l                                                   l')
			end
		elseif MCNumber == 10 then
			HUD.MCMana.MC10.Amount:SetText(GMPText)
			HUD.MCMana.MC10.Amount:SetTextColor(ManaColor.r,ManaColor.g,ManaColor.b)
			HUD.MCSupplies.MC10.SDs:SetText(SDs2) 
			HUD.MCSupplies.MC10.GMPs:SetText(GMPs2)

			HUD.MCSupplies.MC10.SDs:SetTextColor(SDColor.r,SDColor.g,SDColor.b)
			HUD.MCSupplies.MC10.GMPs:SetTextColor(GMPColor.r,GMPColor.g,GMPColor.b)
		
			if createBoundaryLine then
				HUD.MCMana.MC10.EndBorder:SetText('l                                                   l')
			end
		end
	end
end

function GetGMPColor(pots)
	local GMPColor
	if pots > MaxGMP * .75 then
		GMPColor = {r=1, g=255, b=1}
	elseif pots > MaxGMP * .5 then
		GMPColor = {r=255, g=255, b=0}
	elseif pots > MaxGMP * .25 then
		GMPColor = {r=255, g=145, b=0}
	else
		GMPColor = {r=228, g=0, b=0}
	end
	return GMPColor
end

function GetSDColor(sds)
	local SDColor
	if sds > MaxSD * .75 then
		SDColor = {r=1, g=255, b=1}
	elseif sds > MaxSD * .5 then
		SDColor = {r=255, g=255, b=0}
	elseif sds > MaxSD * .25 then
		SDColor = {r=255, g=145, b=0}
	else
		SDColor = {r=228, g=0, b=0}
	end
	return SDColor
end

function GetManaColor(mana)
	local ManaColor
	if mana > 75 then
		ManaColor = {r=1, g=255, b=1}
	elseif mana > 50 then
		ManaColor = {r=255, g=255, b=0}
	elseif mana > 25 then
		ManaColor = {r=255, g=145, b=0}
	else
		ManaColor = {r=228, g=0, b=0}
	end
	return ManaColor
end	