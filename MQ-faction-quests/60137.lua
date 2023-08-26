-- a possessed initiate -- 60137.lua, not the same as 60136.lua!!
-- used in Blackscale - Froglok Initiation (2nd part of quest)

function EVENT_SPAWN(self)
	self:text("A possessed initiate appears, and leaps after YOU!", 11, 150)
end

function EVENT_DEATH(self, other, damage, spell)
	hl = self:GetHateList()
	for k, v in pairs(hl) do
		if hl[k]:InZone() and hl[k]:IsClient() then
			if hl[k]:GetFlag(42514) > 2 and hl[k]:GetFlag(42514) < 9 then
				hl[k]:setFlag(42514, hl[k]:GetFlag(42514) + 1)
				if hl[k]:GetFlag(42514) == 8 then
					hl[k]:text("You hear an eerie silence. Perhaps all of the possessed initiates have been dealt with, and the frogloks have ceased their endless croaking. Time to report back to Essix.", 11, true)
					hl[k]:setFlag(42514, 9)
					hl[k]:journal("Blackscale - Froglok Initiation", 4, "The obnoxious noises in the Lair of Mielech have died down. It's time to report back to Raider Essix on what I've seen here.")
				else
					hl[k]:text("You've disposed of another initiate. Keep going!", 11, true)
				end
			end
		end
	end
end