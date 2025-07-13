-- Sentinel Lieutenant Druek
-- Quest guy for SHD/ROG/NEC

function EVENT_SPAWN(self)
    self:setWeapon(60147, 7)
end

function EVENT_SAY(self, other, msg)
    flag = other:GetFlag(42523)
    
    local gender = "friend"
    if other:GetGender() == 0 then
        gender = "brother"
    elseif other:GetGender() == 1 then
        gender = "sister"
    end

    if string.find(msg, "Hail") and (other:GetClass() == 1 or other:GetClass() == 2 or other:GetClass() == 3 or other:GetClass() == 7 or other:GetClass() == 8 or other:GetClass() == 10 or other:GetClass() == 12) then
        if other:GetRace() == 330 then
            self:say("Hail, "..gender..". Malath's embrace watch over you. While we are in need of assistance, I'm sure the work we have here may not be suited for what you are comfortable with as a "..other:GetClassName()..". May we strike our oppressors down soon.", 100, other)
            dialog(other, self, "Who are you?")

        else
            self:say("Hail, traveler. Malath's embrace watch over you. Unfortunately you are currently of no use to His vision.", 100, other)
            dialog(other, self, "Who are you?")

        end

    elseif other:GetClass() == 5 or other:GetClass() == 9 or other:GetClass() == 11 then -- SHD, ROG, NEC, any race
        if flag == 0 then
            if string.find(msg, "Hail") then
                self:say("Hail to you, friend. I seek like-minded individuals to help us protect Malath's home. While we've been thrusted from His lands of magic, our work has not ended as we rebuild our home and add upon it. That said, we're currently facing opposition from our task. Are you willing to help us? A reward for your efforts will be given.", 100, other)
                dialog(other, self, "I am up for the task.")
                dialog(other, self, "Who are you?")

            elseif string.find(msg, "I am up for the task") then
                self:say("Excellent. First, I want you to prove your resolve to the Mavassi. On the shores of this island, there are sea turtles that have managed to make their way in our great home. Slaughter them.", 100, other)
                dialog(other, self, "[GOOD] Are you sick in the head? That seems cruel.")
                dialog(other, self, "[EVIL] Sounds like turtle soup is on the menu today!")
                dialog(other, self, "Oh. I like turtles.")

            elseif string.find(msg, "Are you sick in the head") then
                self:say("They offend me. Prove yourself to me and I will have a true task for you. Be sure to kill about 5 hatchlings and 2 full grown turtles.", 100, other)
                other:addAlignment("Good", 1)
                other:journal("Proving Myself to Malath", 1, "Druek, the lieutenant of the Sentinels, asked me to kill five hatchlings and two full grown turtles on the shore of Leaga Malath.")
                other:setFlag(42523, 1)

            elseif string.find(msg, "Sounds like turtle soup") then
                self:say("I do love a hot shell full of turtle soup! Prove yourself to me and I will have a true task for you. Be sure to kill about 5 hatchlings and 2 full grown turtles.", 100, other)
                other:addAlignment("Evil", 1)
                other:journal("Proving Myself to Malath", 1, "Druek, the lieutenant of the Sentinels, asked me to kill five hatchlings and two full grown turtles on the shore of Leaga Malath.")
                other:setFlag(42523, 1)

            elseif string.find(msg, "I like turtles") then
                self:say("I do too, but I want to prove yourself to me and I will have a true task for you. Be sure to kill about five hatchlings and two full grown turtles.", 100, other)
                other:journal("Proving Myself to Malath", 1, "Druek, the lieutenant of the Sentinels, asked me to kill five hatchlings and two full grown turtles on the shore of Leaga Malath.")
                other:setFlag(42523, 1)

            end

        elseif flag == 1 then
            hatchling = other:GetFlag(42524)
            turtle = other:GetFlag(42525)

            if string.find(msg, "Hail") then
                if turtle == 2 and hatchling == 5 then
                    self:say("Most people don't have the stones to do what you've done. Here's something for your troubles; I deem you worthy of our mission, and I have another for you to aid our cause.", 100, other)
                    dialog(other, self, "I am ready for another task.")
                    dialog(other, self, "Who are you?")
                    other:setFlag(42523, 2)
                    other:giveItem(60145)
                    other:giveExp(1000)

                else
                    self:say("Have you slaughtered the turtles yet?", 100, other)

                end
            end

        elseif flag == 2 then
            if string.find(msg, "Hail") then
                self:say("Welcome back, "..gender..". You've proven yourself worthy of our mission, and I have another for you to aid our cause.", 100, other)
                dialog(other, self, "I am ready for another task.")
                dialog(other, self, "Who are you?")
            
            elseif string.find(msg, "I am ready for") then
                self:say("Good, because we need more bloodshed from you. Since our barrier had broken around Leaga Malath, our Twilight Harbor has been infiltrated slowly by pirates. While we've done plenty to slow this down, more of these scum have come, and now they have an army. I want you to kill fifty of these scallywags and thin out their leaders. Be sure to cull at least 5 of their captains as well. Come back after you've finished.", 100, other)
                other:journal("Proving Myself to Malath", 2, "Druek wants me to travel to the Twilight Harbor nearby the city of Leaga Malath and kill fifty pirates and five of their captains. I have a feeling there will be plenty of them to kill for myself.")
                other:setFlag(42523, 3)
                other:setFlag(42524, 0)
                other:setFlag(42525, 0)

            end

        elseif flag == 3 then
            if string.find(msg, "Hail") then
                if other:GetFlag(42524) == 50 and other:GetFlag(42525) == 5 then
                    self:say("Splendid! That's the look of a "..other:GetRaceName().." after a bloody battle! The revivifier's now have plenty of corpses to practice raising the dead, and for that I give you a ring of service. You've certainly killed your fill of pirates, but now I have one last task for you.", 100, other)
                    dialog(other, self, "What is left for me?")
                    other:setFlag(42523, 4)
                    other:giveItem(60146)
                    other:giveExp(5000)

                else
                    self:say("Have you killed your fifty pirates and five captains? We need their numbers down to get back to the task at hand.", 100, other)        

                end    
            end
        
        elseif flag == 4 then
            if string.find(msg, "Hail") then
                self:say("You've done a lot for us, but I have one last task for you.", 100, other)
                dialog(other, self, "What is left for me?")

            elseif string.find(msg, "What is left for") then
                self:say("Our scouts have reported that a so-called 'pirate lord' has stumbled upon one of Malath's relics deep within the cave near Twilight Harbor. No matter what their intentions with this relic, the Master's belongings must not be disturbed. End this pirate lord to put this silly seadog scandal to rest.", 100, other)
                other:setFlag(42523, 5)
                other:journal("Proving Myself to Malath", 3, "Druek says there is a so-called 'pirate lord' messing with Malath's belongings. Whether this pirate lord happens to only be plundering, it's probably a bad idea to let a previous god's belongings to some random mortal, so I must be off to stop them.")

            end

        elseif flag == 5 then
            if string.find(msg, "Hail") then
                self:say("Off with you until you end that pirate lord, posthaste!", 100, other)

            end

        elseif flag == 6 then
            self:say("We've gotten reports from Mavassi scouts, well done, "..other:GetName().."! I would like to make you an honorary Sentinel. Use this with pride, and may the Master's embrace protect you on your travels.")
            other:giveItem(60147)
            other:giveExp(10000)
            other:setFlag(42523, 100)
            other:journal("Proving Myself to Malath", 100, "I successfully halted the pirate invasion in Twilight Harbor.")
        end
    
    end

    if string.find(msg, "Who are") then
        self:say("I am Druek, Lieutenant of Malath's Sentinels, sworn protectors and scouts of the Mavassi. My station here is to train our bretheren to join our ranks as we're in need of scouts, protectors, and masters of life and death.", 100, other)
        dialog(other, self, "What is the Mavassi?")

    elseif string.find(msg, "What is the") then
        self:say("First, I must speak of the Inquisition of Malath. I was once a member of this group in Faski Malath... many years ago. It feels as though time has gone on forever since I helplessly watched Malath's end. After His land fell to the akhevans, we rebuilt as much as we could here, but it was just us and the Mavassi, Malath's scouts. We joined forces to reach our goals: regrow our army, revive Malath, and take revenge on those backstabbing akhevans.", 100, other)
        dialog(other, self, "Regrow your army?")
        dialog(other, self, "Revive Malath? Hasn't that been attempted before?")
        dialog(other, self, "Fight the akhevans? One simply does not walk into the Mansion of Portals and slaughter a race of dimension-warping beings.")

    elseif string.find(msg, "Regrow your army") then
        self:say("I lost many soldiers... friends, fighting against the Eternal Empress. I don't know where she got such immense power, but it was too much for us. All of the citizens you see here have fought and lived to tell the tale. Some lost their faith in Althuna, others only strengthened their resolve to defeat the akhevans, many have died on impact of this world. Every day is a living nightmare. Fortunately, some have been able to harness that nightmare's power and join the ranks of the Lucidites.", 100, other)
    
    elseif string.find(msg, "Revive Malath") then
        self:say("We've been working on ways to bring our Master back, no matter the cost. Some of our forces have tossed aside their wizardly and clerical studies and began to use death as a means to life, calling themselves the Revivifiers. As for these past attempts, what do you mean?", 100, other)
        dialog(other,self, "The Ysthar have made attempts on reviving Malath already. This isn't the only part of your Lands of Magic; many adventurers have lived to see what lies in Cyrtho Malath.")
    
    elseif string.find(msg, "Fight the akhevans") then
        self:say("You underestimate the resolve of the Mavassi, "..other:GetRaceName()..". Already since the burst of the Master's protection spell around this land, our best scouts of the Sentinels are looking for any and all information to destroy these fiends. Hopefully, for good.", 100, other)
    
    elseif string.find(msg, "The Ysthar have made attempts on reviving Malath already") then
        self:text("Druke hangs his head in deep thought.", 8)
        self:say("So we've run out of time...", 100, other)
        self:say("No. This is only the beginning. I will not let this cursed time bubble be what has kept us from our Master. We will do more than what the Ysthar can. We MUST. Damn the empress, damn those wretched snakes! We will get our true home back, I swear this to you, "..gender.."!")

    end
end