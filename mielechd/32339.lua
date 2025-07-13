--32339 krazkak

function EVENT_SPAWN(self)
	pot = {-13, 1342, -41}
	
	flames = {}
	flames[1] = {name = "_", level = 70, aiclass =8, race =69, texture=3,hp =1000, size = 5}
	flames[2] = {name = "_", level = 70, aiclass =8, race =69, texture=4,hp =1000, size = 5}
	
	ALL_MOBS = {}
end

function EVENT_SAY(self,other,words)
	if words == "flames" then
		other:text("spawning flames",0,true)
		for i=1,10 do
			a = customSpawn(flames[math.random(1,2)],-13 + math.random(-5,5), 1342 + math.random(-5,5), -40, 0)
			table.insert(ALL_MOBS,a)
		end
		self:timer("extinguish",3000,true)
	end
end

function EVENT_TIMER(self,words)
--	self:text(self:GetNPCID() .. " + " .. words,0,1000)
	if words == "extinguish" then
		for k,v in pairs(ALL_MOBS) do
			if v:GetName() == "_" then
				v:depop()
			end
		end
	end
end