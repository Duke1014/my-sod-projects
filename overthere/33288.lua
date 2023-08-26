--33288.lua a captive

-- needs work
function EVENT_SPAWN(self)
	pacing = 0
end

function EVENT_SAY(self, other, msg)

	chance = math.random(1,3)
	
	if string.find(msg,"Hail") then
		self:say("Althuna's Mercy, you're not one of the pirates! What are you doing here?", 100, other)
		dialog(other,self,"I was on my way to the kaezulian shipyard when I saw this boat.")
		
	elseif string.find(msg,"I was on") and chance == 1 then
		say(self,"Will you set us free?")
		dialog(other,self,"Yes of course!")
		dialog(other,self,"You are probably safer here than out there on your own.")
		dialog(other,self,"I do not care what happens to you or the other captives.")
		
	elseif string.find(msg,"I was on") and chance == 2 then
		say(self,"Will you help us escape?")
		dialog(other,self,"Yes of course!")
		dialog(other,self,"You are probably safer here than out there on your own.")
		dialog(other,self,"I do not care what happens to you or the other captives.")
		
	elseif string.find(msg,"I was on") and chance == 3 then
		say(self,"Free me?")
		dialog(other,self,"Yes of course!")
		dialog(other,self,"You are probably safer here than out there on your own.")
		dialog(other,self,"I do not care about you or the other captives.")
		
	elseif string.find(msg,"Yes of course") then
		self:timer("pacing_1",1000)
		setflag(other,14705,GetTime()) --if GetFlag(other,14705)>(GetTime()-3600000)
		pacing = 1
		
	elseif string.find(msg,"You are probably safer") then
		say(self,"Oh. Well I hope they catch you too!")
		
	elseif string.find(msg,"I do not care") then
		say(self,"Oh. Well I hope you die!")
		
	end
	
end


function EVENT_TIMER(self, timer_name, timer)
	if not self:InCombat() and timer_name == "pacing_1" and self:GetGender() == 0 and pacing == 1 then
		text(self,"As you free the captive of his flimsy bonds, he shoots you a grateful smile.")
		self:timer("pacing_2",3000)
		pacing = 2
		
	elseif not self:InCombat() and timer_name == "pacing_1" and self:GetGender() == 1 and pacing == 1 then
		text(self,"As you free the captive of her flimsy bonds, she shoots you a grateful smile.")
		self:timer("pacing_2",3000)
		pacing = 2
		
	elseif not self:InCombat() and timer_name == "pacing_2" and pacing == 2 then
		self:setAnim(0)
		text(self,GetName(self).." pauses for just a moment and whispers, 'If you're heading to the kaezulian shipyard, you should go quickly.'") 
		self:timer("pacing_3",8000)
		pacing = 3
		
	elseif not self:InCombat() and timer_name == "pacing_3" and pacing == 3 then
		text(self,GetName(self).." continues, 'I heard the captain of this boat say that he'd have to tie off outside of the shipyard because Kaezul's armada just came into port for emergency repairs and no civilian ships are being given berth at the wharf.'") 
		self:timer("pacing_4",8000)
		pacing = 4
		
	elseif not self:InCombat() and timer_name == "pacing_4" and pacing == 4 then
		text(self,GetName(self).." adds quickly, 'With the shipyard's resources completely focused on getting those ships back to fighting shape, the entire shipyard should be off-guard. Good luck!'") 
		self:timer("pacing_5",8000)
		pacing = 5
		
	elseif not self:InCombat() and timer_name == "pacing_5" and pacing == 5 then
		self:fade(true)
		text(self,"Without another word, the escaped captive jumps up through the open hatch above and takes off for the shore and freedom.")
		self:timer("pacing_6",15000)
		pacing = 6
		
	elseif not self:InCombat() and timer_name == "pacing_6" and pacing == 6 then
		text(self,"You hear a single human cry for help as an escaped captive is recaptured by kaezulian pirates.") 
		pacing = 0	
		self:set("aggrorange",30)
		self:timer("pacing_cd_timer",3600000)
		
	elseif self:InCombat() then
		pacing = 0
		self:timer("pacing_cd_timer",3600000)
		
	end
	if timer_name == "pacing_cd_timer" and pacing == 0 then
		self:setAnim(1)
		self:set("aggrorange",1)
		pacing = 0	
		self:fade(false)
		self:stopAllTimers()
		
	end
end