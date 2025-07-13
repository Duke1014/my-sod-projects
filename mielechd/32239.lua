--32239 krazkak

function EVENT_SPAWN(self)
	self:set("PermaRooted",true)
	self:hpTrigger(90)
	cleanup(self) -- double check that things were cleaned up

	-- depopSpawn(76140) -- dont know what this is for yet
	
	fire = {name = "_____a roaring fire", level = 70, aiclass = 8, race = 127, gender = 0, hp = 1000, size = 8, npcid = 2804} -- may need to spawn this...
	fire_loc = {-13, 1340, -60}
	customSpawn(fire, fire_loc)
	-- respawn(76070)
end

function EVENT_TIMER(self, timer)
	if timer == "blood" then
		spawn_blood(self)
		self:timer("blood", 45000, true)
	end
end

function EVENT_HP(self, other, damage, trigger_ratio, spell_object)
	if self:GetHPTrigger() == 90 then
		self:text(self:GetName().." begins to stoke the fire...", 13)
		signal(2804, "start")
	end
end

function EVENT_ATTACK(self, other)
	self:text(self:GetName().." gurgles, blood bubbling from his mouth.")
	self:timer("blood", 10000, true)
end

function EVENT_SIGNAL(self, signal, data)
	if signal == "fire_out" then
		spawn_blood(self)
	end
	if signal == "fire_blast" then
		for k, v in pairs(self:GetHateList()) do
			if v:IsClient() and v:InZone() then
				self:customNuke(v, "Fire Flare", "A flare of fire surrounds you.", data, 2, -100)
			end
		end
	end
end

function EVENT_COMBATEND(self)
	cleanup(self)
	self:respawn()
end

function EVENT_DEATH(self, other, damage, spell)
	cleanup(self)
end

function cleanup(self)
	self:stopAllTimers()
	depop(2804)
	depop(2803)
end

function spawn_blood(self)
	self:text(self:GetName().." spits out a glob of blood, which comes to life!")
	blood = {name = "Blood of Mielech", level = 60, race = 145, gender = 2, texture = 3, size = 3, npcid = 2803}
	-- spawn(60282, self)
	customSpawn(blood, self:GetLoc())
end

function EVENT_INSIGHT(self, other)
	other:text(self:GetName()..":", 13)
	other:text(" * Enjoys the warmth of the magical, roaring fire for his pot of boiling blood.", 13)
	other:text(" * Strange, goopy blood seems to seep out of his mouth.", 13)
end