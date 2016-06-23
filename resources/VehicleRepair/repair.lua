local vehicleRepairStation = {}

-- Setting

vehicleRepairStation.version = "1.4"

-----------------------------------------------------------------------
----------------------------MAP-LOCATION-------------------------------
-----------------------------------------------------------------------

vehicleRepairStation.location1_x = 1183.89
vehicleRepairStation.location1_y = -334.16
vehicleRepairStation.location1_z = 68.41

vehicleRepairStation.location2_x = -2100.31
vehicleRepairStation.location2_y = -312.37
vehicleRepairStation.location2_z = 12.26

vehicleRepairStation.location3_x = 176.20
vehicleRepairStation.location3_y = 6605.06
vehicleRepairStation.location3_z = 31.08

vehicleRepairStation.location4_x = 2584.26
vehicleRepairStation.location4_y = 358.81
vehicleRepairStation.location4_z = 107.69

vehicleRepairStation.location5_x = 2007.83
vehicleRepairStation.location5_y = 3776
vehicleRepairStation.location5_z = 32.40

vehicleRepairStation.location6_x = -728.12
vehicleRepairStation.location6_y = -934.32
vehicleRepairStation.location6_z = 18.25

-----------------------------------------------------------------------
-----------------------------------------------------------------------

-- Keyboard

vehicleRepairStation.key = {}
vehicleRepairStation.key.use = 69 -- "E Key"

-- Code

function vehicleRepairStation.unload()
end

function vehicleRepairStation.init()
print ("=======================")
print ("vehicleRepairStation " .. vehicleRepairStation.version .. " by Aaronlelit")
print ("Visit my youtube channel at : https://www.youtube.com/aaronlelit")
print ("=======================")

-- Draw Blip
-----------------------------------------------------------------------------------------------------------------------------------------------
	
	stationBlip1 = UI.ADD_BLIP_FOR_COORD(vehicleRepairStation.location1_x, vehicleRepairStation.location1_y, vehicleRepairStation.location1_z)
	stationBlip2 = UI.ADD_BLIP_FOR_COORD(vehicleRepairStation.location2_x, vehicleRepairStation.location2_y, vehicleRepairStation.location2_z)
	stationBlip3 = UI.ADD_BLIP_FOR_COORD(vehicleRepairStation.location3_x, vehicleRepairStation.location3_y, vehicleRepairStation.location3_z)
	stationBlip4 = UI.ADD_BLIP_FOR_COORD(vehicleRepairStation.location4_x, vehicleRepairStation.location4_y, vehicleRepairStation.location4_z)
	stationBlip5 = UI.ADD_BLIP_FOR_COORD(vehicleRepairStation.location5_x, vehicleRepairStation.location5_y, vehicleRepairStation.location5_z)
	stationBlip6 = UI.ADD_BLIP_FOR_COORD(vehicleRepairStation.location6_x, vehicleRepairStation.location6_y, vehicleRepairStation.location6_z)
	UI.SET_BLIP_SCALE(stationBlip1, 1)
	UI.SET_BLIP_SCALE(stationBlip2, 1)
	UI.SET_BLIP_SCALE(stationBlip3, 1)
	UI.SET_BLIP_SCALE(stationBlip4, 1)
	UI.SET_BLIP_SCALE(stationBlip5, 1)
	UI.SET_BLIP_SCALE(stationBlip6, 1)
	UI.SET_BLIP_SPRITE(stationBlip1, 100) --100 = CarWash
	UI.SET_BLIP_SPRITE(stationBlip2, 100) --100 = CarWash
	UI.SET_BLIP_SPRITE(stationBlip3, 100) --100 = CarWash
	UI.SET_BLIP_SPRITE(stationBlip4, 100) --100 = CarWash
	UI.SET_BLIP_SPRITE(stationBlip5, 100) --100 = CarWash
	UI.SET_BLIP_SPRITE(stationBlip6, 100) --100 = CarWash
	UI.SET_BLIP_NAME_FROM_TEXT_FILE(stationBlip1, "vehicleRepairStation")
	UI.SET_BLIP_NAME_FROM_TEXT_FILE(stationBlip2, "vehicleRepairStation")
	UI.SET_BLIP_NAME_FROM_TEXT_FILE(stationBlip3, "vehicleRepairStation")
	UI.SET_BLIP_NAME_FROM_TEXT_FILE(stationBlip4, "vehicleRepairStation")
	UI.SET_BLIP_NAME_FROM_TEXT_FILE(stationBlip5, "vehicleRepairStation")
	UI.SET_BLIP_NAME_FROM_TEXT_FILE(stationBlip6, "vehicleRepairStation")
	UI.SET_BLIP_COLOUR(stationBlip1, 2)
	UI.SET_BLIP_COLOUR(stationBlip2, 2)
	UI.SET_BLIP_COLOUR(stationBlip3, 2)
	UI.SET_BLIP_COLOUR(stationBlip4, 2)
	UI.SET_BLIP_COLOUR(stationBlip5, 2)
	UI.SET_BLIP_COLOUR(stationBlip6, 2)
	UI.SET_BLIP_AS_SHORT_RANGE(stationBlip1, true)
	UI.SET_BLIP_AS_SHORT_RANGE(stationBlip2, true) 
	UI.SET_BLIP_AS_SHORT_RANGE(stationBlip3, true) 
	UI.SET_BLIP_AS_SHORT_RANGE(stationBlip4, true) 
	UI.SET_BLIP_AS_SHORT_RANGE(stationBlip5, true) 
	UI.SET_BLIP_AS_SHORT_RANGE(stationBlip6, true) 
	UI.SET_BLIP_FLASHES(stationBlip1, false)
	UI.SET_BLIP_FLASHES(stationBlip2, false)
	UI.SET_BLIP_FLASHES(stationBlip3, false)
	UI.SET_BLIP_FLASHES(stationBlip4, false)
	UI.SET_BLIP_FLASHES(stationBlip5, false)
	UI.SET_BLIP_FLASHES(stationBlip6, false)
	
