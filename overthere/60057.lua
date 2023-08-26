-- a barrier wisp
-- used in the oracle prison, kicks anyone out that doesnt have a specific quest flag

function EVENT_SPAWN(self)
	self:area("oracle_barrier", 223, 20, -460, 494, -260, -521)
end

function EVENT_AREA(self, other, area)
	if other and other:IsClient() then
		if other:GetFlag(42507) ~= 2 then
			other:teleport(197, 140, -544, 228)
			other:text("You feel a strong energy pulse as the barrier pushes you outside.", 8, true)
	
		else 
			other:text("The barrier accepts you as the orb on your tabard vibrates.", 8, true)
		end
	end
end