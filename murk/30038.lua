-- Krukin the Cook

function EVENT_SAY(self, other, msg)
    local hail = string.match(string.lower(msg), "hail")
    local helped_Gralak = other:GetFlag(3006)
    local cook_quest = other:GetFlag(3008)

    self:face(other)

    if other:GetFlag(3000) == 7 then
        if helped_Gralak then
            if cook_quest > 8 then
                if hail then
                    self:say("Why, hello "..other:GetName().."! Decided to drop my little kitchen another visit have you? Do you need something cooked up?")
                    dialog(other, self, "What did you need to make Co`dair steaks again?")
                    dialog(other, self, "What did you need to make that exotic stew again?")
                end

                if hail and other:GetFlag(3055) > 0 then
                    dialog(other, self, "What did you need to make the drink with a kick again?")
                end

                if hail and other:GetFlag(3056) > 0 then
                    dialog(other, self, "What did you need to make the calming, contemplative drink again?")
                end

                if string.match(msg, "What did you need to make Co dair steaks again") then
                    self:say("You liked those, hmm? I can fry you up a couple steaks if you bring me two slabs of Co`dair meat and some vegetables and spices.")
                end

                if string.match(msg, "What did you need to make that exotic stew again") then
                    self:say("Ah, the stew caught you fancy, did it? I can cook up some more if you bring me some more of that - what did you call it - ''wyrm'' meat? That and six wild mushrooms along with some rare spices is all I'll need!")
                end

                if string.match(msg, "drink with a kick again") and other:GetFlag(3055) > 0 then
                    self:say("Let's see here... The recipe calls for an, er, an ''essence of pure, unadulterated rage''... two small vials of um, ''sweat and toil from overworked laborers'', and finally, some very strong, very cheap alcohol. Um, I'm not sure this is a normal kind of drink, or a good-intentioned kind of recipe... But, um, let's try it, shall we? Somehow, I don't think you'll find any of that in this swamp...")
                end

                if string.match(msg, "calming  contemplative drink again") and other:GetFlag(3056) > 0 then
                    self:say("Let's see here... Hmm, this appears to be an old, traditional Gruplok hunter's drink, something to keep them alert. It says here we need some ''elemental water, swelling and fallen from the sky'' and two shots of juice from crushed sand beetle-innards, both combined in a special flask used by the Gruplok hunters of old. Hmmm... I'm not sure if anyone can make those flasks any more. I've rarely heard about them. Perhaps you will be able to find them somewhere...")
                end
            end
            if cook_quest == 0 then
                if hail then
                    self:say("Oh, hello. What brings- oh, oh oh oh! You're the one who's been bringing in meat for our illustrious rationer Gralak, aren't you! Pleased to meet you, I'm Krukin, the one who does most of the cooking around here.")
                    dialog(other, self, "Pleased to meet you.")

                elseif string.match(msg, "Pleased to meet you") then
                    self:say("Gralak's told me a bit about you. The beasts out there are no match for you, huh? I wish I could say the same for us. As boring as it is cooking nothing but icky murk leech meat all the time, I'd never want to run out of it again. That shortage was getting pretty frightening... I'm pretty insulated in here - I enjoy cooking, and it lets me keep my mind off of things, plus there are a lot of mouths to feed so I'm obliged to keep cooking for most of the day - but even I couldn't help but grasp just how precarious our existence is when Gralak came and told me that there wouldn't be anything left to cook the next day. Thank you so much for helping us get through that!")
                    dialog(other, self, "No problem.")

                elseif string.match(msg, "No problem") then
                    self:say("If you say so! I'm just happy that I can go on cooking. But still - and don't think I'm not grateful! - murk leech meat is terribly boring to cook. Serpent meat is tastier, but it's not exactly an epicurean delight - at least, not on its own.")
                    dialog(other, self, "And?")

                elseif string.match(msg, "And") then
                    self:say("Well... you told Gralak that you'd keep your eyes open for potential foodstuffs that you come across in the wilds, right? Gralak is great at what he does, don't get me wrong - he has a great head for numbers, bless him - but he's clueless when it comes to good food. I thought that maybe you could keep a look out for some more interesting culinary odds and ends for me. Even Gralak knows that serpent meat is tasty - I'm sure he has you looking for it, it's his favorite - but there's a world of difference between a boiled slab of meat and a REAL, well-prepared, honest-to-goodness meal. If you can help me out, it'd cure my doldrums - but more importantly, I'm sure it'd raise morale around here, and any help we can get in that department would be well worth it! Murk leech meat may fill our bellies well enough, but that alone just isn't enough - don't you agree?")
                    dialog(other, self, "What did you have in mind?")

                elseif string.match(msg, "What did you have in mind") then
                    self:say("Well, some wild mushrooms would be good to start with. They complement serpent steaks very well as a side dish, and if you could get me a nice supply of them... I'm sure I'd find a lot of uses for 'em! I have some other ideas, but mushrooms will be good for now - just working with something other than raw meat would be a nice change of pace, and I'm sure the others would agree. We used to have our own gardens, my mother used to say... but the only place to get some mushrooms now would be in the wilds. They tend to grow in the hills, above far from the murkwaters - but some of them have grown into twisted fungus men over the centuries, and they tend to hang around the patches that they grew in. But I'm sure they'll be no problem for you! Ten wild mushrooms should do for a start.")
                    other:setFlag(3008, 1)
                    other:journal("Krukin`s Cuisine", 1, "Krukin wants me to get ten wild mushrooms from the fungus patches above the swamplands, for use in cooking up some finer food for the Gruploks.")
                end

            elseif cook_quest == 1 then
                if hail then
                    self:say("You still remember, right? Ten wild mushrooms! If you can manage that, I might have you look for some more interesting things.")
                end

            elseif cook_quest == 2 then
                if hail then
                    self:text("Krukin hums to herself while she stirs the mushrooms in their pot.")
                    dialog(other, self, "Was there something else you wanted?")

                elseif string.match(msg, "Was there something else you wanted") then
                    self:say("Oh! Yes indeed, "..other:GetName()..", if you don't mind! It's been a long time since the Gruploks went beyond the swamplands with any persistence. Our cooking definitely reflects that - at least, I know most of my mother's recipes do. Leech meat, mushrooms, murk weeds, maybe some serpent meat now and then... But! I do know of a few very old recipes that I would like to try, exotic ones to the Gruplok palate! If you'd be willing to take your searching outside of the swamp for me, that is.")
                    dialog(other, self, "Certainly. What do you need?")

                elseif string.match(msg, "Certainly  What do you need") then
                    other:setFlag(3008,3)
                    self:say("One of these recipes calls for Co`dair meat. Seems those wolves have roamed in the nearby forest for quite some time. If you could bring me a couple slabs of their meat, and - let me see here... ah! - and some vegetables, along with a pinch of spice, I think I could do this recipe proud!")
                    other:journal("Krukin`s Cuisine", 3, "Krukin wants me to gather two slabs of Co`dair meat from the nearby plains, as well as some vegetables and spices, for an old recipe she wants to try.")
                end

            elseif cook_quest == 3 then
                if hail then
                    self:say("Two slabs of Co`dair meat, and some vegetables and spices. Got it, "..other:GetName().."?")
                end

            elseif cook_quest == 4 then
                if hail then
                    self:say("I hope you like those steaks, "..other:GetName()..".")
                    dialog(other, self, "Any other recipes you'd like to try?")

                elseif string.match(msg, "It s excellent") then
                    self:say("I'm glad you like it! The vegetables might be a little bland, but I think the steaks turned out rather well. I'd be happy to cook you some more, any time you like: just bring me some more Co`dair meat, vegetables, and spices. Ah, I can't wait to see Gralak when he tries this!")
                    dialog(other, self, "Any other recipes you'd like to try?")

                elseif string.match(msg, "It s not to my taste") then
                    other:addAlignment("Chaotic", 3)
                    self:say("Ah, that's too bad, "..other:GetName()..". I think they turned out rather well, considering! If you change your mind and would ever like some more, bring me some more co'dair meat, vegetables, and spices, and I'll cook you up some. Ah, I can't wait to see Gralak when he tries these!")
                    dialog(other, self, "Any other recipes you'd like to try?")

                elseif string.match(msg, "Any other recipes you d like to try") then
                    other:setFlag(3008, 5)
                    self:say("Do you really need to ask? Haha! I'd like to try something a little different this time. I'd like you to go back to your lands, and bring me the biggest slab of meat from the biggest meaty creature you can find! Along with that, I'd like another six or so wild mushrooms from the swamp, and some spices - the better quality, rarer kind of spices. I want to try to make a stew, something really exotic. I'll be waiting for you, "..other:GetName().."!")
                    other:journal("Krukin`s Cuisine", 5, "Krukin wants me to bring her the 'biggest slab of meat from the biggest meaty creature' I can find, plus six more wild mushrooms and some rare spices to make a stew with.")
                end

            elseif cook_quest == 5 then
                if hail then
                    self:say("I'm not too familiar with the beasts in your lands, "..other:GetName()..", but I've heard there are some really terribly huge beasts roaming around in some of your colder climates. It sounds like something straight out of one of our myths! Hehe!")
                    dialog(other, self, "What did you need for the recipe you're working on, again?")

                elseif string.match(msg, "What did you need for the recipe you re working on  again") then
                    self:say("Need a reminder, do you? Haha! Well, I wanted to try something a little different this time. I'd like you to go back to your lands, and bring me the biggest slab of meat from the biggest meaty creature you can find! Along with that, I'd like another six or so wild mushrooms from the swamp, and some spices - the better quality, rarer kind of spices. I want to try to make a stew, something really exotic. I'll be waiting for you, "..other:GetName().."!")
                end

            elseif cook_quest == 6 then
                if hail then
                    self:say("Well then, "..other:GetName()..". You've been quite a help to me. I haven't had such fun with my cooking in years! I certainly couldn't have done it without you - I'm sure the other Gruploks appreciate a little variety in their diets too. Still, there's one more thing I'd like to do, with your help, if you'd be interested.")
                    dialog(other, self, "What's that, Krukin?")

                elseif string.match(msg, "What s that  Krukin") then
                    self:say("There's one more recipe my mother left me that I would really like to try. When I was still a little toadling, she would tell me how much she wanted to make this recipe, just once in her life. It's a recipe she got from her grandmother, apparently, and was rumoured to be absolutely divine. My mother never managed to make it, though. So now I guess it falls to me! It might not mean much to you, but I hope you won't mind helping me get the ingredients I'll need for it.")
                    dialog(other, self, "Sure, I'll help. What do you need?")
                    dialog(other, self, "[GOOD] I would be happy to help fulfill your mother's wishes! What do you need?")
                    dialog(other, self, "[LAWFUL] Well, I've come this far with you - it would be rude to say no now, eh? So, what do you need?")
                    dialog(other, self, "[CHAOTIC] I suppose so. Just promise me I'll get my fair share! What do you need?")

                elseif string.match(msg, "Sure  I ll help  What do you need") then
                    other:setFlag(3008, 7)
                    self:say("Oh, thank you! This is a very large meal, a bit of a banquet I suppose, and calls for some very rare ingredients. Murk leech meat and serpent meat form the basis of the meal. The serpent meat tends to be good quality, and has quite a potent taste - three slabs should do. As for the leech meat, however, only the finest quality meats will suffice. The recipe specifies that only meat from the most matured murk leeches should be used. Apparently the mature leeches also tend to be quite big - two slabs of their best quality meat will do. I've got some leftover vegetables from you that I can use, but I'll need you to get me a little cheese to melt over everything. One heap of cheese should be enough. Lastly, the rarest ingredient.. and that one which truly makes the meal.")
                    dialog(other, self, "What is it?")

                elseif string.match(msg, "I would be happy to help fulfill your mother s wishes  What do you need") then
                    other:setFlag(3008, 7)
                    other:addAlignment("Good", 3)
                    self:say("Oh, thank you! This is a very large meal, a bit of a banquet I suppose, and calls for some very rare ingredients. Murk leech meat and serpent meat form the basis of the meal. The serpent meat tends to be good quality, and has quite a potent taste - three slabs should do. As for the leech meat, however, only the finest quality meats will do. The recipe specifies that only meat from the most matured murk leeches will do. Apparently the mature leeches also tend to be quite big - two slabs of their best quality meat will do. I've got some leftover vegetables from you that I can use, but I'll need you to get me a little cheese to melt over everything. One heap of cheese should be enough. Lastly, the rarest ingredient.. and that one which truly makes the meal.")
                    dialog(other, self, "What is it?")

                elseif string.match(msg, "Well  I ve come this far with you   it would be rude to say no now  eh  So  what do you need") then
                    other:setFlag(3008, 7)
                    other:addAlignment("Lawful", 3)
                    self:say("Oh, thank you! This is a very large meal, a bit of a banquet I suppose, and calls for some very rare ingredients. Murk leech meat and serpent meat form the basis of the meal. The serpent meat tends to be good quality, and has quite a potent taste - three slabs should do. As for the leech meat, however, only the finest quality meats will do. The recipe specifies that only meat from the most matured murk leeches will do. Apparently the mature leeches also tend to be quite big - two slabs of their best quality meat will do. I've got some leftover vegetables from you that I can use, but I'll need you to get me a little cheese to melt over everything. One heap of cheese should be enough. Lastly, the rarest ingredient.. and that one which truly makes the meal.")
                    dialog(other, self, "What is it?")

                elseif string.match(msg, "I suppose so  Just promise me I ll get my fair share  What do you need") then
                    other:setFlag(3008, 7)
                    other:addAlignment("Chaotic", 3)
                    self:say("I'm sure there'll be enough to go around! This is a very large meal, a bit of a banquet I suppose, and calls for some very rare ingredients. Murk leech meat and serpent meat form the basis of the meal. The serpent meat tends to be good quality, and has quite a potent taste - three slabs should do. As for the leech meat, however, only the finest quality meats will do. The recipe specifies that only meat from the most matured murk leeches will do. Apparently the mature leeches also tend to be quite big - two slabs of their best quality meat will do. I've got some leftover vegetables from you that I can use, but I'll need you to get me a little cheese to melt over everything. One heap of cheese should be enough. Lastly, the rarest ingredient.. and that one which truly makes the meal.")
                    dialog(other, self, "What is it?")
                end

            elseif cook_quest == 7 then
                if hail then
                    self:say("This is a very large meal, a bit of a banquet I suppose, and calls for some very rare ingredients. Murk leech meat and serpent meat form the basis of the meal. The serpent meat tends to be good quality, and has quite a potent taste - three slabs should do. As for the leech meat, however, only the finest quality meats will do. The recipe specifies that only meat from the most matured murk leeches will do. Apparently the mature leeches also tend to be quite big - two slabs of their best quality meat will do. I've got some leftover vegetables from you that I can use, but I'll need you to get me a little cheese to melt over everything. One heap of cheese should be enough. Lastly, the rarest ingredient.. and that one which truly makes the meal.")
                    dialog(other, self, "What is it?")

                elseif string.match(msg, "What is it") then
                    self:say("The recipe calls for a leaf of Murk flower to be ground into a spice. Apparently it's quite a delicacy. There's one problem, though. Maybe Murk flowers were more common back when this recipe was first written, but nowadays they rarely ever grow. Mostly they grow as teensy tiny things under the bellies of the fattest murk leeches, so they say, but those are useless to us, and far too poisonous to make into food. However, there are a few ancient Murk flowers that remain, grown supernaturally large. There isn't enough light to sustain them at the size they are now, and so they spend most of their time curled up, protecting their weakened flowers. Unfortunately the leaves we need tend to be just under their petals, and protected by the outer layers when they curl themselves up. You'll need to wake the flower up... and for just that purpose, I've been talking to Gruklikh, our apothecary. He gave me this - he says that if you pour it onto one of the giant Murk flowers' roots, it'll awaken and open itself up, letting us get at its inner leaves, within moments! However, Murk flowers are known for their poisonous properties, and with their size and all the beasts running around nowadays, I wouldn't be surprised if they were more dangerous than they appear... please be careful, "..other:GetName()..". Come talk to me if you run into trouble and need more of Gruklihk's flower-wakening formula.")
                    other:setFlag(3008, 8)
                    other:giveItem(20804, 1)
                    other:journal("Krukin`s Cuisine", 50, "Krukin wants to try one last big recipe. She needs three slabs of serpent meat, two slabs of mature murk leech meat, some cheese, and a leaf from one of the few giant Murk flowers that can be found in the swamp. I'll need to use the formula she gave me to wake the Murk flower up - if I fail, Krukin can get me some more.")
                end

            elseif cook_quest == 8 then
                if hail then
                    self:say("Hiya "..other:GetName()..". Did you need some more of Gruklikh's formula to wake up the Murk flowers?")
                    dialog(other, self, "No, I'm quite alright, Krukin. I'll get you what you need before you know it!")
                    dialog(other, self, "Yes, I need some more of that formula.")
                    dialog(other, self, "What was it that you needed again?")

                elseif string.match(msg, "What was it that you needed again") then
                    self:say("This is a very large meal, a bit of a banquet I suppose, and calls for some very rare ingredients. Murk leech meat and serpent meat form the basis of the meal. The serpent meat tends to be good quality, and has quite a potent taste - three slabs should do. As for the leech meat, however, only the finest quality meats will do. The recipe specifies that only meat from the most matured murk leeches will do.")
                    self:say("Apparently the mature leeches also tend to be quite big - two slabs of their best quality meat will do. I've got some leftover vegetables from you that I can use, but I'll need you to get me a little cheese to melt over everything. One heap of cheese should be enough. Lastly, the rarest ingredient.. and that one which truly makes the meal... The recipe calls for a leaf of Murk flower to be ground into a spice. Apparently it's quite a delicacy. You'll need to find a Murk flower and wake it up... and for just that purpose, I've been talking to Gruklikh, our apothecary.")
                    self:say("He gave a mixture - he says that if you pour it onto one of the giant Murk flowers' roots, it'll awaken and open itself up, letting us get at its inner leaves, within moments! However, Murk flowers are known for their poisonous properties, and with their size and all the beasts running around nowadays, I wouldn't be surprised if they were more dangerous than they appear... please be careful, "..other:GetName()..". Come talk to me if you run into trouble and need more of Gruklihk's flower-wakening formula.")
                
                elseif string.match(msg, "Yes  I need some more of that formula") then
                    if check_for_formula(other) then
                        self:say("It looks to me like you still haven't used the one I gave you, "..other:GetName()..".")

                    else
                        self:say("Alrighty! Gruklikh gave me some extra. Here you go!")
                        other:giveItem(20804, 1)
                    end
                
                elseif string.match(msg, "No  I m quite alright  Krukin  I ll get you what you need before you know it") then
                    self:text("Krukin smiles. 'Okay, "..other:GetName().."!'")
                end

            elseif cook_quest == 9 then
                if hail then
                    dialog(other, self, "Do you have anything else you want help with? I rather liked hunting down ingredients for you!")

                elseif string.match(msg, "rather liked hunting down ingredients for you") then
                    self:say("Is that so, "..other:GetName().."? Haha! Well, now that you mention it, with my cooking having been such a success with all your help, I got to thinking that I might try drabbling in some brewing! Now, I'm certainly no expert brewer, and if we Gruploks ever had a proud tradition of it, it'd be news to me. Does that interest you, "..other:GetName().."?")
                    dialog(other, self, "Sure, I'll help you dabble with some brewing.")
                    other:setFlag(3008, 10)
                end

            elseif cook_quest == 10 then
                if hail and (other:GetFlag(3055) == 0 or other:GetFlag(3056) == 0) then
                    dialog(other, self, "I'll help you dabble with some brewing.")
                end

                if string.match(msg, "I ll help you dabble with some brewing") then 
                    self:say("Great! I've been speaking with Gruklikh on the matter, and he found me some old brewing recipes. They aren't much to go on, and seem quite outdated... But I'm sure we'll be able to make them work! Mind you, I have a feeling these ingredients will be a mite bit harder to come by than the things you gathered for me before. In any case, I'm not sure where to begin! What kind of drink strikes your fancy?")
                    if other:GetFlag(3055) == 0 then
                        dialog(other, self, "Something with a kick.")
                    end
                    if other:GetFlag(3056) == 0 then
                        dialog(other, self, "Something calming, contemplative.")
                    end

                elseif string.match(msg, "Something with a kick") and other:GetFlag(3055) == 0 then
                    self:say("Alright! Let's see here... The recipe calls for an, er, an ''extraction of pure, mindless rage''... one vial of um, ''unnatural raging essence'', and finally, some very strong, very cheap alcohol. Um, I think we can use any kind of strong alcohol, but perhaps a brandy would do. I've seen Kaezulian officers come through the city drinking some before and he was very angry looking, so it seems fitting... Good luck!")
                    other:journal("Krukin`s Kicker", 1, "Krukin needs an `extraction of pure, mindless rage`, an `unnatural raging essence`, and some brandy to make me a drink with a kick.")
                    other:setFlag(3055, 1)
                
                elseif string.match(msg, "Something calming  contemplative") and other:GetFlag(3056) == 0 then
                    self:say("Ah! Let's see here... Hmm, this appears to be an old, traditional Gruplok hunter's drink, something to keep them alert. It says here we need some ''dew water, collected from trapper fauna'', then a ''collection of calming essence'', and two bushels of murk weed. Hmmm... gathering murk weed seems relatively simple, but I'm not sure where these fauna would be, or a collection of calming essense. Perhaps you will be able to find them somewhere... Good luck!")
                    other:journal("Krukin`s Contemplation", 1, "Krukin needs some `dew water, collected from trapper fauna`, a collection of calming essence, and some murk weed.")
                    other:setFlag(3056, 1)
                end
            end
        else
            if hail then
                self:text("Krukin hums to herself softly as she peers at one of her boiling pots and shoots a glance over the others. She doesn't seem to have heard you.")
            end
        end
    end