-----------------------------------------------------------------------------------------------------------------------------------------------
	
end

function vehicleRepairStation.tick()
	local playerPed = PLAYER.PLAYER_PED_ID()
	local player = PLAYER.GET_PLAYER_PED(playerPed) 
	local location = ENTITY.GET_ENTITY_COORDS(playerPed, nil)
	
	if ( vehicleRepairStation.playerIsAtStation(location) ) then
		vehicleRepairStation.drawText("Press [E] or [PAD-RIGHT] for fix your vehicle !", 0.5, 0.5, 0.75)
		if ( get_key_pressed(vehicleRepairStation.key.use) or CONTROLS.IS_CONTROL_PRESSED(2, 74) ) then
			playerVehicle = PED.GET_VEHICLE_PED_IS_USING(playerPed)
			
			if (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_zero"))) then model = 0
			elseif (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_one"))) then model = 1                                         
			elseif (PED.IS_PED_MODEL(playerPed, GAMEPLAY.GET_HASH_KEY("player_two"))) then model = 2 end
			local statname = "SP"..model.."_TOTAL_CASH"
			local hash = GAMEPLAY.GET_HASH_KEY(statname)
			local bool, val = STATS.STAT_GET_INT(hash, 0, -1)
			
			finalPrice =  - (VEHICLE.GET_VEHICLE_ENGINE_HEALTH(playerVehicle) - 1000) + 150
			
			if (val > finalPrice) then
			STATS.STAT_SET_INT(hash, val - finalPrice, true)
			
			VEHICLE.SET_VEHICLE_UNDRIVEABLE(playerVehicle, true)
			CAM.DO_SCREEN_FADE_OUT(2500)
			wait(2500)
			CAM.DO_SCREEN_FADE_IN(2500)
			AUDIO.PLAY_MISSION_COMPLETE_AUDIO("MICHAEL_BIG_01")
			vehicleRepairStation.notify("Your vehicle has been repaired !")
			VEHICLE.SET_VEHICLE_FIXED(playerVehicle)
			VEHICLE.SET_VEHICLE_UNDRIVEABLE(playerVehicle, false)
			wait(2500)
			else
				vehicleRepairStation.notify("You do not have enough money to repair your vehicle !")
			end
		end
	end
end

function vehicleRepairStation.drawText(text, x, y, scale)
  UI.SET_TEXT_FONT(6)
  UI.SET_TEXT_SCALE(scale, scale)
  UI.SET_TEXT_COLOUR(255, 255, 255, 255)
  UI.SET_TEXT_WRAP(0.0, 1.0)
  UI.SET_TEXT_CENTRE(true)
  UI.SET_TEXT_DROPSHADOW(2, 2, 0, 0, 0)
  UI.SET_TEXT_EDGE(1, 0, 0, 0, 205)
  UI._SET_TEXT_ENTRY("STRING")
  UI._ADD_TEXT_COMPONENT_STRING(text)
  UI._DRAW_TEXT(y, x)
end

function vehicleRepairStation.notify(msg)
	UI._SET_NOTIFICATION_TEXT_ENTRY("STRING")
	UI._ADD_TEXT_COMPONENT_STRING(msg)
	UI._DRAW_NOTIFICATION(false, false)
end

function vehicleRepairStation.playerIsAtStation(location)
if ( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( vehicleRepairStation.location1_x, vehicleRepairStation.location1_y, vehicleRepairStation.location1_z, location.x, location.y, location.z, true ) < 5 ) then return true end
if ( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( vehicleRepairStation.location2_x, vehicleRepairStation.location2_y, vehicleRepairStation.location2_z, location.x, location.y, location.z, true ) < 5 ) then return true end
if ( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( vehicleRepairStation.location3_x, vehicleRepairStation.location3_y, vehicleRepairStation.location3_z, location.x, location.y, location.z, true ) < 5 ) then return true end
if ( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( vehicleRepairStation.location4_x, vehicleRepairStation.location4_y, vehicleRepairStation.location4_z, location.x, location.y, location.z, true ) < 5 ) then return true end
if ( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( vehicleRepairStation.location5_x, vehicleRepairStation.location5_y, vehicleRepairStation.location5_z, location.x, location.y, location.z, true ) < 5 ) then return true end
if ( GAMEPLAY.GET_DISTANCE_BETWEEN_COORDS( vehicleRepairStation.location6_x, vehicleRepairStation.location6_y, vehicleRepairStation.location6_z, location.x, location.y, location.z, true ) < 5 ) then return true end
end

return vehicleRepairStation
