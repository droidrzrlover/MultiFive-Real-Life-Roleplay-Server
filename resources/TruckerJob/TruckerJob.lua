----------------------------------------------------
-- Trucking Job By DGB ( Naimleboss ) Version 1.5 --
----------------------------------------------------

-- Variable localisation
local TruckingCompagny = {{338, 345, 36}}
local TruckingTrainer = {{602.9446, 275.0546, 104.37}}

-- Variable Color Selection 

-- Menu 1
local R1 = 0
local V1 = 128
local B1 = 192
local Alpha1 = 200

--Menu 2
local R2 = 0
local V2 = 128
local B2 = 64
local Alpha2 = 200

---------------------------------------
--     DO NOT EDIT BEYOND HERE     --
---------------------------------------
local Truck = {"HAULER", "PACKER", "PHANTOM"}
local Trainer = {"TANKER", "TRAILERS", "TRAILERS2", "TRAILERLOGS"}
local Hashtrainer = GAMEPLAY.GET_HASH_KEY(Trainer[1])
local Type = 1
local TruckingDestination = {{0, 0, 0}}
local blip = {}
local blip2 = {}
local blip3 = {}
local count = 0
local money = false
local remover = false
local givemoney = 0
local MissionX = 0
local MissionY = 0
local MissionZ = 0

local GUI = {}
GUI.GUI = {}
GUI.title = {}
GUI.menu1 = {}
GUI.menu2 = {}
GUI.description = {}
GUI.TitleCount = 0
GUI.Menu1buttonCount = 0
GUI.Menu2buttonCount = 0
GUI.desCount = 0
GUI.time = 0
GUI.selectionmenu1 = 0
GUI.selectionmenu2 = 0
GUI.loaded = false
GUI.hiddenMenu1 = true
GUI.hiddenMenu2 = true

-- Function local
function GUI.unload()
	for i, coords in pairs(TruckingCompagny) do
		UI.REMOVE_BLIP(blip[i])
	end
end

function GUI.init()
GUI.time = GAMEPLAY.GET_GAME_TIMER()
GUI.loaded = true

	for i, coords in pairs(TruckingCompagny) do
		blip[i] = UI.ADD_BLIP_FOR_COORD(coords[1],coords[2],coords[3])
		UI.SET_BLIP_SPRITE(blip[i],67) -- 67 /8 9
        UI.SET_BLIP_SCALE(blip[i], 0.8)
		UI.SET_BLIP_AS_SHORT_RANGE(blip[i], true)
	end
	
GUI.addTitle("Trucking Job (by DGB)",0.425, 0.19, 0.45, 0.07)
GUI.addDescription("Help:",0.575, 0.375, 0.15, 0.30)	

GUI.addButtonMenu1("RON Tanker trailer", GUI.OptionMission1, 0.35, 0.25, 0.3, 0.05)
GUI.addButtonMenu1("Container trailer", GUI.OptionMission2, 0.35, 0.30, 0.3, 0.05)
GUI.addButtonMenu1("Articulated trailer", GUI.OptionMission3, 0.35, 0.35, 0.3, 0.05)
GUI.addButtonMenu1("Log Trailer", GUI.OptionMission4, 0.35, 0.40, 0.3, 0.05)
GUI.addButtonMenu1(" ", GUI.Null, 0.35, 0.45, 0.3, 0.05)
GUI.addButtonMenu1("Exit Menu", GUI.Exit, 0.35, 0.50, 0.3, 0.05)


GUI.addButtonMenu2("Mission 1 [ 5.000$ ]", GUI.Mission1, 0.35, 0.25, 0.3, 0.05)
GUI.addButtonMenu2("Mission 2 [ 10.000$ ]", GUI.Mission2, 0.35, 0.30, 0.3, 0.05)
GUI.addButtonMenu2("Mission 3 [ 15.000$ ]", GUI.Mission3, 0.35, 0.35, 0.3, 0.05)
GUI.addButtonMenu2("Mission 4 [ 20.000$ ]", GUI.Mission4, 0.35, 0.40, 0.3, 0.05)
GUI.addButtonMenu2("Mission 5 [ 30.000$ ]", GUI.Mission5, 0.35, 0.45, 0.3, 0.05)
GUI.addButtonMenu2("Exit Menu", GUI.Exit, 0.35, 0.50, 0.3, 0.05)

end

function GUI.addTitle(name, xpos, ypos, xscale, yscale)
	print("Added Title "..name )
	GUI.title[GUI.TitleCount +1] = {}
	GUI.title[GUI.TitleCount +1]["name"] = name
	GUI.title[GUI.TitleCount +1]["xpos"] = xpos
	GUI.title[GUI.TitleCount +1]["ypos"] = ypos 	
	GUI.title[GUI.TitleCount +1]["xscale"] = xscale
	GUI.title[GUI.TitleCount +1]["yscale"] = yscale
