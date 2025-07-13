-- Grithrai the Headman

function EVENT_SAY(self, other, msg)
	--##Start big quest
    local faction = other:GetCon(600, true)
    local hail = string.match(msg, "Hail")
    local grithrai_quest = other:GetFlag(3025)
    local has_shield = other:GetFlag(49098)

    self:face(other)

    debugtext(other:GetName().."'s Gruplok Faction: "..other:GetCon(600, true)..".")

    if faction <= 6 then -- starts at apprehensive faction
        if grithrai_quest == 0 then
            if hail and other:GetFlag(3010) > 0 then
                self:say("Ah, greetings "..other:GetName()..". I have been hearing quite a bit about you recently - you really have been doing much for the Gruploks, they tell me, and I would like to express my gratitude. I hope you'll pardon our earlier coldness to you - but I'm sure you must understand how it is for us, having dealt with us for as long as you have now...")
                dialog(other, self, "Don't worry about it.")
                dialog(other, self, "[GOOD] There's no need to apologize - desperate times call for desperate measures. I'm just glad that I could alleviate some of your people's burdens, if only a little.")
                dialog(other, self, "[EVIL] I suppose you can be forgiven for your disrespect on account of your backwardness, as long as you know to respect your betters now.")

            elseif string.match(msg, "Don t worry about it") and other:GetFlag(3010) > 0 then
                other:setFlag(3025, 1)
                self:say("Ah, very considerate for a fighter like yourself. Much like the Sentries of old, I suppose. On that point, actually: I know you have done much for my people, but I was wondering if I could ask for your assistance in a very curious matter.")
                dialog(other, self, "What is it?")

            elseif string.match(msg, "no need to apologize") and other:GetFlag(3010) > 0 then
                other:setFlag(3025, 1)
                other:addAlignment("Good", 1)
                self:say("Ah, that's very kind, especially for a fighter like yourself. Much like the Sentries of old, I suppose. On that point, actually: I know you have done much for my people, but I was wondering if I could ask for your assistance in a very curious matter.")
                dialog(other, self, "What is it?")

            elseif string.match(msg, "on account of your backwardness") and other:GetFlag(3010) > 0 then
                other:setFlag(3025, 1)
                other:addAlignment("Evil", 1)
                self:say("Yes, well, thank you for putting up with our suspicions, I suppose. Perhaps I am overstepping my bounds, but, having heard all you've done to help my people, I was wondering if I could ask for your assistance in a very curious matter.")
                dialog(other, self, "What is it?")
            end
        
        elseif grithrai_quest == 1 then
            if string.match(msg, "Hail") then
                self:say("I was wondering if I could ask for your assistance in a very curious matter.")
                dialog(other, self, "What is it?")
            
            elseif string.match(msg, "What is it") then
                self:say("Some of the townspeople have been complaining of a strange light glowing just north of the city in the night. We thought it might be some new monstrocity stalking the swamp... We sent out the Glakrin to see if he could find it by day. He returned, having found it easily. He said it was just a strange, glowing apparition, and that it seemed harmless. A few of the townspeople are stilled worried about it, and I have inspected it myself and spoken with some of our more knowledgable townspeople. I'm afraid that it might not be as harmless as it seems.")
                dialog(other, self, "How so?")
            
            elseif string.match(msg, "How so") then
                self:say("As I'm sure you know by now, we are a people of a vast mythology. As it would happen, one of the Myths of Gruthluk mentions 'rifts,' gateways used by witches to reach into the void between the worlds of the living and the dead, which bear an alarming resemblance to the light just north of the city. We know that, in the myth, these rifts were a great threat to the Gruplok people... to be safe, I would like to take measures to defend ourselves from this potential threat, find out what exactly we are dealing with, and find out if there is some way to get rid of the rift entirely. I would like your help in this, for the sake of my people.")
                dialog(other, self, "Alright, I'll help. Any idea where I should start investigating?")
                dialog(other, self, "[LAWFUL] For the sake of your people, I will certainly assist you. Any idea where I should start investigating?")
                dialog(other, self, "[CHAOTIC] I suppose I can help you. Just promise me you won't forget my generosity when the time comes, eh? So, any idea where I should start investigating?")
            
            elseif string.match(msg, "Alright  I ll help") then
                other:setFlag(3025, 2)
                self:say("Thank you, "..other:GetName()..". Hopefully our fears about this strange light are unfounded. In any case, you should begin by speaking with Kalunepe. She knows much more about the myth involving the rifts than I could ever tell you.")
                other:journal("Grithrai's Concern", 1, "Grithrai has asked me to investigate a strange light, possibly a mythic 'rift', which has appeared just North of Gruplok City. He wants me to speak with Kalunepe to learn more about the rifts in the myth, so I can determine if that's what we are dealing with.")
            
            elseif string.match(msg, "For the sake of your people") then
                other:setFlag(3025, 2)
                other:addAlignment("Lawful", 1)
                self:say("Thank you, "..other:GetName()..". Hopefully our fears about this strange light are unfounded. In any case, you should begin by speaking with Kalunepe. She knows much more about the myth involving the rifts than I could ever tell you.")
                other:journal("Grithrai's Concern", 1, "Grithrai has asked me to investigate a strange light, possibly a mythic 'rift', which has appeared just North of Gruplok City. He wants me to speak with Kalunepe to learn more about the rifts in the myth, so I can determine if that's what we are dealing with.")
            
            elseif string.match(msg, "Just promise me") then
                other:setFlag(3025, 2)
                other:addAlignment("Chaotic", 1)
                self:say("Thank you, "..other:GetName()..". Hopefully our fears about this strange light are unfounded. In any case, you should begin by speaking with Kalunepe. She knows much more about the myth involving the rifts than I could ever tell you.")
                other:journal("Grithrai's Concern", 1, "Grithrai has asked me to investigate a strange light, possibly a mythic 'rift', which has appeared just North of Gruplok City. He wants me to speak with Kalunepe to learn more about the rifts in the myth, so I can determine if that's what we are dealing with.")
            end

        elseif grithrai_quest == 2 or grithrai_quest == 3 then
            if hail then
                self:say("Please speak with Kalunepe, "..other:GetName()..". She can tell you more about the rifts from the myth. That would be the best place to start investigating, I think.")
            end

        elseif grithrai_quest == 4 then
            if hail then
                self:say("Any news, "..other:GetName().."?")
                dialog(other, self, "-Tell him everything Kalunepe said-")

            elseif string.match(msg, "Tell him everything Kalunepe said") then
                self:say("A jewel, you say? It certainly is worth looking into. And a precise location to look for it! That's more convenience that I could have hoped for - if it's still there, if it was ever *really* there. Well, if the strange light really is the rift from the myth, it stands to reason that the jewel would also be real, right? In any case, you'll see if you can't find it for us, won't you?")
                dialog(other, self, "Certainly.")

            elseif string.match(msg, "Certainly") then
                other:setFlag(3025, 5)
                self:say("Splendid. Thank you for this, "..other:GetName()..". With any luck this whole trouble will be behind us by day's end. It has been a long time since the Gruploks have had such luck - a very long time.")
                other:journal("Grithrai's Concern", 5, "Grithrai wants me to look for this jewel that is supposedly buried in the Southwest of the swamp, according to the myth. It may be the key to putting his fears to rest.")
            end

        elseif grithrai_quest == 5 then
            if hail then
                self:say("Any luck finding that buried jewel, "..other:GetName().."?")
            end

        elseif grithrai_quest == 6 then
            if hail then
                self:say("Have you visited our unwanted rift yet? We really must see if that jewel is able to get rid of it, like in the myth.")
            end

        elseif grithrai_quest == 7 then
            if hail then
                self:say(other:GetName().."! I'm glad to see you are still alive - I heard about the commotion from one of the Sentries who saw the whole thing. Abominations from the void... This has gone worse than I dared to imagine.")
                dialog(other, self, "I think the iksar skeleton that came out of the rift was the witch from that myth - she thought I was that Gruthluk guy...")
    
            elseif string.match(msg, "I think the iksar skeleton") then
                other:setFlag(3025, 8)
                self:say("This is very troubling indeed... A fiend of myth, back and seeking vengeance on the Gruploks for her death? How do you stop a myth? But... we must do something, yes? There must be something we can do to set things right, and keep the Gruploks from being harmed. If she thinks you are Gruthluk... perhaps you will have to defeat her? Ah, but you are powerful, aren't you, "..other:GetName().."..? I'm sure you could defeat that old necromancer. She has been dead for, what, a thousand years? Her skills must be diminished. They have to be!' Grithrai seems to be growing somewhat frantic. A sudden thought seems to hit him. '"..other:GetName().."... do you still have the jewel? Show it to me.")
            end

        elseif grithrai_quest == 8 then
            if hail then
                self:say(other:GetName().."... do you still have the jewel? Show it to me.")
            end

        elseif grithrai_quest == 9 then
            if hail then
                self:say("Hmm...")
                dialog(other, self, "The witch said I should go find her where she and Gruplok first fought. Do you know where that is?")
        
            elseif string.match(msg, "witch said I should go") then
                other:setFlag(3025, 10)
                -- Dialog updated to reflect the NPC's new location in the Field of Bone, near the Kaesora zone-in
                self:say("I'm afraid I don't, "..other:GetName()..". However, I was speaking with Glakrin, and he did recall something from his childhood - a place with a rift similar to ours. He spoke of shifting sands, and seeing the base of a massive stone column, part of some crumbling ruins from a city long forgotten. He believes it was located not far from here, just to the north of this swamp. Many years have passed since he saw it, but it's possible there's a connection... As much as I worry about what else the jewel might stir, we must investigate this lead. The jewel responded to our rift; perhaps it will to this other one. The path to restoring Gruthluk's jewel may lie there.")
                -- self:say("I'm afraid I don't, " .. other:GetName() .. ". Perhaps Kalunepe would know. Ah, that reminds me: I was speaking with Glakrin, and he told me that he remembered seeing something similar to our rift during his childhood. He said it was on a sandy shore, near the bay to the south. It was many years ago that he saw it, but perhaps it is connected somehow... Although I fear for what else may be awakened by the jewel, I still must say that investigating this other rift is likely our best option, at this point. And besides, bringing the jewel to our rift seems to have drawn out a little of its power... Perhaps this other rift may have the same effect. Restoring Gruthluk's jewel may be the key to all of this...")
                other:journal("The Jewel of Gruthluk", 1, "Grithrai has new information about another rift. Glakrin's childhood memory is of a place with shifting sands around the footing of an ancient stone column, part of the ruins of a long-forgotten city. Grithrai says this location is to the north of the swamp. He believes investigating these ruins is our best option and that the jewel might be key.")
                -- other:journal("The Jewel of Gruthluk", 1, "Grithrai wants me to go investigate another rift which is supposedly located on a sandy shore to the south of the swamp. He thinks the jewel may be necessary to defeating the old iksar witch it unleashed, and there seems to be some connection between the jewel and the rifts in any case.")
            end

        elseif grithrai_quest == 10 then
            if hail then
                self:say("Did you ever find that extra rift?")
            end

        elseif grithrai_quest == 11 then
            if hail then
                self:say("Did you ever find that extra rift?")
                dialog(other, self, "I found it, along with an interesting development on this jewel.")

            elseif string.match(msg, "along with an interesting development on this jewel") then
                other:text("You recall the events of what happened in the Field of Bone with the rift...", 6, true)
                self:say("So slaying the reanimated gruploks made Gruthluk's jewel glow? I have a theory... I need you to slay more of our restless ancestors. Perhaps then, the true power of the jewel can come forth.")
                other:journal("The Jewel of Gruthluk", 11, "Grithrai wants me to slay any reanimated gruploks with my jewel. Perhaps there is more power in this gem than we think.")
                other:setFlag(3025, 12)
            end

        elseif grithrai_quest == 12 then
            if hail then
                self:say("Any progress with slaying the undead gruplok?")
            end

        elseif grithrai_quest == 13 then
            if hail then
                self:say("The jewel... ")
                dialog(other, self, "I felt a strong power emanating from it after slaying those undead. Maybe even a little... healthier?")

            elseif string.match(msg, "felt a strong power emanating from it") then
                self:say("Surely with this, you'll have the power to draw out and destroy that witch forever!")
                dialog(other, self, "Then I am off to face against her.")

            elseif string.match(msg, "am off to face against") then
                self:say("Be careful, friend. Bring allies with you, there is no telling what this witch is capable of. That is, if the myths are true...")
                other:setFlag(3025, 14)
                other:journal("The Jewel of Gruthluk", 14, "I am off to finally face off against the witch, Slar`thith`la.")
            end

        end

        if faction <= 2 and has_shield == 0 then
            if hail then
                dialog(other, self, "I am honored to call myself a friend to the Gruploks.")                    
                
            elseif string.match(msg, "I am honored to call myself a friend") and has_shield == 0 then
                other:setFlag(49098, 1)
                other:giveExp(250000, 0)
                self:say("And we are proud to have you for one.  Please accept this modest gift, "..other:GetName()..". It will remind you of us always.")
                other:giveItem(41050, 1)
                if other:GetClass() == 6 or other:GetClass() == 12 then
                    other:giveItem(41156, 1)
                end
            end
        end
    end
