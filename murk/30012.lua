-- Healer Kathrinka

function EVENT_SAY(self, other, msg)
    local hail = string.find(msg, "Hail")
    local faction = other:GetCon(600, true) -- 9 - scowling, 1 - ally
    local alchemy_quest = other:GetFlag(14029)
    local dark_waters_quest = other:GetFlag(19000)
    local pendant_most_pure_quest = other:GetFlag(3011)
    local alchemy = other:GetSkill(59)

    self:face(other)

    if other:GetFlag(3000) == 7 then
        -- ###  alchemy QUEST STUFF     ######
        if faction <= 5 then
            if alchemy_quest == 0 then
                if string.match(string.lower(msg), "alchemy") then
                    self:say("Alchemy?  Well, of course, it is the healer's stock and trade.  But.. as I have explained, there are no wonders I can work with my meager powers.")
                    dialog(other, self, "Surely there must be something we can work on together.")

                elseif string.match(string.lower(msg), "surely there must be something we") then
                    self:say("Together.. yes, perhaps.  If there is one thing that Gruklikh has taught me, it is that we are never without hope.  But, to actually succeed in this.  No, it is too much to hope for.")
                    dialog(other, self, "I will do anything I can to assist you.")
                
                elseif string.match(string.lower(msg), "i will do anything") then
                    self:say("If that is the case, there may be hope yet.  My mentor spoke of a powerful healing mixture, made with common ingredients from these lands.  This was ages ago, when the Gruplok could move freely about the continent.  Still.. I have seen you come and go as you please, so you may be the ray of hope.  I need only a pulsating co`dair bladder and a handful of glowing moss.  And, though it pains me to ask-..")
                    dialog(other, self, "What else do you require?")
                
                elseif string.match(string.lower(msg), "what else do you") then
                    self:say("I need.. an ordinary potion of healing to use as a base.  This should be a small task for a healer, but as you see...  Thank you for this kindness and good luck.")
                    other:setFlag(14029, 1)
                    other:journal("Gruplok Healing", 10, "Kathrinka has request a pulsating co`dair bladder, glowing tunnel moss, and a potion of healing.")
                end

            elseif alchemy_quest == 1 then
                self:say("Have you found them, yet?  The bladder, moss, and potion?")
                
            elseif alchemy_quest == 2 then
                if hail then
                    self:say("Yes?")
                    if alchemy >= 225 then
                        dialog(other, self, "That glow.. from your hands..")
                    end

                elseif string.match(string.lower(msg), "that glow   from your hands") then
                    self:say("You could make this too, if you wish to learn."..(other:GetFlag(14026) == 100 and "" or "Seek out Goplen, he will have a task for you."))
                    if other:GetFlag(14026) == 100 then
                        dialog(other, self, "Yes, please show me.")
                    elseif other:GetFlag(14026) < 10 then
                        other:setFlag(14026, 10)
                    end

                elseif other:GetFlag(14026) == 100 and string.match(string.lower(msg), "yes  please show me") then
                    self:say("Sweet friend, the ability to fashion this unction resides within you.  The ingredients do naught but bring it to the fore.  What you require is as you have seen.  A co`dair bladder, but any will do.  A handful of the moss.  A healing potion.  And, but oh dear.. you would need a sacred stone known to us as Gruthulk's Tooth.  Where you could find that, I have no idea.")
                    other:giveExp(100000, 0)
                    other:journal("Gruplok Healing", 100, "I can now make my own unctions with a co`dair bladder, glowing tunnel moss, a potion of healing, and a Tooth of Gruthulk.")
                    other:setFlag(14029, 10)
                end
            end
        end

        -- Dark Waters --
        if dark_waters_quest == 3 or dark_waters_quest == 4 then
            if dark_waters_quest == 3 then
                if hail then
                    self:say("Are you the one?")
                    dialog(other, self, "Kukrika asked that I bring this to you.")

                elseif string.match(msg, "Kukrika asked that I bring this to you") then
                    self:say("May I see what you found?")
                end

            elseif dark_waters_quest == 4 then
                if hail then
                    self:say("Ah "..other:GetName()..", I guess your braver than I had hoped, or just as foolish. Time will tell soon enough.")
                    dialog(other, self, "Foolish indeed.")

                elseif string.match(msg, "Foolish indeed") then
                    self:say("Well then, let me tell you a tale.  He left many years ago, strange one he was.  His mind lost to the swamps, but once he was a skilled alchemist, more so than I ever was.  You see every alchemist has to test their creations, or at least breathes them.  This is what happened to Githpick, his creations were unpredictable at best, some could make you a skilled hunter, others might give you an extra eye!  After decades of this, his creations finally took their toll.")
                    dialog(other, self, "Where can I find him now?")

                elseif string.match(msg, "Where can I find him now") then
                    self:say("Last I heard he was still in the swamp, maybe he couldn't leave I don't know for sure.  But look for him you must.  He sat out years ago along the south west river, you may start your search there.")
                    dialog(other, self, "I will search for him.")

                elseif string.match(msg, "I will search for him") then
                    self:say("Take this note. He may not believe that you are who you say you are.")
                    other:giveItem(25202, 1)
                    other:setFlag(19000, 5)
                    other:journal("Dark Waters", 2, "Kathrinka wants me to find Githpick to the south west, he may know what has happened to the swamp.")
                end
            end
        else
        -- A Pendant Most Pure -- 
            if pendant_most_pure_quest == 0 then
                if hail then
                    self:say("Hello...")
                    dialog(other, self, "Uh, hi. You're a healer, are you?")

                elseif string.match(msg, "Uh  hi  You re a healer  are you") then
                    self:say("Yes, I am. There is little use for my meager skills here, however... You're the one who gave Grupruk the remains of a lingering Gruplok, aren't you?")
                    dialog(other, self, "Indeed I am.")
                elseif string.match(msg, "Indeed I am") then
                    self:say("I see... It must be quite an interesting life you lead, needing only to raise a weapon and kill all your problems away. Quite enviable, I suppose. Simply keeping this rain water purified seems to take too much energy from me nowadays... Ah, but thank you for putting those fallen Gruploks to rest. It is far beyond my power to purify them, but I still seem to be able to calm their fragmented remains. If you can put any more of them to rest, I would be glad to purify their remains. You need only bring them to me...' Kathrinka suddenly winces sharply, and visibly begins gasping for breath. Before you can say anything, she straightens herself out again. 'If that is all, stranger... please, leave me.'")
                end

            elseif pendant_most_pure_quest == 1 then
                if hail then
                    self:say("So many fallen Gruploks... I'm not sure how many more I can purify with my abilities alone...")
                    dialog(other, self, "What do you mean?")
                        
                elseif string.match(msg, "What do you mean?") then
                    if other:GetClass() == 2 or other:GetClass() == 6 or other:GetClass() == 10 then
                        self:say("Perhaps healing tricks are no difficulty for you, "..other:GetName()..", but my purifying abilities are dependent on a source: my own inner purity, and the purity of the things, places, and people around me... But it has been generations since we Gruploks have had a temple, or even so much as a shrine. The people have no energy and little resources to build a new one, but more than that... their minds are too clouded. Their thoughts dwell on their fears and anxieties - an uncaring, apathetic darkness seems to cling around the whole city... They are not happy, and very few of them are pure enough. Even I have heard more than I can bare, and my abilities have been growing ever weaker... I need to use this purified water to complete even the simplest purifying rituals. But I suppose that is my burden to bear in this life...' Kathrinka looks up at you searchingly for a few moments. 'I'm.. sorry to have troubled you with my problems. It is not my desire to involve anyone in my woes.")
                    else
                        self:say("Perhaps it is beyond your understanding, "..other:GetName()..", but my purifying abilities are dependent on a source: my own inner purity, and the purity of the things, places, and people around me... But it has been generations since we Gruploks have had a temple, or even so much as a shrine. The people have no energy and little resources to build a new one, but more than that... their minds are too clouded. Their thoughts dwell on their fears and anxieties - an uncaring, apathetic darkness seems to cling around the whole city... They are not happy, and very few of them are pure enough. Even I have heard more than I can bare, and my abilities have been growing ever weaker... I need to use this purified water to complete even the simplest purifying rituals. But I suppose that is my burden to bear in this life...' Kathrinka looks up at you searchingly for a few moments. 'I'm.. sorry to have troubled you with my problems. It is not my desire to involve anyone in my woes.")
                    end
                    dialog(other, self, "Please - perhaps I can help?")
                    
                elseif string.match(msg, "Please   perhaps I can help") then
                    other:setFlag(3011, 2)
                    self:text("Kathrinka coughs a few times. 'Doubtful. Where could any purity be found in this accursed place? Even a sacred, purified object would quickly decay and lose its power here, without anyone looking over it. Finding a truly pure heart is out of the question... If you could find a pure object, perhaps you could help me, but I'm beginning to doubt such things exist in this world any more...")
                
                end

            elseif pendant_most_pure_quest == 2 then
                self:say("A truly pure object... If such a thing really existed, it could ease my troubles, certainly... But such fantasies are useless. How could such a thing exist in this terrible world?")

            elseif pendant_most_pure_quest == 3 then
                if hail then
                    self:say("I should have no troubles purifying the remains of the twisted Gruploks, should you bring any more to me. Perhaps I could do even more, now...")
                    dialog(other, self, "More? What do you mean?")
                
                elseif string.match(msg, "Well  it wasn t doing me any good  I thought you might be able to do something with it") then
                    self:say("Indeed. I should have no troubles purifying the remains of the twisted Gruploks, should you bring any more to me. Perhaps I could do even more, now...")
                    dialog(other, self, "More? What do you mean?")

                elseif string.match(msg, "More  What do you mean") then
                    self:say("It has been many years since I considered such things... But, perhaps now, with this stone - and your help, "..other:GetName().." - I can finally bring some purity back to this land...")
                    dialog(other, self, "How do you intend to do that?")
                
                elseif string.match(msg, "How do you intend to do that") then
                    self:say("This stone... its purity and power is great, but it is too raw, too general, too - unfocused. During my training, I remember my mentor- the previous Healer for our city - showing me a pendant he carried. It was a moonstone, mounted in a fixture of gold, and brimming with pure energies. He told me that all of the Gruplok Healers of old carried such objects: the stone was a source of power, but the fixture is what truly made its powers useful. The fixture was imbued with powerful enchantments, the arts of which have been lost... These enchantments allowed the purity of the stone to be harnessed and channeled through the user's will - it is what allowed the healers to perform incredible healing ceremonies, shield our town from pestilence and disease, and protect our hunters from vile beasts in the wilds. It is what allowed them to do all the things that I have never been able to do...")
                    dialog(other, self, "Go on.")
                
                elseif string.match(msg, "Go on") then
                    other:setFlag(3011,4)
                    self:say("If I am to truly make use of your gift, I will need such a fixture. As I said, the proper arts of enchanting that they required have been lost. However, there is hope, of a kind... Not long before my training was to be completed, my mentor was taken by the Kaezulians for questioning, never to return... He never got the chance to pass his pendant on to me. I am certain he would not have let it fall into the wrong hands - it is only an object, after all, and a powerful object of good can be changed into a powerful object of evil far too easily... I have little doubt that my mentor is now among the twisted Gruploks whose remains you have brought to me. If you find him, please put him to rest, and bring me his pendant.")
                    other:journal("A Pendant Most Pure", 1, "Kathrinka wants to use the stone I gave her to bring purity to the Murk. To do this she will need a fixture - apparently the pendant her slain mentor used to carry is the only such fixture that will do.")
                
                end
            elseif pendant_most_pure_quest == 4 then
                self:say("If you can find my mentor's pendant, perhaps I will finally be able to claim my rightful position as a protector of our fair city...")

            elseif pendant_most_pure_quest == 5 then
                if hail then
                    dialog(other, self, "Isn't there something we can do? Another fixture we can find?")

                elseif string.match(msg, "Isn t there something we can do  Another fixture we can find") then
                    other:setFlag(3011,6)
                    self:say("If this fixture has become so corrupted in only a handful of years, there is little hope of finding an older one which his less corrupt. Perhaps... Allow me to think for a moment.' Kathrinka stares at the reflective surface of her purified water while she collects her thoughts. Soon, she speaks, her breath creating tiny ripples in the pool. 'Perhaps there is someone who could help us purify *this* fixture. Please go and find Gruklikh the Apothecary, and tell him everything I have told you. He is very wise - he may know something I do not, some way to focus my purification abilities enough to quell this corruption.")
                    other:journal("A Pendant Most Pure", 3, "Kathrinka wants me to talk to Gruklihk the Apothecary. She thinks he may be able to help her purify the fixture of the pendant.")
                end

            elseif pendant_most_pure_quest == 8 then
                if hail then
                    self:say("Hello, "..other:GetName()..". Do you need more of the elixir..?")
                    dialog(other, self, "No, not yet anyway.")
                    dialog(other, self, "Yes, I need more of the elixir.")

                elseif string.match(msg, "Yes  I need more of the elixir") then
                    self:say("Alright, "..other:GetName()..". I hope you have better luck with this dose...")
                    other:giveItem(20814, 1)
                end

            elseif pendant_most_pure_quest > 8 then
                -- self:say("Good day, "..other:GetName().."! Thank you again for all you've done for me. I'm beginning to learn how to harness the power of the stone you gave me effectively. I hope I will be able to use it for the same grand purposes the Healers of old did, someday...")
            end
        end    
    end

    -- Myths and Bones -- 
	if other:GetFlag(3009) == 16 then
        if hail then
            self:say(other:GetName().."...")
            dialog(other, self, "Yes?")
        elseif string.match(msg, "Yes") then
            other:setFlag(3009, 17)
            self:say("Here... take these to Glakrin... he will be so happy. You have my thanks...' Kathrinka shudders, and closes her eyes to rest.")
            other:giveItem(20788, 1)
            other:journal("Myths and Bones", 50, "Kathrinka has performed the prayer on the stone weapons. I should get these over to Glakrin.")
        end

    elseif other:GetFlag(3009) == 15 then
        if hail then
            dialog(other, self, "Kalunepe sent me.")
        elseif string.match(msg, "Kalunepe sent me") then
            self:say("Ah, you are the one she was speaking of? Then come, show me the weapons and the scroll.")
        end
    end