end

function GUI.addButtonMenu1(name, func, xpos, ypos, xscale, yscale)
	print("Added Button "..name )
	GUI.menu1[GUI.Menu1buttonCount +1] = {}
	GUI.menu1[GUI.Menu1buttonCount +1]["name"] = name
	GUI.menu1[GUI.Menu1buttonCount+1]["func"] = func
	GUI.menu1[GUI.Menu1buttonCount+1]["xpos"] = xpos
	GUI.menu1[GUI.Menu1buttonCount+1]["ypos"] = ypos 	
	GUI.menu1[GUI.Menu1buttonCount+1]["xscale"] = xscale
	GUI.menu1[GUI.Menu1buttonCount+1]["yscale"] = yscale
	GUI.Menu1buttonCount = GUI.Menu1buttonCount+1
end

function GUI.addButtonMenu2(name, func, xpos, ypos, xscale, yscale)
	print("Added Button "..name )
	GUI.menu2[GUI.Menu2buttonCount +1] = {}
	GUI.menu2[GUI.Menu2buttonCount +1]["name"] = name
	GUI.menu2[GUI.Menu2buttonCount+1]["func"] = func
	GUI.menu2[GUI.Menu2buttonCount+1]["xpos"] = xpos
	GUI.menu2[GUI.Menu2buttonCount+1]["ypos"] = ypos 	
	GUI.menu2[GUI.Menu2buttonCount+1]["xscale"] = xscale
	GUI.menu2[GUI.Menu2buttonCount+1]["yscale"] = yscale
	GUI.Menu2buttonCount = GUI.Menu2buttonCount+1
end

function GUI.addDescription(name, xpos, ypos, xscale, yscale)
	print("Added Description "..name )
	GUI.description[GUI.desCount +1] = {}
	GUI.description[GUI.desCount +1]["name"] = name
	GUI.description[GUI.desCount +1]["xpos"] = xpos
	GUI.description[GUI.desCount +1]["ypos"] = ypos 	
	GUI.description[GUI.desCount +1]["xscale"] = xscale
	GUI.description[GUI.desCount +1]["yscale"] = yscale
end

-- Function Primaire 

function wait(seconds)
  local start = os.time()
  repeat until os.time() > start + seconds
end

function GUI.spawntruck()
	local Hashtruck = GAMEPLAY.GET_HASH_KEY(Truck[1])
	STREAMING.REQUEST_MODEL(Hashtruck)				
	local spawn = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 8.0, 0.0, 0.0)
	local truck = VEHICLE.CREATE_VEHICLE(Hashtruck, spawn.x, spawn.y, spawn.z, 170, false, false)
	VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(truck)
	PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), truck, -1);
	print("spawn truck")		
	wait(1)
end

function GUI.spawntrainer()
		STREAMING.REQUEST_MODEL(Hashtrainer)
		local trainer = VEHICLE.CREATE_VEHICLE(Hashtrainer,602.2297, 266.0714, 103.46, 0, false, false)
		VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(trainer)		
		print("spawn trainer")
		wait(1)
end

