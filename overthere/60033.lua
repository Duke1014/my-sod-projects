-- the child's parents
-- sad reacts only

function EVENT_SPAWN(self)

	self:setAnim(3) -- they are big dead
	
end

function EVENT_SIGNAL(self, signal)

	if signal == "flower" then
		self:setWeapon(36122)
		
	end

end