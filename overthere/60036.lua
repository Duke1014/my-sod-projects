-- a Kaezakhan berserker, not a real berserker, but hey hes cool
-- charming this mob grants a strong, melee pet with proficiency in tanking/taunting mobs 

function EVENT_SPAWN(self)

	self:setWeapon(60037, 7)
	
end

function EVENT_ATTACKED(self)

	self:text(""..self:GetName().." shouts, 'My life and body for The Hierophant! For Kaezul!'")
	
end