function EVENT_SPAWN(self)
	if self:IsGM() then
		self:text("GM ONLY MESSAGE: To get around more quickly, use the following commands:", 5, true)
		self:text("-- #harbor - NorthWest Harbortown", 6, true)
		self:text("-- #tarpit - NorthEast Tar Pit", 6, true)
		self:text("-- #forest - Forest of the Fallen Entrance", 6, true)
		self:text("-- #skyfire - Skyfire Mountains Entrance", 6, true)
		self:text("-- #odeum - Odeum of Profunity Entrance", 6, true)
		self:text("-- #ruins - Southern Ruins", 6, true)
		self:text("-- #boat - Ship, out in the ocean", 6, true)
	end
end

function EVENT_COMMAND(self, cmd, args)
	if self:IsGM() then
		if cmd == "harbor" then
			self:teleport(2528, 2895, -49, 136)
		elseif cmd == "tarpit" then
			self:teleport(-2714, 1904, -17, 198)
		elseif cmd == "forest" then
			self:teleport(-3918, 73, 231, 71)
		elseif cmd == "skyfire" then
			self:teleport(3794, -1050, 100, 193)
		elseif cmd == "odeum" then
			self:teleport(821, -85, -502, 180)
		elseif cmd == "ruins" then
			self:teleport(968, -2141, 54, 229)
		elseif cmd == "boat" then
			self:teleport(-1350, 7034, -119.4, 149)
		end
	end
end