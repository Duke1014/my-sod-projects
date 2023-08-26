-- a Kaezakhan nightblade, Rogue
-- charming this grants a strong, melee pet with proficiency in poison debuffs and backstab

function EVENT_SPAWN(self)

	self:setWeapon(60038, 7)
	self:setWeapon(60038, 8)
	
end

function EVENT_ATTACKED(self)

	self:text(""..self:GetName().." shouts, 'My life and body for The Hierophant! For Kaezul!'")
	
end