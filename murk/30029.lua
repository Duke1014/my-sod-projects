--a sentient fungus

function EVENT_DEATH(self, other)
    if other:IsClient() and other:InZone() then
        local chance = math.random() * 100
        
        for k, v in pairs(self:GetHateList()) do
            if v:IsClient() and v:InZone() and v:GetFlag(3018) > 4 then
                v:setFlag(3029, v:GetFlag(3029) + 1)
                if chance > 50 then
                    v:text("Krinaka spots from afar as you slay "..self:GetName()..".", 6, true)
                else
                    v:text("A Gruplok spots you from afar as you slay "..self:GetName()..", and rushes off to tell Krinaka.", 6, true)
                end
            end
        end

        if chance < 2 then
            spawn(32001, self, 120)
        elseif chance == 3 then
            spawn(32002, self, 120)
        end
    end
end