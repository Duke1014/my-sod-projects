-- Defender Mokah
-- Serves as the ZONE OUT and QUESTSTUFF

function EVENT_SPAWN(self)
	self:setWeapon(3028, 7) -- sword
	self:setWeapon(3027, 8) -- board
end

function EVENT_SAY(self, other, msg)
	
	---------------
	--  ZONE OUT --
	---------------
	
	if string.find(msg, "Get me out") then
		self:say("Allow me to lead the way...", 100, other)
		other:zone("erudnext", 80, 160, 20, 0)
		debugtext("Zoning "..other:GetName().." out to Erudin.")
	end
	
	------------------
	-- 	QUESTSTUFF  --
	------------------
	
	if other:GetFlag(42511) == 0 then
		-- First Contact
		if string.find(msg, "Hail") then
			self:say("Oh thank Lady Althuna! I thought reinforcements would never come.", 100, other)
			dialog(other, self, "Reinforcements? What is happening here?")
			dialog(other, self, "I was just passing through here, lady. I don't know what you're talking about.")
			dialog(other, self, "[ZONE OUT] Get me out of here!")
	
		elseif string.find(msg, "What is happening") then
			if other:GetRace() == 3 then
				self:say("Somehow, someone has broken into our treasured morgue. As an Erudite yourself, you may be familar with our morgue, as it is the place where we house our loved ones that have passed. But now, some wicked group has invaded the place, raising our loved ones from the dead for their own deeds!", 100, other)
			else
				self:say("Since you aren't of our people, we wouldn't usually disclose this personal matter, but I need as much help as possible. This is where our loved ones reside, except a group of extremists have come and made a mess of the place! The dead are now restless, and our enemies are vicious.", 100, other)
			end
		dialog(other, self, "What would you have me do to help?")
		dialog(other, self, "[Good] What these people have done here to you and your loved ones, it is unmistakably evil, and cannot go unpunished.")
		dialog(other, self, "[Evil] Unfortunately I have better things to do other than listen to you complain, unless there's more incentive to help...")
		
		elseif string.find(msg, "What would you have me do") then
			self:say("I never thought you'd ask. Thank you, stranger. The most important thing is to take out these maniacs and stop them from desecrating this sacred place. If you can bring back some sort of proof that you disposed of them, I will gladly reward you. Any of the risen that you show proof of putting back to rest will also be of use. Return to me when this task is done, I must stay at my post here to guide any other adventurers on this journey.", 100, other)
			other:journal("The Morgue of Erudin", 1, "I've made my way to Defender Mokah, who has informed me of a raid within their morgue. To help, I am to bring back proof of disposing the vagabonds within the catacombs, while putting the dead back to rest.")
			other:setFlag(42511, 1)
			
		elseif string.find(msg, "What these people have done here to you and your loved") then
			self:say("I'm glad you could be here for this cause. All of Erudin thanks you, brave adventurer. The most important thing is to take out these maniacs and stop them from desecrating this sacred place. If you can bring back some sort of proof that you disposed of them, I will gladly reward you. Any of the risen that you show proof of putting back to rest will also be of use. Return to me when this task is done, I must stay at my post here to guide any other adventurers on this journey.", 100, other)
			other:journal("The Morgue of Erudin", 1, "I've made my way to Defender Mokah, who has informed me of a raid within their morgue. To help, I am to bring back proof of disposing the vagabonds within the catacombs, while putting the dead back to rest.")
			other:addAlignment("Good", 2)
			other:giveExp(500, 51)
			other:setFlag(42511, 1)
			
		elseif string.find(msg, "Unfortunately I have better things to do other than listen") then
			self:say("I- But... Alright. Fine. Here is payment in advance. Just, please help our city. The most important thing is to take out these maniacs and stop them from desecrating this sacred place. If you can bring back some sort of proof that you disposed of them, I will gladly reward you. Any of the risen that you show proof of putting back to rest will also be of use. Return to me when this task is done, I must stay at my post here to guide any other adventurers on this journey.", 100, other)
			other:journal("The Morgue of Erudin", 1, "I've made my way to Defender Mokah, who has informed me of a raid within their morgue. To help, I am to bring back proof of disposing the vagabonds within the catacombs, while putting the dead back to rest.")
			other:addAlignment("Evil", 2)
			other:setFlag(42511, 1)
			other:giveCash(0, 0, 0, 25)
		end
		
	elseif other:GetFlag(42511) == 1 then
		if string.find(msg, "Hail") then
			if other:GetFlag(42512) > 19 and other:GetFlag(42513) > 19 then
				self:say("My dear friend! I cannot thank you enough for your assistance here. Now, if you feel up for the task, and you can find more adventurers, I have a large task for you.", 100, other)
				dialog(other, self, "What is this task?")
				dialog(other, self, "[ZONE OUT] Get me out of here!")
				other:setFlag(42511, 2)
			else
				self:say("Greetings! Have you had any luck with the vagabonds inside the morgue?", 100, other)
				other:text("You have given me "..other:GetFlag(42512).." insignias, and "..other:GetFlag(42513).." essences so far.", 6, true)
				dialog(other, self, "[ZONE OUT] Get me out of here!")
			end
		end
	elseif other:GetFlag(42511) == 2 then
		if string.find(msg, "Hail") then
			self:say("If you feel up for the task, and you can find more adventurers, I have a large task for you.", 100, other)
			dialog(other, self, "What is this task?")
			dialog(other, self, "[ZONE OUT] Get me out of here!")
		elseif string.find(msg, "What is this task") then
			if other:GetLevel() > 51 then
				self:say("Ah, I see this task may be of little reward for you. I need assistance with the leader of the Inevitable Shade, but I'm certain there are other adventures for you. Thank you for your help thus far, friend.", 100, other)
				other:journal("The Morgue of Erudin", 100, "I've given assistance to Defender Mokah, but she is going to enlist the help of other adventurers for the rest of her quest.")
				other:setFlag(42511, 100)
			else
				self:say("The leader of the Inevitable Shade is here. She goes by Magdolena. If you and your friends can take her down, the Defenders of Erudin will handsomely reward you, and not just with money. Something with more... potential. Seek her out, strike her down, but be warned. She is stronger than she looks.", 100, other)
				other:journal("The Morgue of Erudin", 2, "I've been tasked to seek out Magdolena, leader of the Inevitable Shade, and take her down with a team of friends. From what it seems, the back-up will be necessary.")
				other:setFlag(42511, 3)
			end
		end
	elseif other:GetFlag(42511) == 3 then
		if string.find(msg, "Hail") then
			self:say("How goes the expedition, friend? Have you disposed of Magdolena?", 100, other)
			if other:GetLevel() > 50 then
				dialog(other, self, "I mean no offense, Mokah, but I believe this mission is meant for a different adventurer.")
			end
			dialog(other, self, "[ZONE OUT] Get me out of here!")
		elseif string.find(msg, "I believe this mission is meant for a different") then
			self:say("Say no more, friend. You have done so much for Erudin and it's people. I cannot thank you enough for your help, and safe travels to you!", 100, other)
			other:journal("The Morgue of Erudin", 100, "I've given assistance to Defender Mokah, but she is going to enlist the help of other adventurers for the rest of her quest.")
			other:setFlag(42511, 100)
		end
	elseif other:GetFlag(42511) == 4 then
		if string.find(msg, "Hail") then
			self:say("Brave adventurer! I could feel the morgue itself shudder. Have you defeated Magdolena?", 100, other)
			dialog(other, self, "We have. I did not expect her to have so much power. She infused herself with shadow when we fought.")
			dialog(other, self, "[ZONE OUT] Get me out of here!")
		elseif string.find(msg, "I did not expect her to have so much") then
			self:say("The Impending Shade is a group that sought to overthrow the Burning Eye and it's leaders for shunning the dark arts. Magdolena has possibly surpassed their power, and was about to take them all out from here. I fear that this is not the last that we see of her, friend. Thank you for disposing of her for now. All of Erudin thanks you. As such, I would like to bestow upon you a weapon used by the most elite of the Erudin Defenders. Would you accept this gift?", 100, other)
			dialog(other, self, "I would accept this gift!")
		elseif string.find(msg, "I would accept this") then
			self:say("Once again, thank you for your services here, friend!", 100, other)
			debugtext("~~ "..other:GetClass().."")
			if other:GetClass() == 1 or other:GetClass() == 3 or other:GetClass() == 4 or other:GetClass() == 5 then
				other:giveItem(60077)
			elseif other:GetClass() == 2 or other:GetClass() == 6 or other:GetClass() == 7 or other:GetClass() == 10 or other:GetClass() == 11 or other:GetClass() == 12 or other:GetClass() == 13 or other:GetClass() == 14 or other:GetClass() == 15 then
				other:giveItem(60078)
				debugtext("PING")
			elseif other:GetClass() == 8 or other:GetClass() == 9 then
				other:giveItem(60079)
			end
			other:setFlag(42511, 100)
			other:journal("The Morgue of Erudin", 100, "I have defeated Magdolena, and Defender Mokah has kindly gifted me a weapon for my efforts.")
		end
	elseif other:GetFlag(42511) > 4 then
		if string.find(msg, "Hail") then
			self:say("And hail to you, dear friend!", 100, other)
			dialog(other, self, "[ZONE OUT] Get me out of here!")
		end
	end
