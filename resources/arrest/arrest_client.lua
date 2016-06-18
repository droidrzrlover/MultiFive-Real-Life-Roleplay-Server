function checkWantedLevel()
	GET_PLAYER_WANTED_LEVEL(getPlayerID, thePlayer)
	if thePlayer(isWanted)
	then displayName
	else GET_TIME_SINCE_LAST_ARREST("_time_, _reason_")
end

function tazed()
	weapon("stun_gun")
	if playerHit
	then freezePlayer(x, y, z)
	vector3.playerPosition.getModel.getPosition

function arrest()
	IS_PLAYER_BEING_ARRESTED(thePlayer)
	PLAY_ENTITY_ANIM("random@arrests@busted")
	IS_PED_CUFFED(thePlayer)
	PLAY_ENTITY_ANIM("get_up@cuffed")
	SET_PLAYER_WANTED_LEVEL(int)
	SET_PLAYER_WANTED_LEVEL_now(0)
