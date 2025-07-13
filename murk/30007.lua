-- Gruklikh the Apothecary

function EVENT_SAY(self, other, msg)
    local hail = string.find(msg, "Hail")
    
    self:face(other)

    if other:GetFlag(3000) == 7 then
        if other:GetFlag(3003) == 0 then -- this is an unused flag for an unfinished quest, but is apparently used as introductory dialog
            if hail then
                self:text(self:GetName().." pokes his head up from the pages of a dusty old book and peers at you for a moment through rheumy eyes. 'Ehh? Someone come to see old Gruklikh have they? Did a sentry sprain his leg and come to beg lonely little me for some ointment? Or, no, let me see - one of the girls is having trouble laying her eyes and wants some herbs to spare herself the pains of new life? Not here to chat, no - no more time in the day for that, hmm? Cowering in fear simply takes longer than it did twenty years ago, isn't that right?' Gruklikh squints at you, still uncertain of the shape he's seeing.")
                dialog(other, self, "Er, no. I'm new here, and-")

            elseif string.match(msg, "Er  no  I m new here  and") then
                self:say("Oh! Ah, pardon, pardon, I'm - I didn't know who it was - no one's come to visit me lately, and my vision has seen better days. I hope you won't take offense.")
                dialog(other, self, "It's alright.")

            elseif string.match(msg, "It s alright") then
                self:say("Yes, thank you, excuse my rudeness. Ah, you must be the one everyone has been whispering about in the streets. They call me Gruklikh, and I'm the only one around here who still knows how to work with herbs. A pleasure to make your acquiantance.")
                dialog(other, self, "Likewise.")
                other:setFlag(3003, 1)
            end

        elseif other:GetFlag(3003) == 1 then
            if hail or string.match(msg, "Likewise") then
                if other:GetFlag(3002) == 9  then
                    self:say("That's about all I know about making poisons from the local selection of herbs. Oh, there are other poisonous ones, I'm sure, but I doubt I'd be able to make use of them without some instruction, or a proper formula. I'm sorry I can't be of more help to you, young master - but thank you for listening to old Gruklikh jabber, eh? Hah!")
                    other:setFlag(3002,10)
                    other:journal("Kanruka's Skulduggery", 7, "I learned everything Gruklikh knows about making poisons with the locally available ingredients. Time to teach Kanruka what I've learned, so she can get some practice herself.")

                else
                    self:say("Well now, what can old Gruklikh do for you, young master?")
                    dialog(other, self, "Are you the one that forged the knife from the components I gave Grupruk?")
                    dialog(other, self, "I'm just here for the ambiance.")
                    if other:GetFlag(3002) == 6 then
                        dialog(other, self, "What do you know about poisons?")
                    elseif other:GetFlag(3002) == 7 then
                        dialog(other, self, "Do you know of any poisonous herbs that I could find around here?")
                    elseif other:GetFlag(3002) == 8 then
                        dialog(other, self, "Which poisonous herbs were I supposed to be looking for again?")
                    elseif other:GetFlag(3002) == 11 then
                        dialog(other, self, "What were you saying about other poisons?")
                    elseif  other:GetFlag(3002) == 12 then
                        dialog(other, self, "The poison - tell me about the recipe.")
                    end
                end
                if other:GetFlag(3011) == 6 then
                    dialog(other, self, "-Tell him about Kathrinka's problem.-")
                end

            elseif string.match(msg, "the one that forged the knife") then
                self:say("Indeed I am. I must thank you for gathering those materials - I haven't had the privilege of forging a weapon of myth in quite some time. Ha!")
                dialog(other, self, "Weapon of myth?")

            elseif string.match(msg, "I m just here for the ambiance") then
                self:say("Hah! If you say so, young master.")

            elseif string.match(msg, "Weapon of myth") then
                self:say("Indeed. The Myth of Gruthluk is likely our oldest surviving tradition. And I'm quite in favor of keeping tradition alive. Forging a Knife of Gruthluk does that quite nicely: it's a powerful symbol of our heritage, and some are inclined to believe the myths on account of the knife-making process described in one of them alone. Made properly, a Knife of Gruthluk really is a phenomenal hunting knife.") 
                dialog(other, self, "How do you make it?")

            elseif string.match(msg, "How do you make it") then 
		        self:say("In the Myth, Gruthluk the Hero forges the knife from the great hell-beasts' carcases in five minutes with his bare hands alone, but I'm quite happy to manage with my workshop, a smithy hammer, six hours, and some arcane fire. Ha! If you're truly interested in our myths, you should go and speak with Galka some time. He and his wife know more about our history than anyone else alive today - and most of what we know about our history comes from the myths.")
            end

            if other:GetFlag(3002) == 6 then
            	if string.match(msg, "What do you know about poisons") and other:GetFlag(3002) == 6 then
                    self:say("Poisons, you say? Well, I suppose I know a good deal about poisons. One doesn't spend fifty years as a practicing apothecary without learning a thing or two about the composition of poisons, and how best to treat their effects. Ah, you - you've dealt with poisons before, haven't you? Maybe even concocted some of your own?")
                    dialog(other, self, "Maybe I have.")
                elseif string.match(msg, "Maybe I have") and other:GetFlag(3002) == 6 then
                    self:say("Well, so long as your poisons are bound to end up in the back of some Kaezulian scoundrel or Baldakan bastard - or perhaps in the bellies of some of the beasts in the wild - I'd be happy indeed to share whatever knowledge I can with you.")
                    dialog(other, self, "Do you have any poison recipe books or such like that I could borrow?")
                elseif string.match(msg, "Do you have any poison recipe books or such like that I could borrow") and other:GetFlag(3002) == 6 then
                    self:say("Well, I do have a great old tome about herbs, some of which have their poisonous properties listed, but a book about fashioning poisons specifically - I'm afraid not.")
                    other:setFlag(3002,7)
                    dialog(other, self, "Well, do you know of any common poisonous herbs that I could find around here?")
                end
            
            elseif other:GetFlag(3002) == 7 then
                if string.match(msg, "do you know of any common poisonous herbs that I could find around here") and other:GetFlag(3002) == 7 then
                    self:say("Hmm, let me see, now. Murk weed is a little poisonous, but it's more for giving careless younglings a rash than for injecting into your enemies. Spores from the murk fern are a little better, and not difficult to find, as murk fern grows here and there throughout the swamp. Ah, but I think the dread toadstool and murk flower would be more what you're after. Dread toadstools only grow on the bodies of the deadly fungi that have been warped into vile beasts. The toadstools grow all over them, but the ones that have just started to shrivel are the most poisonous. Murk flowers, unlike the weeds and ferns, are quite virulent. They grow quite rarely, though - in fact, my tome says that they hardly grow at all except under the cramped, dark space underneath a fat leech. The natural poison that the leech secretes from its body seeps into the ground below them, and is both the twisted fertilizer that allows the flowers to grow, and the main source of their deadly poison.")
                    dialog(other, self, "Well, which should I get?")
                elseif string.match(msg, "Well  which should I get") and other:GetFlag(3002) == 7 then
                    self:text(self:GetName().." thinks for a moment. 'Ah, well, young master, if you can bring me three pieces of each of them - murk weeds, ferns, flowers, and dread toadstools - then I'd be happy to teach you how to extact their poisons. The weeds and ferns would be more for novices, I suppose, but if you want me to teach you about them as well - more power to you, hmm?'")
                    other:setFlag(3002,8)
                    other:journal("Kanruka's Skulduggery", 6, "I need to find three of each of Murk Weed, Murk Fern, Murk Flower and Dread Toadstool and bring them to Gruklikh the Apothecary. He'll teach me how to extract their poisons, which I can then teach to Kanruka.")
                end

            elseif other:GetFlag(3002) == 8 then
                if string.match(msg, "Which poisonous herbs were I supposed to be looking for again") and other:GetFlag(3002) == 8 then
                    self:say("Murk weed, murk fern, murk flower, and dread toadstool, young master. Do you remember where to look for them?")
                    dialog(other, self, "Yes, I do.")
                    dialog(other, self, "Where do I find Murk Weed?")
                    dialog(other, self, "Where do I find Murk Fern?")
                    dialog(other, self, "Where do I find Murk Flower?")
                    dialog(other, self, "Where do I find Dread Toadstool?")
                
                elseif string.match(msg,  "Where do I find Murk Weed") and other:GetFlag(3002) == 8 then
                    self:say("Murk weed is quite common here. You may simply find it growing in the murkwaters, or clinging to the underbellies of the scavenging leeches or to the local fungus men.")
                
                elseif string.match(msg,  "Where do I find Murk Fern") and other:GetFlag(3002) == 8 then
                    self:say("Murk fern can be found growing here and there throughout the swamp, primarily above water. The leaves are poisonous, so most of the scavengers leave it alone - it shouldn't be difficult to find.")
                
                elseif string.match(msg,  "Where do I find Murk Flower") and other:GetFlag(3002) == 8 then
                    self:say("Murk flowers grow almost exclusively in the cramped spaces underneath the fat, immoble leeches. I doubt they would be obliged to move out of your way so that you can dig about under them, however - and the smaller leeches tend to guard them closely.")
                
                elseif string.match(msg,  "Where do I find Dread Toadstool") and other:GetFlag(3002) == 8 then
                    self:say("Dread toadstool can be found growing on the surfaces of the bodies of the local fungus men. They are quite fragile, however, and a battle would likely destroy most of the usable ones.")
                end

            elseif other:GetFlag(3002) == 9 then
                if string.match(msg,  "That s all of them then  isn t it") and other:GetFlag(3002) == 9 then
                    self:say("Indeed. That's about all I know about making poisons from the local selection of herbs. Oh, there are other poisonous ones, I'm sure, but I doubt I'd be able to make use of them without some instruction, or a proper formula. I'm sorry I can't be of more help to you, young master - but thank you for listening to old Gruklikh jabber, eh? Hah!")
                    other:setFlag(3002, 10)
                    other:journal("Kanruka's Skulduggery", 7, "I learned everything Gruklikh knows about making poisons with the locally available ingredients. Time to teach Kanruka what I've learned, so she can get some practice herself.")
                end
            elseif other:GetFlag(3002) == 11 then
                if string.match(msg,  "What were you saying about other poisons") and other:GetFlag(3002) == 11 then
                    self:say("Hm? Ah, I was just saying that there are other poisonous herbs about, but I'm not familiar enough with their poisonous aspects to high-quality poisons from them. If I had a resource which specifically explains how to make better poisons from the local selection, then perhaps I could learn myself and teach you, as well. Perhaps the Baldakans or the Kaezulians know more than lowly old Gruklikh - but good luck getting any help from them!")
                end
            elseif other:GetFlag(3002) == 12 then
                if string.match(msg,  "The poison   tell me about the recipe") and other:GetFlag(3002) == 12 then
                    self:text("Gruklihk studies the page once again. 'This is interesting. The poison doesn't sound especially virulent, but there is something very peculiar about the ingredients it calls for. The first line of the book makes it quite clear that only very exceptional poisons would be included in its pages, so there must be something to it. The recipe calls for leech blood, murk flower, the 'primary venom producing gland of a matured brood leech,' and... a 'self-spawning fungus'? Very strange. I'm not even sure what the last one means - perhaps my grammar is incorrect... Who knows how long ago this recipe was written? But if you, young master, somehow manage to find all the appropriate ingredients, I would be happy to attempt to complete this venom for you, if only to satisfy an old toad's curiousity and to see what all the fuss is about it.")
                    other:journal("Kanruka's Skulduggery", 10, "I found an old poisoncraft recipe and showed it to Gruklikh the Apothecary. If I can find all the ingredients - leech blood, a murk flower, the venom gland of a mature leech, and a self-spawning fungus - then he will help me concoct it. Kanruka will doubtlessly want to know about it if I can manage to complete it.")
                end
            end

            if other:GetFlag(3011) == 6 then
                if string.match(msg, "Tell him about Kathrinka s problem") then
                    self:text("Gruklikh listens to your story from beginning to end without a word, and remains silent for a few minutes afterword. Finally, he speaks. 'There is a way to focus Kathrinka's purifying skills enough to cleanse the pendant, and then some, young master. But first I must give you a little known lesson of our history. Many generations ago, flowers bloomed in this land... The Gruploks were masterful garderers then, and they cultivated the most beautiful of these flowers. In the wilds, these flowers were barren, but the Gruploks discovered that, properly cared for, they could produce a sort of fruit - and this fruit, they also discovered, was blessed. Simply eatting them could cure slight maladies, and they could be used to make a very potent salve. The flowers in the wilds had the potential to spawn such fruits, but without the proper care, the fruits would never ripen, and before they ripened, they had none of their wonderful powers. I have an ancient text which describes a ceremony using this fruit to purify the victim of an otherworldly plague - I'm certain such a fruit could be used to magnify Kathrinka's powers sufficiently without much trouble. But there is one problem...'")
                    dialog(other, self, "And what is that?")
                
                elseif string.match(msg, "And what is that") then
                    self:say("These flowers have become extinct - the cultivated ones, in any case. And the ones in the wilds have become twisted, and scarce... They are what we now call the Murk flowers. They are very poisonous. Normally they only grow in the dankest of places, and not to any size which could hope to bear their fruit. There is hope, however. I hear there is at least one Murk flower, near the center of the swamp, which is very, very old, and has grown to an enormous size. It is doubtlessly large enough to carry its ancient, unripe fruit within its body. Of course, this flower is doubtlessly as twisted as all the beasts in the wilds. It is not likely that mere 'proper care' will make it bare its fruit for us. But I believe I know of another way.")
                    dialog(other, self, "Another way?")
                
                elseif string.match(msg, "Another way") then
                    self:say("Indeed, young master. It is true what Kathrinka told you - that a passive object brimming with goodness can easily be corrupted and used equally powerfully for evil. But the opposite is also true. There is an elixir I know of, one which can easily rot a patch of earth in seconds, one which is pulsive with negative energies. If we were to make it, and have Kathrinka purify it, I be pure enough, and powerful enough, to ripen the fruit in the ancient Murk flower. It is not a simple elixir to make, mind you - the components may be from common beasts, but they must be absolutely pristine. To make it, I will need you to fetch me the most putrid flesh, blood, and brains you can find from the souless beasts that roam this land. You needn't go far in looking for them, I should think. Bring them to me when you have found them all, young master, and I will do my part. Kathrinka needn't lose the hope of being a great Healer for our people, leastwise not while I'm still alive. Haha!")
                    other:journal("A Pendant Most Pure", 5, "Gruklikh says we will need a fruit from an ancient Murk flower to magnify Kathrinka's purification powers. But to get that, I'll need to find the 'most putrid flesh, blood, and brains' I can find from the local beasts to be made into an elixir to ripen the flower's fruit.")
                end
            end
        end
    end
