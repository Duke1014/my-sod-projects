-- Shadow man
-- 60290 - a shadowbound soul

damage_taken = 0.5

shadow = {npcid = 2800, name = "a grim shadow", level = 55, hp = 35000, damage = 400, race = 373, faction = 64}
grid_id = 5052


function EVENT_SAY(self, other, msg)
	if string.match(msg, "Hail") then
		currentHPRatio = self:GetStats().hpratio
		debugtext("test: "..currentHPRatio)
	end
end


function EVENT_INSIGHT(self)
	self:text(self:GetName(), 13)
	self:text("- This frog has unhinged movement, as if controlled by a puppet.", 13)
	self:text("- Adventurers prepared to protect their group will find little issue in holding attention of this creature.", 6)
end

function EVENT_JOINHATE(self, other) -- ensuring tank threat
	if other:IsClient() and (other:GetClass() == 1 or other:GetClass() == 3 or other:GetClass() == 5) then
		for k, v in pairs(other:GetBuffs()) do
			if v:GetID() == 2190 or  -- do not continue for Holy/Ret Paladin, Unholy SK, or Fury Warrior
				v:GetID() == 7150 or 
				v:GetID() == 7151 or 
				v:GetID() == 7152 or 
				v:GetID() == 7082 or 
				v:GetID() == 7135 or 
				v:GetID() == 7136 or 
				v:GetID() == 4650 or 
				v:GetID() == 7003  then
					debugtext("DEV MSG: This tank is not in tank-mode.")
				return
			else
				debugtext("DEV MSG: Tank found - increasing hate.")
				self:setHate(v, 100000)
			end
		end
	end
end

function EVENT_SPAWN(self)
	self:setAnim(3)
	-- 350000 HP
	conga_line = true
	self:area("end_of_conga_line", 40, -210, -293, -48)
	self:set("style.absorption", damage_taken)
	-- self:set("permarooted", true)
	self:timer("shadow_conga_line", 10000, true)
end

function EVENT_AREA(self, other, area)
	if area == "end_of_conga_line" and other:IsClient() and conga_line == true then
		self:text("The hallway quiets down as you approach the source of the shadows....")
		self:stopTimer("shadow_conga_line")
		conga_line = false
	end
end

function EVENT_ATTACK(self, other)
	self:text("The frog shambles over to "..other:GetName().." without a sound. Shadows encase the armor around it.")
	self:timer("shadow_soul", 30000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "shadow_soul" then
		swap_to_soul(self)
	elseif timer == "shadow_conga_line" then
		shadow_add = customspawn(shadow, self)
		shadow_add:assignGrid(grid_id)
		self:timer("shadow_conga_line", 10000, true)
	elseif timer == "back_to_frog" then
		swap_back_to_frog(self)
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
	depop(60290)
	self:deleteArea()
end

function swap_to_soul(self)
	currentHPRatio = self:GetStats().hpratio
	hl = self:GetHateList()
	spawn(60290, self)
	signal(60290, "swap_stuff", currentHPRatio)
	self:set("permarooted", true)
	self:set("specialattks", 1, 0)
	self:suspendMelee(true)
	self:setAnim(3)
	self:set("style.absorption", 0.1)
end

function swap_back_to_frog(self)
	self:set("specialattks", 1, 3)
	self:set("permarooted", false)
	self:suspendMelee(false)
	self:setAnim(1)
	self:set("style.absorption", damage_taken)
	self:timer("shadow_soul", 36000, true)
end

function EVENT_SIGNAL(self, msg, data)
	if msg == "shadow_died" then
		self:setHP(1)
	elseif msg == "shadow_return" then
		self:setHP(self:GetStats().hp - data)
		swap_back_to_frog(self)
	end
end