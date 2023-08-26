-- a lone kaezakhan child (Boud`Ika)		prolly not gonna use this 
--[[ 
timertimedonttalktome = false

function EVENT_SPAWN(self)

	self:setAnim(1) -- begins spawn sitting down in corner
	spawn(60033, -3093, -1974, -45, 162)
	spawn(60033, -3102, -1939, -45, 33)

end

function EVENT_SAY(self, other, msg)

local mainflag = other:GetFlag(42504)
	
	if timertimedonttalktome == false then 
		if mainflag == 0 then -- first-ever hail sequence
	
			if string.find(msg, "Hail") then
				self:say("P-p-please... no m-m-more...")
				dialog(other, self, "Are you okay?")
	
			elseif string.find(msg, "Are you okay") then
				self:text("The child looks at you, slowly. It's very obvious that she's never heard your dialect before.", 8)
				self:say("...wait, who are you? You're not with those big meanies.", 100, other)
				dialog(other, self, "Who are the big meanies? Did they do this to them?")
		
			elseif string.find(msg, "Who are the big meanies") then
				self:text("You gesture to the corpses. The child looks at them, with horror overcoming her as the memory replays in her head.", 8)
				self:say("They... m-my momma... Daddy came back from working with the big, scary pirates earlier than before. They... oh please, I want my momma and daddy back!", 100, other)
				dialog(other, self, "I.. I'm so sorry, little one. I don't think they're gonna come back. Would you like to come with me for now?")
				dialog(other, self, "Shame, they couldn't hold their own. I expected more out of the Kaezulian people. Let's go before they take you next.")
		
			elseif string.find(msg, "Would you like to come with me for now") then
				other:addAlignment("good", 1)
				self:say("Oh... I'm so hungry. I can't move...")
				other:setFlag(42504, 1)
				other:journal("The Child", 1, "I found a lost child in The Overthere, with what I can only assume is her dead parents, laying on the ground behind her. I need to get her out of here, but she's starved and has no energy. I'll have to see what the locals here have to eat.")
				other:text("You gather that, in order to get this child away from here, she needs to eat something, but judging by the desolate, war-torn area, regular rations won't cut it. Perhaps something around here would be delectable to eat...", 8)
		
			elseif string.find(msg, "I expected more out of the Kaezakhan people") then
				other:addAlignment("evil", 1)
				self:say("Oh... I'm so hungry. I can't move...")
				other:setFlag(42504, 1)
				other:journal("The Child", 1, "I found a lost child in The Overthere, with what I can only assume is her dead parents, laying on the ground behind her. I need to get her out of here, but she's starved and has no energy. I'll have to see what the locals here have to eat.")
				other:text("You gather that, in order to get this child away from here, she needs to eat something, but judging by the desolate, war-torn area, regular rations won't cut it. Perhaps something around here would be delectable to eat...", 8)
		
			end
		
		elseif mainflag == 1 then -- this is between first chatting and feeding War Ration
		
			if string.find(msg, "Hail") then
				self:say("So... hungry... please...")
			
			end
			
		elseif mainflag == 2 then
		
			if string.find(msg, "Hail") then
				self:say("Thank you, stranger! Will you keep me safe from the big meanies?", 100, other)
				dialog(other, self, "Yes, but first I need you to answer some questions for me.")
				other:setFlag(42504, 3)
		
			elseif string.find(msg, "Feeling any better?") then
				self:text("She nods and says, 'Thank you, stranger! Will you keep me safe from the big meanies?")
				dialog(other, self, "Yes, but first I need you to answer some questions for me.")
				other:setFlag(42504, 3)
		
			end

		elseif mainflag == 3 then
	
			if string.find(msg, "Hail") or string.find(msg, "I need you to answer some questions") then
				dialog(other, self, "What exactly happened to your parents?")
				dialog(other, self, "Do you have a home?")
			
			elseif string.find(msg, "What exactly happened to") then
				self:text("Still whimpering, the child wipes her tears away.", 8)
				self:say("My daddy worked at the docks while my momma took care of me. I was the only hatchling of our family. Daddy wanted me to grow big and strong, just like him! He even showed me how to hold a dagger!", 100, other)
				self:text("The child pulls out a dagger out of seemingly nowhere. She then twirls it in her hand. Such dexterity for a hatchling is quite impressive to you.", 8)
				dialog(other, self, "Impressive, young one! I'll keep that in mind.")
			
			elseif string.find(msg, "keep that in mind") then
				self:text("A tiny smirk appears on her face.", 8)
				self:say("But... the big meanies came all of a sudden. They yelled at daddy a lot, and threw momma onto the wall. Daddy got mad and tried to hit one, but the big meanies were really strong! They... they...", 100, other)
				dialog(other, self, "Hey, it's okay now. You are safe with me. My name is... (whisper).")
			
			elseif string.find(msg, "My name is") then
				self:text("The child smiles and says, 'That's a funny name! "..other:GetName()..", "..other:GetName()..", "..other:GetName().."!")
				self:doAnim(52)
				dialog(other, self, "What exactly happened to your parents?")
				dialog(other, self, "Do you have a home?")
			
			elseif string.find(msg, "Do you have a home") then
				self:say("This... used to be home. But the big meanies will come back soon if we don't leave!", 100, other)
				dialog(other, self, "Fair enough, kid. Is this the only home you've ever had?")
			
			elseif string.find(msg, "Is this the only home") then
				self:say("Yup. Momma said that her and daddy used to live with the big dragon people in New Ikild. Dragon smolders? Wagon forgers? I don't remember.", 100, other)
				dialog(other, self, "New Ikild? So I'm sure you know about Kaezul?")
		
			elseif string.find(msg, "you know about Kaezul") then
				self:text("She scowls, 'Momma and daddy don't like that man. They say tha- said... that he was the biggest meanie of all. I don't like him just as much as momma and daddy did.")
				dialog(other, self, "Well that is quite fortunate. I don't like that big meanie either!")
		
			elseif string.find(msg, "Well that is quite fortunate") then
				self:say("Oh, yay! I will stay safe with you for sure, "..other:GetName().."! Let's leave before the big meanies come back.", 100, other)
				dialog(other, self, "Okay, but one more thing. What's your name, little one?")
			
			elseif string.find(msg, "but one more thing") then
				self:say("Oh! My name is Boud`Ika.")
				self:tempname("Boud`Ika")
				dialog(other, self, "A lovely name for a youngling like you. Let's get out of here.")
				other:setFlag(42504, 4)
				other:journal("The Child", 3, "Turns out this kid, Boud`Ika, knows a thing or two about this area. She will be extremely handy to have around someday.")
			
			end
	
		elseif mainflag == 4 then
		
			if string.find(msg, "A lovely name for a youngling like you") then
				self:say("Absolutely!")
				self:setAnim(38)
				self:timer("goodbye_1", 5000, true)
				timertimedonttalktome = true
			
			end
		
		end
	
	end

end

function EVENT_TIMER(self, timer)

	if timer == "goodbye_1" then
		self:walkTo(-3072, -1942.4, -45, 176)
		self:timer("goodbye_2", 2000, true)
		
	elseif timer == "goodbye_2" then	
		self:say("Oh, one last thing.")
		self:timer("goodbye_3", 5000, true)
	
	elseif timer == "goodbye_3" then
		self:walkTo(-3086.5, -1969.7, -45, 153.2)
		self:timer("goodbye_4", 5000, true)
		
	elseif timer == "goodbye_4" then
		self:doAnim(24)
		self:timer("goodbye_5", 1500, true)
		
	elseif timer == "goodbye_5" then
		self:walkTo(-3096.4, -1938.3, -45, 195.4)
		self:timer("goodbye_6", 5000, true)
		
	elseif timer == "goodbye_6" then
		self:doAnim(24)
		self:timer("goodbye_7", 5000, true)
		signal(60033, "flower")
		
	elseif timer == "goodbye_7" then
		self:walkTo(-3067.6, -1892.7, -45, 127.8)
		self:text("Boud`Ika sniffles as she leaves the room, parents left with flowers of what is left of the barren area.", 8)
		self:timer("goodbye_8", 8000, true)
		
	elseif timer == "goodbye_8" then
		self:say("Goodbye, Momma. Goodbye, Daddy. I'll miss you, both. I'm gonna grow big and strong. Stronger than those big meanies!")
		self:timer("goodbye_9", 8000, true)

	elseif timer == "goodbye_9" then
		self:walkTo(-3170, 1850, -43, 202.1)
		self:timer("goodbye_final", 10000, true)
		
	elseif timer == "goodbye_final" then -- includes clean up
		spawnloc = self:GetLoc()
		spawn(60034, spawnloc)
		depop(60033)
		respawn(81627)
		
	end

end

function EVENT_ITEM(self, other, item)

local mainflag = other:GetFlag(42504)

	if mainflag == 1 and timertimedonttalktome == false then
		
		if item(60035) > 0 then -- War Ration
			self:face(other)
			self:text("The child begins to tear into the ration. It's clear that this was exactly what she was looking for.")
			other:setFlag(42504, 2)
			item:keep(60035, 1)
			other:journal("The Child", 2, "I found some war rations to tide over the child's starvation. Time to get her the hell out of here.")
			dialog(other, self, "Feeling any better?")
		
		end
	
	end
	
end