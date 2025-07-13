-- a corpulent murk leech

function EVENT_ATTACK(self)
	self:text(self:GetName().. "opens its maw and issues a series of disgusting sounds as it senses a meal approaching.")
    self:timer("check_distance", 10000)
end

function EVENT_TIMER(self, timer)
    if timer == "check_distance" then
        for k, v in pairs(self:GetHateList()) do
            if v:IsClient() and v:InZone() and v:IsAlive() and v:GetDist(self) > 200 then
                self:wipeHate(v)
            end
        end
    end
end


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
    end
end