--33213.lua a kaezakhan grunt

-- flag 7120, 1 == You fought/killed Raptor

function EVENT_ATTACK(self, other)
    taunts = {"Finally, a new job! Killing you!", 
            "Who dares invade Kaezul's shipyard?",
            "This sure beats carrying things around all day."}
        
        if other:GetFlag(7120) >= 1 then
            table.insert(taunts, "This is way above my pay grade to deal with you.")
            table.insert(taunts, "I'm only fighting you because we're being watched. I won't go easy on you!")
        end
        
    taunt = taunts[math.random(1, #taunts)]

    self:say(""..taunt.."")
end