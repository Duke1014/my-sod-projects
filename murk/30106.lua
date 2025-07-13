-- Skirish`ka the Loathing

local hp = 100
local target = nil
local focused = false

function EVENT_ATTACK(self)
	self:text(self:GetName().." screams with seething rage.")
    self:hpTrigger(90)
end

function EVENT_HP(self, other, damage, ratio)
	if ratio == 90 then
		self:text("The air grows thick as Skirish`ka's rage builds.")
        self:hpTrigger(70)
        hp = 90
    elseif ratio == 70 then
		self:text("The air swells as Skirish`ka's rage builds further.")
        self:hpTrigger(10)
        hp = 70
	elseif ratio == 10 then
		self:text("The air sizzles as Skirish`ka's rage climaxes, a terrible growl tears into your thoughts.")
        self:timer("soft_enrage", 2000)
        hp = 10
    end
end

function EVENT_SPELL(self, other, spell, spell_id, resist, mana, damage)
    local random_cast = math.random() * 100
    local random_target = math.random(0,2)
    
    if mana > 200 then
        if hp == 90 then
            if random_cast > 90 then
                self:text("As "..self:GetName().." takes the brunt of "..other:GetName().."'s "..spell..", she twists the magic into an unholy blast back to them!", 13, 300)
                self:cast(918, other)

            elseif random_cast > 40 then
                self:text("As "..self:GetName().." takes the brunt of "..other:GetName().."'s "..spell..", she twists the magic into an unholy blast back to them!", 13, 300)
                self:cast(913, other)
            end

        elseif hp == 70 then
            if random_cast > 80 then
                self:text("As "..self:GetName().." takes the brunt of "..other:GetName().."'s "..spell..", she twists the magic into an unholy blast back to them!", 13, 300)
                self:cast(918, other)
            
            elseif random_cast > 30 then
                self:text("As "..self:GetName().." takes the brunt of "..other:GetName().."'s "..spell..", she twists the magic into an unholy blast back to them!", 13, 300)
                self:cast(913, other)
            end

            if focused == false then
                if random_target == 0 then
                    self:text("Skirish`ka glares at "..other:GetName()..".", 13, 300)
                    target = other
                    focused = true
                    self:timer("glare", 10000, true)

                elseif random_target == 1 then
                    target = find_nearest_target(self)
                    self:text("Skirish`ka trembles, turning her rage to her closest threat, "..target:GetName().."!", 13, 300)
                    focused = true
                    self:timer("glare2", 15000, true)

                elseif random_target == 2 then
                    target = find_furthest_target(self)
                    self:text("Skirish`ka seethes, turning her rage to her farthest threat, "..target:GetName().."!", 13, 300)
                    focused = true
                    self:timer("glare2", 15000, true)
                end
            end
        end
    end
end

function find_nearest_target(self)
    local nearest_target_distance = 10000
    local nearest_target = nil

    for k, v in pairs(self:GetHateList()) do
        if v:IsClient() and v:InZone() and v:IsAlive() then
            if v:GetDist(self) < nearest_target_distance then
                nearest_target = v
                nearest_target_distance = v:GetDist(self)
            end
        end
    end
    return nearest_target
end

function find_furthest_target(self)
    local furthest_target_distance = 0 
    local furthest_target = nil

    for k, v in pairs(self:GetHateList()) do
        if v:IsClient() and v:InZone() and v:IsAlive() then
            if self:GetDist(v) > furthest_target_distance then
                furthest_target = v
                furthest_target_distance = v:GetDist(self)
            end
        end
    end
    return furthest_target
end

function EVENT_TIMER(self, timer)
    if timer == "glare" then
        self:cast(3893, target)
        focused = false

    elseif timer == "glare2" then
        if math.random(4) == 0 then
            self:cast(3892, target)
            focused = false
        else
            self:cast(3891, target)
            focused = false
        end

    elseif timer == "soft_enrage" then
        local max = self:GetStats().maxdamage
        self:set("Damage", max + 150, (max / 2) + 75)
    end
end

function EVENT_COMBATEND(self)
	respawn(54902)
    self:stopAllTimers()
    self:depop()
end

function EVENT_DEATH(self)
    self:stopAllTimers()
	self:text("Skirish`ka's bones convulse violently as she lets out one last shattering scream of rage.")
end