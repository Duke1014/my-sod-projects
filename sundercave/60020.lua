-- earth add for 60013/60017

function EVENT_SPAWN(self)
	self:setAppearance(540)
	self:timer("earthnuke", 5000, true)
	self:timer("bye", 6000, true)
end

function EVENT_TIMER(self, words, other)
	if words == "earthnuke" then
	hl = _G.nalansar:GetHateList()
		for k,v in pairs(hl) do
			if v:InZone() and v:IsClient() then
				if v:InCone(self, 180) then
					self:customNuke(v, "fakeearthquake", "Nalansar breaks down reality around you.", 5000)
				end
			end
		end
	end
	if words == "bye" then
		self:depop()
	end
end

function EVENT_SLAY(self, other, damage, spell)
	if other and other:IsClient() then
		self:signal(60013, "earthfail")
	end
end

function EVENT_SIGNAL(self, words, data)
	if words == "failed" then
		self:depop()
		self:stopAllTimers()
	end
end