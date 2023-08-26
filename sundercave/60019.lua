-- air add for 60013/60016

function EVENT_AREA(self, other)
	if other:IsNPC() then
		if other:GetNPCID() == 60016 then
			self:depop()
		end
	end
end

function EVENT_SPAWN(self)
	self:runTo(1839.8, 224.9, 317)
	self:followArea(10)
	self:destroyCorpse()
end

function EVENT_ATTACKED(self, other)
	self:wipeHate()
	self:runTo(1839.8, 224.9, 317)
end

function EVENT_DEATH(self)
	self:depop()
end