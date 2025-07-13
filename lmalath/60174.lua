-- a Leaga citizen

function EVENT_SAY(self, other, msg)
    if string.find(msg, "Hail") then
        self:say("Welcome, "..other:GetRaceName()..". Malath's embrace protect you. What can I do for you?", 100, other) 
        dialog(other, self, "What is this city?");
        dialog(other, self, "What sights are there to see around here?");
        dialog(other, self, "Where do I go if I want to wet my throat?");
        dialog(other, self, "Where do I go to have some fun in this city?");
        dialog(other, self, "Where can I go to stock up on supplies?");
        dialog(other, self, "Where can I find work?");
        dialog(other, self, "What methods of travel are available here?");
        dialog(other, self, "What are the latest rumors?");

    elseif string.find(msg, "What is this") then
        self:say("This is Leaga Malath, fallen from our Master's plane. His embrace kept us safe from the harm of the dreaded Akhevans. We've been here for... longer than we can remember.", 100, other) 

    elseif string.find(msg, "What sights are there to see") then
        self:say("There is not much on our land for sightseeing, just the remnants of our sacred land.", 100, other) 

    elseif string.find(msg, "Where do I go if I want") then
        self:say("We have food and water in town, seek out the siblings, Blovik and Jobok.", 100, other) 

    elseif string.find(msg, "Where do I go to have some") then
        self:say("Fun? The only fun we have here is preparing for our Master's return and training to be his hand of vengeance.", 100, other) 

    elseif string.find(msg, "Where can I go to stock") then
        self:say("Seek out our supply master in town, Roonim. You will find everything needed to take on your journey.", 100, other) 

    elseif string.find(msg, "Where can I find") then
        self:say("Seek out the commissioner in town, he has mundane tasks needed to be done in the Master's name.", 100, other) 

    elseif string.find(msg, "What methods of travel are available") then
        self:say("In the castle, fort and lighthouse to the North, you will find small portals to get around this land faster. We've heard there is a boat to make way towards Malath's other holy lands.", 100, other) 

    elseif string.find(msg, "What are the latest") then
        self:say("Rumors? If there is something you don't know about anyone here, "..other:GetRaceName()..", it's for a reason.", 100, other) 

    end
end