end

function check_for_formula(player)
    for k, v in pairs(player:GetInventory()) do
        if v:GetID() == 20804 then
            return true
        end
    end
    return false
end

function EVENT_ITEM(self, other, item, coin)
	if other:GetFlag(3008) == 1 and item(20774) > 9 then
		item:keep(20774, 10)
		other:setFlag(3008, 2)
		self:say("Oh, you got them already? Faster than I was expecting! Ah, let me see if I can remember what my mother taught me about cooking these...")
		other:journal("Krukin`s Cuisine", 2, "I brought Krukin ten wild mushrooms, like she asked. Perhaps she has another job for me.")
		other:giveExp(3000, 0)
		other:giveFaction(600, 10)
		dialog(other, self, "Was there something else you wanted?")
	end

	if other:GetFlag(3008) == 3 and item(40906) > 1 and item(1355) > 0 and item(3370) > 0 then
		-- item:keep(20801, 2)
		item:keep(40906, 2)
		item:keep(1355, 1)
		item:keep(3370, 1)
		other:setFlag(3008, 4)
		self:say("Ah, thank you kindly, "..other:GetName().."! I think this calls for some good old fashioned frying!' Krukin throws the vegetables in a pot to boil, and produces a small grill to cook the meat on. She asks you to wait until she's finished - it doesn't take long. 'Alright, there we go! I'd be honored if you'd be the first to try it, "..other:GetName()..". How is it?")
		other:giveItem(20802, 2)
		other:journal("Krukin`s Cuisine", 4, "I brought Krukin the Co`dair meats and fixings she wanted. Perhaps she has another job for me.")
		other:giveExp(7500, 0)
		other:giveFaction(600, 30)
		dialog(other, self, "It's excellent.")
		dialog(other, self, "[CHAOTIC] It's not to my taste.")
	end

	if other:GetFlag(3008) > 3 and item(40906) > 1 and item(1355) > 0 and item(3370) > 0 then
		item:keep(40906, 2)
		item:keep(1355, 1)
		item:keep(3370, 1)
		self:say("Oh! Looking for some more Co`dair steaks are you, "..other:GetName().."? I'll have these done for you in just a moment!")
		other:giveItem(20802, 2)
	end

	if other:GetFlag(3008) == 5 and item(1016) > 0 and item(20774) > 5 and item(10603) > 0 then
		item:keep(1016, 1)
		item:keep(20774, 6)
		item:keep(10603, 1)
		other:setFlag(3008, 6)
		self:say("Oh my. This really is quite a huge slab of meat. I could feed half the town with this! Thank you, "..other:GetName()..". I'll get to work on my stew right away! I think this will work out quite nicely. If you don't mind waiting, you can have the first taste of this, too.")
		other:giveItem(20803, 2)
		other:journal("Krukin`s Cuisine", 6, "I brought Krukin the biggest slab of meat I could find, and everything she wanted to go with it. Perhaps she has another job for me.")
		other:giveExp(7500, 0)
		other:giveFaction(600, 30)
	end
    
	if other:GetFlag(3008) > 5 and item(1016) > 0 and item(20774) > 5 and item(10603) > 0 then
		item:keep(1016, 1)
		item:keep(20774, 6)
		item:keep(10603, 1)
		self:say("Ah, up for some more stew, "..other:GetName().."? I'll have it done in just a few minutes.")
		other:giveItem(20803, 2)
	end
	
    if other:GetFlag(3008) == 8 and item(20772) > 2 and item(20805) > 1 and item(10608) > 0 and item(20806) > 0 then
		item:keep(20772, 3)
		item:keep(20805, 2)
		item:keep(10608, 1)
		item:keep(20806, 1)
		other:setFlag(3008, 9)
		other:setFlag(3010, other:GetFlag(3010) + 1)
		self:say("Oh wow, you found them all, "..other:GetName().."! I was beginning to doubt the ancient Murk flowers were still around, but these leaves seem to be very healthy. I'm sure they'll make for a marvelous spice! I'm going to get started on this right away - please wait around a while, "..other:GetName()..". I want you to have the first bite!' Krukin begins grilling some of the meat and boiling some vegetables. You watch her as she checks everything meticulously - nothing under- or over-cooking in her kitchen. You begin to feel a little bored when Krukin turns to you. 'I made your share extra-quick. It might be a little hot, and the flavor might suffer just a tiny bit without the proper time to soak everything in, but I think it will be quite good regardless! I'm very, very happy with this meal. I think everyone will agree it was worth waiting a few decades for! Thank you so much for all you've helped me with, "..other:GetName().."! I really don't deserve all you've done for me, all the new things I was able to try, thanks to you. If you ever need anything else cooked up, just come talk to me. Come see me any time!")
		other:giveExp(30000, 0)
		other:giveFaction(600, 100)
		other:giveItem(20807, 5)
		other:journal("Krukin`s Cuisine", 100, "I helped Krukin gather everything she needed to finish the meal her mother was never able to complete, which was her last request of me.")
	end
	
    if other:GetFlag(3056) == 1 and item(60159) > 0 and item(60160) > 0 and item(20765) > 1 then
		item:keep(60159, 1) -- drop of dew - szithri trapper in Remnants
		item:keep(60160, 1) -- calming essense - any calm-side creature in remnants
		item:keep(20765, 2) -- murk weed
		self:say("Excellent, "..other:GetName().."! This looks like everything we need. Give me a moment!' Krukin mixes the ingredients in a small wooden bowl before pouring them into a flask. 'Here you go! Just gather me some more of those ingredients if you'd like some more!")
		other:setFlag(3056, 2)
		other:giveExp(20000, 0)
		other:giveFaction(600, 50)
		other:giveItem(13678, 1)
		other:journal("Krukin`s Contemplation", 100, "I gathered the ingredients for Krukin`s calming, contemplative drink.")
	end
	
    if other:GetFlag(3056) == 2 and item(13675) > 0 and item(13676) > 0 and item(13677) > 1 then
		item:keep(60159, 1)
		item:keep(60160, 1)
		item:keep(20765, 2)
		self:say("Ah! Just a moment, "..other:GetName().."!' Krukin mixes the ingredients in a small wooden bowl before pouring them into a flask. 'Here you go!")
		other:giveItem(13678, 1)
	end
	
    if other:GetFlag(3055) == 1 and item(13679) > 0 and item(60161) > 0 and item(19011) > 0 then
		item:keep(13679, 1) -- mindless rage from kaesora
		item:keep(60161, 1) -- raging essence - any angry-side creature in remnants
		item:keep(19011, 1) -- brandy
		self:say("Ah! I suppose this is what we need... Just a moment.' Krukin cringes as she mixes the liquids, then pours them into a bottle. 'Here you go!")
		other:setFlag(3055, 2)
		other:giveExp(20000, 0)
		other:giveFaction(600, 50)
		other:giveItem(13682, 1)
		other:journal("Krukin`s Kicker", 100, "I gathered the ingredients for Krukin`s drink with a kick.")
	end
	
    if other:GetFlag(3055) == 2 and item(13679) > 0 and item(60161) > 1 and item(19011) > 0 then
		item:keep(13679, 1)
		item:keep(60161, 1)
		item:keep(19011, 1)
		self:say("Ah... Just a moment.' Krukin cringes as she mixes the liquids, then pours them into a bottle. 'Here you go!")
		other:giveItem(13682, 1)
	end
end