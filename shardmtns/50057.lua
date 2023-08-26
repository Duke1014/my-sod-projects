--[[ 
spiny mole 
Obsidian Shard Mountains (loc: 1850.74 -663.32 0.68)
NPCID: 50057
periodically strikes around itself as "Devastating Slashes"
spawns explosive adds at 70/50/30
stationary, 
will ALWAYS drop a quest piece and ONE loot
]]

function EVENT_SPAWN(self)
	self:hpTrigger(70)
	self:set("permarooted", 1)
end

function EVENT_HP(self, other, damage, trigger_ratio, spell_object)
	if trigger_ratio == 70 then
		self:hpTrigger(50)
		zonetext("Giant ticks come out of the ground!")
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		for k,v in pairs(HL) do
			if v and v:InZone() then
				self:customNuke(v, "earthquake", "A massive earthquake erupts in the area." , 3000, 0, 0) --it is add time, my dudes
			end
		end
	end
	if trigger_ratio == 50 then	
		self:hpTrigger(30)
		zonetext("Giant ticks come out of the ground!")
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2) -- spawns explosive adds
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		for k,v in pairs(HL) do
			if v and v:InZone() then
				self:customNuke(v, "earthquake", "A massive earthquake erupts in the area." , 3000, 0, 0)
			end
		end
	end
	if trigger_ratio == 30 then
		self:hpTrigger(25)
		zonetext("Giant ticks come out of the ground!")	
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2) -- spawns explosive adds
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		spawn(60002, self:GetX(), self:GetY(), self:GetZ() + 2)
		for k,v in pairs(HL) do
			if v and v:InZone() then
				self:customNuke(v, "earthquake", "A massive earthquake erupts in the area." , 3000, 0, 0)
			end
		end
	end
	if trigger_ratio == 25 then
		zonetext("The mole, disturbed from his friendly ticks being destroyed, is overcomed by RAGE!", 13)
		self:stopTimer("slashwarn")
		self:timer("enragedslash", 6000)
	end	
end

function EVENT_TIMER(self, timer_name, timer_object) --  directional slashes
	if timer_name == "slashwarn" or timer_name == "enragedslash" then
		slash_direction = math.random(4)
		if (slash_direction == 1) then
			zonetext("spiny mole brings his claws back, glancing forward...", 13)						--front
			self:timer("frontslash",5000,true)
		elseif (slash_direction == 2) then
			zonetext("spiny mole stretches his claws in front of him, glancing backward...", 13)		--back
			self:timer("slashback",5000,true)
		elseif (slash_direction == 3) then
			zonetext("spiny mole brings his arms together, glancing to his sides...", 13)				--sides
			self:timer("slashsides",5000,true)
		else 
			zonetext("spiny mole glances all around...", 13)											--all around 
			self:timer("slashww",5000,true)
		end
    end
	if timer_name == "frontslash" then
		HL = self:GetHateList()
		self:text("spiny mole lunges his claws FORWARD, creating a DEVASTATING SLASH!", 13)
		for k, v in pairs(HL) do
			if v:IsClient() then
				if v:InCone(self, 140) then
					self:customHit(v, 7000, 4, false,false,false,true,true)
				end	
			end
		end
	end
	if timer_name == "slashback" then
		HL = self:GetHateList()
		self:text("spiny mole lunges his claws BACKWARD, creating a DEVASTATING SLASH!", 13)
		for k, v in pairs(HL) do			
			if v:IsClient() then
				if v:InCone(self, 180, 180) then
					self:customHit(v, 7000, 4, false,false,false,true,true)
				end
			end
		end		
	end
	if timer_name == "slashsides" then
		HL = self:GetHateList()
		self:text("spiny mole lunges his claws to his SIDES, creating DEVASTATING SLASHES!", 13)
		for k, v in pairs(HL) do
			if v:IsClient() then
				if v:InCone(self, 100, 90) or v:InCone(self,100,270) then
					self:customHit(v, 7000, 4, false,false,false,true,true)
				end	
			end	
		end
	end
	if timer_name == "slashww" then
		HL = self:GetHateList()
		self:text("spiny mole swings his arms wildly, creating DEVASTATING SLASHES!", 13)
		for k, v in pairs(HL) do
			if v:IsClient() then
				self:customHit(v, 7000, 4, false,false,false,true,true)
			end	
		end
	end
end

function EVENT_INSIGHT(self, other)
	zonetext("spiny mole:", 13)
	zonetext("---Will perform a slash attack in different directions that cannot be out-ranged.", 13)
	zonetext("---70/50/30: ticks appear from the ground from an earthquake, that will explode upon death.", 13)
	zonetext("---The ticks will explode if not dealt with after 60 seconds of spawning.", 13) 
end

function EVENT_ATTACK(self, other)
	zonetext("The great spiny mole screams in rage!")
	self:timer("slashwarn",25000)	
end

function EVENT_COMBATEND(self, timer_name)
	self:respawn()
	depop(60002)
	self:stopAllTimers()
end

function EVENT_DEATH(self, timer_name)
	depop(60002)
	self:stopAllTimers()
end