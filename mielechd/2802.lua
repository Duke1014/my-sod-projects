-- all adds can be wizard destroyed, enchanter/bard/necro mezzed, stunned
-- all adds can NOT be rooted, charmed, feared

fly_model = 265
cube_model = 31
spore_model = 28

function EVENT_SPAWN(self)
	self:destroyCorpse()

	local random_mob_type = math.random(1,3)

    if random_mob_type == 1 then
		mechanic(self, "bug")
    elseif random_mob_type == 2 then
		mechanic(self, "cube")
    elseif random_mob_type == 3 then
		mechanic(self, "spore")
    end

	self:runTo(self:GetX(), 910, -18)
end

function EVENT_ATTACK(self, other)
	self:stopMove()
	mechanic(self)
end

function mechanic(self, mob_type)
	if mob_type == "bug" then
		self:setAppearance(fly_model)
		self:cast(6048, self)
		self:set("bodytype", 22)
		self:timer("suckysucky", 10000, true)
	elseif mob_type == "cube" then
		self:setAppearance(cube_model)
		self:set("bodytype", 13)
		self:set("specialattks", 3, 3)
	elseif mob_type == "spore" then
		self:setAppearance(spore_model)
		self:set("bodytype", 21)
		self:set("proc", 3355)
		self:set("Abilities", "3332 20")
	end
end

function suck(self)
	target = self:GetTarget()

	if target == nil then
		self:timer("suckysucky", 2000, true)
		return
	end

	nuke = customnuke(self, target, "Vile Suck", 500, 5, -150, "A vile mosquito bites you. Gross...")
	debugtext(tostring(nuke))

	self:timer("suckysucky", 12000, true)
end

function EVENT_SPELL(self, other, spellname, spellid, resist_type, mana_used, damage, spell_object)
	if spell_object:HasEffect(22) or spell_object:HasEffect(23) or spell_object:HasEffect(31) then 
		self:stopTimer("suckysucky")
	end
end

function EVENT_FADEBUFF(self, spellname, spellid, spell_object)
	if spell_object:HasEffect(22) or spell_object:HasEffect(23) or spell_object:HasEffect(31) then 
		self:timer("suckysucky", 6000, true)
	end
end

function EVENT_TIMER(self, timer)
	if timer == "suckysucky" then
		suck(self)
	end
end