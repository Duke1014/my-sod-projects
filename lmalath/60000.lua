-- FRIEND
function EVENT_SPAWN(self)
    links = {}
    self:setSize(50)
    links[1] = "I wish to travel to the Twilight Harbor, please."
end

function EVENT_SAY(self, other, msg)
    if string.find(msg, "Hail") then
        self:text(""..saylink("-- ZONE TO TWILIGHT HARBOR", 1).."")

    elseif string.find(msg, "I wish to travel to the Twilight Harbor, please.") then
        other:zone("dulak", 0, 0, 0)
    end
end

function EVENT_SAYLINK(self, other, id)
	EVENT_SAY(self,other,links[id])
end