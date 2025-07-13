-- Second Lieutenant Vaszak 
-- Murk trapping event

local surprise = true
local stun_length = 20000
-- local shouts = {
-- 	"Vaszak shouts, 'No, no! Zalissk! Tharluk! Help me!'",
-- 	"Vaszak screams in a shaky voice, 'Tharluk! Tharluk, help! Save me!'"
-- }

function EVENT_SPAWN(self)
    -- check npc editor if scowling normally
    self:timer("walk_1", 2000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "walk_1" then
		self:timer("walk_2", 50000, true)
		self:walkTo(1580, 2661, -8)
	end
	if timer == "walk_2" then
        self:say("Wait... something feels off.", 200)
        surprise = false
    end
	if timer == "surprise_linger" then
		surprise = false
	end
	if timer == "healing" then
		self:heal(4000)
		debugtext("HEALS")
	end
end

function EVENT_SPELL(self, other, spell, spellid, resist, mana_used, damage, spell_object)
	if spellid == 3 then
		self:stopMove()
		self:stopAllTimers()
		if surprise == true then
			surprise = false
			other:text("Your surprise attack managed to trap all three iksars!", 14, true)
			self:stun(20000, true)
			signal(32017, "stun")
			signal(32018, "stun")

		else
			if stun_length > 0 then
				self:stun(stun_length, true)
				stun_length = stun_length - 5000
				self:text(self:GetName().." spasms in place from the Gruplok Trap!", 14, 200)
			end
		end
	end
end

function EVENT_SIGNAL(self, signal)
	debugtext("A SIGNAL WENT THROUGH")
	if signal == "shielded" then -- not working....
		self:set("AC", 10000)
		debugtext("SHIELDING")
	end
	
	if signal == "shield_end" then
		debugtext("C")
		self:set("AC", 400)
		debugtext("SHIELDING STOPPED")
	end
	
	if signal == "heal" then
		self:timer("healing", 6000)
		debugtext("HEALING")
	end

	if signal == "heal_end" then
		self:stopTimer("healing")
		debugtext("HEALING STOPPED")
	end
end

function EVENT_ATTACK(self, other)
	self:timer("surprise_linger", 5000, true)
	self:stopMove()
end

function EVENT_DEATH(self)
	self:say("You fools.. you.. worthless... ugh..")
	self:text("The bodyguard and valet, terrfied, scamper off.")
	local hate_list = self:GetHateList()
	for k, v in pairs(hate_list) do
		if v:IsClient() and v:GetFlag(14011) == 14 then
			v:setFlag(14011, 15)
			v:text("The trap crumbles.", 6, true)
			v:takeItem(41019)
			v:giveItem(41020)
		end
	end
	depop(32017)
	depop(32018)
end

function EVENT_COMBATEND(self)
	self:say("Pfah!")
	depop(32018)
	depop(32017)
	self:depop()
end