-- Alea-Kaz, Captain of the Guard
-- 6-man AND quest mob, has a cooresponding * version, 60054

local ammo_slot = 21
local disguise = 41304

function EVENT_SAY(self, other, msg)
local mainflag = other:GetFlag(42503) -- [The Hierophant's Apprentice]
local tempflag1 = other:GetFlag(42505) -- Oldlt's questflag
local tempflag2 = other:GetFlag(42506) -- Azkae's questflag
-- first two temp flags are used once to set tempflag3 to 1, then not needed afterwards
local tempflag3 = other:GetFlag(42507) -- Alea-Kaz's questflag

	if mainflag > 10 and checkDisguise(other) then
	
		if string.find(msg, "Hail") and tempflag3 == 0 then
			self:say("DON'T YOU 'HAIL' ME, RECRUIT! Have you been given orders by Oldlt and Azkae yet?", 100, other)
			dialog(other, self, "Sir, no, sir!")
			
			if tempflag1 > 99 and tempflag2 > 99 then
				dialog(other, self, "Sir, yes, sir!")
			end
			
		elseif string.find(msg, "no") and tempflag3 == 0 then
			self:say("Then get to it. Out of my sight, or I'll toss you out myself.", 100, other)
			
		elseif string.find(msg, "yes") and tempflag1 > 99 and tempflag2 > 99  and tempflag3 == 0 then
			self:say("Good. I have one more task for you. Since you completed your tasks quickly, I need you to go check on our precious cargo in the Scar.", 100, other)
			dialog(other, self, "What kind of cargo?")
			other:setFlag(42507, 1)
			
		elseif tempflag3 == 1 then
			if string.find(msg, "Hail") then
				self:say("I have one more task for you. Since you completed your tasks quickly, I need you to go check on our precious cargo in the Scar.", 100, other)
				dialog(other, self, "WWhat kind of cargo?")
				
			elseif string.find(msg, "What kind of cargo") then
				self:say("The Oracle is being held there, until it is time for her to be shipped off to Kaezul. It seems He no longer has a use for her, and will most likely be killed, if not tortured to near-death like the other monsters have. All you need to do is inspect her holding cell.", 100, other)
				dialog(other, self, "Where would I find The Oracle?")
			
			elseif string.find (msg, "Where would I find The Oracle") then
				self:say("Go to the center of The Scar, you'll see a few tunnels down there, go to the smallest one, and you should see a magic barrier out front. You will need this to get through.' Alea-kaz presses a tiny orb onto your tabard.")
				other:journal("The Hierophant's Apprentice", 4, "My Ikildian persona has been tasked with inspecting the holding area of The Oracle. The captain of the guard said to find her in the smallest tunnel where a barrier will be seen. I should go and confirm if she's there before talking to Rorlna.")
				other:setFlag(42507, 2)
				other:setFlag(42503, 12)				
				dialog(other, self, "I will return shortly.")
				
			elseif string.find(msg, "I will return shortly") then
				self:say("I hope you will. Or it's all of our blood on His hands. Long may Kaezul reign.")				
			end
		end
	end
end

function checkDisguise(player)
	local ammo = player:GetInventory(ammo_slot)
	if ammo and ammo:GetID(disguise) then
		return true
	end
end