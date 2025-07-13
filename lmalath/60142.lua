-- Gunthak Guard

function EVENT_SPAWN(self)
    self:setWeapon(60112, 7)
	self:setWeapon(60113, 8)
end

function EVENT_SAY(self, other, msg)
    self:say("Hail to you, friend. If you wish to help see out the Master's vision, seek out Commissioner Froknut in town for work. Otherwise, may His embrace protect you.")
end