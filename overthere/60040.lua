-- Caretaker Kolsaz, meeting him at night in Refuge at the Monument
-- This is used for the quest, The Hierophant's Apprentice
-- any clean-up associated with this mob is handled by the controller: 60042.lua

busy = false

function EVENT_SAY(self)

local mainflag = other:GetFlag(42503)

	if mainflag == 1 and busy == false then
	
		if string.find(msg, "Hail") then
			self:say("Shhh! Keep it down! We can't let the others know this information.")
			other:setFlag(42053, 2)
			dialog(other, self, "What information? Why is this such a huge secret?")
			self:stopAllTimers()
			
		end
	
	elseif mainflag == 2 then
	
		if string.find(msg, "Hail") then
			dialog(other, self, "What information? Why is this such a huge secret?")
	
		if string.find(msg, "What information") then
			self:text("Kolsaz sighs, 'The Hierophant. He-'")
			busy = true
			self:timer("rorlna", 3000, true)
			self:text("From the shadows, you hear. 'The Hierophant is your father. Is that what you were going to say?'")
			quester = other
			other:setFlag(42503, 3)
			
		end
		
	elseif mainflag == 3 and busy == true then
		
		if string.find(msg, "This is awkward") then
			self:text("Rorlna says, 'Both of you should know better than to think im not always listening. So go on, Kolsaz. I'd like to know more.")
			self:timer("talky_one", 4000, true)
			
		elseif string.find(msg, "What can I do") then
			self:text("Rorlna says, 'The Oracle, as I've previously said, is a seer. She forsaw your arrival to Ikisith years ago. Her powers are highly sought by Kaezul, but it seems she's back in imprisonment, and they're going to ship her straight into Reghrat to be dealt with by Kaezul.")
			self:timer("talky2_one", 5000, true)
			
		end
	
	end
	
end

function EVENT_TIMER(self, timer)

	if timer == "rorlna" then
		spawn(60041, (self:GetX() + 5), self:GetY(), self:GetBestZ())
		dialog(quester, self, "Well. This is awkward.")
		
	elseif timer == "talky_one" then
		self:say("W-well. He, The uh... The Hierophant has been working on something big, recently.")
		self:timer("talky_two", 5000, true)
		
	elseif timer == "talky_two" then
		self:text("Rorlna says, 'He's also taken The Oracle from what it seems. She's currently being held in the Overthere with other prisoners.'"
		self:timer("talky_three", 5000, true)
		
	elseif timer == "talky_three" then
		self:text("Kolsaz's face turns pale. 'WHAT?! Was she discovered talking to one of us? What is that bastard planning?'")
		self:doAnim(13)
		self:timer("talky_four", 5000, true)
	
	elseif timer == "talky_four" then
		self:text("That's why I followed you here. I want to speak to "..quester:GetName().." about rescuing her. We're going to bring her back here.")
		dialog(quester, self, "What can I do? And most importantly, who is The Oracle? I still want answers about that!")
		
	elseif timer == "talky2_one" then
		self:say("Which means that she's currently under the watch of The Hierophant. This is VERY bad, we need to rescue her.")
		self:timer("talky2_two", 5000, true)
		
	elseif timer == "talky2_two" then
		self:text("Rorlna says, 'Leave that to me. "..quester:GetName()..", the Oracle will be a necessary ally against this war. Speak with me quickly, we're setting out for The Overthere.")
		busy = false
		quester:setFlag(42503, 4)
		
	end
	
end