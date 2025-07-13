--[[

	Mob Name: Zzz`t X`zz`x`t
	ID: 32240

	Rewritten by Duke

	Related mobs:
		sludge 				- 2805 
		an annoying gnat 	- 2806

	Related flags:
		n/a

	Final mob of MielechD (Mielech's Laboratory)
	Drops any Old World Tome based on the player's previously obtained tomes.
		- The weight of the tome's drop rates are lowered if a character has the tome already
		- This is to help alleviate dropping a tome that would rot
	
]]

sludge = {
	npcid = 2805, name = "", race = 145, size = 4,
	level = 65, hp = 10000, aiclass = 8, texture = 6, gender = 2,
}

gnat = {
	npcid = 2806, name = "an annoying gnat", race = 245, size = 2, 
	level = 65, hp = 12000, aiclass = 0, faction = 64, damage = 555, attacks = 3
}

local excluded_classes = {
    ["Warrior"] = true, ["Shadowknight"] = true, ["Paladin"] = true, -- Tanks
    ["Cleric"] = true, ["Shaman"] = true, ["Druid"] = true -- Healers
}

-- UNTESTED
local loot_iterator = 0

local tome_data = {
	[35400] = { tome_id = 12970, weight = 5 }, -- Secrets of the Wee Folk
	[35401] = { tome_id = 12971, weight = 5 }, -- Understanding and Working With Runes
	[35402] = { tome_id = 12972, weight = 5 }, -- Compendium of Aggressive Stances
	[35403] = { tome_id = 12973, weight = 5 }, -- Compendium of Passive Stances
	[35404] = { tome_id = 12974, weight = 5 }, -- Dodging the Tears of Tarhyl
	[35405] = { tome_id = 12975, weight = 5 }, -- Treatise on Armor Optimization
	[35406] = { tome_id = 12976, weight = 5 }, -- Tales of Rapid Recovery
	[35407] = { tome_id = 12977, weight = 5 }, -- Advanced Foe Management
	[35408] = { tome_id = 12978, weight = 5 }  -- Manual of Triggered Casting
}

function calculate_tome_weight(self, hatelist)
	for k, v in pairs(hatelist) do
		if v:IsClient() then
			for flag, tome in pairs(tome_data) do
				if v:GetFlag(flag) > 0 then
					tome.weight = tome.weight - 1 -- if someone at all has the tome flag, reduce the chance of the tome dropping by 1 point
					loot_iterator = loot_iterator + tome.weight
				end
			end
		end
	end
end

function add_tome_to_loot(self)
	if loot_iterator == 0 then return end -- exit if no tomes can be looted, extremely unlikely but YA KNOW

	local loot_roll = math.random(1, loot_iterator)

	for flag, tome in pairs(tome_data) do
		loot_iterator = loot_iterator - tome.weight
		if loot_iterator <= 0 then
			self:addLoot(tome.tome_id, 1)
			return
		end
	end
end
-- END UNTESTED

function define_last_buff_slot(player)
	local last_slot = 0
	for k, v in pairs(player:GetBuffs()) do 
		-- the plan is to iterate through every buff the player has
		-- when we get to the last buff, we add +1 to grab the final slot
		last_slot = last_slot + 1 -- this may be wrong
		if (k == 17) then
			last_slot = 17
		end
	end
	return last_slot
end

function is_valid_target(player)
    return not excluded_classes[player:GetClassName()]
end

function EVENT_INSIGHT(self, other)
	self:text(self:GetName()..":", 13)
	self:text(" * One of Mielech's first creations, able to produce life on it's own.", 13)
	self:text(" * As any gnat can be, extremely pesky and bothersome. Don't let the small gnats distract you away from the big one!", 13)
	self:text(" * Any bites should be treated quickly. The disease from this creature is fast-acting and will attract more gnats.", 13)
end

function EVENT_SPAWN(self)
	cleanup(self)
	self:set("tether", 70)
	self:timer("roam", 1000, true)
	self:hpTrigger(90)
end

function EVENT_ATTACK(self, other)
	self:stopTimer("roam")
	self:stopMove()
	self:text(self:GetName() .. " gives a startled buzz!")
	self:timer("bite", 15000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "roam" then
		RandomRoam(self)
		self:timer("roam", 6000, true)
	end

	if timer == "bite" then
		local bitees = {}
		local hl = self:GetHateList()
		for k,v in pairs(hl) do
			if v:IsClient() and is_valid_target(v) then
				table.insert(bitees,v)
			end
		end
		if #bitees > 0 then
			Bite(self,bitees[math.random(#bitees)])
		else
			Bite(self, hl[math.random(#hl)])
		end
	end

	if timer == "bug" then
		customspawn(gnat, self)
		self:timer("bug", 35000, true)
	end
end

function RandomRoam(self)
	maxX = 121
	minX = 29
	maxY = -809
	minY = -872
	self:walkTo(math.random(minX,maxX), math.random(minY,maxY), 4, math.random(256))
end

function Bite(self, target)
	self:text(self:GetName() .. " takes a chunk out of " .. target:GetName() .."'s flesh!",306,100)
	customnuke(self, target, "Bite of Mielech", (target:GetStats().maxhp / 2), -200, 5, "You've been bitten by "..self:GetName().."!")
	target:setBuff(define_last_buff_slot(target), 2320, 5, false)
	-- self:timer("check_for_festering", 30000, true)
	self:timer("bite", 40000, true)
end

function EVENT_HP(self, other, damage, ratio, spell_object)
	if ratio == 90 then
		self:text(self:GetName().." reels back and spits an awful sludge at the entrance!")
		sludge_1 = customspawn(sludge, 12.4, -835, 9.8, 191.5)
		sludge_2 = customspawn(sludge, -14.3, -835, 16.6, 191.5)
		sludge_3 = customspawn(sludge, -42.1, -835, 27.9, 191.5)
		self:timer("bug", 10000, true)
		self:hpTrigger(25)

	elseif ratio == 25 then
		self:text(self:GetName().." lets out a loud screech of rage!")
		self:set("damage", 1800, 900)
		self:set("SpecialAttks", 3, 5) -- vengeful strikesw
	end
end

function EVENT_DEATH(self,other,d,s)
	self:stopAllTimers()
	cleanup(self)
	local hl = self:GetHateList()
	calculate_tome_weight(self, hl)
	add_tome_to_loot(self)
	-- for k,v in pairs(hl) do
	-- 	if v:IsClient() and v:GetFlag(14452) == 16 and v:GetFlag(14453) < 100 then
	-- 		v:text("The fly's gigantic wings fall to the ground. You pocket them.",0,true)
	-- 		v:giveItem(41729,1)
	-- 		v:setFlag(14453,100)
	-- 		v:journal("Delicacies of Dormim",71,"I found the Monstrous Wings for Dormim.")
	-- 	end
	-- end
end	

function EVENT_COMBATEND(self)
	cleanup(self)
	self:respawn()
end

function cleanup(self)
	depop(2805)
	depop(2806)
end

function EVENT_SIGNAL(self, signal, data)
	if signal == "buzz" then
		debugtext(data:GetName().."'s hate before: "..self:GetHate(data))
		self:setHate(data, (self:GetHate(data) - 500))
		debugtext(data:GetName().."'s hate after: "..self:GetHate(data))
	end

	if signal == "natural_fade" then
		customspawn(gnat, data:GetLoc())
		self:text("A nasty gnat crawls from "..data:GetName().."'s bite wound!")
	end
end