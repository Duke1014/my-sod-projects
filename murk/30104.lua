-- an enslaved warrior
function EVENT_SPAWN(self)
	if self:GetX() == -1207 then
		self:walkTo(-1216,-378,-5.3)
	
	elseif (self:GetX() == -1201 then
		self:walkTo(-1202,-389,-4.3)
	
	elseif (self:GetX() == -1221 then
		self:walkTo(-1233,-394,-4.8)
	
	elseif (self:GetX() == -1253 then
		self:walkTo(-1210,-366,-6)
    end
	self:set("speed", 0.8)
end