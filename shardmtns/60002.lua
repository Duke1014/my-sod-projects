--[[ 
volatile tick 
NPCID 60002
add for "spiny mole" (60001) MOLEYMOLEYMOLEYMOLEYMOLEYMOLEYMOLEYMOLEYMOLEYMOLEYMOLEY
--]]

function EVENT_DEATH(self)
	HL = self:GetHateList()
	for k,v in pairs(HL) do
		customnuke(self, v, "explodingtick", 5000, 0, 0, "The volatile tick EXPLODES upon death!")
	end
end		

function EVENT_SPAWN(self)
	self:destroyCorpse()
end

function EVENT_ATTACK(self, other)
	self:timer("KABOOM", 60000)
	self:timer("warn", 50000)
	other:text("As the tick attacks, a gurgling sound is heard inside it. You don't have long before it explodes...", 326)
end

function EVENT_TIMER(self, timer_name)
	if timer_name == "KABOOM" then
		HL = self:GetHateList()
		for k,v in pairs(HL) do
			self:customNuke(v, "explodingtick", "The volatile tick EXPLODES upon death!", 5000)
		end
		self:depop()
	end
	if timer_name == "warn" then
		self:text("The tick is about to explode!", 326)
	end
end

function EVENT_COMBATEND(self)
	self:depop()
end
