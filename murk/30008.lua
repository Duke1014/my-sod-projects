-- Krinaka the Poetess

function EVENT_SAY(self, other, msg)
    local hail = string.match(msg, "Hail")
    local poetry_quest = other:GetFlag(3018)
    self:face(other)

    if other:GetFlag(3000) == 7 then
        if poetry_quest == 0 then
            if hail then
                self:text("Krinaka hums to herself absently. She doesn't seem to notice you.")
                dialog(other, self, "Uh, hello?")

            elseif string.match(msg, "Uh  hello") then
                self:say("Oh... Hello there. You're the one Grupruk was talking about when he came to town recently, aren't you?")
                other:setFlag(3018, 1)
                dialog(other, self, "Yeah, that's me.")
            end

        elseif poetry_quest == 1 then
            if hail or string.match(string.lower(msg), "yeah  that s me")then
                self:say("Hmm. You're an adventurer, right? You must have quite a few interesting stories to tell.")
                dialog(other, self, "Well, I suppose so. Why do you ask?")
                dialog(other, self, "[CHAOTIC] You bet I do! You wouldn't believe half the stuff I've pulled off. Why do you ask?")
                dialog(other, self, "[LAWFUL] I do what must be done... Why do you ask?")    

            elseif string.match(string.lower(msg), "i suppose so") then
                self:say("Oh, well... I suppose it might seem silly, but I love telling stories. Especially the kind of stories that can inspire others... or at least take their mind off of their troubles, for a little while. We Gruploks have a long tradition of storytelling, going all the way back to the myths of our forgotten ancestors. But, these days... People around here don't care much for stories, anymore. The myths are slipping out of memory, and the stories of Gruthluk routing grandiose beasts seem out of touch with the reality of not even being able to venture out into our own swamp for fear of being eaten. Hardly anyone listens to the stories anymore...")
                other:setFlag(3018, 2)
                dialog(other, self, "Are stories really so important, considering what your people have to go through every day?")

            elseif string.match(string.lower(msg), "you bet i do") then
                self:say("Oh, well... I suppose it might seem silly, but I love telling stories. Especially the kind of stories that can inspire others... or at least take their mind off of their troubles, for a little while. We Gruploks have a long tradition of storytelling, going all the way back to the myths of our forgotten ancestors. But, these days... People around here don't care much for stories, anymore. The myths are slipping out of memory, and the stories of Gruthluk routing grandiose beasts seem out of touch with the reality of not even being able to venture out into our own swamp for fear of being eaten. Hardly anyone listens to the stories anymore...")
                other:setFlag(3018, 2)
                other:addAlignment("Chaotic", 1)
                dialog(other, self, "Are stories really so important, considering what your people have to go through every day?")

            elseif string.match(string.lower(msg), "i do what must be done") then
                self:say("Oh, well... I suppose it might seem silly, but I love telling stories. Especially the kind of stories that can inspire others... or at least take their mind off of their troubles, for a little while. We Gruploks have a long tradition of storytelling, going all the way back to the myths of our forgotten ancestors. But, these days... People around here don't care much for stories any more. The myths are slipping out of memory, and the stories of Gruthluk routing grandiose beasts seem out of touch with the reality of not even being able to venture out into our own swamp for fear of being eaten. Hardly anyone listens to the stories anymore...")
                other:setFlag(3018, 2)
                other:addAlignment("Lawful", 1)
                dialog(other, self, "Are stories really so important, considering what your people have to go through every day?")

            end

        elseif poetry_quest == 2 then
            if hail or string.match(string.lower(msg), "are stories really so important") then
                self:say("Absolutely! Without stories to inspire them, how will they have hope? How will they look to the future without a story to show them the way? How will they fight for what they have lost if they can't remember the way things once were? How will they understand the sacrifices they must make if they don't realize all the sacrifices that have been made by those who came before them? Without stories - how will they live?")
                dialog(other, self, "Okay, I see your point. What's the problem, then?")

            elseif string.match(string.lower(msg), "what s the problem  then") then
                self:say("Well, like I said, hardly anyone listens to the old myths any more. Many have such trouble accepting the surface action of the old myths that the deeper meaning no longer touches them... Furthermore, I must admit that I have trouble finding inspiration in this place, myself. I need a new story, but I can hardly think of what I could say to inspire others... Any plot borrowed from the stalwart myths would be too recognizable, even as they slowly fade from memory. What I need is something real to latch on to - something simple, maybe, something that isn't so grandiose as to be detached from our situation, yet something that reminds us of what we have merely forgotten about ourselves. We live in such fear, now... Hardly anyone would remember that, however much we warn our children to flee from them, the szithri are simply overgrown pests, hardly a nuisance to the Gruplok hunters of old...")
                dialog(other, self, "Hmm. You know, I could probably kill a couple dozen Szithri without too much trouble.")

            elseif string.match(string.lower(msg), "i could probably kill a couple dozen szithri") then
                self:say("Really? Hmmm... Maybe--maybe I could tell a story about you? Not about your exploits in your lands - I doubt you could say much that we could understand of your home, or believe - but maybe about your exploits in OUR lands? Your name has spread through the town quite quickly, ever since Grupruk came with your gifts to us... Perhaps my people *could* believe you if you kill two dozen Szithri. Some Gruploks keep their eyes out toward the vast reaches of the swamp, myself included. Maybe if I told them to keep an eye out, they would see you as you hunt the dreaded Szithri! Between your skill and a witness, perhaps the Gruploks really will remember that the Szithri are mere pests, not invincible horrors! Tell me, were you not boasting? Would you really be up to slaying two dozen Szithri?")
                dialog(other, self, "Sure, it shouldn't be a problem.")
                dialog(other, self, "On second thought...")

            elseif string.match(string.lower(msg), "on second thought") then   
                self:text("A sparkle seems to fade from Krinaka's eyes, 'Oh... That is unfortunate. Well, if you change your mind...'")
                other:setFlag(3018, 3)
                    
            elseif string.match(string.lower(msg), "it shouldn t be a problem") then
                self:say("Oh, that's great! I'll be keeping my eyes out, and I'll tell some of the others to do the same. Come back and talk to me when you've slain the full two dozen! Who knows, if you can really do it... maybe some young Gruplok will find the strength to follow in your footsteps.")
                other:setFlag(3018, 4)
                other:journal("Feats of Poetry", 1, "Krinaka the Poetess has asked me to slay two dozen Szithri in the swamp, so that she will have a true story of strength and perseverence to tell her fellow Gruploks.")            
            end

        elseif poetry_quest == 3 then
            if hail then
                self:say("Oh, "..other:GetName()..". Have you changed your mind? Do you think you can really slay two dozen Szithri, so that I can write a story about it?")
                dialog(other, self, "Sure, it shouldn't be a problem.")
                dialog(other, self, "Er... I don't think so.")
                
            elseif string.match(string.lower(msg), "i don t think so") then
                self:text(self:GetName().." sighs.")
                
            elseif string.match(string.lower(msg), "it shouldn t be a problem") then
                self:say("Oh, that's great! I'll be keeping my eyes out, and I'll tell some of the others to do the same. Come back and talk to me when you've slain the full two dozen! Who knows, if you can really do it... maybe some young Gruplok will find the strength to follow in your footsteps.")
                other:setFlag(3018, 4)
                other:journal("Feats of Poetry", 1, "Krinaka the Poetess has asked me to slay two dozen Szithri in the swamp, so that she will have a true story of strength and perseverence to tell her fellow Gruploks.")
            end

        elseif poetry_quest == 4 then
            if hail then
                self:say("Oh! Back so soon, "..other:GetName().."?")
                dialog(other, self, "How many Szithri have I killed so far?")
                if other:GetFlag(3026) > 0 then
                    dialog(other, self, "You know, that wasn't so hard. I could probably kill lots more swamp creatures. It'd make for a better story, right?")
                end

            elseif string.match(string.lower(msg), "how many szithri have i killed") then
                self:say("I believe you've killed "..other:GetFlag(3020).." Szithri since we've started keeping count.")
                if other:GetFlag(3020) > 23 then
                    dialog(other, self, "I have slain two dozen Szithri!")
                end

            elseif string.match(string.lower(msg), "i have slain two dozen szithri") and other:GetFlag(3020) > 23 then
                self:say("So you have, "..other:GetName().."! I can't wait to tell the story of the Slayer of the Vile Szithri to the others! Thank you for doing this.")
                other:giveExp(1200, 0)
                other:giveFaction(600, 5)
                other:setFlag(3026, 1)
                dialog(other, self, "You know, that wasn't so hard. I could probably kill lots more swamp creatures. It'd make for a better story, right?")

            elseif string.match(string.lower(msg), "i could probably kill lots more swamp creatures") and other:GetFlag(3026) > 0 then
                self:say("That would be marvelous! Hmm. Well, less Szithri to plague us is always good, but how about some of those pernicious murkling leeches? They have long been a plague to us Gruploks. If our first story goes well, I'm sure the others will be glad to hear more. Perhaps you could aim for twenty-five Murklings? Keep killing Szithri if you can, too!")
                other:setFlag(3018, 5)
                other:journal("Feats of Poetry", 2, "Krinaka wants me to kill twenty-five Murkling leeches out in the swamp to serve as the basis of another inspiring story. She'll continue to keep track of Szithri I kill, should I choose to, as well.")
            end

        elseif poetry_quest == 5 then
            if hail then
                self:say("Oh! Back so soon, "..other:GetName().."?")
                dialog(other, self, "How many Murklings and Szithri have I killed so far?")
                if other:GetFlag(3028) > 0 then
                    dialog(other, self, "You know, that wasn't so hard. I could probably kill lots more swamp creatures. It'd make for a better story, right?")
                end

            elseif string.match(string.lower(msg), "how many") then
                self:say("I believe you've killed "..other:GetFlag(3027).." Murklings and "..other:GetFlag(3020).." Szithri since we've started keeping count.")
                if other:GetFlag(3027) > 24 and other:GetFlag(3028) == 0 then
                    dialog(other, self, "I have slain twenty-five murklings!")
                end

            elseif string.match(string.lower(msg), "i have slain twenty five murklings") and other:GetFlag(3027) > 24 and other:GetFlag(3028) == 0 then
                self:say("So you have, "..other:GetName().."! I can't wait to tell the story of the Murkling Clobberer to the others! Thank you for doing this.")
                other:giveExp(2500, 0)
                other:giveFaction(600, 5)
                other:setFlag(3028, 1)
                dialog(other, self, "You know, that wasn't so hard. I could probably kill lots more swamp creatures. It'd make for a better story, right?")
            
            elseif string.match(string.lower(msg), "i could probably kill lots more swamp creatures") and other:GetFlag(3028) > 0 then
                self:say("That would be marvelous! Hmm. Well, less Murklings scavenging our food sources is always good, but how about some of those disturbing fungal men? They have shown some very strange and deadly behavior when approached by Gruploks in the past... If our first story goes well, I'm sure the others will be glad to hear more. Perhaps you could aim for fifty Fungi? Keep killing Szithri and Murklings if you can, too!")
                other:setFlag(3018, 6)
                other:journal("Feats of Poetry", 3, "Krinaka wants me to kill Fungi out in the swamp to serve as the basis of another inspiring story. She'll continue to keep track of Szithri and Murklings I kill, should I choose to continue with them, as well.")
            end

        elseif poetry_quest > 5 then
            if hail then
                self:say("Oh! Back so soon, "..other:GetName().."?")
                dialog(other, self, "How many Fungi, Murklings and Szithri have I killed so far?")
                if other:GetFlag(3035) > 0 and other:GetFlag(3018) == 6 then    
                    dialog(other, self, "You know, that wasn't so hard. I could probably kill lots more swamp creatures. It'd make for a better story, right?")
                end

            elseif string.match(string.lower(msg), "how many") and other:GetFlag(3018) > 5 then
                self:say("I believe you've killed "..other:GetFlag(3029).." Fungi, "..other:GetFlag(3027).." Murklings and "..other:GetFlag(3020).." Szithri since we've started keeping count.")

                if other:GetFlag(3029) > 49 and other:GetFlag(3035) == 0 then -- FUNGI
                    dialog(other, self, "I have slain fifty Fungi!")
                elseif other:GetFlag(3029) > 99 and other:GetFlag(3035) == 1 then
                    dialog(other, self, "I have slain one hundred Fungi!")
                elseif other:GetFlag(3029) > 249 and other:GetFlag(3035) == 2 then
                    dialog(other, self, "I have slain so many Fungi!")
                elseif other:GetFlag(3029) > 499 and other:GetFlag(3035) == 3 then
                    dialog(other, self, "I have slain countless Fungi!")
                elseif other:GetFlag(3029) > 999 and other:GetFlag(3035) == 4 then
                    dialog(other, self, "I have slain endless Fungi!")
                end

                if other:GetFlag(3020) > 49 and other:GetFlag(3026) == 1 then -- SZITHRI
                    dialog(other, self, "I have slain fifty Szithri!")
                elseif other:GetFlag(3020) > 99 and other:GetFlag(3026) == 2 then
                    dialog(other, self, "I have slain one hundred Szithri!")
                elseif other:GetFlag(3020) > 249 and other:GetFlag(3026) == 3 then
                    dialog(other, self, "I have slain so many Szithri!")
                elseif other:GetFlag(3020) > 499 and other:GetFlag(3026) == 4 then
                    dialog(other, self, "I have slain countless Szithri!")
                elseif other:GetFlag(3020) > 999 and other:GetFlag(3026) == 5 then
                    dialog(other, self, "I have slain endless Szithri!")
                end

                if other:GetFlag(3027) > 49 and other:GetFlag(3028) == 1 then -- MURKLINGS
                    dialog(other, self, "I have slain fifty Murklings!")
                elseif other:GetFlag(3027) > 99 and other:GetFlag(3028) == 2 then
                    dialog(other, self, "I have slain one hundred Murklings!")
                elseif other:GetFlag(3027) > 249 and other:GetFlag(3028) == 3 then
                    dialog(other, self, "I have slain so many Murklings!")
                elseif other:GetFlag(3027) > 499 and other:GetFlag(3028) == 4 then
                    dialog(other, self, "I have slain countless Murklings!")
                elseif other:GetFlag(3027) > 999 and other:GetFlag(3028) == 5 then
                    dialog(other, self, "I have slain endless Murklings!")
                end

            -- fungi kills --
            elseif string.match(string.lower(msg), "i have slain fifty fungi") and other:GetFlag(3029) > 49 and other:GetFlag(3035) == 0 then
                self:say("So you have, "..other:GetName().."! I can't wait to tell the story of the Fungi Shriveler to the others! Thank you for doing this.")
                other:giveExp(5000, 0)
                other:giveFaction(600, 5)
                other:setFlag(3035, 1)
                dialog(other, self, "You know, that wasn't so hard. I could probably kill lots more swamp creatures. It'd make for a better story, right?")

            elseif string.match(string.lower(msg), "i have slain one hundred fungi") and other:GetFlag(3029) > 99 and other:GetFlag(3035) == 1 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(10000, 0)
                other:giveFaction(600, 10)
                other:setFlag(3035, 2)
            
            elseif string.match(string.lower(msg), "i have slain so many fungi") and other:GetFlag(3029) > 249 and other:GetFlag(3035) == 2 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(25000, 0)
                other:giveFaction(600, 25)
                other:setFlag(3035, 3)
            
            elseif string.match(string.lower(msg), "i have slain countless fungi") and other:GetFlag(3029) > 499 and other:GetFlag(3035) == 3 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(50000, 0)
                other:giveFaction(600, 50)
                other:setFlag(3035, 4)
            
            elseif string.match(string.lower(msg), "i have slain endless fungi") and other:GetFlag(3029) > 999 and other:GetFlag(3035) == 4 then
                self:say("Wow... That's amazing, "..other:GetName().."! You've slain "..other:GetFlag(3029).." Fungi!! I... Well, we have been thinking of a gift for your efforts and worked hard to make this, but... I hope you'll accept this as a token of my respect, of the respect we all have for you!")
                other:giveItem(13283, 1)
                other:giveExp(200000, 0)
                other:giveFaction(600, 200)
                other:setFlag(3035, 100)

            -- szithri kills --
            elseif string.match(string.lower(msg), "i have slain fifty szithri") and other:GetFlag(3020) > 49 and other:GetFlag(3026) == 1 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(5000, 0)
                other:giveFaction(600, 5)
                other:setFlag(3026, 2)
            
            elseif string.match(string.lower(msg), "i have slain one hundred szithri") and other:GetFlag(3020) > 99 and other:GetFlag(3026) == 2 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(10000,0)
                other:giveFaction(600, 10)
                other:setFlag(3026,3)
            
            elseif string.match(string.lower(msg), "i have slain so many szithri") and other:GetFlag(3020) > 249 and other:GetFlag(3026) == 3 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(25000, 0)
                other:giveFaction(600, 25)
                other:setFlag(3026, 4)
            
            elseif string.match(string.lower(msg), "i have slain countless szithri") and other:GetFlag(3020) > 499 and other:GetFlag(3026) == 4 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(50000, 0)
                other:giveFaction(600, 50)
                other:setFlag(3026, 5)
            
            elseif string.match(string.lower(msg), "i have slain endless szithri") and other:GetFlag(3020) > 999 and other:GetFlag(3026) == 5 then
                self:say("Wow... That's amazing, "..other:GetName().."! You've slain "..other:GetFlag(3020).." Szithri!! I... Well, we have been thinking of a gift for your efforts and worked hard to make this, but... I hope you'll accept this as a token of my respect, of the respect we all have for you!")
                other:giveItem(13282, 1)
                other:giveExp(200000, 0)
                other:giveFaction(600, 200)
                other:setFlag(3026, 100)
            
            -- murkling kills --
            elseif string.match(string.lower(msg), "i have slain fifty murklings") and other:GetFlag(3027) > 49 and other:GetFlag(3028) == 1 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(5000, 0)
                other:giveFaction(600, 5)
                other:setFlag(3028, 2)

            elseif string.match(string.lower(msg), "i have slain one hundred murklings") and other:GetFlag(3027) > 99 and other:GetFlag(3028) == 2 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(10000, 0)
                other:giveFaction(600, 10)
                other:setFlag(3028, 3)

            elseif string.match(string.lower(msg), "i have slain so many murklings") and other:GetFlag(3027) > 249 and other:GetFlag(3028) == 3 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(25000, 0)
                other:giveFaction(600, 25)
                other:setFlag(3028, 4)

            elseif string.match(string.lower(msg), "i have slain countless murklings") and other:GetFlag(3027) > 499 and other:GetFlag(3028) == 4 then
                self:say("Wonderful, "..other:GetName().."! The others will be glad to hear of this. Keep it up!")
                other:giveExp(50000, 0)
                other:giveFaction(600, 50)
                other:setFlag(3028, 5)

            elseif string.match(string.lower(msg), "i have slain endless murklings") and other:GetFlag(3027) > 999 and other:GetFlag(3028) == 5 then
                self:say("Wow... That's amazing, "..other:GetName().."! You've slain "..other:GetFlag(3027).." Murklings!! I... Well, we have been thinking of a gift for your efforts and worked hard to make this, but... I hope you'll accept this as a token of my respect, of the respect we all have for you!")
                other:giveItem(13282, 1)
                other:giveExp(200000, 0)
                other:giveFaction(600, 200)
                other:setFlag(3028, 100)
            
            elseif string.match(string.lower(msg), "i could probably kill lots more swamp creatures") and other:GetFlag(3035) > 0 and other:GetFlag(3018) == 6 then
                self:say("Ah, you've already done so much, "..other:GetName()..", and I'd be glad to see you defeat more of those monsters and to tell your tales. But those are pretty much the only swamp creatures we have! Keep killing them and I will gladly keep telling your stories. Perhaps someday my people may give you something that will fit your legend...")
                other:setFlag(3018, 7)
                other:journal("Feats of Poetry", 100, "Krinaka would like me to continue killing the creatures of the swamp, should I choose to. She also implied a gift from the Gruploks if there are more stories of my success...")
            end
        end
    end
end