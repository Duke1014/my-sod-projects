-- sludge, used in Zzz fight to keep people inside room

function EVENT_SPAWN(self)
	self:area(25)
end

function EVENT_AREA(self, other, area)
	if other:IsClient() then
		player_z = other:GetZ()
		dmg = player_z * 200
		customnuke(self, other, "Slime Slide", dmg, 0, 0, "You slide down the horrid sludge hill.")
		other:teleport(40, other:GetY(), 5, 0)
	end
end