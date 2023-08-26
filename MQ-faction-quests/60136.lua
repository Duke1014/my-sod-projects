-- a possessed initiate
-- used in Blackscale - Froglok Initiation

function EVENT_SPAWN(self)
	self:text("A possessed initiate appears, and leaps after YOU!", 11, 150)
end

function EVENT_DEATH(self, other, damage, spell)
	hl = self:GetHateList()
	for k, v in pairs(hl) do
		if v and v:InZone() and v:IsClient() then
			if v:GetFlag(42514) == 1 and v:GetFlag(42515) > 70 then
				v:setFlag(42514, 2)
				v:text("You found one of the initiates! But something was very wrong with them. It's time to report back to Essix", 11, true)
				v:journal("Blackscale - Froglok Initiation", 2, "I've thoroughly explored the Lair of Mielech, and one of the initiates I was looking for attacked me! I'm certain they were possessed, I hope... I need to report back to Raider Essix.")
			end
		end
	end
end