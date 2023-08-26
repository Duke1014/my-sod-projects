-- Tinkerer Binkerer (60138)
-- Council of Innovation
-- Quest - COI - Drone-hunting in Highkeep ( Flag: 42516, 42517 - kill flag )

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
		1 - Associate
		2 - Assistant
		3 - Senior Assistant
		4 - Junior Researcher
		5 - Researcher
		6 - Councillor
	]]
	
	questFlag = other:GetFlag(42518)
	--[[ Flags
		0 - Never talked to me before
		1 - Quest accepted
		2 - Found thing in HHK
		3 - Going back inside
		9+ - completed quest
	]]
	
	if factionFlag == 0 then
		self:say("Hmm? I'm terribly sorry, I don't believe I know. If you'd like to get to know me better, seek out my colleagues of the Council of Innovation in the Heartland Forest.", 100, other)
	elseif factionFlag == 3 or factionFlag == 2 then
		self:say("Oh. Terribly sorry, I thought you were a member of the Council. I'm afraid we have no business to discuss. Good day.", 100, other)
	elseif factionFlag == 1 then
		if rankFlag < 2 then
			if string.find(msg, "Hail") then
				self:text("Binkerer looks closely at your assistant badge. 'Ah. Terribly sorry, friend. I do require assistance, but I believe you may be of more use in the Heartland Forest, at the momemt. Apologies, friend, but do come back when you are finished there.")
				self:face(other)
			end
		
		elseif rankFlag > 1 and questFlag == 0 then
			if string.find(msg, "Hail") then
				self:text("Binkerer looks closely at your badge. 'Mmm. Yes. You may be the perfect specimen for what I'm looking for.")
				self:face(other)
				dialog(other, self, "I don't believe anyone has ever called me a specimen before. What do you need?")
				
			elseif string.find(msg, "believe anyone has ever called me a specimen") then
				self:say("Forgive me. I shall call you, my partner. We're now partners of science! Now. It is time to hold up your weight in this experiment.")
				dialog(other, self, "Umm... I don't believe I ever agreed to anything yet.")
				
			elseif string.find(msg, "I ever agreed to anything") then
				self:text("Binkerer takes a small needle and pokes your hand, breaking your skin and causing you to bleed a small bit. Rude!", 11, true)
				-- self:damage(other, 1, 100, 65535, true, true) [OOPS, ANYONE WITH PETS MIGHT GET IN TROUBLE WITH THIS...]
				self:say("Perfect. Not to worry, I'm just borrowing this for a moment, I'll give it right back. Anyways, I need you to gather my drone in old Highkeep.", 100, other)
				dialog(other, self, "That's a big ask for someone who randomly poked my hand and drew blood.")
				
			elseif string.find(msg, "a big ask for someone who randomly poked my hand") then
				self:say("Oh please, you big baby. Here is your blood back.")
				self:text("She stabs a small, blinking device into your hand. Ouch!", 11, true)
				self:say("This will help alert you when you're getting close to the drone. It also will stop the bleeding, I suppose. Go off, find my child, and I'll put in a good word to the councillors. I'll be waiiitinnnng! ♪♫♪", 100, other)
				other:setFlag(42518, 1)
				other:journal("COI - Drone-hunting in Highkeep", 1, "Some rude gnome named Binkerer (whatever that kind of name means...) just rudely asked me to retrieve her drones from Highkeep. Giving me no lead on where to start, I suppose I'll just clear my way through until I find something.")
		
			end
		
		elseif rankFlag > 1 and questFlag == 1 then
			self:say("Hmm. I don't see a drone. Go, get busy.", 100, other)
		
		elseif rankFlag > 1 and questFlag == 2 then
			if string.find(msg, "Hail") then
				self:say("You did it! My drone is back! Thank you, partner! Now for the other drones I forgot to mention earlier.", 100, other)
				other:setFlag(4176, other:GetFlag(4176) + 50)
				other:text("You gained faction experience!", 15, true)
				dialog(other, self, "EXCUSE ME?")
				
			elseif string.find(msg, "EXCUSE ME") then
				self:say("Buh-byeeeeee! ♫♪♫")
				other:setFlag(42518, 3)
				other:setFlag(42519, 0)
				other:journal("COI - Drone-hunting in Highkeep", 3, "This gnome has some nerve. G-nerve? Gnerve. I have to head back and get more drones that were neglected to be told about to me.")
			end
		
		elseif rankFlag > 1 and questFlag > 2 and questFlag < 9 then
			self:say("More drones. Highkeep. GO!", 100, other)
			
		elseif rankFlag > 1 and questFlag == 9 then
			if string.find(msg, "Hail") then
				self:say("Ahh, my babies are back! You did it! You actually did it! Not that I ever doubted my colleague and partner uhh.... mmm.", 100, other)
				dialog(other, self, ""..other:GetName()..". My name is "..other:GetName().."!")
				
			elseif string.find(msg, "My name is") then
				self:say("Yes, I apologize for my behavior, "..other:GetName()..". As promised, I will put in a good word to the councillors. Thank you very very much for your assistance!", 100, other)
				other:setFlag(42518, 100)
				other:journal("COI - Drone-hunting in Highkeep", 100, "After a begrudging amount of work for this selfish gnome, I've finally collected all of her drones and she has put in a good word of my successes with the councillors.")
				other:setFlag(4176, other:GetFlag(4176) + 100)
				other:text("You gain faction experience!", 15, true)
			end
		end
	end
end