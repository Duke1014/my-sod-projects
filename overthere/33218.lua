--33215.lua Training Master Zeke

-- flag 7120, 1 == You fought/killed Raptor

weapon_time = false

function EVENT_SPAWN(self)
    signal(33216, "exercise")
    _G.Zeke = self
end

function EVENT_ATTACK(self)
    self:say("You'll feel the full force of the Kaezulian Armada soon enough!")
    self:timer("rotate_weapon", 3000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "rotate_weapon" then
		self:text(""..self:GetName().." unsheathes a new weapon and changes their stance.")
		weapon = math.random(1, 6)
		weapon_time = true
		
		if weapon == 1 then -- 2H Sword
			style = "2HS"
			self:setWeapon(4632)
			self:setWeapon(0, 8)
			self:set("AC", 1000)
			self:set("Damage", 2000, 1000)
			self:set("SpecialAttks", 4, 5) -- Cleaving Strike
			self:set("attacks", 3)
		elseif weapon == 2 then -- 2H Staff
			style = "2HB"
			self:setWeapon(4630)
			self:setWeapon(0, 8)
			self:set("AC", 1000)
			self:set("Damage", 2000, 1000)
			self:set("attacks", 3)
			self:timer("db", 15000) -- Dev Blow
		elseif weapon == 3 then -- 2H Pierce
			style = "2HP"
			self:setWeapon(4633)
			self:setWeapon(0, 8)
			self:set("AC", 1000)
			self:set("Damage", 2000, 1000)
			self:set("SpecialAttks", 4, 4)-- Piercing Strike
			self:set("attacks", 3)
		elseif weapon == 4 then -- 1H Sword + Shield
			style = "swordboard"
			self:setWeapon(4626)
			self:setWeapon(12374, 8)
			self:set("AC", 1250)
			self:set("Damage", 800, 400)
			self:set("attacks", 2)
			self:timer("bash", 10000)
		elseif weapon == 5 then -- 1H Dual Wield Sticks
			style = "sticks"
			self:setWeapon(4628)
			self:setWeapon(4628, 8)
			self:set("AC", 1000)
			self:set("Damage", 1000, 500)
			self:set("SpecialAttks", 3, 2) -- Whirlwind 
			self:set("attacks", 6)
		else -- 1H Dual Wield Daggers
			style = "daggers"
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
		self:text(""..self:GetName().." recoils from losing their weapon! As the weapon falls onto the ground, it springs to life!")
		spawn_data = {}
		if style == "2HS" then
			spawn_data = {name = "a claymore", level = 55, hp = 10000, race = 127, weapon1 = 4632}
		elseif style == "2HB" then
			spawn_data = {name = "a quarterstaff", level = 55, hp = 10000, race = 127, weapon1 = 4630}
		elseif style == "2HP" then
			spawn_data = {name = "a trident", level = 55, hp = 10000, race = 127, weapon1 = 4633}
		elseif style == "swordboard" then
			spawn_data = {name = "a sword and shield", level = 55, hp = 10000, race = 127, weapon1 = 4626, weapon2 = 12374}
		elseif style == "sticks" then
			spawn_data = {name = "a pair of maces", level = 55, hp = 10000, race = 127, weapon1 = 4628, weapon2 = 4628}
		else
			spawn_data = {name = "a set of daggers", level = 55, hp = 10000, race = 127, weapon1 = 4624, weapon2 = 4624}
		end
		weapon_spawn = customSpawn(spawn_data, self:GetX() + math.random(-5, 5), self:GetY() + math.random(-5, 5), self:GetBestZ())
		weapon_spawn:addHate(self:GetTarget())
		self:setWeapon(0, 7)
		self:setWeapon(0, 8)
		self:set("AC", 800)
		self:set("Damage", 700, 350)
		self:set("attacks", 2)
		self:set("SpecialAttks", 3, 0)
		self:set("SpecialAttks", 4, 0)
		self:stopAllTimers()
		self:timer("rotate_weapon", 10000, true)
	end
end