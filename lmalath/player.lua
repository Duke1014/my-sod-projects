-- Gulf of Gunthak player.lua

-- GM COMMANDS

function EVENT_SPAWN(self)
	if self:IsGM() then
		self:text("GM ONLY MESSAGE: To get around more quickly, use the following commands:", 5, true)
		self:text("-- #lava - Lava area in the tunnels.", 6, true)
		self:text("-- #castle - Entrance to the castle in the SouthWest.", 6, true)
        self:text("-- #fort - Fort area in the SouthEast.", 6, true)
        self:text("-- #lighthouse (or #boat) - Lighthouse in the NorthEast.", 6, true)
		self:text("-- #town - Next to the zone line to the harbor, in the middle of the town.", 6, true)
	end
	-- if self:GetFlag(42533) == 0 then
	-- 	self:
	-- end
end

oldCommand = EVENT_COMMAND;
function EVENT_COMMAND(self, cmd, args)
	if self:IsGM() then
		if cmd == "lava" then
			self:teleport(1790, -2439, -60, 128)
		elseif cmd == "castle" then
			self:teleport(2604, -2508, 460, 128)
        elseif cmd == "fort" then
            self:teleport(91, -1738, 52, 189)
        elseif cmd == "lighthouse" or cmd == "boat" then
            self:teleport(-323, 1330, 4, 215)
		elseif cmd == "town" then
			self:teleport(2280, -666, 69, 128)
		elseif cmd == "test" then
			self:giveFaction(646, -1000)
		end
	end
	
	return oldCommand(self, command, args)
end

function EVENT_ZONEAREA(self, area_id)
	if area_id == 1 then
        self:text("The heat is unbearable! You instinctually head back to solid ground.", 0, true)
        self:teleport(1790, -2439, -60, 128)
	end
end