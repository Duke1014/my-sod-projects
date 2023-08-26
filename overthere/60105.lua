-- big bad guy Kaezakhan, the Hierophant - the quest version

function EVENT_SPAWN(self)
	self:walkTo(388, -182.7, -518, 192)
	self:timer("walk", 7000, true)
	self:timer("depop", 29000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "depop" then
		self:depop()
		self:stopAllTimers()
	
	elseif timer == "walk" then
		self:walkTo(369, -182.7, -518, 143)
		self:timer("walk2", 8000, true)
	
	elseif timer == "walk2" then
		self:walkTo(345.6, -238.7, -518, 2)		
	end
end