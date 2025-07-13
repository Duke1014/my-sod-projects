-- Tharluk the Valet
-- Murk trapping event

local healing = false
local stun_length = 20000
-- local shouts = {
-- 	"Vaszak screams in fury, 'How can you just stand there! They're hurting me! Make them stop!!'",
-- 	"Vaszak panics and shouts, 'Help me! You.. you fools! Help me defeat these inferior, soft-scaled Grup-lovers!'",
-- 	"Vaszak shouts, 'Tharluk! Whats wrong with you? Don't just stand there--protect me!'"
-- }

function EVENT_SPAWN(self)
    -- check npc editor if scowling normally
    self:timer("walk_1", 2000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "walk_1" then
		self:walkTo(1597.3, 2675, -5)
	end

	if timer == "heal_start" then
		self:text(self:GetName().." begins weaving a healing mist around Vaszak...", 13, 200)
		self:timer("healing_mist", 6000, true)
	end

	if timer == "healing_mist" then
		self:text(self:GetName().."'s healing mist envelopes Vaszak and heals his wounds continuously!", 13, 200)
		signal(32016, "heal")
		healing = true
	end

end

function EVENT_SPELL(self, other, spell, spellid, resist, mana_used, damage, spell_object)
	if spellid == 3 then
		self:stopMove()
		self:stopAllTimers()
		if stun_length > 0 then
			self:text(self:GetName().." visibly begins to slow until his movements stop entirely.", 0, 200)
			self:stun(stun_length, true)
			stun_length = stun_length - 5000
		end
		if healing == true then
			self:text(self:GetName().." is interrupted! The wreath of mist disperses immediately!", 14, 200)
			healing = false
			signal(32016, "heal_end")
		end
		self:interrupt()
		self:timer("heal_start", 60000, true)
	end
end

function EVENT_SIGNAL(self, signal)
	if signal == "stun" then
		self:stun(20000, true)
		self:stopMove()
		self:stopAllTimers()
		self:timer("heal_start", 60000, true)
	end
end

function EVENT_COMBATEND(self)
	self:stopAllTimers()
end

function EVENT_ATTACK(self, other)
	self:stopMove()
end