-- Kukrika the Midwife 
-- Items
-- 25199 Scrap of Gruplok scales
-- 25200 An Empty Vial
-- 25201 A Vial of Tainted Water

-- Flags
-- 3000 > 6 and 19000 < 1 - Not started "Dark Waters"
-- 19000 is used throughout the quest

function EVENT_SAY(self, other, msg)
    self:face(other)

	if string.find(msg, "Hail") and other:GetFlag(3000) < 7 and other:GetFlag(19000) < 1 then
		self:text(self:GetName().." glares and gathers the younglings closer to herself.")
    end

    if other:GetFlag(3000) == 7 then
        if other:GetFlag(19000) == 0 then
            if string.find(msg, "Hail") then
                self:say("Hello...")
                dialog(other, self, "You look after the newborn Gruploks?")

            elseif string.match(msg, "You look after the newborn Gruploks") then
                self:say("Yes. Dangers abound for our young from the moment they are laid... Even the water is becoming unsafe.")
        		-- dialog(other, self, "What kind of dangers?")
                dialog(other, self, "What is wrong with the water?")
            
            -- elseif string.match(msg, "What kind of dangers") then
            --     self:say("There are so many... but the some of the beasts in the wild target the younglings in particular. They say there was a time when our people could roam the wilds with little worry, and children could play in the murkwaters on the outskirts of the city. But those days are gone. I can't let any of these children out of my sight: if they were to enter the outer murkwaters for even a moment they would be attacked and have their life sucked out of them in moments by a mindless szithri, or be captured by a murk leech to be whisked away and devoured by one of their spawnmothers - or worse.")
            --     dialog(other, self, "Is there anything that can be done about it?")
            
            -- elseif string.match(msg, "Is there anything that can be done about it") then
            --     self:say("I have no hope that the wilds can be made safe again - the beasts are countless, and ever more are being born. But, left unchallenged, they are becoming more aggressive, and creeping closer and closer to the nursery... I fear that even with the best efforts of Grathrik and the other sentries, the beasts would still capture some of our young if they ever attacked in numbers. Any scavengers that you can keep away from the city will leave our young that much safer. I will be happy to hear of any number of them slain.")
            
            -- Start of Dev-Omi Quest "Dark Waters"	
            elseif string.match(msg, "What is wrong with the water?") then
                self:say("The younglings won't go near the deeper water, some have even fallen ill. We're not sure what has come over them, they can barely crawl and don't want to eat.")
                dialog(other, self, "Has anything happened recently?")
            
            elseif string.match(msg, "Has anything happened") then
                self:say("The waters where the children play have become an ill color, almost black.")
                dialog(other, self, "Can you show me?")
            
            elseif string.match(msg, "Can you show me?") then
                self:say("I cannot leave the children unattended, if you travel north west to the island of the tree columns.  You may find a clue to what might be happening.")
                dialog(other, self, "I'll go take a look.")
            
            elseif string.match(msg, "I ll go take a look.") then
                self:say("Be wary " .. other:GetName() .. ", these are dangerous swamps and there is more to fear than just the animals.")
                other:journal("Dark Waters", 0, "Kukrika thinks something in the water may be harming the children.  The answer I seek is in the swamp, Kukrika mentioned the inlets origin to the North West maybe I'll start there.")
            end    
            
        elseif other:GetFlag(19000) == 1 then
            if string.find(msg, "Hail") then
                self:say("I told you it can only get worse, but if you're that foolish to seek answers, I will try to help where I can.");
                dialog(other, self, "I want answers.")
            
            elseif string.match(msg, "I want answers") then
                self:say("I wonder if all your kind are this foolish, so willing to get yourself killed trying to help others. If you are seeking answers, go get a sample of the water and take it to Healer Kathrinka. She is on the topmost platform above the swamp. Maybe she has seen something like it before.  You must find the source to get a pure sample, look near where you found this scale, my hunch is that island has the answers we seek.")
                other:giveItem(25200)
                other:setFlag(19000, 2)
                self:say("Take this vial and hurry, the younglings are getting worse by the minute.  If you lose your vial come back to me and I'll try to find another.")
                other:journal("Dark Waters", 1, "Kukrika wants me to get a sample of the blackish water to give to Healer Kathrinka.")
            end
        
        elseif other:GetFlag(19000) == 2 then
            if string.find(msg, "Hail") then
                self:say("Did you lose your vial? Are you even worth my time?")
                dialog(other, self, "I lost my vial.")
                dialog(other, self, "No, I will get what you asked for.")
            
            elseif string.match(msg, "I lost my vial") then
                other:giveItem(25200)
                self:say("Hurry "..other:GetName()..", we are already raising suspicion.")
            
            elseif string.match(msg, "No, I will get what you asked for") then
                self:say("Hurry "..other:GetName()..", we are already raising suspicion.")
            end

        elseif other:GetFlag(19000) == 3 then
            if string.find(msg, "Hail") then
                self:say("I see you have done what you said you would.  Now please do as I asked and take the vial to Healer Kathrinka. She is the only one who can tell us what it is.")
            end

        elseif other:GetFlag(19000) == 10 then
            if string.find(msg, "Hail") then
                self:say("They are getting worse "..other:GetName()..".  I hope you have found something that might help.")
            end
        elseif other:GetFlag(19000) == 11 then
            if string.find(msg, "Hail") then
                self:say("Thank you "..other:GetName()..", we will never forget what you have done for us.")
                self:text(self:GetName().." points towards you and the younglings swim around you frantically.")
            end
        end
    end
