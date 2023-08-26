--33214.lua a kaezulian volunteer

-- flag 7120, 1 == You fought/killed Raptor

function EVENT_ATTACK(self, other)
    taunts = {"This is not exactly what I volunteered for!", 
            "Who dares invade Kaezul's shipyard?",
            "The children of Ikisith will never fall to you!"}
        
        if other:GetFlag(7120) >= 1 then
            table.insert(taunts, "I didn't expect to be face to face with you, "..other:GetName().."".")
            table.insert(taunts, "Is this the "..other:GetRaceName().." we were told about? You seem much shorter in person!")
        end
        
    taunt = taunts[math.random(1, #taunts)]

    self:say(""..taunt.."")
end