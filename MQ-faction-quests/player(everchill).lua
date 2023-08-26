-- player.lua - Everchill Caverns
-- Currently used for 2021 Blackscale quest (Duke)


function EVENT_SPAWN(self)
	if self:GetInventory(21) then
		local ammo = self:GetInventory(21)
		if ammo:GetID() == 44331 then 
			self:text("The Enlightenment of the Everchill surrounds you...", 18, true)
			self:setAppearance(54, 2, 2)
		end 
	end
end

function EVENT_SLAY(self, other, damage, spell)	
	--enlightenment of everchill
	if self:GetInventory(21) then
		local ammo = self:GetInventory(21)
		if ammo:GetID() == 44331 then 
			--if math.random(1,2) == 1 then
				if self:InGroup() then 
					self:text(self:GetName() .. " feels the ENLIGHTENMENT OF THE EVERCHILL!",304,70)
					local gl = self:GetGroupMembers()
					for k, v in pairs(gl) do
						v:proc(5242)
					end 
				else 
					self:proc(5242)
					self:text(self:GetName() .. " feels the ENLIGHTENMENT OF THE EVERCHILL!",304,70)
				end 
			--end 
		end 
	end 


	if other:GetRace() == 54 and other:GetLevel() > 50 then -- orc race 54
		local hl = other:GetHateList()
		for k, v in pairs(hl) do
			if hl[k]:IsClient() and hl[k]:InZone() then
				local currentFlag = hl[k]:GetFlag(42517)
				if hl[k]:GetFlag(42516) == 1 then
					hl[k]:setFlag(42517, currentFlag + 2)

					if currentFlag > 150 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42517, currentFlag - 21)
						hireling = spawn(60139, self:GetX(), self:GetY(), self:GetBestZ(other))
					elseif currentFlag > 125 then
						hl[k]:text("You believe you are getting closer to your goal...", 11, true)
					elseif currentFlag > 75 then
						hl[k]:text("You can hear screaming from within the great caverns, the hirelings are here somewhere!", 11, true)
					elseif currentFlag > 50 then
						hl[k]:text("The grunt of orcs begin to echo around you. Keep going!", 11, true)
					elseif currentFlag < 51 then
						hl[k]:text("You are in the right area, keep looking for clues!", 11, true)
					end
			
				elseif hl[k]:GetFlag(42516) > 2 and hl[k]:GetFlag(42516) < 9 then
					hl[k]:setFlag(42517, currentFlag + 2)
					
					if currentFlag > 40 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42517, currentFlag - 20)
						hireling = spawn(60139, self:GetX(), self:GetY(), self:GetBestZ(other))

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
				local currentFlag = hl[k]:GetFlag(42517)
				if hl[k]:GetFlag(42516) == 1 then
					hl[k]:setFlag(42517, currentFlag + 4)

					if currentFlag > 150 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42517, currentFlag - 21)
						hireling = spawn(60139, self:GetX(), self:GetY(), self:GetBestZ(other))
					elseif currentFlag > 125 then
						hl[k]:text("You believe you are getting closer to your goal...", 11, true)					
					elseif currentFlag > 75 then
						hl[k]:text("You can hear screaming from within the great caverns, the hirelings are here somewhere!", 11, true)
					elseif currentFlag > 50 then
						hl[k]:text("The grunt of orcs begin to echo around you. Keep going!", 11, true)
					elseif currentFlag < 51 then
						hl[k]:text("You are in the right area, keep looking for clues!", 11, true)
					end
				
				elseif hl[k]:GetFlag(42516) > 2 and hl[k]:GetFlag(42516) < 9 then
					hl[k]:setFlag(42517, currentFlag + 4)
					
					if currentFlag > 40 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42517, currentFlag - 40)
						hireling = spawn(60139, self:GetX(), self:GetY(), self:GetBestZ(other))
					
					else
						hl[k]:text("You are in the right area, keep looking!", 11, true)
					end
				end
			end
		end
		
	elseif string.match(other:GetName(), "nazdrich") then
		local hl = other:GetHateList()
		for k, v in pairs(hl) do
					
			if hl[k]:IsClient() and hl[k]:InZone() then
				local currentFlag = hl[k]:GetFlag(42517)
				if hl[k]:GetFlag(42516) == 1 then
					hl[k]:setFlag(42517, currentFlag + 5)

					if currentFlag > 150 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42517, currentFlag - 21)
						hireling = spawn(60139, self:GetX(), self:GetY(), self:GetBestZ(other))
					elseif currentFlag > 125 then
						hl[k]:text("You believe you are getting closer to your goal...", 11, true)					
					elseif currentFlag > 75 then
						hl[k]:text("You can hear screaming from within the great caverns, the hirelings are here somewhere!", 11, true)
					elseif currentFlag > 50 then
						hl[k]:text("The grunt of orcs begin to echo around you. Keep going!", 11, true)
					elseif currentFlag < 51 then
						hl[k]:text("You are in the right area, keep looking for clues!", 11, true)
					end
					
				elseif hl[k]:GetFlag(42516) > 2 and hl[k]:GetFlag(42516) < 9 then
					hl[k]:setFlag(42517, currentFlag + 5)
					
					if currentFlag > 40 then
						debugtext("GM MESSAGE: Spawning Quest Mob")
						hl[k]:setFlag(42517, currentFlag - 40)
						hireling = spawn(60139, self:GetX(), self:GetY(), self:GetBestZ(other))
					
					else
						hl[k]:text("You are in the right area, keep looking!", 11, true)
					end
				end
			end
		end
	end
end