-- Magdolena, the Inevitable

function EVENT_SPAWN(self)
	_G.magdolena = self
	self:hpTrigger(90)
end

function EVENT_ATTACKED(self, other, damage, spell)
	self:say("You will not stop the Inevitable Shade! This is our destiny!", 400)
end

function EVENT_HP(self, other, damage, hp)
	if hp == 90 then
		spawn(60134, -2074, 2279, 1.4)
		self:hpTrigger(80)
	elseif hp == 80 then
		spawn(60134, -2356, 2289, 1.4)
		self:hpTrigger(70)
	elseif hp == 70 then
		spawn(60134, -2347, 2020, 1.4)
		self:hpTrigger(60)
	elseif hp == 60 then
		spawn(60134, -2205, 1963, 1.4)
		self:hpTrigger(50)
	elseif hp == 50 then
		self:text("Magdolena unleashes a loud scream as her body is torn asunder. Shadows across the room flee to her body as they envelop her.")
		self:setAppearance(85, 2)
		self:set("SpecialAttks", 3, 8)
		self:set("SpecialAttks", 5, 0)
		self:set("Damage", 320)
		self:set("Offense", "0 0 0 0 0 0 0 0")
		self:set("Immunities", 2, 1)
		self:set("Speed", 2)
		self:hpTrigger(40)
	elseif hp == 40 then
		spawn(60134, -2356, 2289, 1.4)
		self:hpTrigger(30)
	elseif hp == 30 then
		spawn(60134, -2076, 2017, 1.4)
		self:hpTrigger(20)
	elseif hp == 20 then
		spawn(60134, -2399, 2153, 1.4)
		self:hpTrigger(10)
	elseif hp == 10 then
		spawn(60134, -2076, 2017, 1.4)
	end
end

function EVENT_COMBATEND(self)
	debugtext("GM MESSAGE - Cleanup initiated.")
	depop(60134)
	respawn(83353) -- self respawn
end

function EVENT_DEATH(self, other, damage, spell)
	self:text("The shade that remains of Magdolena falls emptily to the floor. The shadows disperse from the corpse and away into the morgue.")
	hl = self:GetHateList()
	for k,v in pairs(hl) do
		if hl[k]:IsClient() and hl[k]:InZone() then
			debugtext("- "..hl[k]:GetName().."")
			if hl[k]:GetFlag(42511) == 3 then
				hl[k]:text("You've defeated Magdolena! Speak to Defender Mokah to claim your prize!", 0, true)
				hl[k]:journal("The Morgue of Erudin", 3, "Magdolena has been defeated! I must report back to Mokah.")
				hl[k]:setFlag(42511, 4)
			end
		end
	end
end