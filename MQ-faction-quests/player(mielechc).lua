--[[ player.lua - Mielech's Lair
-- Currently used for 2021 Blackscale quest (Duke)
fuwok's mielc quest flags
14819	 shortcut quest
14820	 froglok darkvile - 1
14821	 scarab - 1
14822	cinderglomp - 8
14823	pool of frogloks - 1
14824   new spell quest 
]]
function EVENT_SLAY(self, other, damage, spell)
	if other:GetRace() == 26 or other:GetRace() == 27 then -- frogloks
		local hl = other:GetHateList()
		for k, v in pairs(hl) do
			if hl[k]:IsClient() and hl[k]:InZone() then
				local currentFlag = hl[k]:GetFlag(42515)
				if hl[k]:GetFlag(42514) == 1 then
					hl[k]:setFlag(42515, currentFlag + 1)
					
					if currentFlag > 150 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42515, currentFlag - 24)
						initiate = spawn(60136, self:GetX() + 5, self:GetY() + 5, self:GetBestZ(other))
						initiate:addHate(hl[k])
					elseif currentFlag > 125 then
						hl[k]:text("You believe you are getting closer to your goal...", 11, true)
					elseif currentFlag > 75 then
						hl[k]:text("The croaks of froglok begin to echo around you. Keep going!", 11, true)
					elseif currentFlag > 50 then
						hl[k]:text("You can hear the screaming of trolls from within the great caverns, they must certainly be holding the initiates here!", 11, true)
					elseif currentFlag < 51 then
						hl[k]:text("You are in the right area, keep looking for clues!", 11, true)
					end
					
				elseif hl[k]:GetFlag(42514) > 2 and hl[k]:GetFlag(42514) < 9 then
					hl[k]:setFlag(42515, currentFlag + 1)
					
					if currentFlag > 40 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42515, currentFlag - 40)
						initiate = spawn(60137, self:GetX() + 5, self:GetY() + 5, self:GetBestZ(other))
						initiate:addHate(hl[k])
					
					else
						hl[k]:text("You are in the right area, keep looking!", 11, true)
					end
				end
			end
		end

	elseif other:GetRace() == 160 then -- race 160
		local hl = other:GetHateList()
		for k, v in pairs(hl) do
			
			if hl[k]:IsClient() and hl[k]:InZone() then
				local currentFlag = hl[k]:GetFlag(42515)
				if hl[k]:GetFlag(42514) == 1 then
					hl[k]:setFlag(42515, currentFlag + 3)
					
					if currentFlag > 150 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42515, currentFlag - 24)
						initiate = spawn(60136, self:GetX() + 5, self:GetY() + 5, self:GetBestZ(other))
						initiate:addHate(hl[k])
					elseif currentFlag > 125 then
						hl[k]:text("You believe you are getting closer to your goal...", 11, true)
					elseif currentFlag > 75 then
						hl[k]:text("The croaks of froglok begin to echo around you. Keep going!", 11, true)
					elseif currentFlag > 50 then
						hl[k]:text("You can hear the screaming of trolls from within the great caverns, they must certainly be holding the initiates here!", 11, true)
					elseif currentFlag < 51 then
						hl[k]:text("You are in the right area, keep looking for clues!", 11, true)
					end
					
				elseif hl[k]:GetFlag(42514) > 2 and hl[k]:GetFlag(42514) < 9 then
					
					hl[k]:setFlag(42515, currentFlag + 3)
					
					if currentFlag > 40 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42515, currentFlag - 40)
						initiate = spawn(60137, self:GetX() + 5, self:GetY() + 5, self:GetBestZ(other))
						initiate:addHate(hl[k])
					
					else
						hl[k]:text("You are in the right area, keep looking!", 11, true)
					end
				end
			
			end
		end
	end
	
	--fuwok mielc revamp potpourri mobs
	--debugtext(other:GetNPCID())
	--stop the event from spawning from the event. disclaim fungus man from this since he is used for another part of the quest.              14825 set to 1 is OFF
	if math.random(100) < 2 and (other:GetNPCID() < 56804 or other:GetNPCID() > 56833) and not (other:GetNPCID() == 765 or other:GetNPCID() == 872 or other:GetNPCID() == 4601) and self:InGroup() and self:GetFlag(14824) > 0 and self:GetFlag(14825) ~= 1 then
		--[[grouphp = 0
		if self:InGroup() then 
			group = self:GetGroupMembers()
			for k,v in pairs(group) do
				grouphp = grouphp + v:GetStats().maxhp
				--debugtext("Total Group HP: " .. grouphp)
			end 
			grouphp = grouphp / #group
			--debugtext("Avg Group HP: " .. grouphp)
		else
			grouphp = grouphp + self:GetStats().maxhp
			--debugtext("Avg HP: " .. grouphp)
		end 
		if grouphp > 6500 then ]]
			seed = math.random(1,4)
			if seed == 1 then 
				spawn(56805, self:GetLoc())
			elseif seed == 2 then 
				spawn(56806, self:GetLoc())
			elseif seed == 3 then 
				spawn(56808, self:GetLoc())
			elseif seed == 4 then 
				spawn(56812, self:GetLoc())
			end 
		--end
	end 
	--check anybody in the group to see if they have the quest flag to spawn the antidote fungus boss
	
	if other:GetNPCID() == 765 then
		spawnfungusboss = 0
		if self:GetFlag(14824) == 10 then
			if math.random(1,15) == 1 then 
				spawnfungusboss = 1
			else
				self:text("You have killed a fungus man, but this one was not the lucky fungus man you needed.",14,true)
			end 
		elseif self:InGroup() then 
			group = self:GetGroupMembers()
			if math.random(1,15) == 1 then 
				for k,v in pairs(group) do
					if v:GetFlag(14824) == 10 then 
						spawnfungusboss = 1
					end 
				end
			else
				for k,v in pairs(group) do
					if v:GetFlag(14824) == 10 then 
						v:text("You have killed a fungus man, but this one was not the lucky fungus man you needed.",14,true)				
					end 
				end
				
			end 
		end 
		if spawnfungusboss == 1 then
			spawn(56817, self:GetLoc())
		end 
	end 
	--greater fire elemental for mielc quest
	if other:GetNPCID() == 872 then 
		spawnfireboss = 0
		if self:GetFlag(14824) == 18 then
			spawnfireboss = 1
		elseif self:InGroup() then 
			group = self:GetGroupMembers()
			for k,v in pairs(group) do
				if v:GetFlag(14824) == 18 then 
					spawnfireboss = 1
				end 
			end 
		end 
		
		if spawnfireboss == 1 then
			local nl = GetNPCList()
			local count = 0
			for k,v in pairs(nl) do
				if v:GetNPCID() == 56819 then
					count = count + 1
				end
			end
			if count == 0 then 
				spawn(56819, self:GetLoc())
			end 
		end 
	end 
	
	--add random chance to this or some other restriction.  time based?
	
	
	if self:GetFlag(14824) >= 23 and other:GetLevel() < 61 and other:GetEnv().reanimated ~= 1  and other:GetNPCID() ~= 56833 then 
		if cooldowntimer then
			return
		else 
			if not self:GetPet() then 
				self:text(other:GetName() .. " is enslaved by the power of Mielech!",0,100)         
				add=customSpawn({name = self:GetName() .. "`s slave", level = other:GetLevel(), faction = 449, race = other:GetRace(), gender = other:GetGender(), texture = other:GetTexture(), size = other:GetSize(), hp = other:GetStats().maxhp, other:GetStats().maxdamage, npcid = 4601, owner=self},self)		
				add:set("Proc", 4461)
				--start cooldown timer 20 mins	
				cooldowntimer = self:timer("cooldowntimer",1200000, true)
			else 
				--debugtext("has pet")
				--cannot add a pet to pet.  spawn a treasure chest with monsters inside.  100% chance of monsters
				add = spawn(56833,self)
				--start cooldown timer 10 mins	
				cooldowntimer = self:timer("cooldowntimer",600000, true)
			end 
		end 
	end 
