-- roaring fire

function EVENT_SPAWN(self)
	heat = 2000
end

function EVENT_SIGNAL(self, signal)
	if signal == "start" then
		event = true
		self:timer("stoke", 5000)
	end
	if signal == "absorbed" then
		self:text("The Blood of Mielech is absorbed into the pot, increasing the heat of the fire!", 13)
		heat = heat + 2000
	end
end

function EVENT_TIMER(self, timer)
	if timer == "stoke" then
		heat = heat + 500
		if heat > 2500 then
			local damage = (heat - 2000) / 5
			signal(32239, "fire_blast", damage)
		end
	end
end

function EVENT_SPELL(self, other, spellname, spellid, resist_type, mana_used, damage, spell_object)
	local fire = 2
	local cold = 3

	if event == true then
		if resist_type == cold then
			heat = heat - damage
			self:text("The roaring fire shrinks from "..other:GetName().."'s "..spellname.."!", 4)
			if heat < 0 then
				heat = 0
				self:text("The heat from the roaring fire dissipates! Krazkah croaks loudly from the sudden chill.")
				signal(32239, "fire_out")
			end
		elseif resist_type == fire then
			heat = heat + damage
			self:text("The roaring fire GROWS from "..other:GetName().."'s "..spellname.."!", 13)
		end
	end

	debugtext(heat)
end

function EVENT_DEATH(self)
	debugtext("GM: SOMETHING WENT WRONG, RESETTING EVENT")
	respawn(76135)
end