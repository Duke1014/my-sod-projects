-- THE TAR MONSTER
-- ruh-ruh, Raggy...
-- This event involves The Tar Monster, who shapeshifts into different models, while changing mechanics on the fly
local target
breath = 0

function EVENT_SPAWN(self)
	self:text("Born from the strange tar pits, a monster reveals itself, but looks as though the tar will lose it's form soon...", 13, 500)
	self:timer("TookTooLongToEngage", 60000, true)
	self:hpTrigger(80)
end
	
function EVENT_ATTACK(self, other)
	self:text("The Tar Monster shambles itself toward "..other:GetName().."!", 13, 500)
	self:stopTimer("TookTooLongToEngage")
end

function EVENT_TIMER(self, timer, data)
	-- golem phase stuff
	if timer == "TookTooLongToEngage" then
		self:text("you suck", 13, 500)
		resetEncounter(self)
	
	-- elephant phase stuff
	elseif timer == "Knockback" then
		self:timer("Charge", 5000, true)
		local chargeTargets = {}
		hl = self:GetHateList() -- set up aggro table
		self:suspendMelee(true)
		for k, v in pairs(hl) do
			if v:IsClient() and self:GetDist(v) < 25 then
				self:damage(v, 1500, 100, 905, true) -- avatar knockback + 1500 dmg to close-by players
			end
			if v:IsClient() and v:InZone() and not v:IsPet() then
                table.insert(chargeTargets,v)
            end
		end
		if chargeTargets == nil then
			target = self:GetTarget()
		else
			target = chargeTargets[math.random(#chargeTargets)]
		end
		self:text(""..self:GetName().." rears back and stomps, preparing to charge at "..target:GetName().."!")
		target:text("[NOTE: You can avoid extra damage by moving away at the right moment.]")
	
	elseif timer == "Charge" then -- charge at someone on aggro table	
		self:followArea("charging", 30)
		target:text("The Tar Monster charges after YOU!", 13, true)
		self:runTo(target)
		self:timer("Charge_End", 5000, true)
	elseif timer == "Charge_End" then
		self:suspendMelee(false)
		
	-- scorpion phase stuff
	elseif timer == "Impale" then
		hl = self:GetHateList() -- set up aggro table
		local impaleTargets = {}
        for k,v in pairs(hl) do
            if v:IsClient() and v:InZone() and not v:IsPet() then
				if v:GetClass() == 4 
				or v:GetClass() == 7 
				or v:GetClass() == 8 
				or v:GetClass() == 9 
				or v:GetClass() == 11 
				or v:GetClass() == 12 
				or v:GetClass() == 13 
				or v:GetClass() == 14 
				or v:GetClass() == 15 then -- Not the tank or healer
					table.insert(impaleTargets,v)
				end
			end
        end
		if impaleTargets == nil then
			target = self:GetTarget()
			debugtext("GM: No impaleTargets found. Using target.")
		else
			target = impaleTargets[math.random(#impaleTargets)]
		end
		self:text(""..target:GetName().." is IMPALED by the scorpion's stinger!", 13, 150)
		target:teleport(self, true)
		target:stun(10000, true)
		self:damage(target, 6500, 3)
	
	-- alien phase stuff
	elseif timer == "AoE_Punch_Start" then
		hl = self:GetHateList() -- set up aggro table
		self:timer("AoE_Punch", 5000) 
		for k, v in pairs(hl) do
			if v:IsClient() then -- punch all players (not pets)
				self:damage(self, v, math.random(400,800), 4)
			end
		end
	
	elseif timer == "AoE_Punch" then
		hl = self:GetHateList() -- set up aggro table
		for k, v in pairs(hl) do
			if v:IsClient() then -- punch all players (not pets)
				self:damage(self, v, math.random(400,800), 4)
			end
		end	
		
	elseif timer == "Mud_Explosion" then
		self:timer("Mud_Explosion_Kaboom", 5000)
		self:stopTimer("AoE_Punch")
		self:set("permaroot", 1) -- root me
		self:set("specialattks", 0, 0, 0, 0, 0, 0) -- F I X  M E
		self:text("The Tar Monster's body begins to gurgle and simmer, steam rising from it's body...", textcolor, 500)
		
	elseif timer == "Mud_Explosion_Kaboom" then
		hl = self:GetHateList() -- set up aggro table
		for k, v in pairs(hl) do
			if v:IsClient() and v:InZone() then -- punch all players (not pets)
				distance = self:GetDist(v)
				if distance < 400 then -- 100 ish = bad. u r ded	
					self:customNuke(v, "Seething Tar", "Tar sears into your flesh.", (20000 - (distance*67)))
				end
			end
		end
		self:set("permaroot", 0) -- unroot me
		self:set("specialattks", 3, 0, 0, 0, 0, 0) -- F I X  M E
		
	-- dragon phase stuff
	elseif timer == "Berserk" then
		hl = self:GetHateList() -- set up aggro table
		for k, v in pairs(hl) do
			if v:IsClient() and v:InCone(self, 150) then
				self:customNuke(v, "Tar Blast", "A blast of tar sears your flesh.", (500 + (500*breath))) -- breath
			end
		end
		breath = (breath + 1)
	end
end

function EVENT_AREA(self, other, area)
	if area == "charging" then
		if other:IsClient() and other:InZone() then
			self:damage(other, 10000, 2)
			other:doAnim(16)
		end
	end
end

function EVENT_HP(self, other, damage, hp)
	if hp == 80 then
		self:stopAllTimers()
		elephant(self, other)
		self:hpTrigger(60)
	elseif hp == 60 then
		self:stopAllTimers()
		scorpion(self, other)
		self:hpTrigger(40)
	elseif hp == 40 then
		self:stopAllTimers()
		alien(self, other)
		self:hpTrigger(20)
	elseif hp == 20 then
		self:stopAllTimers()
		dragon(self, other)
	end
end

function elephant(self, other)
	self:text(""..self:GetName().." reforms itself to a new form from the land!")
	self:setAppearance(107, 0, 4)
	self:setSize(20)
	self:set("specialattks", 4, 2) -- frenzy
	self:set("speed", 4) -- big vroom-vroom
	self:timer("Knockback", 30000) -- knock anyone in melee range 200 units away, charge after one of them in 2-3 seconds
end

function scorpion(self, other)
	self:text(""..self:GetName().." reforms itself to a new form from the land!")
	self:setAppearance(129, 4)
	self:setSize(20)
	self:set("specialattks", 1, 2) -- summons
	self:set("specialattks", 4, 4) -- piercing strikes
	self:set("damage", 4500, 2500) -- adjust max dmg for piercing strikes
	self:set("attacks", 1)
	self:timer("Impale", 25000) -- impale random dps, making them unable to move. mob cannot move either (never healer or highest aggro)
end

function alien(self, other)
	self:text(""..self:GetName().." reforms itself to a new form from the land!")
	self:setAppearance(229, 0, 0)
	self:setSize(40)
	self:set("specialattks", 1, 3) -- blinks to tank -- F I X  M E
	self:set("damage", 2500, 1000) -- dmg
	self:timer("AoE_Punch_Start", 10000, true) -- AoE melee strikes - the farther away the more dmg you take
	self:timer("Mud_Explosion", 30000) -- mud explosion - the closer you are the more dmg you take. lethal
end

function dragon(self, other)
	self:text(""..self:GetName().." reforms itself to a new form from the land!")
	self:setAppearance(530, 2, 5)
	self:setSize(100)
	self:set("specialattks", 2, 0, 4, 0, 0, 0) -- rampage -- F I X  M E
	self:set("damage", 4000, 2000)
	self:timer("Berserk", 5000)
end

function EVENT_COMBATEND(self)
	self:stopAllTimers()
	respawn(69965)
	self:depop()
end

function EVENT_DEATH(self)

end