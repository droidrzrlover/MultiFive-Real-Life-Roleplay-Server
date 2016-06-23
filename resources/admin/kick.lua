function kickPlayer(command, theClient, reason)
  if ( hasObjectPermissionTo ( theClient, "function.kickPlayer" ) ) then
		--Get player element from the name
		local kickedPlayer = getPlayerFromName ( kickedName )
	  showNotification ( "Kick:" .. kickedName .. " has been kicked " ..Reason.. )
