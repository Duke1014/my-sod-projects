
function EVENT_SPAWN(self)
	say(self,"Respawning undead Gruploks.",10)
	local list = GetNPCList()
	for i,v in ipairs(list) do
		if GetNPCID(v) >= 30021 and GetNPCID(v) <= 30024 then
			respawn(v)
		end
	end
end