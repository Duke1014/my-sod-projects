--33211.lua a kaezulian guardsman

-- flag 7120, 1 == You fought/killed Raptor

function EVENT_ATTACK(self, other)
    taunts = {"You've stepped your last foot in here, "..other:GetRaceName().."!", 
            "Who dares invade Kaezul's shipyard?",
            "I'll have an easy promotion after I'm through with you."}
        
        if other:GetFlag(7120) >= 1 then
            table.insert(taunts, "It's my lucky day, I get to kill the infamous "..other:GetName()..".")
            table.insert(taunts, "Hmm, perhaps Alea-kaz will let me be his right-hand man after killing Raptor's End.")
        end
        
    taunt = taunts[math.random(1, #taunts)]

    self:say(""..taunt.."")
end