--33216.lua a kaezulian private

-- flag 7120, 1 == You fought/killed Raptor

function EVENT_ATTACK(self, other)
    taunts = {"Please, I'd rather just go back to work!", 
            "Could we just go back to training drills?",
            "I didn't ask to be stationed here, now this is where I'm going to die?"}
        
        if other:GetFlag(7120) >= 1 then
            table.insert(taunts, "Wait, is that "..other:GetName().."? Why send us after them, we're done for!")
            table.insert(taunts, "But I've barely passed my training! How am I supposed to fight "..other:GetName().."?!")
        end
        
    taunt = taunts[math.random(1, #taunts)]

    self:say(""..taunt.."")
end

function EVENT_SPAWN(self)
    if self:GetY() > 2334 and self:GetY() < 2369 then
        training = true
        if _G.Zeke then
            animations = {1, 2, 3, 4, 5, 6, 7, 8, 11, 45, 46, 47}
            a = animations[math.random(1, #animations)]
            self:timer("exercise", 6000)
        end
    end
end

function EVENT_TIMER(self, timer)
    if timer == "exercise" then
        self:doAnim(a)
    end
end

function EVENT_SIGNAL(self, signal)
    if signal == "exercise" then
        if training == true then
            self:timer("exercise", 6000)
        end
    end
end