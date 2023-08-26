-- Provision Master Azkae
-- 6-man AND quest mob, has a cooresponding * version, 60052

local ammo_slot = 21
local disguise = 41304

function EVENT_SAY(self, other, msg)
local tempflag = other:GetFlag(42505)
local mainflag = other:GetFlag(42503)

	if mainflag > 10 and checkDisguise(other) == true then
		if tempflag == 0 then
			if string.find(msg, "Hail") then
				self:say("Hmph. Are you supposed to be one of the new recruit?", 100, other)
				dialog(other, self, "That would be me.")
				dialog(other, self, "Yes, ma'am!")
				dialog(other, self, "Of course. I live to serve the Armada.")
				dialog(other, self, "Sure, that's me!")
			
			elseif string.find(msg, "That would be me") or string.find(msg, "Yes") or string.find(msg, "Sure") then -- they do not like your language
				self:text(self:GetName().." squints her eyes at you.", 263, 100)
				self:say("Right... You'll be working double time for that. We need our food supply doubled for other upcoming recruits. Twenty portions of meat from the elephants, scorpions, and vipers in the wastelands. Get to it, and now. Out of my sight.", 100, other)
				other:setFlag(42505, 1)
			
			elseif string.find(msg, "Of course") then -- good job
				self:say("Good, we need more obedient soldiers here. We need our food supply doubled for other upcoming recruits. Twenty portions of meat from elephants, scorpions, and vipers will do for your portion of work. Off with you, before anyone else gets any ideas of easier work.", 100, other)
				other:setFlag(42505, 2)
			end

		elseif tempflag == 1 or tempflag == 2 then
			if string.find(msg, "Hail") then
				self:say("Come now, we need those meats! Twenty chunks of elephant, viper, and scorpion meat. They better be fresh slabs!")
			end

		elseif tempflag < 2 then
			self:say("I don't need you anymore, recruit. Go help someone else!")
		end
	end
end

function EVENT_ITEM(self, other, item)
local tempflag = other:GetFlag(42505)
	if item(60041) > 19 and item(60047) > 19 and item(60048) > 19 then -- elephant meat, scorpion meat, viper meat
		item:keep(60041, 20)
		item:keep(60047, 20)
		item:keep(60048, 20)
		other:setFlag(42505, 100)
		if tempflag == 1 then
			self:say("Good. We need more efficiency like this around here. Go see if Oldlt still needs help. Otherwise, report back to the captain.")
		elseif tempflag == 2 then
			self:say("Good. We need more efficiency like this around here. Go see if Oldlt still needs help. Otherwise, report back to the captain. Here is your split of rations, but don't go around telling everyone you got your rations early. Dismissed!")
			other:giveItem(41313, 10)	
		end
	end
end

function checkDisguise(player)
	local ammo = player:GetInventory(ammo_slot)
	if ammo and ammo:GetID(disguise) then
		return true
	end
end


-- all below here is for the 6-man fight: