-- Bodyguard Zalissk
-- Murk trapping event

local shield = false
local stun_length = 20000
-- local shouts = {
-- 	"Vaszak screams in fury, 'How can you just stand there! They're hurting me! Make them stop!!'",
-- 	"Vaszak panics and shouts, 'Help me! You.. you fools! Help me defeat these inferior, soft-scaled Grup-lovers!'",
-- 	"Vaszak shouts, 'Zalissk! You fool! The Commander will hear of your cowardice!'"
-- }

function EVENT_SPAWN(self)
    -- check npc editor if scowling normally
    self:timer("walk_1", 2000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "walk_1" then
		self:walkTo(1601, 2652, -5)
	end

	if timer == "shield_start" then
		self:text(self:GetName().." prepares his shield to protect Vaszak...", 13, 200)
		self:timer("shielding", 6000, true)
	end

	if timer == "shielding" then
		self:text(self:GetName().." shelters Vaszak with his shield!", 13, 200)
		signal(32016, "shielded")
		self:set("AIClass", 8)
		shield = true
		-- do we need to take hate away?
	end

end 

function EVENT_SIGNAL(self, signal)
	if signal == "stun" then
		self:stun(20000, true)
        self:stopMove()
        self:stopAllTimers()
        self:timer("shield_start", 60000, true)
	end

end

function EVENT_ATTACK(self)
	self:timer("shield_start", 25000, true)
	self:stopMove()
end

function EVENT_SPELL(self, other, spell, spellid, resist, mana_used, damage, spell_object)
	if spellid == 3 then
        self:stopMove()
		self:stopAllTimers()
		if stun_length > 0 then
			self:text(self:GetName().." slows.. and finally stops as the trap takes effect.", 14, 200)
			self:stun(stun_length, true)
			stun_length = stun_length - 5000
		end
		if shield == true then
			debugtext("A")
			self:set("AIClass", 0)
			debugtext("B")
			signal(32016, "shield_end")
			debugtext("D")
			self:text(self:GetName().." ceases shielding Vaszak!", 14, 200)
		end
		self:interrupt()
		self:timer("shield_start", 60000, true)
	end
end