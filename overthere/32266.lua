-- a tar golem - Controller for Tar Monster event
-- takes the goop that spawns after killing partially formed golems (NPCID: 33223) and grows in size, forming into The Tar Monster
absorb = 0
countdown = false

function EVENT_SPAWN(self)
	spawn(33223, -2954, 1874, -39)		--------------------------------------
	spawn(33223, -2776, 1883, -32)		--		Begin with spawning the		--	
	spawn(33223, -2785, 2012, -38)		--		necessary starting mobs		--
	spawn(33223, -2913, 2069, -31)		--------------------------------------
	self:invul(true)
end

function EVENT_SIGNAL(self, signal, data)
	if signal == "tar_countdown" and countdown == false then
		self:timer("area_countdown", 120000, true)
		countdown = true
		self:text("The tar pits begin to bubble... [2 minutes]", 8, 250)
	elseif signal == "grow" then
		debugtext("GM: GOLEM ABSORBED TAR")
		currentSize = self:GetSize()		--------------------------------------------------
		absorb = absorb + 1					-- 	grows the tar golem as goops form into it	--
		self:setSize(currentSize + 5)		--------------------------------------------------
		if absorb == 4 then
			debugtext("GM: it is golem time :)")
			self:set("aiclass", 28)
			spawn(60029, self:GetX(), self:GetY(), self:GetZ())
			self:stopAllTimers()
		end
	end
end

function EVENT_TIMER(self, timer)
	if timer == "area_countdown" then
		self:text("The golems reform themselves as the tar pit calms.", 8, 250)
		depop(33223)
		respawn(69965)
	end
end

function EVENT_ATTACKED(self, other)
	self:wipeHate()
end