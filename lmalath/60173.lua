-- portal to castle

function EVENT_SPAWN(self)
    self:area("enter_portal", 7)
end

function EVENT_AREA(self, other, area)
    if other:IsClient() and area == "enter_portal" then
        other:teleport(2639, -3738, 551.5, 128)
    end
end