-- controller mob for Overthere
-- idk what to use this for, yet
--[[
function EVENT_SPAWN(self)
	-- player has entered the harbortown
	self:area("harbor1", 2218.3, 2332.5, -170, 3932.3, 3111, 1133.2)
	self:area("harbor2", 2034.6, 2479.5, -170, 3000, 3546, 1133.2)
end

function EVENT_AREA(self, other, area)
	
	if area == "harbor1" or "harbor2" then
		
		if other:IsClient() and other:GetAccountStatus() > 50 then
			debugtext("GM entered Harbor") -- GM is safe
		elseif other:IsClient() and other:GetAccountStatus() < 50 then
			other:customNuke(other, "SuperDeath", ""..other:GetName().."'s heart explodes.", 100000)
			other:customNuke(other, "SuperDeath", ""..other:GetName().."'s heart explodes.", 100000)
			other:customNuke(other, "SuperDeath", ""..other:GetName().."'s heart explodes.", 100000)
		end
		
	end
	
end