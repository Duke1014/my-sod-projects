-- Corporal Mangus (60138)
-- Silver Crown Corporal
-- Quest - Icing the Everchill Orcs ( Flag: 42516, 42517 - kill flag )

function EVENT_SAY(self, other, msg)	
	
	factionFlag = other:GetFlag(4960)
	--[[ Factions
		0 - None
		1 - Council of Innovation
		2 - Blackscale
		3 - Silver Crown
	]]
	
	rankFlag = other:GetFlag(4975) 
	--[[ Ranks
		0 - None
		1 - Hireling
		2 - Soldier
		3 - Corporal
		4 - Sergeant
		5 - Trader 
		6 - High Trader
	]]
	
	questFlag = other:GetFlag(42516)
	--[[ Flags
		0 - Never talked to me before
		1 - Quest accepted
		2 - Found evidence in EC
		3 - Going back inside
		9+ - completed quest
	]]

	if factionFlag == 0 then
		self:say("Sorry, "..other:GetRaceName()..", I be in no condition to help ya. If yer lookin' for work, go seek our camp in the Heartland Forest.", 100, other)
		
	elseif factionFlag == 2 or factionFlag == 1 then
		self:text("Mangus looks at you curiously. 'Are ya lost, "..other:GetRaceName().."? This be the Silver Crown's territory. Afraid it's time ye got lost.'")
		self:face(other)
		
	elseif factionFlag == 3 then
		if rankFlag < 2 then
			self:say("Ye'll have to forgive me, newbie, there is nothing for you to help me with here. If yer lookin' for work, go seek our camp in the Heartland Forest.", 100, other)
		elseif rankFlag > 1 and questFlag == 0 then
			if string.find(msg, "Hail") then
				self:say("Bah, leave me be to my sorrow, "..other:GetRaceName()..". I be nothing but a sad excuse of a Corporal.", 100, other)
				dialog(other, self, "What's the matter?")
				
			elseif string.find(msg, "the matter") then
				self:text("Mangus looks down and away from eye contact. 'I've dishonored the Silver Crown. I'm a disgrace to my name, to Kaladim, to Underhill, the world.'")
				self:face(other)
				dialog(other, self, "Wow, slow down and explain yourself.")
			
			elseif string.find(msg, "slow down and explain yourself") then
				self:text("Mangus whimpers. 'I- We... were tasked with collecting supplies in the Everchill Caverns to the east of here. We knew of the orcs taking shelter there, but...' Magnus begins shaking as if he's seen a ghost.")
				self:face(other)
				dialog(other, self, "We? Do you mean there are others that might be in the caves still?")
				
			elseif string.find(msg, "you mean there are other") then
				self:say("Aye, friend. I was their leader. They were all new hirelings, too. They all looked up to me, a dwarf! I just managed to escape from those monsters. I'm not sure about the rest. They could very well be in there, still.", 100, other)
				dialog(other, self, "I think it's best that we go back in there. I'll bring my own crew along to help.")
				
			elseif string.find(msg, "best that we go back in") then
				self:say("Please, fer the love of the Divine Light, be VERY careful in there. I was overzealous to bring a crew of hirelings in there, don't make the same mistake I did. If you can find any proof of the others inside, please come back and inform me.", 100, other)
				other:setFlag(42516, 1)
				other:journal("Silver Crown - Icing the Everchill Orcs", 1, "I met a very stressed Dwarf by the name of Mangus. He tried to bring a group of hirelings into the Everchill Caverns for a supply run, but ran into a terrible fate. I've offered my assistance to find the missing recruits, or what's left of them.")
			end		
		
		elseif rankFlag > 1 and questFlag == 1 then
			self:say("Any luck in Everchill Caverns, mate?", 100, other)
			
		elseif rankFlag > 1 and questFlag == 2 then
			if string.find(msg, "Hail") then
				self:say("You... found him! You found Sammy! I just sent him back to Halas.", 100, other)
				other:setFlag(4176, other:GetFlag(4176) + 50)
				other:text("You gained faction experience!", 15, true)
				dialog(other, self, "Mangus, if we were able to find one, I'm sure the rest of your crew is in there somewhere! I'm going back in to find them.")
			
			elseif string.find(msg, "if we were able to find one") then
				self:say("Yer absolutely right, friend. I believe in you! Bring them back safely and I'll escort them back home!", 100, other)
				other:setFlag(42516, 3)
				other:journal("Silver Crown - Icing the Everchill Orcs", 3, "Mangus is in a much more cheerful mood. Rightfully so! Time to go back into Everchill Caverns and find the rest of his crew.")
			end
		elseif rankFlag > 1 and questFlag == 9 then
			if string.find(msg, "Hail") then
				self:say("Friend! I can't believe it! They're all back! I thought I lost those hirelings for forever.", 100, other)
				dialog(other, self, "Think nothing of it, Mangus. I think you deserve a drink and a good night's rest!")
				
			elseif string.find(msg, "Think nothing of it") then
				self:say("But I-")
				self:text("You hear chattering outside of the igloo. 'Mangus! Come back to Halas with us! We wanna celebrate you and your bravery for rescuing us!'")
				dialog(other, self, "Sounds like the hirelings think you deserve a drink, too! Go on, Mangus, you earned it. They really do look up to you.")
				
			elseif string.find(msg, "Sounds like the hirelings think you deserve") then
				self:say("Thank you. I'll never forget this, "..other:GetName()..".")
				self:text("I'M COMIN', CREW!")
				other:setFlag(42516, 100)
				other:journal("Silver Crown - Icing the Everchill Orcs", 100, "Corporal Mangus has his hirelings back, his pride, and his senses back. I did a great deed today!")
				other:setFlag(4176, other:GetFlag(4176) + 100)
				other:text("You gained faction experience!", 15, true)
				self:runTo(-1076, 1243, -60)
				self:timer("depop", 7000, true)
			end
		end
	end
end

function EVENT_TIMER(self, timer)
	if timer == "depop" then
		self:depop()
	end
end