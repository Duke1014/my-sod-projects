-- portal to fort

function EVENT_SPAWN(self)
    self:area("enter_portal", 7)
end

function EVENT_AREA(self, other, area)
    if other:IsClient() and area == "enter_portal" then
        other:teleport(-415, -1777, 45.6, 90)
    end
end