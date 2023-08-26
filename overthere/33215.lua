-- a kaezulian master-at-arms
-- this one is special, the weapons change around every now and then
-- disarm is important here!

-- flag 7120, 1 == You fought/killed Raptor

-- TESTING --
function EVENT_SPAWN(self)
	self:set("AIClass", 80)
end
-- TESTING --

weapon_time = false
function EVENT_ATTACK(self, other)
    taunts = {"Let's see... maybe I feel like using this sword? Or perhaps my polearm...", 
            "Who dares invade Kaezul's shipyard?",
            "Hmmph, this should be quick!"}
        
        if other:GetFlag(7120) >= 1 then
            table.insert(taunts, "I've been saving this weapon just for you, "..other:GetName()..".")
            table.insert(taunts, "Raptor must've used the wrong weapon against you, let's see what works best!")
        end
        
    taunt = taunts[math.random(1, #taunts)]

    self:say(""..taunt.."")

    self:timer("rotate_weapon", 8000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "rotate_weapon" then
		self:text(""..self:GetName().." unsheathes a new weapon and changes their stance.")
		weapon = math.random(1, 6)
		weapon_time = true
		
		if weapon == 1 then -- 2H Sword
			self:setWeapon(4632)
			self:setWeapon(36400, 8)
			self:set("AC", 1000)
			self:set("Damage", 2000, 1000)
			self:set("SpecialAttks", 4, 5) -- Cleaving Strike
			self:set("attacks", 3)
		elseif weapon == 2 then -- 2H Staff
			self:setWeapon(4630)
			self:setWeapon(36400, 8)
			self:set("AC", 1000)
			self:set("Damage", 2000, 1000)
			self:set("attacks", 3)
			self:timer("db", 15000) -- Dev Blow
		elseif weapon == 3 then -- 2H Pierce
			self:setWeapon(4633)
			self:setWeapon(36400, 8)
			self:set("AC", 1000)
			self:set("Damage", 2000, 1000)
			self:set("SpecialAttks", 4, 4)-- Piercing Strike
			self:set("attacks", 3)
		elseif weapon == 4 then -- 1H Sword + Shield
			self:setWeapon(4626)
			self:setWeapon(12374, 8)
			self:set("AC", 1250)
			self:set("Damage", 800, 400)
			self:set("attacks", 2)
			self:timer("bash", 10000)
		elseif weapon == 5 then -- 1H Dual Wield Sticks
			self:setWeapon(4628)
			self:setWeapon(4628, 8)
			self:set("AC", 1000)
			self:set("Damage", 1000, 500)
			self:set("SpecialAttks", 3, 2) -- Whirlwind 
			self:set("attacks", 6)
		else -- 1H Dual Wield Daggers
			self:setWeapon(4624)
			self:setWeapon(4624, 8)
			self:set("AC", 1000)
			self:set("Damage", 1000, 500)
			self:set("SpecialAttks", 4, 2) -- Frenzy 
			self:set("attacks", 6)
		end
	
	elseif timer == "db" then
		self:timer("db2", 5000, true)
		self:text(""..self:GetName().." growls...", 13)

	elseif timer == "db2" then
		self:text(""..self:GetName().." delivers a DEVASTATING BLOW!", 13)
		target = self:GetTarget()
		self:damage(target, 8000, 4, 65535, true) -- guarenteed hit of half of target's max hp

	elseif timer == "bash" then
		self:text(""..self:GetName().." performs a stunning bash!", 13)
		self:doAnim(4)
		target = self:GetTarget()
		self:damage(target, 500)
		target:stun(500, true) -- guarenteed hit of 500 and stun, to interrupt spells and such
	end
end

function EVENT_DISARM_SUCCESS(self, other)
	if weapon_time == true then
		weapon_time = false
		self:text(""..self:GetName().." recoils from losing their weapon!")
		self:setWeapon(36400, 8)
		self:set("AC", 800)
		self:set("Damage", 700, 350)
		self:set("attacks", 2)
		self:set("SpecialAttks", 3, 0)
		self:set("SpecialAttks", 4, 0)
		self:stopAllTimers()
		self:timer("rotate_weapon", 20000, true)
	end
end

function EVENT_COMBATEND(self)
	self:stopAllTimers()
end

function EVENT_DEATH(self, other, damage, spell)
	self:stopAllTimers()
end