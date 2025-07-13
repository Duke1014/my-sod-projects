-- a ship ladder
-- hailing this will send the client up to the top of the ship in order to explore
-- considering this will hint towards hailing the mob

function EVENT_CONSIDER(self, other)
    other:text("a ship ladder rests on the shipwreck -- Hailing this mob will allow you to climb to the top of this ship.", 6, true)
end

function EVENT_SAY(self, other, msg)
    if string.find(msg, "Hail") then
        if self:GetX() == -1000 then
            other:teleport(-1003, -1239, 50, 50)
        elseif self:GetX() == -224 then
            other:teleport(-236, -226, 32, 105)
        elseif self:GetX() == -399 then
            other:teleport(-390, -779, 71, 45)
        elseif self:GetX() == -38 then
            other:teleport(-37, -723, 78, 151)
        end
    else return end
end