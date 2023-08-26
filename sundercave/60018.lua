-- fire add for 60013/60014
-- explodes in 60 seconds

function EVENT_TIMER(self, words)
	if words == "fireadd" then
		hl = self:GetHateList()
		for k,v in pairs(hl) do
			if v and v:InZone() then
				self:customNuke(v, "Shade Bomb", "Nalansar uses the power of the chosen to rain fire upon you.", 5000, 1)
			end
		end
	signal(60014, "kaboom")
	self:depop()
	self:stopAllTimers()
	end
	
	if words == "10_sec" then
		self:text("40 Seconds Remaining")
		
	elseif words == "20_sec" then
		self:text("30 Seconds Remaining")
		
	elseif words == "30_sec" then
		self:text("20 Seconds Remaining")
		
	elseif words == "40_sec" then
		self:text("10 Seconds Remaining")
		
	end
	
end

function EVENT_SPAWN(self)
	self:timer("fireadd", 50000, true)
	self:set("permarooted", 1)
	self:setAppearance(373)
	self:destroyCorpse()
	self:timer("10_sec", 10000, true)
	self:timer("20_sec", 20000, true)
	self:timer("30_sec", 30000, true)
	self:timer("40_sec", 40000, true)
end

function EVENT_DEATH(self)
	signal(60013, "firewin")
	signal(60014, "firewin")
	self:stopAllTimers()
end