function arrest()
	GET_PLAYER_WANTED_LEVEL(getPlayerID, thePlayer)
	if thePlayer(isWanted)
	then displayName
	else GET_TIME_SINCE_LAST_ARREST("_time_, _reason_")

end

function tazed()
	weapon("stun_gun")
	if playerIsHit
	then freezePlayer(x, y, z)
	vector3.playerPosition.getModel.getPosition
