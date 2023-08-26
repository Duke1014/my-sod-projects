-- a tinkered drone
-- Highkeep - Council of Innovation

function EVENT_SPAWN(self)
	zonetext("You hear the whirring and clicking of a drone nearby!")
	self:timer("depop", 180000, true)
end

function EVENT_SAY(self, other, msg)
	if other:GetFlag(42518) == 1 then
		if string.find(msg, "Hail") then
			self:text("There is a button on the back of the drone that conveniently says 'Go Home'. Would you like to press the button?")
			dialog(other, self, "[Press The Button]")
			
		elseif string.find(msg, "Press The Button") then
			self:say("GO HOME FUNCTION INITIATED.")
			other:setFlag(42518, 2)
			other:setFlag(42519, 0)
			other:journal("COI - Drone-hunting in Highkeep", 2, "I found the drone in Highkeep! Time to head back and report to Binkerer.")
		end

	elseif other:GetFlag(42518) > 2 and other:GetFlag(42518) < 9 then
		if string.find(msg, "Hail") then
			self:text("There is a button on the back of the drone that conveniently says 'Go Home'. Would you like to press the button?")
			dialog(other, self, "[Press The Button]")
			
		elseif string.find(msg, "Press The Button") then
			self:say("GO HOME FUNCTION INITIATED.")
			other:setFlag(42519, 0)
			other:setFlag(42518, other:GetFlag(42518) + 1)
			other:text("You rescued a tinkered drone!", 11, true)
			if other:GetFlag(42518) == 8 then
				other:text("You found all the drones! Time to report back to Tinkerer Binkerer.", 11, true)
				other:setFlag(42518, 9)
				other:journal("COI - Drone-hunting in Highkeep", 4, "I found all of Binkerer's drones! Time to head back to her.")
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