end

function EVENT_DROP_ITEM(self, item)
	--debugtext("Dropped item.")
	rockloc = {-467, -2076.1, -192.5}
	--massive tail 12756
	if self:GetDist(rockloc) < 20 and self:GetFlag(14824) == 3 and item:GetID() == 12756 then 
		debugtext("Player dropped terrorsaur tail on the tiny rock.")
		
		bosscount = 0 
		bossid = 56815
		local nl = GetNPCList()
		for k, v in pairs(nl) do
			if v:GetNPCID() == bossid then 
				debugtext("Boss is already spawned.")
				bosscount = 1
			end 
		end
		if bosscount == 1 then 
			self:text("You cannot attract a second scintillating cube while there is already one spawned!", 11, true)
		else
			bossloc = {-366.7, -2003.5, -198.2, 164.1}
			debugtext("Spawning scintillating cube boss.")
			spawn(bossid,bossloc)
		end 
	end 
end 

function EVENT_SPAWN(self)
	--client has completed mielc questline.  spawn a reward mob. 
	if self:GetFlag(14824) >= 23 then 
		local addid = 56832
		add=spawn(addid, self)
		add:GetEnv().followtarget = self
	elseif self:GetFlag(14824) == 21 then  
		--spawn the tiny golem to trigger mielech encounter
		nl = GetNPCList() 
		sl = GetSpawnList()
		for i in pairs(nl) do
			spawncheck = nl[i]:GetSpawn()
			for k,v in pairs(sl) do 
				--prevent respawn of any mob that is already spawned
				if v == spawncheck then 
					table.remove(sl,k)
				end 
			end 
		end
		--debugtext("SL: " .. #sl)
		for i=1,#sl do
			if sl[i]:GetID() == 84195 then 
				sl[i]:respawn()
			end 
		end 
	end 
end 

function EVENT_TIMER(self, words)
	if words == "cooldowntimer" then
		cooldowntimer = nil 
	end 
end 

function EVENT_LEAVEZONE(self, type)
	self:stopAllTimers()
end 