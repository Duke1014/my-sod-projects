-- tablet runes, spawns from 60004 after handing in tablets

function EVENT_SPAWN(self)
	self:setAppearance(510) 		-- make sure its the rune model
	self:timer("talkone", 5000, true)
end

function EVENT_TIMER(self, words)

	if words == "talkone" then
		self:text("After locking in place, a shimmering rune manifests from the combined tablets, radiating with a glowing energy.", 8)
		self:timer("talktwo", 5000, true)
		
	elseif words == "talktwo" then
	
		self:text("The rune begins to glow brighter...", 8)
		self:timer("talkthree", 5000, true)
		
	elseif words == "talkthree" then
	
		self:text("Suddenly, the rune fades! A massive quake occurs as the tablets are sucked underground, disappearing before your eyes.", 8)
		self:setAppearance(127) 	-- invisible
		self:timer("talkfour", 5000, true)
		
	elseif words == "talkfour" then
	
		self:text("Azura stares at where the tablets just were, blinking her eyes in confusion and disbelief.", 8)
		self:timer("end", 5000, true)
		
	elseif words == "end" then
	
		signal(60004, "uhoh")
		self:depop()
		
	end
end