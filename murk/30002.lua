-- Grupruk the Thoughtful

function EVENT_SPAWN(self) 
    self:set("playerfriendly", 1)
end

function EVENT_SAY(self, other, msg)
	local flag = other:GetFlag(3000)

	debugtext(other:GetName().."'s Gruplok Faction: "..other:GetCon(600, true)..".")

	if flag == 0 then
		if string.find(msg, "Hail") then
			self:say("Eh?' Grupruk peers at you with a contemplative gaze. He continues to scrutinize you as he speaks in a steady, measured voice. 'I suppose if you were some new kind of Kaezulian monstrosity, you'd have dragged me off by now. Well,' he says with a smile, 'so long as you're willing to be civil - welcome! I'd offer you some szithri stew, but there's an old saying about giving away more than you can catch with your own tongue - and as you can perhaps tell, I prefer to use my tongue for conversation rather than hunting overgrown insects.", 100, other)
			dialog(other, self, "What? Who are you?")
			
		elseif string.find(msg, "Who are you") then
			self:text("Grupruk chuckles, 'Ha! Yes, you're certainly no Kaezulian - they have such a way with words, one can hardly spot a difference between their questions and their commands.' Grupruk croaks, clearing his throat, 'Ah, pardon my rudeness, but it's not every season one meets a friendly stranger in these parts! They call me Grupruk, Grupruk the Wise, Grupruk the Thoughtful... but mostly they call me Grupruk the Fool. For you, simply Grupruk will do, if you please.'")
			dialog(other, self, "Who calls you these? It doesn't seem like anyone else lives here with you.")

		elseif string.find(msg, "seem like anyone else lives here with you") then
			self:say("Quite right, quite right. There is a city in the East, less than an hour's journey from here - more of a village, I suppose - perhaps you've already caught sight of it? Thasra Marlithuk... was once its name, if you choose to believe the tattered historical texts. These days the Kaezulians just call it Gruplok City, and we've taken to following their preference - my people, I mean - the Gruploks.", 100, other)
			dialog(other, self, "What do you mean, 'following their preference'? Are they in league with Kaezul?!")

		elseif string.find(msg, "Are they in league with Kaezul") then
			self:say("Now, now, no need to raise your voice, stranger. The elderly sentries like to say that in their great-grandfathers' day, the Gruploks mounted quite a grand resistance against the Kaezulians and their wicked ways. Of course, they're not terribly pleased to hear an old windbag like me question how effective that resistance really was, considering our present circumstances. You see, the Gruploks are a subjugated people. The Kaezulians have kept us in check for generations - since before the birth of any Gruplok alive today, I can assure you - but exactly how long, we're not sure. We're lucky to have the bits and pieces of our history that we do.", 100, other)
			dialog(other, self, "Subjugated? Why haven't they just destroyed you?")

		elseif string.find(msg, "Subjugated") then	
			self:text("Grupruk sighs, 'Pockets of resistance creep up now and then, inevitably - and there have been times when it seemed like the Kaezulians would burn our fair city and hunt down every last one of us... but for the most part, they tell us what to do, and we listen. They take what little we can make as supplies for their endless campaigns to lands unknown... when they aren't dragging our young off to build extravagant monuments to their Lord, of course. Other than that, and some random patrols and executions to make sure we're still paying attention, they basically leave us to fend for ourselves - which is not an easy task in this wasteland, mind you. It's quite a sad state of affairs, I suppose... but my people have grown accustomed to it. They don't have the patience to live as slaves and listen to my musings at the same time - which is why I'm here instead of there. A self-imposed exile, I suppose you might call it.'")
			dialog(other, self, "How do I get to Gruplok City?")
			dialog(other, self, "[GOOD] Is there some way I can help you?")

		elseif string.find(msg, "How do I get to Gruplok City") then
			other:setFlag(3000, 1)
			self:say("It's due North-East from here, provided you don't mind going for a swim. I don't expect you'll find much hospitality there, mind you. My people - they don't have quite as open a mind as I do, you have to understand. They won't be seen consorting with unknowns, lest they incur the Kaezulians' ire. And some of the younger sentries are fanatic enough to slay anyone they don't recognize without a word of warning, I fear. It's a very trying existence for us, you see - but as bad as it is, my people haven't lost the will to live yet.", 100, other)
			dialog(other, self, "How can I earn their trust?")

		elseif string.find(msg, "Is there some way I can help you") then
			other:setFlag(3000, 1)
			other:addAlignment("Good", 2)
			self:text("Grupruk's eyes widen, 'Help my people? Truly? Well, it'd be no small task to gain their trust - but any assistance you'd be willing to provide would be of great help. We're constantly short on supplies - and on morale.'")
			dialog(other, self, "What do your people need, exactly?")
		end

	elseif flag == 1 then
		if string.find(msg, "Hail") then
			self:text("Grupruk scratches his chin. 'Ah, where was I...'")
			dialog(other, self, "What do your people need, exactly?")

		elseif string.find(msg, "How can I earn their trust") then
			self:say("Earn their trust, you say? Ah, to hear such words has already earned you mine, stranger. But my people need far more than kind words. If you're truly willing to help, however...", 100, other)
			dialog(other, self, "What do your people need, exactly?")

		elseif string.find(msg, "What do your people need") then
			self:text("Grupruk ponders for a moment. 'The Gruploks have long lived off the bounty of Dalaya. These days, however, the beasts that roam the land are twisted and unnaturally strong. Straying far from the city to forage is unsafe for all, and few hunters remain who can fell the local monstrosities for food. On top of that, we don't have the equipment or the energy to train more hunters or gather together in hunting parties - every able-bodied person and every sword is occupied in the defense of the city - and even that isn't enough.'")
			dialog(other, self, "What kind of equipment do they need?")

		elseif string.find(msg, "What kind of equipment do they need") then
			other:setFlag(3000, 2)
			self:say("Hmm. Perhaps some hunting weapons... Ah! I have it! Gruklikh the Apothecary knew how to make the Gruplok hunting knives of old - the kind the elders spoke of of while regaling children with the Myth of Gruthluk. I remember the children would beg him to show them the one he had made. If you could fetch me a thick leech hide, and two spider fangs to be carved into a blade - I'm sure I could be persuaded to take a trip home and tell them all about you and your interest in us.", 100, other)
			other:journal("A Gift for the Gruploks", 0, "Grupruk asked you to find a thick leech hide and two spider fangs, as components for a knife the Gruploks can use for hunting. In return, he promised to put in a good word for you with the Gruplok people.")
		end

	elseif flag == 2 then
		if string.find(msg, "Hail") then
			self:say("Ah, welcome back, my friend. I'd be pleased to chat, but I'm afraid I'm feeling quite tired at the moment...", 100, other)
		end

	elseif flag == 3 then
		if string.find(msg, "Hail") then
			self:say("Greetings, friend.", 100, other)
			dialog(other, self, "How was your trip to the city?")
		
		elseif string.find(msg, "How was your trip to the city") then
			self:text("Grupruk smiles, 'Ah, it was quite a sight for my people. The looks on their faces when they saw me, Grupruk the Fool, approaching the city after so long - and bearing a bounty not seen in decades! Whispering filled the streets in a way that I had not seen since my youth. And the shine in the eyes of the young sentries when I told them that a new Knife of Gruthluk could be forged! Ah, but it was quite an experience for an old windbag like me.' Grupruk sighs, 'The headman, however, was not as excited as I.'")
			dialog(other, self, "Oh? What did the headman say?")

		elseif string.find(msg, "What did the headman say") then
			self:text("The excitement in Grupruk's voice has faded. 'I told him about you and your interest in our city, and made it clear that the pieces for the new knife were a humble gesture from you to our lowly people. He was suspicious - though I must say, he is quite wary, and not one to have his hopes raised - understandably so. Your gift worked in your favor, let me assure you now - but the headman is not keen on symbols and myths when there are more pressing concerns to attend to.'")
			dialog(other, self, "More pressing concerns?")

		elseif string.find(msg, "More pressing concerns") then
			other:setFlag(3000,4)
			self:say("Quite. It seems the supply of food in Gruplok City is atrociously low - even by our standards. The headman asked, 'If this benefactor of yours can slay the local beasts for their rare trinkets, why not for their common meats?' The headman is still quite apprehensive about letting you near the city. But if you can bring me some murk leech meat to bring to them - perhaps five slabs? - even he would be truly grateful. Your gift, the knife, has made you known to my people. If you can provide these meats and relieve their hunger-ravaged bodies - I believe that would truly garner their trust.", 100, other)
			other:journal("A Gift for the Gruploks", 2, "Grupruk has conveyed a message from the Gruplok headman informing you that the Gruplok village's food supply is critically low. He has requested five slabs of giant murk leech meat to quell the shortage. Grupruk believes this could help persuade the villages to trust you.")
		end

	elseif flag == 4 then
		if string.find(msg, "Hail") then
			self:say("How goes the hunt, friend?", 100, other)
		end

	elseif flag == 5 then
		if string.find(msg, "Hail") then
			self:text("Grupruk stretches his legs as he greets you, 'Ah, hello again, friend.' You hear his bones creak as he stretches his arms and back. 'Ahh, that's better. It's been some time since I've traveled like this. I don't have as much energy as I used to, that's for certain.'")
			dialog(other, self, "Did you deliver the meat?")
		
		elseif string.find(msg, "Did you deliver the meat") then
			self:say("Indeed I did. The headman did not let his demeanor betray him, but I know he was truly grateful. As am I. But perhaps I overestimated my people's trust...", 100, other)
			dialog(other, self, "What do you mean?")

		elseif string.find(msg, "What do you mean") then
			self:text("Grupruk sighs. 'You must understand. My people can scarcely recall a time when we were not enslaved. What few stories we have from the old times are only myths. They can hardly conceive of random acts of kindness or of outsiders other than Kaezulians and Baldakans looking to round up slaves whose lives mean nothing to them. Even with both of your gifts, nearly miracles in the eyes of my people, some of them still do not believe that you truly exist, that a stranger would really do this for the lowly Gruploks. And they are afraid. Some almost believe that the Kaezulians will spring from the swamp muck and set the city ablaze the moment you, an outsider, set one foot inside. There is still hope for them, and for you, however.'")
			dialog(other, self, "How do you mean?")
				
		elseif string.find(msg, "How do you mean") then
			other:setFlag(3000, 6)
			self:text("Grupruk speaks in a solemn tone, 'I believe there is one thing you can do which will persuade some of my people to speak with you... You see, we Gruploks have not had a peaceful history. Many Gruploks, leaders, revolutionaries, moralists, innocents, children, entire families, have died violently over the generations: executed, tortured, worked to death. Countless others have died from hunger, or were slain in the wilds by beasts. Many of these most tragic Gruploks, these martyrs, linger... twisted by Kaezulian experiments and necromancy, or by the sheer power of their immortal hatred. Perhaps you have spotted some of them in the swamp... They are mindless, now, thoughtlessly attack any who come near, even their former kinsmen. But they are still Gruploks. We still honor their lives and deaths. If you can put any of them to rest, and bring me some of their remains for burial, I know my that people, in their respect and their grief, will allow you into their city to speak with them.'")
			other:journal("A Gift for the Gruploks", 4, "Grupruk has asked you to put to rest any lingering spirits of Gruploks who were violently killed in the swamp, and to bring back some of their remains for burial.")
		end

	elseif flag == 6 then
		if string.find(msg, "Hail") then
			self:text("Grupruk is strangely quiet. He seems to be lost in his thoughts.")
		end

	elseif flag == 7 then		
		if string.find(msg, "Hail") then
			if other:GetCon(600, true) > 7 then -- if you need more Gruplok Faction:
				self:say("Tough luck, friend? The Gruploks not happy to see you as they should? We will have to take more extreme measures. The Gruploks like to pretend that they are not vengeful and violent, but we both know that is untrue, don't we? Perhaps a little slaughter on their behalf will do much to assuage their wounded pride? Ah, yes, of course. The lizards around the city. The sentinels. Bring me a set of four badges. I will transport them to the Gruploks. Don't worry. They will know it was you who sent them.", 100, other)
			
			else -- if your faction is high enough:
				self:say("Ah, but it's nice to be at rest again. Which reminds me: with all the excitement lately, we haven't had the chance to get acquainted and simply chat. Does any particular subject strike your fancy?", 100, other)
				dialog(other, self, "What do you know about the Kaezulians?")
				dialog(other, self, "What do you know about the Baldakans?")
				dialog(other, self, "What do you know about the history of the Gruploks?")
				dialog(other, self, "What can you tell me about the beasts in the Murk?")
				dialog(other, self, "Not particularly.")
			end

		elseif string.find(msg, "What do you know about the Kaezulians") then
			self:say("There is little that I haven't already conveyed to you, "..other:GetName()..". I have only seen members of their military - brutish, loyal, firm believers in the chain of command. I could not tell you what goes through their soldiers' minds when their superiors tell them to kill innocent Gruploks, but I suspect they have never learned to care - certainly, not for other beings. Do they care for each other? I cannot say. Perhaps only to avoid being punished by their superiors... Ah, but I suppose I'm the only Gruplok who would give them even that much thought. To everyone else, they are monsters - living nightmares each and every one. Ah, but I would be interested to meet one of their citizens one day, and to speak with them openly...", 100, other)
		elseif string.find(msg, "What do you know about the Baldakans") then
			self:say("Ah, I suppose I haven't mentioned much about them, have I? They have taken many Gruploks for slaves recently, although not as many as the Kaezulians have. They have not been around here for very long, at least not that I know of. To be truthful, I know little else about them... precious few stories have circulated about them in Gruplok city, at least when I still resided there. I'm sorry I cannot be more helpful to you, "..other:GetName()..".", 100, other)
		elseif string.find(msg, "What do you know about the history of the Gruploks") then
			self:say("Our history is quite sketchy. We do know that we have a long tradition of myth-telling. Most of what we understand about our history comes directly from the myths, and some Gruploks have spent much time trying to determine how much of it is historically accurate - which figures truly lived, which events truly happened, and which are merely fantasies. I wonder if it is truly worth the effort. Some of them seem to believe that finding the right myth and proving it to be true will be enough to suddenly free our people, give meaning to all our past struggles, and vindicate all those who have died... Ah, but if you'd like to know more, "..other:GetName()..", you should go and speak with Galka and his wife, Kalunepe. They are the current living authorities on Gruplok history and myth.", 100, other)
		elseif string.find(msg, "What can you tell me about the beasts in the Murk") then
			self:say("I have done all I can to keep clear of them, myself. But I suppose I can recall some of the things the huntsmen used to say. Let me think... The szithri are bloodsuckers, and very numerous throughout the swamp. Most are somewhat weak, and easy to flee, though I have heard of greater szithri defeating seasoned huntsmen quite horrifically. Murklings are also bloodsuckers, but tend to stay near the murkwaters. I have heard that they form into social groupings, unlike the szithri, with most murklings hunting to gather food for the broodmothers they cluster around. I've heard that there are serpents in some of the deeper murkwaters, and some consider their meat a delicacy, but I've never actually caught sight of one myself, come to think of it. I believe I've already explained to you about the fallen Gruploks that linger... Ah, there are also the fungus men, a result of unnatural growth among the fungus patches that have always surrounded the swamp. I don't know what to tell you about them - I've rarely heard of them. And that is about all I know on this subject, I suppose. I'm sorry my information isn't a little more concrete or firsthand, but monstrosities have never been my particular interest, you know! Haha!", 100, other)
		elseif string.find(msg, "Not particularly") then
			self:say("Ah, I know the feeling, friend. Sometimes it is best to just let the mind wander. And yet, sometimes simply letting one's mind wander can be too much, even for me. Ah, but some of the things we do are so absurd when we stop to think about them, don't you agree, "..other:GetName().."? Perhaps most people never have the experience... Why do my people go on living? Oh, certainly, a few of the townspeople have learned to cope, learned to live for today as their tomorrows are never certain - but the wisdom in that is another issue altogether. Most of my people live in constant fear and insecurity for all of their lives, never assured that they will have food to eat, never assured that the next patrol won't decide to take them or their family away, never to return, at a whim. And yet they live out their lives, day by day, some cowering openly, some cowering under a thin veil of pride or apathy. Why do they do it? Do they think the freedom of the Gruploks is only a matter of time? If not, then how do they justify it, how do they justify continuing to mate, to have families, to bring new lives into their world of slavery and fear? Is the continuation of the Gruploks really worth all of our suffering, our pains, our countless perils? Or do they even think of it? Do they simply perpetuate the species mindlessly, like animals, like the beasts in the wilds? Is there truly any purpose to it all? Would we really be any worse off if we allowed ourselves to become extinct, never to be born into suffering again...?' Grupruk continues muttering to himself. He seems to have forgotten he was talking to you.", 100, other)
		end
	end
