-- portal to Town

function EVENT_SPAWN(self)
    self:area("enter_portal", 7)
end

function EVENT_AREA(self, other, area)
    if other:IsClient() and area == "enter_portal" then
        other:teleport(1930, -695, 69, 65)
    end
end