--60011, fire ele add for 60007--

function EVENT_SPAWN(self)
	self:timer("nuke", 4000)
	self:destroyCorpse()
end

function EVENT_TIMER(self, words)
	if words == "nuke" then
		HL = self:GetHateList()
		for k,v in pairs(HL) do
			self:customNuke(v, "nuke", "Fire engulfs you.", 1000)
		end
	end
end

function EVENT_DEATH(self)
	self:stopAllTimers()
	self:depop()
end

function EVENT_COMBATEND(self)
	self:stopAllTimers()
	self:depop()
end