end

function EVENT_ITEM(self, other, item, coin)
	if other:GetFlag(3002) == 8 and item(20765) > 2 then
		item:keep(20765, 3)
		other:setFlag(3021, 1)
		self:say("Ah, the murk weed. Its poison is not very strong, but dried, ground, and mixed into a paste, its toxicity will keep for quite some time. Here, allow me to demonstrate...")
		other:text("You have learned how to make poison from Murk Weed.", 6, true)
		other:giveExp(2500, 0)
        if other:GetFlag(3022) == 1 and other:GetFlag(3023) == 1 and other:GetFlag(3024) == 1 then
            other:setFlag(3002, 9)
            dialog(other, self, "That's all of them then, isn't it?")
        end
	end

	if other:GetFlag(3002) == 8 and item(20766) > 2 then
		item:keep(20766, 3)
		other:setFlag(3022, 1)
		self:say("Ah, yes, the murk fern. Though the leaves still carry some toxicity to ward away insects, the spores are where the real poison is. A little heat will disintegrate the outer shell, allowing you to use the purest of its inner toxins. Here, allow me to demonstrate...")
		other:text("You have learned how to make poison from Murk Fern.", 6, true)
		other:giveExp(5000,0)
        if other:GetFlag(3021) == 1 and other:GetFlag(3023) == 1 and other:GetFlag(3024) == 1 then
            other:setFlag(3002, 9)
            dialog(other, self, "That's all of them then, isn't it?")
        end
	end

	if other:GetFlag(3002) == 8 and item(20767) > 2 then
		item:keep(20767, 3)
		other:setFlag(3023, 1)
		self:say("Oho, you found some of the dread toadstool, did you? Simply squeezing the juices they contain at a foe can have some toxic effects. However, properly extracted and applied, they can be much more effective. There are several steps needed to make a good venom from it, and you have to be quite careful to avoid getting yourself sprayed by its innards while you work with it. Here, allow me to demonstrate...")
		other:text("You have learned how to make poison from Dread Toadstool.", 6, true)
		other:giveExp(15000, 0)
        if other:GetFlag(3021) == 1 and other:GetFlag(3022) == 1 and other:GetFlag(3024) == 1 then
            other:setFlag(3002, 9)
            dialog(other, self, "That's all of them then, isn't it?")
        end
	end

	if other:GetFlag(3002) == 8 and item(20768) > 2 then
		item:keep(20768, 3)
		other:setFlag(3024, 1)
		self:say("Haha! Murk flower, indeed. You must have had quite some fun getting this, eh? Ah, in any case - the murk flower is nearly gushing with toxins, and extracting an effective poison from them is not difficult. The main difficulty is the care required - you need to be quite cautious if you wish to avoid being infected by it. Here, allow me to demonstrate...")
		other:text("You have learned how to make poison from Murk Flower.", 6, true)
		other:giveExp(20000, 0)
        if other:GetFlag(3021) == 1 and other:GetFlag(3022) == 1 and other:GetFlag(3023) == 1 then
            other:setFlag(3002, 9)
            dialog(other, self, "That's all of them then, isn't it?")
        end
	end

	if other:GetFlag(3002) == 11 and item(20764) > 0 then
		item:keep(20764, 1)
		self:text("Gruklikh looks up from his studies and takes the book from your outstretched hand. 'Eh, what's this?' Gruklikh flips through the pages. 'All of the pages past the first are blank. But the first page... It looks to be some kind of formula. But the writing - it seems to be in a very old style. Give me a moment.' Gruklikh squints at the text and mutters to himself in a harsh-sounding language. 'Where did you find this? It's seems to be an old poison recipe, devised by an Iksar - from the old Empire, not a Kaezulian. From the sounds of it, the chap was setting out to write a book on the most deadly poisons he could create, but the fact that he stopped writing after the first recipe would suggest he was perhaps a little too absorbed in his working with poisons, eh? Hah!")
		other:setFlag(3002, 12)
		dialog(other, self, "The poison - tell me about the recipe.")
    end

    if other:GetFlag(3002) == 12 and item(9085) > 0 and item(20768) > 0 and item(20759) > 0 and item(20763) > 0 then
		item:keep(9085, 1)
		item:keep(20768, 1)
		item:keep(20759, 1)
		item:keep(20763, 1)
		self:say("Oho! You found them! You are incredible, young master. Now, let me see what I can do with this...' You watch for several minutes as Gruklikh works silently, sitting on the floor, eyes flitting back and forth between the formula page and his mortar bowl. Finally, he addresses you again. 'I think I am beginning to understand this recipe, young master. Look at this: even ground into mush, the fungus continues to live, and reproduce itself. The fungus absorbs the blood, the juice from the murk flower, and the poison from the venom gland - and somehow reproduces them as well! This is incredible! Reading the recipe, I thought there must be some mistake, or my knowledge of the language was worse than I remembered, because it seemed to call this poison 'Venom of life', which would make no sense - but what it really meant is 'Venom which is alive'! So long as you spare some of this poison, and keep it undiluted, it will continue to produce itself, effectively providing you with endless doses of poison! Here, take it - I will keep a drop for myself to study. This vial may be overflowing within a few hours!'")
		other:giveItem(20769, 1)
    end

    if other:GetFlag(3011) == 6 and other:GetFlag(3001) == 1 and item(20809) > 0 and item(20810) > 0 and item(20811) > 0 then
		other:setFlag(3011, 7)
		item:keep(20809, 1)
		item:keep(20810, 1)
		item:keep(20811, 1)
		self:text("Gruklikh takes the flesh, blood, and brain from your hands, examining them for a moment in his. 'Hmm. Yes, yes, I think these will do quite nicely, young master. Give me a little time to prepare the elixir.' You watch for nearly an hour as Gruklikh prepares the ingredients, his rheumy eyes flitting back and forth between his mortal bowl and the pages of a dusty book. Eventually, he turns and hands you a bottle. 'I spoke with Kathrinka while you were out collecting these, young master, and told her the plan. Purifying this elixir should be a simple trick for her. Just be sure not to drop it, young master - it is still quite potent.'")
		other:journal("A Pendant Most Pure", 10, "I need to take Gruklikh's elixir to Kathrinka to be purified.")
		other:giveItem(20815, 1)
    end
end