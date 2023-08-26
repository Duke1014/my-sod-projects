-- living tar
-- just used as a fun visual effect to begin The Tar Monster

function EVENT_AREA(self, other)
	if other:IsNPC() and other:GetNPCID() == 32266 then
		signal(32266, "grow")
		debugtext("GM: TAR GOOP DEPOPPED")
		self:depop()
	end
end

function EVENT_SPAWN(self)
	debugtext("GM: TAR GOOP SPAWN")
	self:timer("walk_to_golem", 1500, true)
	self:followArea(10)
	self:destroyCorpse()
end

function EVENT_TIMER(self, timer)
	if timer == "walk_to_golem" then
		debugtext("GM: TAR GOOP MOVING")
		self:walkTo(-2871, 1944, -62)
	end
end