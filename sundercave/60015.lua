-- Diplo, Shojar's Chosen
-- water mini game, win to earn mana!

ClericBig 	= 1072 	-- 20%
ClericQuick = 2475 	-- 10%
ShamanBig 	= 1079 	-- 20%
Revitalize 	= 3295 	-- 20%
Chloroshock	= 3021 	-- 10%
Chloroblast = 1290 	-- 5%
PallyBig 	= 3344 	-- 20%
PallyQuick 	= 1518 	-- 10%
ShamanRunic = 3978 	-- 50%
RitualHeal 	= 3192 	-- 35%
Complete1 	= 1110	-- 100%
Complete2 	= 859 	-- 100%
Complete3 	= 13 	-- 100%
Complete4 	= 1019	-- 100%

startx = 1825.4
starty = 207.1
startz = 315
starth = 87.2

function EVENT_SPELL(self, other, spellname, spellid, resist_type, mana_used, damage, spell_object)
--[[	if spellid == Complete1 or spellid == Complete2 or spellid == Complete3 or spellid == Complete4 then
		self:heal()
		debugtext("Complete Heal Landed")
	end]]
	if spellid == RitualHeal then
		self:heal(35000)
		debugtext("Ritual Heal Landed")
	end
--[[	if spellid == ClericBig or spellid == ShamanBig or spellid == Revitalize or spellid == PallyBig then
		self:heal(25000)
		debugtext("Big Heal Landed")
	end
	if spellid == ShamanRunic then
		self:heal(35000)
		debugtext("Shaman Runic 2 Landed")
	end
	if spellid == ClericQuick or spellid == Chloroshock or spellid == PallyQuick then
		self:heal(10000)
		debugtext("Quick Heal Landed")
	end]]
end

function EVENT_SIGNAL(self, words, data)
	if words == "waterphase" then
		self:timer("cursed", 1000)
		self:timer("watercheck", 35000, true)
	end
end

function EVENT_TIMER(self, words)
	if words == "cursed" then
		self:customNuke(self, "curse", "Diplo is cursed!", 8500, 0)
	end
	if words == "watercheck" then
		self:stopAllTimers()
		signal(60013, "waterwin")
	end
end

function EVENT_SPAWN(self)
	self:runTo(startx, starty, startz)
	self:set("playerfriendly", 1)
end

function EVENT_DEATH(self)
	signal(60013, "waterfail")
	self:say("No... I'm sorry, mortals.")
	self:stopAllTimers()
end