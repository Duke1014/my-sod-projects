-- ##<slaariel>	30028 30029 fungi
-- ##<slaariel>	30016 30017 30018 30019 30054 30055 
-- ##<slaariel>	30056 murk guardian
-- ##<slaariel>	30059 30086 30059

-- a murkling gatherer

function EVENT_DEATH(self, other)
    if other:IsClient() and other:InZone() then
        local chance = math.random() * 100

        for k, v in pairs(self:GetHateList()) do
            if v:IsClient() and v:InZone() and v:GetFlag(3018) > 4 then
                v:setFlag(3027, v:GetFlag(3027) + 1)
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