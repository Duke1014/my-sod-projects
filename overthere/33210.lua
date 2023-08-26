-- 33210 - a Kaezulian furymage

-- flag 7120, 1 == You fought/killed Raptor

function EVENT_ATTACK(self, other)
    taunts = {"I've been waiting for a real target to try this spell on!", 
            "Who dares invade Kaezul's shipyard?",
            "I'll have an easy promotion after I'm through with you."}
        
        if other:GetFlag(7120) >= 1 then
            table.insert(taunts, "You're the one they warned us about? Heh, no matter, you'll be incinerated.")
            table.insert(taunts, "I've always wanted to meet the one who bested Raptor. I'll become legendary today.")
        end
        
    taunt = taunts[math.random(1, #taunts)]

    self:say(""..taunt.."")
end