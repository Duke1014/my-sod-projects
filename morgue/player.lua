-- Morgue of Erudin player file

-- GM stuff
function EVENT_SPAWN(self)
	if self:IsGM() then
		self:text("GM ONLY MESSAGE: To get around more quickly, use the following commands:", 5, true)
		self:text("-- #entrance (or #ent) - Entrance, next to Defender Mokah", 6, true)
		self:text("-- #adept - Adept room, circular room in the North East", 6, true)
	end
end

function EVENT_COMMAND(self, cmd, args)
	
	if self:IsGM() then
		if cmd == "entrance" or cmd == "ent" then
			self:teleport(48, -15, -7.5, 214)
		elseif cmd == "adept" then
			self:teleport(-2088, 2156, 9, 190)
		end
	end
end