end

function EVENT_ITEM(self, other, item)
    if other:GetFlag(3000) == 7 then
        if item(25199) > 0 then
            item:keep(25199, 1)
            other:setFlag(19000, 1)
            self:text("What have you found "..other:GetName().."? Let me take a closer look.' Kukrika examines the scales and begins to look frightened. Kukrika speaks, 'You shouldn't look into this any further, these feel like Gruplok scales, but they are the wrong color. Gruplok scales are only green.  I'm afraid this can only get worse if we get keep meddling. Someone from our own tribe may be behind this.")
            self:face(other)
            other:giveExp(100, 0)
        
        elseif item(25201) > 0 and other:GetFlag(19000) == 4 then
            item:keep(25201, 1)
            self:say("This..  I recognize this.  Oh, we may as well give up hope if our future rests with that abandoner.  Oh, Githpick.  Never a good bone in his body.'  She stops to write a note.  'Give this to him, "..other:GetName()..", and maybe he will see reason.  He's our only chance.'", 100, other)
            other:giveItem(25202, 1)
            other:setFlag(19000, 5)
            other:journal("Dark Waters", 3, "Apparently, this illness is Githpick's fault.  Hopefully Kukrika's note will help him see reason.")
        
        elseif item(25205) > 0 and other:GetFlag(19000) == 10 then
            item:keep(25205, 1)
            self:say("Githpick gave this to you, normally I wouldn't trust him, but at this point what choice do we have?' Kukrika pours some of the ointment on to her hand and begins to rub down the younglings.  Immediately they start hopping around and croaking loudly. Kukrika speaks, '" .. other:GetName() .. " I can't thank you enough for saving them, if there are more of your kind out there that are this brave, maybe there is a small chance of hope.  Take this, its not much, but maybe you will find a use in your adventures.", 100, other)
            other:giveItem(25206, 1)
            other:setFlag(19000, 11)
            other:giveFaction(600, 34)
            other:giveExp(25000, 0)
            other:journal("Dark Waters", 100, "I never thought I would run around in a foul smelling, mosquito infested swamp helping frogs, but I am growing fond of them almost pity.  Maybe there is something more I can do, no one deserves what they have been through.")
        end
    end
end
	
function EVENT_ATTACK(self)
	self:say("No!")
end

function EVENT_DEATH(self)
	self:say("Children... forgive me.")
end