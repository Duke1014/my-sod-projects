-- add for Magdolena, the Inevitable

function EVENT_SPAWN(self)
	debugtext("add spawned")
	-- hl = _G.magdolena:GetHateList()
	-- for k,v in pairs(hl) do
	-- 	if v:IsClient() and v:InZone() then
	-- 		self:addHate(v)
	-- 	end
	-- end

	self:runTo(-2223, 2150, 14)

end