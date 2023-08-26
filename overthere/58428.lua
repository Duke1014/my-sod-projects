--[[
a dragonforged escort

Part of the Dragonforged Convoy Controller. 

This script pauses the controller when engaged in combat.
This script also resets agro when kited to far from engage point.

]]

--Log coordinates on aggro join
--Start check timer 1s
--if greater than distance, 

function EVENT_SPAWN(self)
	self:setWeapon(46313)
end