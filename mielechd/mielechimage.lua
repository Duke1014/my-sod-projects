-- Image of Mielech

function EVENT_SAY(self, other, msg)
    local quest_flag = other:GetFlag(14824)

    self:face(other)

    if quest_flag == 0 then
        if string.find(string.lower(msg), "hail") then
            self:say("You... how... no one is supposed to be here.")
            other:dialog(self, "I had a key from outside.")
            other:dialog(self, "Who or what are you?")
            other:dialog(self, "What is this place?")
        
        elseif string.find(string.lower(msg), "i had a key from outside") then
            self:say("A key? From outside? That is... unexpected. I have not seen anyone for so long. You must be careful, this place is dangerous and not what it once was.")
            other:dialog(self, "Is there anything you remember at all?")
            other:dialog(self, "Who or what are you?")
            other:dialog(self, "What is this place?")

        elseif string.find(string.lower(msg), "who or what are you") then
            self:say("I am... unsure. I was once something, but now I am... this. I think I was created to watch over this laboratory and the halls surrounding it, but I don't remember why, or who created me.")
            other:dialog(self, "Is there anything you remember at all?")
            other:dialog(self, "I had a key from outside.")
            other:dialog(self, "What is this place?")

        elseif string.find(string.lower(msg), "what is this place") then
            self:say("This was once a place of research and experimentation, but now it is a shadow of its former self. I am the only one left to guard it, but I do not know why. I have been here for so long that I have forgotten much of my purpose.")
            other:dialog(self, "Is there anything you remember at all?")
            other:dialog(self, "I had a key from outside.")
            other:dialog(self, "Who or what are you?")

        elseif string.find(string.lower(msg), "is there anything you remember at all") then
            self:say("I remember bits and pieces. I remember the smell of chemicals, the echoes of voices across the halls, and the feeling of purpose. Then, I see a bright flash of light, and then... nothing. I was left here, alone, with only fragments of my past.")
            other:dialog(self, "Does the name Mielech mean anything to you?")

        elseif string.find(string.lower(msg), "does the name mielech mean anything to you") then
            -- increment the quest flag
            self:text("The image beings to slightly glow and flicker, as if trying to remember something.")
            self:say("Mielech... yes, that name resonates with me. ")
        end
    end
end