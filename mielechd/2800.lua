--2800 shadow guys
combat = false

function EVENT_SPAWN(self)
	self:timer("check", 2000)
	self:destroyCorpse()
end

function EVENT_TIMER(self,words)
	if words == "check" and combat == false then
		if self:GetX() > 50 then
			self:stopAllTimers()
			self:depop()
		end
	end
end

function EVENT_ATTACK()
	combat = true
end

function EVENT_COMBATEND()
	combat = false
end