end

-- function check_for_shield(other) -- cannot be used without bank, womp womp
--     local has_shield = false

--     for k, v in pairs(other:GetInventory()) do
--         debugtext(tostring(v:GetID()))
--         if v:GetID() == 41050 then
--             has_shield = true
--             break
--         end
--     end
--     debugtext("----")
--     for k, v in pairs(other:GetInventory(2000, 2999)) do
--         debugtext(tostring(v:GetID()))
--         if v:GetID() == 41050 then
--             has_shield = true
--             break
--         end
--     end
--     debugtext(other:GetName().." has a shield: "..tostring(has_shield))

--     return has_shield
-- end

function EVENT_ITEM(self, other, item, coin)
	if other:GetFlag(3025) == 5 and item(20843) > 0 then
		other:setFlag(3025, 6)
		self:say(other:GetName().."! You really found it? This is the jewel? Such luck! You should hang on to it - go and see if you can seal the light North of the city up with it, or at least get some kind of reaction to show we are on the right track. In any case, come tell me what happens afterward, please.")
		other:journal("Grithrai's Concern", 10, "Grithrai wants me to try to use the jewel on the rift - if it really is a rift - just North of the city. I'm to report back to him afterward, whatever results.")
    end

	if other:GetFlag(3025) == 8 and item(20843) > 0 then
		item:keep(20843, 1)
		other:setFlag(3025, 9)
		self:say("Gruthluk's jewel... This is what awakened the witch, right? Perhaps it is the key to sealing her back up again. Perhaps Gruthluk's spirit is in this jewel, waiting to defeat her once again... I know a little spirit magic, you know. This jewel... something has changed about it. A power seems to have been awakened in it. It is faint, but maybe... Maybe it will be of use against the witch. Here. I have done what I can to draw out its power.")
		other:giveItem(20845, 1)
		other:journal("Grithrai's Concern", 100, "Grithrai's concerns have proven to be very well founded. A mythic, Gruplok-hating witch has been awakened, seeking vengeance on a long-dead hero. It seems it's up to me to protect the Gruploks from her.")
		dialog(other, self, "The witch said I should go find her where she and Gruplok first fought. Do you know where that is?")
    end
end