function GUI.Money()
local playerPed = PLAYER.PLAYER_PED_ID()

		if (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_zero"))) then
			model = 0
		elseif (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_one"))) then                                
			model = 1                                         
		elseif (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_two"))) then
			model = 2
		end
	
		local statname = "SP"..model.."_TOTAL_CASH"
		local hash = GAMEPLAY.GET_HASH_KEY(statname)
		local bool, val = STATS.STAT_GET_INT(hash, 0, -1)

		STATS.STAT_SET_INT(hash, val + givemoney, true)

		money = false
		count = 1
end

function GUI.Marker()
count = 0
	for i, coords in pairs(TruckingTrainer) do
		blip2[i] = UI.ADD_BLIP_FOR_COORD(coords[1],coords[2],coords[3])
		UI.SET_BLIP_SPRITE(blip2[i],9)
		UI.SET_BLIP_SCALE(blip2[i], 0.1)
		UI.SET_BLIP_COLOUR(blip2[i],3)
		UI.SET_BLIP_AS_SHORT_RANGE(blip2[i], false)	
		UI.SET_BLIP_ROUTE(blip2[i], true)
	end
		print("marker trainer")

	for i, coords in pairs(TruckingDestination) do
		blip3[i] = UI.ADD_BLIP_FOR_COORD(MissionX,MissionY,MissionZ)
		UI.SET_BLIP_SPRITE(blip3[i],2)
		UI.SET_BLIP_SCALE(blip3[i], 1.2)
		UI.SET_BLIP_COLOUR(blip3[i],2)
		UI.SET_BLIP_AS_SHORT_RANGE(blip3[i], false)
		UI.SET_BLIP_ROUTE(blip3[i], false)	
	end							
		print("marker destination")
		wait(1)	
		GUI.hiddenMenu2 = true
end

-- Option Mission

function GUI.OptionMission1()
	GUI.hiddenMenu1 = true
	GUI.hiddenMenu2 = false
	Type = 1
	GUI.spawntrainer()
	
end

function GUI.OptionMission2()
	GUI.hiddenMenu1 = true
	GUI.hiddenMenu2 = false
	Type = 2
	GUI.spawntrainer()

end

function GUI.OptionMission3()
	GUI.hiddenMenu1 = true
	GUI.hiddenMenu2 = false
	Type = 3
	GUI.spawntrainer()
end

function GUI.OptionMission4()
	GUI.hiddenMenu1 = true
	GUI.hiddenMenu2 = false
	Type = 4
	GUI.spawntrainer()

end

-- Mission 

function GUI.Mission1()
		MissionX = 1212.4463
		MissionY = 2667.4351
		MissionZ = 38.79
		givemoney = 5000
		print("Loaded Mission 1")
		remover = true
		GUI.Marker()
end

function GUI.Mission2()
		MissionX = 2574.5144
		MissionY = 328.5554
		MissionZ = 108.45
		givemoney = 10000
		print("Loaded Mission 2")
		remover = true
		GUI.Marker()
end

function GUI.Mission3()
		MissionX = -2565.0894
		MissionY = 2345.8904
		MissionZ = 33.06
		givemoney = 15000
		print("Loaded Mission 3")
		remover = true
		GUI.Marker()
end

function GUI.Mission4()
		MissionX = 1706.7966
		MissionY = 4943.9897
		MissionZ = 42.16
		givemoney = 20000
		print("Loaded Mission 4")
		remover = true
		GUI.Marker()
end

function GUI.Mission5()
		MissionX = 196.5617
		MissionY = 6631.0967
		MissionZ = 31.53
		givemoney = 30000
		print("Loaded Mission 5")
		remover = true
		GUI.Marker()
end

function GUI.Null()

end

function GUI.Exit()
	GUI.hiddenMenu1 = true
	GUI.hiddenMenu2 = true
	print("Exit menu")
end

-- Master Function

function GUI.tick()
local playerPed = PLAYER.PLAYER_PED_ID()
local player = PLAYER.GET_PLAYER_PED(playerPed)
local playerExists = ENTITY.DOES_ENTITY_EXIST(playerPed)
local coords = ENTITY.GET_ENTITY_COORDS( playerPed, nil )

	if( playerExists ) then
				
				if( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( coords.x, coords.y, coords.z,338, 345, 36, false ) < 3 ) then
				GUI.drawText()
				GUI.drawText2() 
					if(get_key_pressed(111)) then
						GUI.hiddenMenu1 = false						
					end
						
					if(get_key_pressed(106)) then
						GUI.spawntruck()
					end
				else
				GUI.hiddenMenu1 = true
				GUI.hiddenMenu2 = true	
				end
				
				if( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( coords.x, coords.y, coords.z,602.9446, 275.0546, 104.37, false ) < 3 and remover == true) then
					for i, coords in pairs(TruckingTrainer) do
						UI.REMOVE_BLIP(blip2[i])
					end

					for i, coords in pairs(TruckingDestination) do
						UI.SET_BLIP_ROUTE(blip3[i], true)
					end
				end

					if( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( coords.x, coords.y, coords.z,MissionX , MissionY , MissionZ, false ) < 3 and remover == true) then
							for i, coords in pairs(TruckingDestination) do
									UI.REMOVE_BLIP(blip3[i])
									money = true
									if (money == true and count == 0) then
											GUI.Money()
									end	
								
							end
							remover = false
					end
		
		if (Type == 1) then
			Hashtrainer = GAMEPLAY.GET_HASH_KEY(Trainer[1])
		end

		if (Type == 2) then
			Hashtrainer = GAMEPLAY.GET_HASH_KEY(Trainer[2])
		end

		if (Type == 3) then
			Hashtrainer = GAMEPLAY.GET_HASH_KEY(Trainer[3])
		end

		if (Type == 4) then
			Hashtrainer = GAMEPLAY.GET_HASH_KEY(Trainer[4])
		end
					
		if(not GUI.hiddenMenu1)then
			if( GUI.time == 0) then
				GUI.time = GAMEPLAY.GET_GAME_TIMER()
			end
			if((GAMEPLAY.GET_GAME_TIMER() - GUI.time)> 100) then
				GUI.updateSelectionMenu1()
			end	
			GUI.renderMenu1GUI()	
			if(not GUI.loaded ) then
				GUI.init()	 
			end
		end
		
		if(not GUI.hiddenMenu2)then
			if( GUI.time == 0) then
				GUI.time = GAMEPLAY.GET_GAME_TIMER()
			end
			if((GAMEPLAY.GET_GAME_TIMER() - GUI.time)> 100) then
				GUI.updateSelectionMenu2()
			end	
			GUI.renderMenu2GUI()	
			if(not GUI.loaded ) then
				GUI.init()	 
			end
		end
	end
end

-- GUI Function 

function GUI.drawText()
        UI.SET_TEXT_FONT(0)
        UI.SET_TEXT_PROPORTIONAL(1)
        UI.SET_TEXT_SCALE(0.0, 0.35)
        UI.SET_TEXT_COLOUR(255, 255, 255, 255)
        UI.SET_TEXT_DROPSHADOW(0, 0, 0, 0,255)
        UI.SET_TEXT_EDGE(1, 0, 0, 0, 255)
        UI.SET_TEXT_DROP_SHADOW()
        UI.SET_TEXT_OUTLINE()
        UI._SET_TEXT_ENTRY("STRING")
        UI._ADD_TEXT_COMPONENT_STRING("Press NumPad/ to show menu")
        UI._DRAW_TEXT(0.015, 0.015)
		GRAPHICS.DRAW_RECT(0.1,0.045,0.18,0.07,0,0,0,200)
end

function GUI.drawText2()
        UI.SET_TEXT_FONT(0)
        UI.SET_TEXT_PROPORTIONAL(1)
        UI.SET_TEXT_SCALE(0.0, 0.35)
        UI.SET_TEXT_COLOUR(255, 255, 255, 255)
        UI.SET_TEXT_DROPSHADOW(0, 0, 0, 0,255)
        UI.SET_TEXT_EDGE(1, 0, 0, 0, 255)
        UI.SET_TEXT_DROP_SHADOW()
        UI.SET_TEXT_OUTLINE()
        UI._SET_TEXT_ENTRY("STRING")
        UI._ADD_TEXT_COMPONENT_STRING("Press NumPad* to spawn truck")
        UI._DRAW_TEXT(0.015, 0.045)
end


function GUI.updateSelectionMenu1() 
	if(get_key_pressed(Keys.NumPad2)) then 
		if(GUI.selectionmenu1 < GUI.Menu1buttonCount -1  )then
			GUI.selectionmenu1 = GUI.selectionmenu1 +1
			GUI.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad8) )then
		if(GUI.selectionmenu1 > 0)then
			GUI.selectionmenu1 = GUI.selectionmenu1 -1
			GUI.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad5)) then
		if(type(GUI.menu1[GUI.selectionmenu1 +1]["func"]) == "function") then
			GUI.menu1[GUI.selectionmenu1 +1]["func"](GUI.menu1[GUI.selectionmenu1 +1]["args"])
		else
			print(type(GUI.menu1[GUI.selectionmenu1]["func"]))
		end
		GUI.time = 0
	end
	local iterator = 0
	for id, settings in ipairs(GUI.menu1) do
		GUI.menu1[id]["active"] = false
		if(iterator == GUI.selectionmenu1 ) then
			GUI.menu1[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function GUI.updateSelectionMenu2() 
	if(get_key_pressed(Keys.NumPad2)) then 
		if(GUI.selectionmenu2 < GUI.Menu2buttonCount -1  )then
			GUI.selectionmenu2 = GUI.selectionmenu2 +1
			GUI.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad8) )then
		if(GUI.selectionmenu2 > 0)then
			GUI.selectionmenu2 = GUI.selectionmenu2 -1
			GUI.time = 0
		end
	elseif (get_key_pressed(Keys.NumPad5)) then
		if(type(GUI.menu2[GUI.selectionmenu2 +1]["func"]) == "function") then
			GUI.menu2[GUI.selectionmenu2 +1]["func"](GUI.menu2[GUI.selectionmenu2 +1]["args"])
		else
			print(type(GUI.menu2[GUI.selectionmenu2]["func"]))
		end
		GUI.time = 0
	end
	local iterator = 0
	for id, settings in ipairs(GUI.menu2) do
		GUI.menu2[id]["active"] = false
		if(iterator == GUI.selectionmenu2 ) then
			GUI.menu2[iterator +1]["active"] = true
		end
		iterator = iterator +1
	end
