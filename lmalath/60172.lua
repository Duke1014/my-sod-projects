-- portal to lighthouse

function EVENT_SPAWN(self)
    self:area("enter_portal", 7)
end

function EVENT_AREA(self, other, area)
    if other:IsClient() and area == "enter_portal" then
        other:teleport(-216, 1457, 7.7, 64)
    end
end