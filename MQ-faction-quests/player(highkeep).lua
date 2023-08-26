-- player.lua - Highkeep
-- Currently used for 2021 Blackscale quest (Duke)

function EVENT_SLAY(self, other, damage, spell)
	if other:GetRace() == 60 then
		local hl = other:GetHateList()
		for k, v in pairs(hl) do
			if hl[k]:IsClient() and hl[k]:InZone() then
				local currentFlag = hl[k]:GetFlag(42519)
				if hl[k]:GetFlag(42518) == 1 then
					hl[k]:setFlag(42519, currentFlag + 1)
					
					if currentFlag > 150 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42519, currentFlag - 21)
						drone = spawn(60141, self:GetX(), self:GetY(), self:GetBestZ(other))
					elseif currentFlag > 125 then
						hl[k]:text("You believe you are getting closer to your goal...", 11, true)					
					elseif currentFlag > 75 then
						hl[k]:text("The clicks of machines begin to echo around you. Keep going!", 11, true)
					elseif currentFlag > 50 then
						hl[k]:text("You can hear whizzing from within the old hallways, the drones are here somewhere!", 11, true)
					elseif currentFlag < 51 then
						hl[k]:text("You are in the right area, keep looking for clues!", 11, true)
					end
					
				elseif hl[k]:GetFlag(42518) > 2 and hl[k]:GetFlag(42518) < 9 then
					hl[k]:setFlag(42519, currentFlag + 1)

					if currentFlag > 40 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42519, currentFlag - 40)
						drone = spawn(60141, self:GetX(), self:GetY(), self:GetBestZ(other))

					else
						hl[k]:text("You are in the right area, keep looking!", 11, true)
					end

				end
			end
		end

	elseif other:GetRace() == 68 then -- tentacle terror race 68
		local hl = other:GetHateList()
		for k, v in pairs(hl) do
			
			if hl[k]:IsClient() and hl[k]:InZone() then
				local currentFlag = hl[k]:GetFlag(42519)
				if hl[k]:GetFlag(42518) == 1 then
					hl[k]:setFlag(42519, currentFlag + 5)
					
					if currentFlag > 150 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42519, currentFlag - 21)
						drone = spawn(60141, self:GetX(), self:GetY(), self:GetBestZ(other))
					elseif currentFlag > 125 then
						hl[k]:text("You believe you are getting closer to your goal...", 11, true)					
					elseif currentFlag > 75 then
						hl[k]:text("The clicks of machines begin to echo around you. Keep going!", 11, true)
					elseif currentFlag > 50 then
						hl[k]:text("You can hear whizzing from within the old hallways, the drones are here somewhere!", 11, true)
					elseif currentFlag < 51 then
						hl[k]:text("You are in the right area, keep looking for clues!", 11, true)
					end
					
				elseif hl[k]:GetFlag(42518) > 2 and hl[k]:GetFlag(42518) < 9 then
					hl[k]:setFlag(42519, currentFlag + 5)

					if currentFlag > 40 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42519, currentFlag - 40)
						drone = spawn(60141, self:GetX(), self:GetY(), self:GetBestZ(other))

					else
						hl[k]:text("You are in the right area, keep looking!", 11, true)
					end

				end
			end
		end
	end
end

--[[
Highkeep Basement Lantern Script

Related Item
	10153	Lit Lantern of Divine Light
]]

local LIT_LANTERN = 10153
local SLOT_SECONDARY = 14
local in_darkness = true
_G.num_clients = 0

function EVENT_ZONEAREA(self,area_id)
	--Entrance Area
	if area_id == 22 and not self:IsGM() then
		self:timer("Tentacles",300000,true)
		self:text("This place makes you feel rather uneasy...", 0, true)
		
		--Vah Treasure Map
		if self:GetFlag(5187) == 0 and self:GetFlag(5117) > 3 and npccount(7687) == 0 then
			spawn(7687,-11,-10,-5,0,3600)
			self:text("You locate the dig site in the middle of the courtyard.",0,true)
		end
		
	elseif area_id == 2 then
		_G.num_clients = _G.num_clients + 1
		if _G.num_clients == 1 then
			spawn(4461, -311, 76, 32, 128, 0)
			spawn(4462, -333, 76, 32, 128, 0)
			spawn(4463, -321, 63, 32, 128, 0)
			spawn(4464, -341, 37, 29, 250, 0)
			spawn(4464, -312, 36, 29, 0, 0)
			spawn(4464, -330, 38, 29, 0, 0)
			spawn(4464, -346, 36, 29, 26, 0)
		end
		
	--Basement Area
	elseif area_id == 3 --[[and not self:IsGM()]] then
		in_darkness = (CHECK_LATERN_NEARBY(self) == false)
		self:timer("Check Lantern",9500,true)
		if in_darkness then
			self:text("A sudden rush of panic enters your mind. You must leave this area right now!", 0, true)
		else
			self:text("A sudden rush of panic enters your mind.", 0, true)
		end
	end
end

function EVENT_LEAVE_ZONEAREA(self,area_id)
	--Entrance Area
	if area_id == 22 and not self:IsGM() then
		self:stopAllTimers()
		self:text("You feel much better after leaving the courtyard behind.", 0, true)
	
	elseif area_id == 2 then
		_G.num_clients = _G.num_clients - 1
		if _G.num_clients < 0 then
			_G.num_clients = 0
		end
		if _G.num_clients < 1 then
			depop(4461)
			depop(4462)
			depop(4463)
			depop(4464)
		end
		
	--Basement Area
	elseif area_id == 3 --[[and not self:IsGM()]] then
		self:stopAllTimers()
		self:text("Your panic stills as you leave the mine area behind you.", 0, true)
	end
end

function EVENT_TIMER(self, timer_name, timer_object)
	if timer_name == "Check Lantern" then
		in_darkness = (CHECK_LATERN_NEARBY(self) == false)
		if in_darkness then
			self:text("You are filled with sudden dread!", 13, true)
			self:timer("Death",6000,true)
		else
			self:timer("Check Lantern",1000,true)
		end
	elseif timer_name == "Death" then
		in_darkness = (CHECK_LATERN_NEARBY(self) == false)
		if in_darkness then
			self:text("Your soul is consumed by the shadows of the dead.", 0, true)
			self:kill(self)
		else
			self:text("Your panic stills.", 0, true)
			self:timer("Check Lantern",1000,true)
		end
	elseif timer_name =="Tentacles" then
		self:spellEffect(1887)
	end
end

function CHECK_LATERN_NEARBY(self)
	for k,v in pairs(GetAliveClientList()) do
		local secondary = v:GetInventory(SLOT_SECONDARY)
		if self:GetDist(v) < 75 and secondary and secondary:GetID() == LIT_LANTERN then
			return true
		end
	end
	return false
end

function npccount(npc_id)
	local count = 0
	for _,v in pairs(GetNPCList()) do
		if v:GetNPCID() == npc_id then
			count = count + 1
		end
	end
	return count
end
