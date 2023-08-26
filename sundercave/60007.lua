--[[ 60007
infernal dude, make it spawn fiery adds or something: 60011]]--

function EVENT_ATTACK(self, other)

	self:timer("add", 10000)
	self:text("An unseen voice shouts, 'You FOOLS! Destroy these intelopers already!'", 13)
	
end

function EVENT_DEATH(self, other, damage, spell)

	depop(60011)	
	self:stopAllTimers()	
	
end

function EVENT_TIMER(self, words)

	if words == "add" then
	
		spawn(60011, self:GetX(), self:GetY(), self:GetZ())
		self:text("The demon summons an elemental ally.", 8)
		
	end
	
end

function EVENT_COMBATEND(self)

	depop(60011)	
	self:respawn()
	self:stopAllTimers()
	
end