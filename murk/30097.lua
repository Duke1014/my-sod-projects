-- an envenomed droplet

function EVENT_SPAWN(self)
	self:destroyCorpse()

	if npcCount(30096) > 0 then
		debugtext("ping")
	end
end

function EVENT_DEATH(self)
	-- signal(30096, "droplet_death")
	nl = GetNPCList()
	for k,v in pairs(nl) do
		if v:GetNPCID() == 30096 then
			v:signal("droplet_death")
		end
	end
end

function npcCount(npc_id)
	count = 0
	nl = GetGeneralFunctions().GetNPCList()
	for k,v in pairs(nl) do
		if GetNPCID(v) == npc_id then
			count = count + 1
		end
	end
	return count
end