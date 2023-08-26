-- a Kaezakhan lookout, RANGER
-- charming this mob grants a ranged 

function EVENT_SPAWN(self)

	self:setWeapon(13430, 8)
	
end

function EVENT_ATTACKED(self)

	self:text(""..self:GetName().." shouts, 'My life and body for The Hierophant! For Kaezul!'")
	
end