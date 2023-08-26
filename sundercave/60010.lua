-- Nalansar
-- Trigger mob for 60013

event_start = false

function EVENT_SPAWN(self)

	self:setAppearance(300) -- make sure he is a demon
	self:invul()
	depop(60014)
	depop(60015)
	depop(60016)
	depop(60017)
	depop(60018)
	depop(60019)
	depop(60020)
	spawn(60012, 1941.4, 125.7, 321.9, 236.5)
	
end

function EVENT_ATTACKED(self, other, damage, spell)

	self:wipeHate()
	
end

function EVENT_SAY(self, other, msg)

	if event_start == false and other:GetFlag(42500) == 6 then
	
		if string.find(msg, "Hail") then
		
			self:say("Welcome, interlopers. It's been too long. I'm so glad you could witness the destruction of your world.' Nalansar gestures towards the glowing portal ahead of him. 'Here lies the secret that the Four have kept from you mortals. An infinite amount of power comes from here, more than you can handle. Do you wish to stop me from completing my previous plan of dooming the world to darkness?")
			dialog(other, self, "We've defeated you before, what makes now so different?")
			
		elseif string.find(msg, "now so different?") then
		
			event_start = true
			self:say("You are most welcome to find out...")
			other:text("A loud, booming voice echoes in the caverns, 'HALT!'", 258, 500)
			self:timer("transform", 10000, true)
			spawn(60014, 1703.1, 198, 293, 73.8)
			spawn(60015, 1711.6, 231.6, 297, 80.8)
			spawn(60016, 1736.6, 253.9, 302, 79.9)
			spawn(60017, 1770.1, 275.2, 302, 85.9)
			
		end
		
	end
	
end

function EVENT_TIMER(self, words, other)

	if words == "transform" then
		self:text("The Chosen shout, 'This is the end of your schemes, demon! Worry not, mortals, we are here to aid you!", 258, 500)
		self:timer("transform2", 5000, true)
	elseif words == "transform2" then
		self:say("I don't think you understand your place, mortals and ''chosen'' of the Four.", 500)
		self:timer("transform3", 5000, true)
	elseif words == "transform3" then
		self:text("Nalansar's demonic body begins to warp.", 8, 500)
		self:say("I have already siphoned off the Soul Pool, your lives will be forfeit. And now...", 500)
		self:timer("transform4", 5000, true)
	elseif words == "transform4" then
		self:setAppearance(622)
		self:text("Nalansar shouts in a warped voice, 'Let's test this god-like power.'", 13, 500)
		self:timer("transform5", 2500, true)
	elseif words == "transform5" then
		spawn(60013, self:GetLoc())
		self:depop()
		
	end
end

function EVENT_INSIGHT(self, other)
	zonetext("Jayla's voice enters your mind, 'Heroes, help is on the way! Confront the demon and protect the Chosen!'", 4)
end