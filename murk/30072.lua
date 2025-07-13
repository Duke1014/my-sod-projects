-- a fungal overgrowth

function EVENT_ATTACK(self, other)
	self:text("The swampgrass rises to meet a fungal overgrowth's feet as it bounds towards "..other:GetName()..".")
    self:hpTrigger(90)
end

function EVENT_COMBATEND(self)
	self:set("abilities", "0 0")
end

function EVENT_HP(self, other, damage, ratio)
	if ratio == 90 then
		self:text(self:GetName().." calls the swamp itself to its aid.")
		self:cast(3294, self:GetTarget(), 1000)
		self:set("abilities", "3294 30")
    end
end

function EVENT_DEATH(self, other)
    if other:IsClient() and other:InZone() then
        local chance = math.random() * 100
        self:text("The surrounding swampgrass bristles momentarily, then calms again as a fungal overgrowth collapses into the earth.")
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