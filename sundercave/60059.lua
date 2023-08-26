-- Sundered Caverns Controller
-- used to spawn Nalansar and Uthic the Destroyer

function EVENT_SPAWN(self)
	_G.controller = self
	
	SPAWN_NALANSAR()
	SPAWN_UTHIC()	
end

function SPAWN_UTHIC()
	spawn(60008, 1253, -71, 248, 195.6) -- Uthic the Destroyer
end

function SPAWN_NALANSAR()
	spawn(60010, 1923, 154, 317, 108.2) -- Nalansar (his script takes care of himself)
end