end

function EVENT_ITEM(self, other, item)
	local flag = other:GetFlag(3000)

	if flag == 2 then
		if item(20752) > 1 and item(20753) > 0 then
			item:keep(20752, 2)
			item:keep(20753, 1)
			other:setFlag(3000, 3)
			self:text("Grupruk smiles, 'Aha! Leech skin and spider fangs, indeed! You truly are a person of your word, friend. We could use more vibrant folk like you in our fair city, if only they could raise everyone's spirits the way you have raised mine. No matter, I must bring this bounty to the city at once! I will return as soon as I can. You have my thanks - hopefully my people will not withhold theirs.")
			other:giveExp(5000)
			other:giveFaction(600, 1100)
			other:journal("A Gift for the Gruploks", 1, "Grupruk accepted the hunting knife components and took them to the Gruplok village. You should speak with him when he returns.")
			depop(self)
		end

	elseif flag == 4 then
		if item(20754) > 4 then
			item:keep(20754, 5)
			other:setFlag(3000, 5)
			self:text("Grupruk smiles as he admires the quality of the meats. 'Ah, you have done it again, my friend! These should provide enough rations to feed the entire city for a week! The headman will surely be pleased. I will return shortly.'")
			other:giveExp(10000, 0)
			other:giveFaction(600, 100)
			other:journal("A Gift for the Gruploks", 3, "Grupruk accepted the five slabs of murk leech meat and transported them to the Gruplok village to be made into rations. You should speak with Grupruk when he returns.")
			depop(self)
		end

	elseif flag == 6 then
		if item(20755) > 0 then
			item:keep(20755,1)
			other:setFlag(3000, 7)
			self:text("Grupruk gathers the remains in his hands and takes a long, deep breath. He seems unusually somber. 'Thank you, my friend... Thank you. I must make another trip, but you needn't wait for me. Once they have heard from me, someone among them will wish to talk to you, and you have my word.' Grupruk carefully places the remains into his haversack, and leaves due North-East.")
			other:giveExp(25000, 0)
			other:giveFaction(600, 151)
			other:journal("A Gift for the Gruploks", 100, "You gave Grupruk the Thoughtful the remains of a fallen Gruplok, and with this gesture you have gained permission to enter the Gruplok village.")
			if other:GetCon(600, true) > 7 then
				other:text("You get the feeling that the Gruplok's may not accept you just yet...", 0, true)
			end
			depop(self)
		end

	elseif flag == 7 and other:GetCon(600, true) > 7 then
		if item(41055) > 3 then
			item:keep(41055, 4)
			self:say("Excellent, a full set. The sad Gruplings will appreciate your hard work and violence.", 100, other)
			other:giveFaction(600, 25)
		end
	end
end