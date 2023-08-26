--[[ 60008
big dragon, Uthic the Destroyer]]--

function EVENT_ATTACK(self, other)
	self:timer("tailwhip", 25000, true)
	self:timer("darkness", 17000)
	self:text("Uthic shouts, 'FOOLS! YOU HAVE NO CHANCE AGAINST ME.'", 13, 500)
end

function EVENT_TIMER(self, words)
	if words == "tailwhip" then
		self:timer("tailwhip2", 5000, true)
		self:text("Uthic begins to flick his tail...", 13, 500)
	end
	if words == "tailwhip2" then
		self:timer("tailwhip", 25000, true)
		self:text("Uthic SLAMS his tail onto the ground!", 13, 500)
		HL = self:GetHateList()
		for k, v in pairs(HL) do			
			if v:IsClient() then
				if v:InCone(self, 180, 180) then
					self:customNuke(v, "tailwhip", "The ground shakes behind the great destroyer as his tail.", 8000)				
				end
			end	
		end
	end
	if words == "darkness" then
		HL = self:GetHateList()
		for k, v in pairs(HL) do			
			if v:IsClient() then
				self:customNuke(v, "darkness", "A dark mass of energy seeps out of Uthic and covers you.", 3500, 1, -200)
			end
		end
	end
	if words == "bigdarkness" then
		HL = self:GetHateList()
		for k, v in pairs(HL) do			
			if v:IsClient() then
				self:customNuke(v, "bigdarkness", "A dark mass of energy seeps out of Uthic and covers you.", 6000, 1, -400)
			end
		end
	end
end

function EVENT_DEATH(self)
	self:stopAllTimers()
	self:text("an unseen voice says, 'No matter. My work is almost done, and I've gained enough power to wipe you out easily. Come, mortals, and face me again!'", 13, 500)
	signal(60004, "Uthicdead")
end

function EVENT_COMBATEND(self)
	self:stopAllTimers()
	--self:respawn() He has no spawn
	_G.controller:GetEnv().SPAWN_UTHIC()
	self:depop()
end

function EVENT_SPAWN(self)
	self:hpTrigger(90)
end

function EVENT_HP(self, other, damage, ratio)
	
	if ratio == 90 then
		self:text("Uthic shouts, 'THE MASTER'S PLAN WILL COME TO FRUITION, WHETHER OR NOT I DIE HERE.'", 13, 500)
		self:hpTrigger(80)
	end
	
	if ratio == 80 then
		self:text("Uthic shouts, 'YOU WILL... you... What? Wher-'", 330, 500)
		self:hpTrigger(78)
	end
	
	if ratio == 78 then
		self:text("As Uthic roars, an unseen voice shouts, 'UTHIC! You have fought for years against my corruption and you will DIE before you break free!'", 13, 500)
		self:hpTrigger(75)
	end
	
	if ratio == 75 then
		self:text("Uthic shouts, 'You, end my life, here and now. I refuse to be a pawn of Nala-'", 330, 500)
		self:text("Uthic roars in agony as his body becomes overcome by darkness, his eyes pale.", 13, 500)
		self:stopTimer("darkness")
		self:timer("bigdarkness", 8500)
		self:hpTrigger(15)
	end
	
	if ratio == 15 then
		self:text("Uthic starts to weaken, his attacks diminishing...")
		self:set("Damage",1000,2000)
		self:hpTrigger(5)
	end
	
	if ratio == 5 then
		self:text("Uthic says, in a low grumble, 'Thank you, heroes. Don't let Nalansar get to the Soul Pool...", 330, 500)
	end

end