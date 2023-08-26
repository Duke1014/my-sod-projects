-- a Silver Crown hireling
-- Everchill Caverns - Silver Crown Quest

function EVENT_SPAWN(self)
	zonetext("Is it safe to come out?")
	self:timer("depop", 180000, true)
end

function EVENT_SAY(self, other, msg)
	if other:GetFlag(42516) == 1 then
		if string.find(msg, "Hail") then
			self:say("Oh, thank goodness, a strong adventurer. I thought I was a goner!", 100, other)
			dialog(other, self, "The way is clear, time to get back home, soldier.")
			
		elseif string.find(msg, "The way is clear") then
			self:say("No need to tell me twice, I'm outta here! Thanks for your help, I can get myself out from here.")
			other:setFlag(42516, 2)
			other:setFlag(42517, 0)
			other:journal("Silver Crown - Icing the Everchill Orcs", 2, "I was able to find one of the hirelings! Time to head back and report to Mangus")	
		end

	elseif other:GetFlag(42516) > 2 and other:GetFlag(42516) < 9 then
		if string.find(msg, "Hail") then
			self:say("Oh, thank goodness, a strong adventurer. I thought I was a goner!", 100, other)
			dialog(other, self, "The way is clear, time to get back home, soldier.")
			
		elseif string.find(msg, "The way is clear") then
			self:say("No need to tell me twice, I'm outta here! Thanks for your help, I can get myself out from here.")
			other:setFlag(42517, 0)
			other:setFlag(42516, other:GetFlag(42516) + 1)
			other:text("You rescued a hireling!", 11, true)
			if other:GetFlag(42516) == 8 then
				other:text("You found all the hirelings! Time to report back to Corporal Mangus.", 11, true)
				other:setFlag(42516, 9)
				other:journal("Silver Crown - Icing the Everchill Orcs", 4, "I found all the hirelings from Mangus' crew! Time to head back and check on Mangus himself.")
			end
			self:depop()
			self:stopAllTimers()
		end
	end
end

function EVENT_TIMER(self, timer)
	if timer == "depop" then
		self:depop()
		self:stopAllTimers()
	end
end