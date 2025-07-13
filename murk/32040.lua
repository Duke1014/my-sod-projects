-- Widow Kistulka

function EVENT_SAY(self, other, msg)

    self:face(other)

    if other:GetFlag(3000) == 7 then
        if string.match(string.lower(msg), "hail") and other:GetFlag(14001) < 10 then
            self:say("I can't take it anymore! I can't take it ANYMORE! I can't!")
            self:text(self:GetName().." sobs and buries her face in her arms.")
            dialog(other, self, "What's wrong?  What can I do to help?")
                
        elseif string.match(string.lower(msg), "what s wrong") and other:GetFlag(14001) < 10 then
            self:say("I have to know where he is! I can't live here while he's still out there.. while what's left of him... I'll run! Run after him into the swamp! I can't!")
            dialog(other, self, "Who? Who is missing?")

        elseif string.match(string.lower(msg), "who  who is missing") and other:GetFlag(14001) < 10 then
            self:say("Missing? No.. missing? Yes, maybe missing, but no he's dead, dead and gone. Oh, I can't bear to... Ah!")
            self:text(self:GetName().." bursts into sobs and thrusts a crumpled piece of paper into your hands.")
            other:giveItem(41004, 1)
            other:setFlag(14001, 10)
            dialog(other, self, "Does this have to do with your husband?")

        elseif string.match(string.lower(msg), "husband") then
            self:say("Oh my poor, poor Grolklat. They killed him! Killed him and threw his bones away and my only memory of him this vile leaflet! It's not right! They flood the city with these leaflets and leave his bones in the swamp! His bones out there alone! Oh he's dead! Dead and his bones lost forever! Please! Please help!")
            dialog(other, self, "You want me to find his bones?")

        elseif string.match(string.lower(msg), "you want me to find his bones") then
            self:say("Oh, find them! Find them! Return him to me! And take that wretched piece of paper from my sight!")
            other:journal("Widow's Lament", 1, "The widow Kistulka is looking for her late husbands bones. Chances are slim of finding them all while on my travels in The Murk, but maybe finding at least three parts will suffice.")
        end
    else
        self:text(self:GetName().." stares into the distance, clutching a tattered leaflet.")
    end
end

function EVENT_ITEM(self, other, item, coin)
	if item(41000) > 0 and item(41001) > 0 and item(41002) > 0 then
		other:giveExp(5000, 0)
		other:giveFaction(600, 50)
		item:keep(41000, 1)
		item:keep(41001, 1)
		item:keep(41002, 1)
		self:say("Oh my poor Grolklat.  Oh my poor, poor Grolklat that's all that's left of you.  Oh, why?  Oh, thank you.  My poor, sweet Grolklat.")
        other:journal("Widow's Lament", 100, "I've found the bones of Widow Kistulka's late husband.")
		other:setFlag(14001,14)
    end
end