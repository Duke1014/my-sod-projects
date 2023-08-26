-- Duke's helper friend, Sundered Caverns

--[[function EVENT_SPAWN(self)
	self:setAppearance(27)
end]]

function EVENT_SAY(self, other, msg)
	if GetAccountStatus(other) > 50 then
		if string.find(msg, "weed") then -- gets rid of untargettable flowers from 60013
			depop(60020)
			debugtext("Mob '60020' has been de-weeded (depopped).")
		elseif string.find(msg, "restart Nalansar") then
			respawn(81271) -- respawns the nalansar event start (60010)
			debugtext("Nalansar has been respawned. Check his spawn point in front of the lone rock.")
		elseif string.find(msg, "depop tablet") then
			depop(60009)
		elseif string.find(msg, "Hail") then
			level = other:GetLevel()
			debugtext(""..level..".")
		end
	end
end