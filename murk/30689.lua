-- Galak the Morbid - Mage Summoned Pet armor quest, Abyss entry quest

function EVENT_SAY(self, other, msg)
    local morbid_quest = other:GetFlag(3040)
    local grave_quest = other:GetFlag(14043)
    local hail = string.match(string.lower(msg), "hail")

    self:face(other)

    if other:GetFlag(3000) == 7 then
        if morbid_quest == 0 then
            if hail then
                self:say("...Hello.")
                dialog(other, self, "So what're you all about then?")
                -- dialog(other, self, -Stare-)
            elseif string.match(string.lower(msg), "so what re you all about then")then
                self:say("...Nothing.")
                dialog(other, self, "Tell me!")
                dialog(other, self, "[GOOD] Nothing? Are you sure? I just want to help you. But if you don't want to speak, that's okay...")
                dialog(other, self, "[CHAOTIC] Don't waste my time. Adventurer for hire here, you scratch my back, I'll scratch yours and all that. Just tell me what you need!")
                dialog(other, self, "[EVIL] Shut up and tell me already! Don't make me beat it out of you.")

            elseif string.match(string.lower(msg), "tell me") or string.match(string.lower(msg), "nothing  are you sure") or string.match(string.lower(msg), "don t waste my time") or string.match(string.lower(msg), "shut up and tell me") then
                if string.match(msg, "GOOD") then
                    other:addAlignment("Good", 2)
                elseif string.match(msg, "CHAOTIC") then
                    other:addAlignment("Chaotic", 2)
                elseif string.match(msg, "EVIL") then
                    other:addAlignment("Evil", 2)
                end
                self:say("...There is a place not far north of this village... A place where dead things dwell. Dead lizards. I saw them once. I want to know why the other lizards, the living ones, don't destroy them they way they destroy everything else. There must be some reason. Ruins, swarming with dead lizards. They know it's there. They don't go in. They wouldn't let the dead things be without a good reason. Go inside, and find me a reason.")
                other:journal("Morbid Curiousity", 1, "Galak wants me to investigate inside the `ruins full of dead lizards close to the lizard city` and find out why the Kaezulians don't stamp them out. I'm not sure what he's looking for. Maybe I'll find some information I can take back to him...")
                other:setFlag(3040, 1)
            end
            
        elseif morbid_quest == 1 then
            if hail then
                self:say("...Do you have something for me?")
                dialog(other, self, "What was it you wanted?")
            elseif string.match(string.lower(msg),  "what was it you wanted") then
                self:say("...There is a place not far north of this village... A place where dead things dwell. A place where the dead rule the night. Dead lizards. I saw them once. I want to know why the other lizards, the living ones, don't destroy them they way they destroy everything else. There must be some reason. Ruins, swarming with dead lizards, so close to the lizard's city. They know it's there. They don't go in. They wouldn't let the dead things be without a good reason. Find me a reason.")
            end

        elseif morbid_quest == 2 then
            if hail then
                self:say("Very interesting... I think I've found something. I might have another use for you.")
                dialog(other, self, "What is it?")
            elseif string.match(string.lower(msg),  "what is it") then
                self:say("Some of these pages seem to be about the same subject. Something about some kind of conjuration... ''Spectral Defense''... I wonder if it was some kind of experiment the dead iksars did before they died? Maybe that's why the lizards don't destroy them. Maybe they have useful magic. Spectral Defense... Maybe we could use it... I wonder if anything remains of whatever this thing is. There seems to be talk of ''silk and spirit'' at the end of this page. See if you can find what it's talking about, and bring me as much as you can.")
                other:journal("Morbid Curiousity", 10, "Galak wants me to find `silk and spirit` which was apparently used in some kind of `Spectral Defense` conjuration by the Iksars of Kaesora. He wants me to bring as much as I kind find.")
                other:setFlag(3040, 3)
            end

        elseif morbid_quest == 3 then
            if hail and other:GetFlag(3053) > 9 and other:GetFlag(3054) > 9 then
                self:say("Perfect! After ruining most of what you've brought, I think I finally have it. A spell, in fact... a conjuration for Spectral Silk armor. We will make good use of this, some day, we Gruploks... There is only one problem. I can't complete quite complete the spell. Something is missing! The very last incantation... I'm sure one of the dead lizards in Kaesora must have it. Go back and find it!")
                other:journal("Morbid Curiousity",50,"Galak needs me to gather one more thing to complete his spell. The end piece of the scroll he has been reconstructing - he thinks the undead iksars might have it.")
                other:setFlag(3040,4)
            end

        elseif morbid_quest == 4 then
            if hail then
                self:say("I can't quite complete the spell. Something is missing. The very last incantation... I'm sure one of the dead lizards in Kaesora must have it. Go back and find it!")
            end

        elseif morbid_quest == 5 then
            if hail then
                self:say("Hello again.")
            end
        end
    else
		self:text(self:GetName().." stares at "..other:GetName()..".")
    end

    if morbid_quest > 0 then
        if grave_quest == 1 then
            if hail then
                dialog(other, self, "Would you know anything about this strange grave?")

            elseif string.match(string.lower(msg),  "would you know anything about this") then
                self:text(self:GetName().." stares into the distance before answering, 'A grave where before there was nothing?  Truly, the swamp holds secrets even from the Gruplok.  Do I care to learn these secrets?  Do you?  To force the swamp to divulge what it hides can only bring ruin.  Why not let it rest?'")
                dialog(other, self, "[GOOD] I sense the hint of darkness in your tone.  I would help to conquer this darkness.")
                dialog(other, self, "[LAWFUL] You are right--nothing good can come of disturbing this grave.")
                dialog(other, self, "[CHAOTIC] A fresh grave means fresh treasure.. help me and I will reward you.")
                dialog(other, self, "I can't resist a mystery, and it sounds like you can't either.")
            
            elseif string.match(string.lower(msg),  "i sense the hint of darkness") then
                other:addAlignment("Good", 2)
                self:text(self:GetName().." ponders your righteous answer, 'Your zeal will be your doom, perhaps, but not mine.  Go, stalwart one, and feed the earth an emerald.  Then feed it poison until it cries for mercy.  Then feed it disease until the secrets come out.  By these means will the swamp answer to you.'")
                other:setFlag(14043, 2)
            
            elseif string.match(string.lower(msg),  "you are right")then
                other:addAlignment("Lawful", 2)
                self:text(self:GetName().." ponders your prudent answer, 'You are sensible, but this mystery must be answered.  Go and feed the earth an emerald.  Then feed it poison until it cries for mercy.  Then feed it disease until the secrets come out.  By these means will the swamp answer to you.'")
                other:setFlag(14043, 2)
            
            elseif string.match(string.lower(msg),  "a fresh grave means") then
                other:addAlignment("Chaotic", 2)
                self:text(self:GetName().." smiles at your avaricious answer, 'Your greed will be your doom, perhaps, but not mine.  Go, stalwart one, and feed the earth an emerald.  Then feed it poison until it cries for mercy.  Then feed it disease until the secrets come out.  By these means will the swamp answer to you.'")
                other:setFlag(14043, 2)

            elseif string.match(string.lower(msg),  "i can t resist") then
                self:text(self:GetName().." smiles at your insightful answer, 'You have understood me deeply.  Go, clever one, and feed the earth an emerald.  Then feed it poison until it cries for mercy.  Then feed it disease until the secrets come out.  By these means will the swamp answer to you.'")
                other:setFlag(14043, 2)
            end

        elseif grave_quest == 2 then
            if hail then
                dialog(other, self, "Please tell me again about the grave.")
            elseif string.match(string.lower(msg),  "please tell me again about the grave") then
                self:say("First, feed the earth an emerald.  Then feed it poison until it cries for mercy.  Then feed it disease until the secrets come out.  By these means will the swamp answer to you..")
            end
        end
    end
