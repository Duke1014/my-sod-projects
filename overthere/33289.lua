-- Oldlt the Smithy
-- 6-man AND quest mob, has a cooresponding * version, 60053
-- all below here is for quest

local ammo_slot = 21
local disguise = 41304

function EVENT_SAY(self, other, msg)
local tempflag = other:GetFlag(42506)
local mainflag = other:GetFlag(42503)

	if mainflag > 10 and checkDisguise(other) == true then
		-- debugtext("GM TEXT: "..other:GetName().." - successfully speaking to "..self:GetName()..".")
		if tempflag == 0 then
			if string.find(msg, "Hail") then
				self:text("Oldlt narrows his eyes at you.", 263, 100)
				self:say("YOU! FRONT AND CENTER.", 100, other)
				dialog(other, self, "Did I do something wrong?")
				dialog(other, self, "Right away, sir. [Stand at attention]")
				dialog(other, self, "Who, me?")
				dialog(other, self, "Sure thing, fellow Ikildian.")
				
			elseif string.find(msg, "Did I do something") or string.find(msg, "Who") or string.find(msg, "Sure thing") then -- YA MADE AN OOPS
				self:text("Oldlt clenches his hammer in frustration.", 263, 100)
				self:say("I don't know who you are, recruit. Nor do I know how in the hell you ended up this far, but here, you will do as your officers say, and your officer says to bring me 5 yclistnite chunks, as well as 10 fangs from the vipers outside, and 10 stingers from the scorpions. Get to it, soldier, or you're taking over more grunt work.", 100, other)
				other:setFlag(42506, 1)
			
			elseif string.find(msg, "Right away") then -- GOOD JOB
				self:say("Good. It's about time we had some respect around here. Now listen, recruit. I need materials in order to restock our new troops. You included. Bring me 5 chunks of yclistnite, as well as 10 fangs from vipers seen out here, and 10 stingers from the scorpions. Get to it!", 100, other)
				other:setFlag(42506, 2)
				
			end
			
		elseif tempflag == 1 or tempflag == 2 then
			if string.find(msg, "Hail") then
				self:say("You dolt, get those supplies! Five chunks of Yclistnite and ten viper fangs and scoprion stingers. Get to it!")
			end

		elseif tempflag < 2 then
			self:say("I don't need you anymore, recruit. Go help someone else!")
		end
	end
end

function EVENT_ITEM(self, other, item)
local tempflag = other:GetFlag(42506)

	if tempflag > 0 then
		if item(41111) > 4 and item(60049) > 9 and item(60050) > 9 then		-- raw yclistnite chunks, viper fangs, scorpion stingers
			item:keep(41111, 5)
			item:keep(60049, 10)
			item:keep(60050, 10)
			if tempflag == 1 then
				self:say("Splendid. Perhaps you aren't as useless as you led on to be. Now, begone.")
			elseif tempflag == 2 then
				self:say("Splendid. You gathered those materials faster than most other recruits. Here, something to protect you while you're out on patrol.")
				other:giveItem(60051)
			end
			other:setFlag(42506, 100)
		end
	end	
end

function checkDisguise(player)
	local ammo = player:GetInventory(ammo_slot)
	if ammo and ammo:GetID(disguise) then
		return true
	end
end



