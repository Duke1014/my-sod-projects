-- The Murk Queen

local hp = 75

function EVENT_ATTACK(self)
	self:text(self:GetName().." opens its gaping, slimey maw and consumes $name in the blink of an eye.")
    self:hpTrigger(hp)
end

function EVENT_HP(self, other, damage, ratio)
	if ratio == 75 or ratio == 50 or ratio == 25 then
		self:text(self:GetName().." releases a rapidly developing larva from within its body.")
		spawn(30018, self, 300)
		hp = hp - 25
    end
end

function EVENT_COMBATEND(self)
	self:respawn()
end

function EVENT_DEATH(self)
    local chance = math.random() * 100
    
    self:text(self:GetName().." collapses into a pool of its own frothing juices, oozing a foul-smelling blood.")

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