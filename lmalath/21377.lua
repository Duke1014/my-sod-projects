-- Captain Spak
-- Hail her to get to Sundered Mountains or Oasis

function EVENT_SPAWN(self)
    links = {}

    links[1] = "I wish to travel to the Sundered Mountains, please."
	links[2] = "I wish to travel to the Oasis, please."
end

function EVENT_SAY(self, other, words)
    if string.find(words, "Hail") then
        other:text(""..self:GetName().." says, 'Ho, there! If you be need'n travel to "..saylink("Sundered Mountains",1)..", right this way! Otherwise, we be stoppin' by "..saylink("the Oasis",2)..".'", 0, true)
        self:face(other)

    elseif string.find(words, "I wish to travel to the Sundered Mountains, please.") then
        other:text(""..self:GetName().." says, 'Hop on board, we be leavin' shortly!'", 0, true)
        other:zone("sundermtns", -1550, -4066, -377, 0)

    elseif string.find(words, "I wish to travel to the Oasis, please.") then
        other:text(""..self:GetName().." says, 'Hop on board, we be leavin' shortly!'", 0, true)
        other:zone("oasis", -822, 883, 0, 64)

    end
end

function EVENT_SAYLINK(self, other, id)
	EVENT_SAY(self,other,links[id])
end