end

function EVENT_ITEM(self, other, item, coin)
    -- Dark Waters -- 
	if item(25201) > 0 and other:GetFlag(19000) == 3 then
		item:keep(25201, 1)
		self:say("Ah, so you are the one Kukrika spoke of.  She told me what has been happening to the children and who may be responsible.  Let me take a look at the vial quickly.' Kathrinka pours some of the vial in the cauldron and swirls it about. 'Kathrinka speaks, I don't have the power left in me to cure this, whoever created this knows our history.  This type of poison hasn't been seen in a very long time.  There is only one left still alive who may know something. We are meddling in something much bigger than ourselves, this may not end like you have hoped, if you want to keep your head attached I would suggest leaving now and never speaking of this.  On the other hand, if you like being headless there maybe someone we can talk to.")
		other:setFlag(19000, 4)
		other:giveExp(1000, 0)
    end

    -- A Pendant Most Pure -- 
    -- Gruplok Remains -- 
    local gruplok_remains_count = other:GetFlag(3012)
    if item(20755) > 0 then
        if gruplok_remains_count == 26 then
            item:keep(20755, item(20755))
            self:say("So many Gruploks twisted by hatred... I fear there isn't enough purity in the world today to cleanse them all...", 100, other)
            other:giveFaction(600, item(20755))
            other:giveExp(500 * item(20755), 0)

        elseif other:GetFlag(3011) > 0 and gruplok_remains_count < 26 then
            item:keep(20755, 1)
            other:giveFaction(600, 5)
            other:setFlag(3012, gruplok_remains_count + 1)
            self:say("Ah, more Gruploks put to rest... Thank you.", 100, other)
            other:giveExp(2500, 0)
        
        elseif gruplok_remains_count == 9 then
            item:keep(20755, 1)
            other:giveFaction(600, 10)
            other:setFlag(3012, gruplok_remains_count + 1)
            other:setFlag(3011, 1)
            self:say("Still more twisted Gruplok remains... I'm not sure how many more of these I can purify with my abilities alone...", 100, other)
            other:giveExp(2500, 0)
            dialog(other, self, "What do you mean?")

        elseif gruplok_remains_count < 9 then
            item:keep(20755, 1)
            other:giveFaction(600, 10)
            other:setFlag(3012, gruplok_remains_count + 1)
            self:say("Ah, more Gruploks put to rest... Thank you, stranger.", 100, other)
            other:giveExp(2500, 0)
        end
    end

    if other:GetFlag(3011) == 2 and item(20808) > 0 then
		item:keep(20808, 1)
		other:setFlag(3011, 3)
		self:text("Kathrinka takes the stone in her hands with a bewildered, uncomprehending look on her face. 'I... could feel something, something very powerful and perplexing enter the city. Its presence seemed.. pure, somehow. I could hardly understand it - but now I understand even less. How did you..? Where..?' Kathrinka looks at you searchingly for a moment before resting her crinkled brow. You think you detect the beginnings of a smile on her face, just barely. 'I suppose it isn't important. This.. this gift, this blessing - I don't know what to say. This stone is saturated with purified energies. Drawing from its power, my tasks should be much easier on me. I could never have hoped for something like this, "..other:GetName().."... Thank you.")
		self:face(other)
        other:giveFaction(600, 1)
		other:giveExp(8000, 0)
		dialog(other, self, "Well, it wasn't doing me any good. I thought you might be able to do something with it.")
    end

    if other:GetFlag(3011) == 4 and item(20813) > 0 then
		item:keep(20813, 1)
		other:setFlag(3011, 5)
		self:say("Ah, this is indeed my mentor's pendant, but... Its purity is gone. It has been corrupted... did the Kaezulians get ahold of it after all? But if they did this, why wouldn't they keep it? Perhaps my mentor simply became too twisted, and his torment and his hatred overpowered the purity of the stone... We can replace the corrupt stone with the stone you gave me, but even the fixture has absorbed too much corruption - we cannot use it, not as it is. I do not believe I can purify it, not with the unfocused stone alone. This is most unfortunate...")
		other:giveFaction(600, 5)
		other:giveExp(5000, 0)
		other:journal("A Pendant Most Pure", 2, "I found the pendant Kathrinka was looking for, but it turns out that it is too corrupt for her to use. Perhaps there's another way...")
		dialog(other, self, "Isn't there something we can do? Another fixture we can find?")
    end

    if other:GetFlag(3011) == 7 and item(20815) > 0 then
		other:setFlag(3011, 8)
		item:keep(20815, 1)
		self:say("Ah, it is good to see you again, "..other:GetName()..". So this is the elixir Gruklikh was speaking of, hmm? It will only take me a moment - we needn't even use all of it.' Kathrinka produces a smaller bottle, pours some of the elixir into it, then adds a droplet of her purified water and begins to chant softly. Little seems to happen, but in a few moments Kathrinka hands you the small bottle. The liquid inside is much lighter than the elixir Gruklikh gave you - almost florescent. Kathrinka speaks, 'This should do, I hope... Pour this onto the ancient Murk flower out in the swamp. The flowers are know to be quite deadly, and this one is likely quite twisted.. Gruklikh says that the elixir may take several minutes to ripen the flower's fruit and remove the poisons flowing through it and the flower's body. If you should need another dose of the elixir, come speak with me. And "..other:GetName().."... Be careful.'")
		other:giveItem(20814, 1)
		other:journal("A Pendant Most Pure", 50, "Kathrinka has given me the purified elixir to use on the ancient Murk flower in the swamp. I'll need to use it to get the fruit from the flower's body. If I need another dose of the elixir, Kathrinka has some to spare.")
    end

    if other:GetFlag(3011) == 8 and item(20812) > 0 then
		other:setFlag(3011, 9)
		other:setFlag(3010, other:GetFlag(3010) + 1)
		item:keep(20812, 1)
		self:say("This is the fruit? Gruklikh was right.. it is *very* pure. I am surprised, considering its source... Ah, in any case, thank you, "..other:GetName()..". Gruklikh has already told me what I must do with this. If you'll excuse me.'  Kathrinka turns and places the stone, her mentor's pendant, and the fruit into a pool of purified water. After a brief chant, the water begins to radiate with white light. You don't much understand the rest of the ceremony, but soon it is over, and Kathrinka reaches into the water before turning back to you. 'The pendant has been purified, and the enchantments restored... The stone in my mentor's pendant has been restored as well, although I will not need it with the stone you have given me. Here, "..other:GetName()..", I'd like you to have my mentor's pendant. I'll only need a small part of it chain to be made into a fixture for my stone - it is no sense wasting the powers of my mentor's pendant. Even if it is not useful to you, it should provide you with some protection, at least in this place... Thank you, "..other:GetName()..", for all your help.'")
		other:journal("A Pendant Most Pure", 100, "Kathrinka has completed the ceremony to purify the fixture for her pure stone. She has given me her mentor's pendant - something she had considered a lost cause - and says it may provide me with some protection.")
		other:giveFaction(600, 25)
		other:giveExp(25000, 0)
		other:giveItem(20816, 1)
    end

    -- Myths and Bones -- 
	if other:GetFlag(3009) == 15 and item(20784) > 0 and item(20785) > 0 and item(20786) > 0 and item(20787) > 0 then
		item:keep(20784, 1)
		item:keep(20785, 1)
		item:keep(20786, 1)
		item:keep(20787, 1)
		other:setFlag(3009, 16)
		self:text("Kathrinka carefully sets the weapons into a tub of purified water, then glances over the prayer scroll. Then she closes her eyes and stands silently for several minutes, concentrating, focusing her entire consciousness onto her task. Finally, she begins to chant the prayer from the scroll, her voice suddenly filled with beauty. Soon - too soon, you feel - her voices dies away, and Kathrinka sighs heavily to herself before finally opening her eyes again. She speaks to you, her voice suddenly very weary, '"..other:GetName().."...'")
		self:face(other)
        dialog(other, self, "Yes?")
    end

    -- Alchemy Quest --
	if item(41116) > 0 and item(41120) > 0 and item(6883) > 0 and other:GetFlag(14029) == 1 then
		item:keep(41116,1)
		item:keep(41120,1)
		item:keep(6883,1)
		self:doAnim(14)
	    self:text("Kathrinka solemnly blends the elements together.  Her hands glow softly as the combination clears.")
		other:setFlag(14029, 2)
		other:giveFaction(600, 80)
		other:giveExp(12000, 0)
		self:say("My word, it worked!  Perhaps there is healing power in my soul after all.")
		other:giveItem(21768, 5)
		other:journal("Gruplok Healing", 50, "Kathrinka has made me an unction.")
		self:text("Kathrinka is still breathless and gazes at you in wonder.")
        if other:GetSkill(59) >= 225 then
            other:text("You understand the meaning behind the glow..", 6, true)
            dialog(other, self, "That glow.. from your hands..")
        end
    end
end