end

function EVENT_ITEM(self, other, item, coin)

	if other:GetFlag(42511) > 0 then
		if item(60075) > 0 then
			for i = 1, item(60075) do		
				currentInsignias = other:GetFlag(42512)
				if currentInsignias < 20 then
					item:keep(60075, 1)
					other:giveCash(0, 0, 0, 5)
					other:setFlag(42512, currentInsignias + 1)
					self:say("This is it! I had a feeling that this group was responsible for this violence. They call themselves the Inevitable Shade, a group of erudites that practice the dark arts, as I'm sure you saw. Be very careful within these halls, friend. I have a bad feeling about what's happening deeper within...", 100, other)
					if currentInsignias == 20 then
						self:say("Incredible! I think this is plenty enough evidence, but feel free to give me any more insignias that you find. I'll happily give you your fair payment, but after this I can only pay you half the usual rate.", 100, other)
					end
				elseif currentInsignias > 20 then
					item:keep(60075, 1)
					other:giveCash(0, 0, 5, 2)
					other:setFlag(42512, currentInsignias + 1)
				end
				
			end
			
		elseif item(60076) > 0 then
			for i = 1, item(60076) do
				currentEssences = other:GetFlag(42513)
				if currentEssences < 20 then
					item:keep(60076, essences)
					other:giveExp(5000, 51)
					other:setFlag(42513, currentEssences + 1)
					self:say("I can sense something within this essence... I can feel my ancestors within this place ease ever-so-slightly. Thank you, friend. Please, release others from their pain!", 100, other)
					if currentEssences == 20 then
						self:say("Splendid! The dead will rest easier here, now. If you come across any more essences, feel free to give them to me, but I can only give you half the usual reward.", 100, other)
					end
				elseif currentEssences > 20 then
					item:keep(60076, 1)
					other:giveExp(2500, 51)
					other:setFlag(42513, currentEssences + 1)
				end
			end
		end
	end
end