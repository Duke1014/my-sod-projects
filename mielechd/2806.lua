-- an annoying gnat (Zzz fight)

-- attacks from this gnat lower other's hate from main guy Zzz. Either fight them on tank and kill fast, or have someone else tank it and suffer.

function EVENT_ATTACK(self)
    self:timer("buzz", 2000, true)
end

function EVENT_TIMER(self, timer)
    if timer == "buzz" then
        customnuke(self, self:GetTarget(), "Gnat Buzz", 200, 0, 0, "You're distracted by the absolutely annoying gnat buzzing.")
        signal(32240, "buzz", self:GetTarget())
        self:timer("buzz", 2000, true)
    end
end

function EVENT_COMBATEND(self)
    self:stopAllTimers()
end

function EVENT_DEATH(self)
    self:stopAllTimers()
end