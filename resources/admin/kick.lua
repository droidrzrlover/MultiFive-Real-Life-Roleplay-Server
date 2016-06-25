function kickPlayer (theClient, commandName, kickedName, reason)
  if ( hasObjectPermissionTo ( theClient, "function.kickPlayer" ) ) then
		--Get player element from the name
		local kickedPlayer = getPlayerFromName ( kickedName )
		
		kickPlayer ( kickedPlayer, theClient, reason )
	  	showNotification ( "Kick:" .. kickedName .. " has been kicked " ..Reason.. )
	  else
	  	showNotification ( "You do not have permission to kick players" )
	  end
	end
end
addCommandHandler ( "kick", kickPlayer )
