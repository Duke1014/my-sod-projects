--33212.lua a kaezulian devastator

-- flag 7120, 1 == You fought/killed Raptor

function EVENT_ATTACK(self, other)
    taunts = {"After I kill you, I'll have a new pet to play with!", 
            "Who dares invade Kaezul's shipyard?",
            "Don't worry, I'll be sure to harvest all of your parts when we're through."}
        
        if other:GetFlag(7120) >= 1 then
            table.insert(taunts, "This is the "..other:GetRaceName().." they warned us about? No matter, they'll feel the might of Kaezul.")
            table.insert(taunts, "Just because your infamy across Kaezul's land, does not make you immortal. I'll make sure to show you.")
        end
        
    taunt = taunts[math.random(1, #taunts)]

    self:say(""..taunt.."")
end