end

function GUI.renderMenu1GUI()
	 GUI.renderTitle()
	 GUI.renderButtonsMenu1()
	 GUI.renderDescription()
end

function GUI.renderMenu2GUI()
	 GUI.renderTitle()
	 GUI.renderButtonsMenu2()
	 GUI.renderDescription()
end

function GUI.renderBox(xpos,ypos,xscale,yscale,color1,color2,color3,color4)
	GRAPHICS.DRAW_RECT(xpos,ypos,xscale,yscale, color1, color2, color3, color4);
end

function GUI.renderTitle()
		for id, settings in pairs(GUI.title) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)
		boxColor = {0,0,0,255}
		UI.SET_TEXT_FONT(0)
		UI.SET_TEXT_SCALE(0.0, 0.40)
		UI.SET_TEXT_COLOUR(255, 255, 255, 255)
		UI.SET_TEXT_CENTRE(true)
		UI.SET_TEXT_DROPSHADOW(0, 0, 0, 0, 0)
		UI.SET_TEXT_EDGE(0, 0, 0, 0, 0)
		UI._SET_TEXT_ENTRY("STRING")
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		UI._DRAW_TEXT((settings["xpos"] + 0.001), (settings["ypos"] - 0.015))
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		GUI.renderBox(settings["xpos"],settings["ypos"],settings["xscale"],settings["yscale"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
		end
end

function GUI.renderButtonsMenu1()
	
	for id, settings in pairs(GUI.menu1) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)
		boxColor = {0,0,0,100}
		if(settings["active"]) then
			boxColor = {R1,V1,B1,Alpha1}
		end
		UI.SET_TEXT_FONT(0)
		UI.SET_TEXT_SCALE(0.0, 0.35)
		UI.SET_TEXT_COLOUR(255, 255, 255, 255)
		UI.SET_TEXT_CENTRE(true)
		UI.SET_TEXT_DROPSHADOW(0, 0, 0, 0, 0)
		UI.SET_TEXT_EDGE(0, 0, 0, 0, 0)
		UI._SET_TEXT_ENTRY("STRING")
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		UI._DRAW_TEXT((settings["xpos"] + 0.001), (settings["ypos"] - 0.015))
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		GUI.renderBox(settings["xpos"] ,settings["ypos"], settings["xscale"], settings["yscale"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	 end     
end

function GUI.renderButtonsMenu2()
	
	for id, settings in pairs(GUI.menu2) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)
		boxColor = {0,0,0,100}
		if(settings["active"]) then
			boxColor = {R2,V2,B2,Alpha2}
		end
		UI.SET_TEXT_FONT(0)
		UI.SET_TEXT_SCALE(0.0, 0.35)
		UI.SET_TEXT_COLOUR(255, 255, 255, 255)
		UI.SET_TEXT_CENTRE(true)
		UI.SET_TEXT_DROPSHADOW(0, 0, 0, 0, 0)
		UI.SET_TEXT_EDGE(0, 0, 0, 0, 0)
		UI._SET_TEXT_ENTRY("STRING")
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		UI._DRAW_TEXT((settings["xpos"] + 0.001), (settings["ypos"] - 0.015))
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		GUI.renderBox(settings["xpos"] ,settings["ypos"], settings["xscale"], settings["yscale"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
	 end     
end

function GUI.renderDescription()
		for id, settings in pairs(GUI.description) do
		local screen_w = 0
		local screen_h = 0
		screen_w, screen_h =  GRAPHICS.GET_SCREEN_RESOLUTION(0, 0)
		boxColor = {0,0,0,240}
		UI.SET_TEXT_FONT(0)
		UI.SET_TEXT_SCALE(0.0, 0.37)
		UI.SET_TEXT_COLOUR(255, 255, 255, 255)
		UI.SET_TEXT_DROPSHADOW(0, 0, 0, 0, 0)
		UI.SET_TEXT_EDGE(0, 0, 0, 0, 0)
		UI._SET_TEXT_ENTRY("STRING")
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"] .. "\n" .."\n" .."Num8 for UP" .. "\n" .. "Num2 for DOWN" .. "\n" .. "Num5 to Select".. "\n" .."Hold H to Detach" .. "\n" .. "Trainer")
		UI._DRAW_TEXT((settings["xpos"] - 0.06), (settings["ypos"] - 0.13))
		UI._ADD_TEXT_COMPONENT_STRING(settings["name"])
		GUI.renderBox(settings["xpos"],settings["ypos"],settings["xscale"],settings["yscale"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
		end
end

return GUI