end

function EVENT_ITEM(self, other, item, coin)
	if other:GetFlag(14043) > 1 and item(41155) > 0 then
		self:say("This.. answers nothing as it is.  Still, one hopes that investigation will produce results.  I thank you for your commitment to my cause, whatever the motivation.")
		other:setFlag(14043, 3)
		item:keep(41155,item(41155))
		other:giveFaction(600, 10)
		other:giveExp(75000, 0)
	end

	if other:GetFlag(3040) == 1 and item(13671) > 0 and other:GetFlag(3052) < 4 then    -- research papers now comes from inside Kaesora!
		other:giveFaction(600, 3)
		item:keep(13671, 1)
        other:setFlag(3052, other:GetFlag(3052) + 1)
		self:say("Hmm... I will study this. Bring me more.")
	end

	if other:GetFlag(3040) == 1 and item(13671) > 0 and other:GetFlag(3052) == 4 then   -- research papers now comes from inside Kaesora!
		other:giveFaction(600, 3)
		item:keep(13671, 1)
		other:setFlag(3052, 5)
		other:setFlag(3040, 2)
		self:say("Very interesting... I think I've found something. I might have another use for you.")
		dialog(other, self, "What is it?")
	end

	if item(13671) > 0 and other:GetFlag(3052) > 4 then                                 -- research papers now comes from inside Kaesora!
		other:giveFaction(600, item(13671))
		item:keep(13671, item(13671))
        other:setFlag(3052, other:GetFlag(3052) + item(13671))
		self:say("Hmm... I will suppose I may as well study this. I'm not very interested in these anymore, however.")
	end

	if other:GetFlag(3040) == 3 and item(13672) > 0 and other:GetFlag(3053) < 9 then
		other:giveFaction(600, 3)
		item:keep(13672, 1)
        other:setFlag(3053, other:GetFlag(3053) + 1)
		self:say("Interesting... This may just do... Find me more!")
	end

	if other:GetFlag(3040) == 3 and item(13672) > 0 and other:GetFlag(3053) == 9 then
		other:giveFaction(600, 3)
		item:keep(13672, 1)
        other:setFlag(3053, other:GetFlag(3053) + 1)
		self:say("Hmmm. I think I may have all I need for this... I'm sure I could use some more of these Essence things later on, though.")
	end

	if other:GetFlag(3040) > 2 and item(13672) > 0 and other:GetFlag(3053) > 9 then
		other:giveFaction(600, item(13672))
		item:keep(13672, item(13672))
		other:setFlag(3053, other:GetFlag(3053) + 1)
		self:say("I will find a use for this.")
	end

	if other:GetFlag(3040) == 3 and item(13673) > 0 and other:GetFlag(3054) < 9 then
		other:giveFaction(600, 2)
		item:keep(13673, 1)
		other:setFlag(3054, other:GetFlag(3054) + 1)
		self:say("Is this the silk it spoke of? There's something odd about it... Bring me more!")
	end

	if other:GetFlag(3040) == 3 and item(13673) > 0 and other:GetFlag(3054) == 9 then
		other:giveFaction(600, 3)
		item:keep(13673, 1)
		other:setFlag(3054, other:GetFlag(3054) + 1)
		self:say("Hmmm. I think I may have all I need for this... I'm sure I could use some more of these silks later on, though. They have some interesting properties. Very resilient.")
	end

	if other:GetFlag(3040) > 2 and item(13673) > 0 and other:GetFlag(3054) > 9 then
		other:giveFaction(600, item(13673))
		item:keep(13673, item(13673))
		other:setFlag(3054, other:GetFlag(3054) + 1)
		self:say("I will find a use for this.")
	end

	if other:GetFlag(3040) == 4 and item(13674) > 0 and other:GetClass() == 13 then
		item:keep(13674, 1)
		self:say("Ah! Perfect!' Galak scribbles something down. 'Yes, the conjuration is complete now. We Gruploks will make good use of this summoned armor, some day... Until then, I think you may find this useful.' Galak spends a few minutes writing out a copy of the spell. 'Here. And... thank you.")
		other:giveItem(13670, 1)
		other:giveExp(75000, 0)
		other:giveFaction(600, 100)
		other:setFlag(3040, 5)
		other:journal("Morbid Curiousity", 100, "I have helped Galak gather he needed to complete a spell which may one day help the Gruploks. He also gave me a copy of it!")

    elseif other:GetFlag(3040) == 4 and item(13674) > 0 then
		item:keep(13674, 1)
		self:say("Ah! Perfect!' Galak scribbles something down. 'Yes, the conjuration is complete now. We Gruploks will make good use of this summoned armor, some day... Thank you.")
		other:giveExp(75000, 0)
		other:giveFaction(600, 100)
		other:setFlag(3040, 5)
		other:journal("Morbid Curiousity", 100, "I have helped Galak gather he needed to complete a spell which may one day help the Gruploks.")
	end

	-- if other:GetFlag(3040) == 7 and item(13730) > 0 then
	-- 	self:say("...Yes, yes! You have done it! This looks just like the lizard's heirloom... I am certain of it. Now, take it to one of the lingering Gruploks... I do not know what may happen, but it seems that you will be the one to find out.")
	-- 	other:setFlag(3040,8)
	-- 	other:journal("Sorrow",2,"I found the right ritual dagger. Galak wants me to take it to one of the lingering Gruploks and see what happens...")
    -- end
	-- if other:GetFlag(3040) == 11 and item(13524) > 0 then
	-- 	self:say("This may just do, "..other:GetName()..". Coat the dagger in this as you give it to one of the lingering Gruploks, this time. Perhaps we will find out what they expected to happen...")
	-- 	other:setFlag(3040,12)
	-- 	other:journal("Sorrow",50,"This `transmigratory goop` stuff seems like it might work. Galak wants me to coat the dagger with it as I hand it to one of the undead Gruploks...")
    -- end
