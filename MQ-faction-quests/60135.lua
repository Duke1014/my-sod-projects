-- Raider Essix (60135)
-- Blackscale Raider
-- Quest - Froglok Initiation (flag id(s): 42514, 42515 - Kill Count)

function EVENT_SAY(self, other, msg)

	factionFlag = other:GetFlag(4960)
	--[[ Factions
		0 - None
		1 - Silver Crown
		2 - Blackscale
		3 - Council of Innovation
	]]
	
	rankFlag = other:GetFlag(4975) 
	--[[ Ranks
		0 - None
		1 - Mercenary
		2 - Warrior
		3 - Raider
		4 - Corsair
		5 - Warleader 
		6 - Warlord (NOT YET IMPLEMENTED, 12/9/2021)
	]]
	
	questFlag = other:GetFlag(42514)
	
	if factionFlag == 0 then
		self:say("I have no use for you, "..other:GetRaceName()..". Go seek out the Heartlands if you wish to be of use to us.", 100, other)
	
	elseif factionFlag == 1 --[[Silver Crown]] or factionFlag == 3 --[[Council of Innovation]] then
		self:text("Essix hisses at you. 'We have no need for you and your faction. Begone before I feel less merciful.'")
		self:face(other)
	
	elseif factionFlag == 2 then	--[[Blackscale]]
		if rankFlag == 1 then
			self:say("Seek out our camp in the Heartlands, Mercenary. I have no use for you at the moment.", 100, other)
		
		elseif rankFlag >= 2 and questFlag == 0 then
			if string.find(msg, "Hail") then
				self:say("Save your hailing for someone who cares. I received a report on your efforts in the Heartlands, are you the one that Xilkaz promoted from there?", 100, other)
				dialog(other, self, "Yes.")
				
			elseif string.find(msg, "Yes") then 
				self:text("Essix lets out a hiss. 'Excellent. It's relieving to see recruits make it this far. Our initiates from Grobb have not been able to make it as far as you have lately.'")
				self:face(other)
				dialog(other, self, "What happened to the recruits from Grobb?")
				
			elseif string.find(msg, "What happened to the recruits") then
				self:say("I'm so glad you asked, because you've just volunteered to go find out. Our spies report that a group of excessively strong frogloks have been skulking around the bog outside of Grobb, taking our recruits, then bringing them back into Mielech's halls. I want you to venture deep into the lair of Mielech to find out where the initiates are going and why.", 100, other)
				dialog(other, self, "All the way into the Lair of Mielech?! You must be twisted to send whoever you'd like there!")
				
			elseif string.find(msg, "All the way into the Lair") then
				self:text("Essix nods. 'A noble test of your skills and loyalty. Start by killing as many of the frogs as you can in the deepest lair. See you soon!'")
				self:face(other)
				other:setFlag(42514, 1)
				other:journal("Blackscale - Froglok Initiation", 1, "Raider Essix, from the Greenmist Jungle station, has tasked me with inspecting the Lair of Mielech. Supposedly, initiates from Grobb have been taken in there and have not returned. I'll have to explore the lair for a while to find evidence of this.")
			
			end
			
		elseif rankFlag >= 2 and questFlag == 1 then
			self:say("Are you finished with your expedition in the Lair of Mielech? We need to know what's happening to our initiates.", 100, other)
				
		elseif rankFlag >= 2 and questFlag == 2 then
			if string.find(msg, "Hail") then
				self:say("Are you finished with your expedition in the Lair of Mielech? We need to know what's happening to our initiates.", 100, other)
				dialog(other, self, "Essix, I was attacked by our own. It was as if they were possessed!")
				
			elseif string.find(msg, "I was attacked by") then
				self:say("This is worse than I thought, we need to get them out of there, go back and find any more of the initiates. If it means disposing of them, so be it.", 100, other)
				dialog(other, self, "I understand.")
				other:setFlag(4176, other:GetFlag(4176) + 50)
				other:text("You gained faction experience!", 15, true)
				
			elseif string.find(msg, "I understand") then
				self:say("Good. There's no telling what could happen to the initiates. Or worse, Grobb, itself.", 100, other)
				other:setFlag(42514, 3)
				other:setFlag(42515, 0) -- resetting kill flag
				other:journal("Blackscale - Froglok Initiation", 3, "I've been asked to go back into the Lair of Mielech and find any more initiates, and to kill them if they are hostile.")
			
			end	
			
		elseif rankFlag >= 2 and questFlag > 3  and questFlag < 100 then
			if string.find(msg, "Hail") then
				self:say("What's your status report on the initiates?", 100, other)
				dialog(other, self, "There is no mistake that the initiates were possessed by the frogloks. However, I have slain many of them, including the possessed.")
			
			elseif string.find(msg, "There is no mistake") then
				self:say("Hmph. Those recruits were weak-minded if they expected to be part of the glorious rise of the Blackscale. This was a win-win situation. Thank you... what was your name again?", 100, other)
				dialog(other, self, ""..other:GetName()..", sir.")
				
			elseif string.find(msg, "sir") then
				self:say("I think you will do just fine with the Blackscale, "..other:GetName()..". Sorry for ever doubting you. I'll put in a good word to our superiors.")
				other:setFlag(42514, 100)
				other:journal("Blackscale - Froglok Initiation", 100, "I assisted Raider Essix with the slaughter of frogloks taking our initiates from Grobb.")
				other:setFlag(4176, other:GetFlag(4176) + 100)
				other:text("You gain faction experience!", 15, true)
				
			end
		end
	end
	
end