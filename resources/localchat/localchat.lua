chat_range=100
 
addEventHandler("onPlayerJoin",getRootElement(),
function ()
bindKey(source,"y","down","chat","Local")
end)
 
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
function ()
for index, player in pairs(getElementsByType("player")) do
bindKey(player,"y","down","chat","Local")
  end
end)
 
function isPlayerInRangeOfPoint(player,x,y,z,range)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end
 
function onChat(player,_,...)
  local px,py,pz=getElementPosition(player)
  local msg = table.concat({...}, " ")
  local nick=getPlayerName(player)
local r,g,b = getTeamColor(getPlayerTeam(player))
  for _,v in ipairs(getElementsByType("player")) do
    if isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then
      outputChatBox("(Local) "..nick..": "..msg,v,r,g,b,true)
    end
  end
end
addCommandHandler("Local",onChat)
 