end

	-- elseif hail and other:GetFlag(3040) == 5 and $faction < 7 then
	-- 	self:say(Hello again... Have you been keeping well of late? I have not been keeping so well... My dreams have been disturbed. I feel as though something has changed, something dramatic, something terrible... as though a great barrier had been pierced, freeing ancient terrors to stalk the night. I am used to fear. We are used to it... But this is different, somehow...)
	-- 	dialog(other, self, ...Go on.)
	-- 	dialog(other, self, Is there anything I can do? It pains me to hear of your suffering.)
	-- 	dialog(other, self, Fine, fine. What do you need from me?)
	-- 	dialog(other, self, How can I help? What needs to be done?)
	-- }

	-- elseif hail and other:GetFlag(3040) == 6 then
	-- 	self:say(Do you know that the living dead among us - the lingering Gruploks out in the swamp - do you know that they have begun to weep, at night? Weep so much that it carries across the misted murkwaters? The others do not seem to hear it... But I do. Destroying them - putting them to rest - it is not enough, it does not help them. There are always more... I do not think, even if our people, the Gruploks left alive, were to become freed... I do not think that that would help the lingering dead. There's something else going on... They do not weep for our people, our village, our heritage. They do not weep for the ones left behind, or the ones made to join them in death before their time...)
	-- 	dialog(other, self, Carry on.)
	-- }
	-- elseif hail and other:GetFlag(3040) == 7 then
	-- 	self:say(We have not seen as many lately, but in the past we had many patrols of lizards through our village. Usually the lizards were quite cruel, but some seemed to have little interest in cruelty, little interest in patrolling our village. I remember one such lizard, one of their witches... She carried a queer dagger, and spoke to one of her fellow patrollers as though she was quite far from the screams of tormented Gruploks. I heard her say that the dagger - an heirloom, she called it, an ancient heirloom - had been forged of strange metal long ago, to used in unknown rituals, and that it had strange properties... in particular, that it had a strange effect on the lingering dead. It seemed to calm them, to draw them close to it, to mesmerize them... so she said. Perhaps we can use such a dagger... I do not know where that lizard's heirloom was from. Somewhere lost, somewhere ancient... Find me one.)
	-- }
	-- elseif hail and other:GetFlag(3040) == 8 then
	-- 	self:say(Take the dagger to one of the lingering Gruploks... I am not sure what will happen. It is up to you to find out for the both of us.)
	-- }
	-- elseif hail and other:GetFlag(3040) == 9 then
	-- 	self:say(Hmm... It would not take the dagger? Perhaps I overestimated the calming effect... Or perhaps we must make them take the dagger in their hands? I am not sure how we should proceed... But we must not give up so easily. Keep trying.)
	-- }
	-- elseif hail and other:GetFlag(3040) == 10 then
	-- 	self:say(What? It tried to stab itself with the dagger? Quite strange... It seemed confused afterward? Perhaps... perhaps it expected something to happen? Something more than the formation of a meaningless wound in its bloodless body... Hmmm. Something must be missing. A blade, by itself, can certainly pierce a body. But what is a body to the dead? Perhaps it is trying to pierce deeper... Pierce its very essence. I have heard strange tales of those ruins, "..other:GetName()..". You remember, the ruins of the dead lizards? Strange tales of some of the beings there, beings that seem to bridge a gap between this world and some other... Perhaps they have something we can use, something that will let the blade pierce more than the merely physical?)
	-- 	other:journal("Sorrow",5,"Galak wants me to find something from Kaesora, something that can help that dagger `pierce more than the merely physical`. Something I can coat the dagger with, I think...")
	-- 	other:setFlag(3040,11)
	-- }
	-- elseif hail and other:GetFlag(3040) == 11 then
	-- 	self:say(Yes... Something to allow the blade to pierce beyond the merely physical...)
	-- }

	-- if string.match(string.lower(msg),  "go on") and other:GetFlag(3040) == 5 and $faction < 7 then
	-- 	self:say(Do you know that the living dead among us - the lingering Gruploks out in the swamp - do you know that they have begun to weep, at night? Weep so much that it carries across the misted murkwaters? The others do not seem to hear it... But I do. Destroying them - putting them to rest - it is not enough, it does not help them. There are always more... I do not think, even if our people, the Gruploks left alive, were to become freed... I do not think that that would help the lingering dead. There's something else going on... They do not weep for our people, our village, our heritage. They do not weep for the ones left behind, or the ones made to join them in death before their time...)
	-- 	dialog(other, self, Carry on.)
	-- 	other:setFlag(3040,6)
	-- }
	-- if string.match(string.lower(msg),  "it pains me to hear of your suffering") and other:GetFlag(3040) == 5 and $faction < 7 then
	-- 	self:say(Do you know that the living dead among us - the lingering Gruploks out in the swamp - do you know that they have begun to weep, at night? Weep so much that it carries across the misted murkwaters? The others do not seem to hear it... But I do. Destroying them - putting them to rest - it is not enough, it does not help them. There are always more... I do not think, even if our people, the Gruploks left alive, were to become freed... I do not think that that would help the lingering dead. There's something else going on... They do not weep for our people, our village, our heritage. They do not weep for the ones left behind, or the ones made to join them in death before their time...)
	-- 	dialog(other, self, Carry on.)
	-- 	other:setFlag(3040,6)
	-- 	goodpoints(1)
	-- }
	-- if string.match(string.lower(msg),  "fine  fine  what do you need from me") and other:GetFlag(3040) == 5 and $faction < 7 then
	-- 	self:say(Do you know that the living dead among us - the lingering Gruploks out in the swamp - do you know that they have begun to weep, at night? Weep so much that it carries across the misted murkwaters? The others do not seem to hear it... But I do. Destroying them - putting them to rest - it is not enough, it does not help them. There are always more... I do not think, even if our people, the Gruploks left alive, were to become freed... I do not think that that would help the lingering dead. There's something else going on... They do not weep for our people, our village, our heritage. They do not weep for the ones left behind, or the ones made to join them in death before their time...)
	-- 	dialog(other, self, Carry on.)
	-- 	other:setFlag(3040,6)
	-- 	chaospoints(1)
	-- }
	-- if string.match(string.lower(msg),  "what needs to be done") and other:GetFlag(3040) == 5 and $faction < 7 then
	-- 	self:say(Do you know that the living dead among us - the lingering Gruploks out in the swamp - do you know that they have begun to weep, at night? Weep so much that it carries across the misted murkwaters? The others do not seem to hear it... But I do. Destroying them - putting them to rest - it is not enough, it does not help them. There are always more... I do not think, even if our people, the Gruploks left alive, were to become freed... I do not think that that would help the lingering dead. There's something else going on... They do not weep for our people, our village, our heritage. They do not weep for the ones left behind, or the ones made to join them in death before their time...)
	-- 	dialog(other, self, Carry on.)
	-- 	other:setFlag(3040,6)
	-- 	lawpoints(1)
	-- }
	-- if string.match(string.lower(msg),  "carry on") and other:GetFlag(3040) == 6 then
	-- 	self:say(The lingering dead - there are so many of them, I am sure that many of them died long before our people were enslaved... And I have heared the the dead of the swamp are mindless. What could they know of our struggles? What could the know to make them weep? The only thing I can think of is pain... mindless pain for the mindless dead. But what has brought them here? The dead did not begin to linger until after we were enslaved... Months after, in fact. I do not think it was our enslavement that caused the long dead to rise, nor do I think the cruel whims of the lizards can account for the sheer number that have risen, and continue to rise... I am certain of it: there is something else at play here, something that kept the dead here, something that is now causing them to weep with pain in the night. What that something is, I do not know... But I have an idea.)
	-- 	dialog(other, self, What's the idea?)
	-- }
	-- if string.match(string.lower(msg),  "what s the idea") and other:GetFlag(3040) == 6 then
	-- 	self:say(We have not seen as many lately, but in the past we had many patrols of lizards through our village. Usually the lizards were quite cruel, but some seemed to have little interest in cruelty, little interest in patrolling our village. I remember one such lizard, one of their witches... She carried a queer dagger, and spoke to one of her fellow patrollers as though she was quite far from the screams of tormented Gruploks. I heard her say that the dagger - an heirloom, she called it, an ancient heirloom - had been forged of strange metal long ago, to used in unknown rituals, and that it had strange properties... in particular, that it had a strange effect on the lingering dead. It seemed to calm them, to draw them close to it, to mesmerize them... so she said. Perhaps we can use such a dagger... I do not know where that lizard's heirloom was from. Somewhere lost, somewhere ancient... Find me one.)
	-- 	other:setFlag(3040,7)
	-- 	other:journal("Sorrow",1,"Galak wants me to find some kind of ancient, ritual dagger. He thinks it must have been from somewhere ancient, somewhere lost, somewhere that a Kaezulian would have it handed down as an heirloom but know little about it...")
	-- }