-- a Kaezakhan priest, Cleric
-- charming this mob will grant the owner, and group, with Blessing of Aegolism, and occasional heals

function EVENT_SPAWN(self)

	self:setWeapon(60039, 7)
	
end

function EVENT_ATTACKED(self)

	self:text(""..self:GetName().." shouts, 'My life and body for The Hierophant! For Kaezul!'")
	
end