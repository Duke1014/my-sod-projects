-- mavassi revivifier
-- stationed around portals in Leaga Malath

local location

function EVENT_SPAWN(self)
    if self:GetY() > 1350 then
        location = "lighthouse"

    elseif self:GetY() > -1800 and self:GetY() < -1700 then
        location = "fort"

    elseif self:GetY() < -3000 then
        if self:GetX() > 2650 then
            location = "castle1"
        else
            location = "castle2"
        end
    end
        
end

function EVENT_SAY(self, other, msg)
    if string.find(msg, "Hail") then
        self:say("Hail to you, friend. I am a revivifier, once master and keeper of the art for Malath. While we've turned to necromantic ways to fulfill our destiny, some of us still regularly use our more wizardly power to help those in need. If you ever so need quick transportation around our home, feel free to use the portals here to travel faster to the castle, fort, town, and lighthouse.", 100, other)
        dialog(other, self, "How do I get to the castle?")
        dialog(other, self, "How do I get to the fort?")
        dialog(other, self, "How do I get to the lighthouse?")
        dialog(other, self, "How do I get to the town?")
        dialog(other, self, "What is a revivifier?")

    elseif string.find(msg, "How do I get to the castle?") then
        if location == "lighthouse" then
            self:say("You will want to step into the portal that is closer to my keeper friend here! You'll be taken into our inner-most room of the castle.", 100, other)
        elseif location == "fort" then
            self:say("You will want to step into the portal to my left, that is next to this beer bottle. Not sure why it's here, but someone had left a mess...", 100)
        else
            self:say("Why you're already here! Did you have another location in mind?")
        end
        dialog(other, self, "How do I get to the fort?")
        dialog(other, self, "How do I get to the lighthouse?")
        dialog(other, self, "How do I get to the town?")

    elseif string.find(msg, "How do I get to the fort?") then
        if location == "lighthouse" then
            self:say("You will want to step into the portal in front of me!", 100, other)
        elseif location == "castle1" then
            self:say("You will want to step into this portal here!", 100, other)
        elseif location == "castle2" then
            self:say("You will want to go to the portal on the other side of the room.", 100, other)
        else
            self:say("Why you're already here! Did you have another location in mind?")
        end
        dialog(other, self, "How do I get to the castle?")
        dialog(other, self, "How do I get to the lighthouse?")
        dialog(other, self, "How do I get to the town?")

    elseif string.find(msg, "How do I get to the lighthouse?") then
        if location == "fort" then
            self:say("You will want to go into the portal on my right!", 100)
        elseif location == "castle1" then
            self:say("You will want to go to the portal on the other side of the room.", 100, other)
        elseif location == "castle2" then
            self:say("You will want to step into this portal here!", 100, other)
        else
            self:say("Why you're already here! Did you have another location in mind?")
        end
        dialog(other, self, "How do I get to the castle?")
        dialog(other, self, "How do I get to the fort?")
        dialog(other, self, "How do I get to the town?")

    elseif string.find(msg, "How do I get to the town?") then
        if location == "castle1" or location == "castle2" then
            self:say("You will want the portal next to the fort portal, off to the side.")
        elseif location == "fort" then
            self:say("You will want the portal behind this training equipment here.")
        elseif location == "lighthouse" then
            self:say("You will want the portal behind my keeper friend! Don't be shy, we use this one quite often.")
        end
        dialog(other, self, "How do I get to the castle?")
        dialog(other, self, "How do I get to the fort?")
        dialog(other, self, "How do I get to the lighthouse?")

    elseif string.find(msg, "What is a revivifier?") then
        self:say("We are part of an order of keepers that witnessed the fall of the Master. While some have kept at the arts, others like myself have trained in necromancy in order to bolster the power of the Mavassi, while finding a way to bring back the Master. A wild thought, I know, but He's done the impossible to give us life, it only seems right to do the same for Malath.", 100, other)
    end
end