-- Kanruka the Quiet.lua
-- The Murk
-- There is also a separate QST script for her rogue-only questline.

local flagId = 49001; 
local alignmentFlag = 49002; 
local daggerId = 45602; 

function checkForDagger(equipped)
	for i, v in pairs(equipped) do
		if v:GetID() == daggerId then
			return v:GetLevel();
		end
	end
	
	return false;
end

function EVENT_SAY(self, other, message)
	local daggerLevel = checkForDagger(other:GetInventory())
	local flag = other:GetFlag(flagId);
	
	if message:lower():find("hail") and flag == 7 and daggerLevel then
		if other:GetFlag(3002) < 15 and daggerLevel and flag >= 7 then
			other:text("Kanruka isn't a master rogue yet, but she might become one with time and help.", 5, true)
		else
			self:text("Kanruka the Quiet stares at you. Her eyes briefly fall to your Reactive Dagger, but she notices you catch her gaze and immediately looks away.")
			dialog(other, self, "I see you fancy my dagger.")
		end
	elseif message:lower():find"fancy my dagger" and flag == 7 and daggerLevel then
		if daggerLevel == 50 then
			self:text("Kanruka thinks to herself for a moment, and then speaks. 'No. I could never make good use of a weapon that powerful. It's literally gleaming with unrealized potential.'")
			dialog(other, self, "I've heard. What is this unrealized potential, and how can I unlock it?.")
			dialog(other, self, "Alright, I can see where this is going.. how much do you want?")
			other:setFlag(flagId, 8)
		else 
			self:text("Kanruka scoffs at you. 'You don't even know how to use it yourself. You can come back and brag about it after you've mastered it.'")
			other:text(("Reactive Dagger Level: [%d / 50]"):format(daggerLevel), 5, true)
			other:journal("Madrick`s Dagger", 3, "Kanruka said (in a pretty rude manner) that I should fully master the Reactive Dagger before speaking with her.")
		end
	elseif message:lower():find("hail") and flag == 8 and daggerLevel == 50 then
		self:text("Kanruka says, 'I'll need three thousand platinum for further information. Rest assured though, I have nowhere to flee to, and with a weapon that powerful, you could kill me in an instant if I were to lie.'")
		dialog(other, self, "*Pay her*")
		
		if other:GetFlag(alignmentFlag) ~= 1 then -- don't show the option if they already did it
			dialog(other, self, "*Raise your weapon* [EVIL]")
		end
	elseif message:lower():find("unrealized potential") and flag == 8 and daggerLevel == 50 then
		self:text("Kanruka smirks. 'I'll need three thousand platinum for further information. Rest assured though, I have nowhere to flee to, and with a weapon that powerful, you could kill me in an instant if I were to lie.'")
		dialog(other, self, "*Pay her*")
		
		if other:GetFlag(alignmentFlag) ~= 1 then -- don't show the option if they already did it
			dialog(other, self, "*Raise your weapon* [EVIL]")
		end
	elseif message:lower():find("see where this is going") and flag == 8 and daggerLevel == 50 then
		self:text("Kanruka grins widely. 'You read me like a book! To the point then - three thousand platinum, and I'll spill.'")
		dialog(other, self, "*Pay her*")
	elseif message:lower():find("raise your weapon") and flag == 8 and daggerLevel == 50 and other:GetFlag(alignmentFlag) ~= 1 then
		other:setFlag(alignmentFlag, 1) -- prevent them from spamming the message to get infinite alignment
		addalignment(other, "evil", 2)
		self:text("Kanruka chuckles, a surprisingly relaxed expression on her face. 'I can respect that attitude, but I'm guessing it must have taken quite a bit of effort to get my people to accept you around here.. It'd be a shame for all that work to go to waste. Not to mention, I'm likely the only one who can tell you about that dagger. Think again.'")
		dialog(other, self, "*Pay her*")
	elseif message:lower():find("pay her") and flag == 8 and daggerLevel == 50 then
		if not other:takeCash(0, 0, 0, 3000) then 
			self:text("Kanruka the Quiet says, 'So how are you going to pay me then? You don't have what I asked for.'")
			return 
		end;
		
		other:setFlag(flagId, 9)
		self:text("Kanruka takes a short bow before swiping the coin from the palm of your hand, almost faster than your eye can catch. A second later, however, you realize that the dagger is now in her hand, and not in yours. She examines it for a brief moment, and then hands it back to you as if nothing happened at all. She clears her throat before speaking.", 1)
		self:timer("speaker", 2000, true, function()
			self:text("Kanruka the Quiet says, 'For some reason, when you reforged this dagger, a small void opened up inside it. The more you used it, the larger that void became. Now that you've mastered it, the blade is hollow deep within. The Gruploks of old forged similar weaponry that was hollow on the inside to be filled up with spirits to empower it, though they never even came close to this level. The stash of our weapons the Kaezulians took was similar.")
			dialog(other, self, "*Wait her to continue*")
		end)
	elseif message:lower():find("hail") and flag == 9 and daggerLevel == 50 then
		self:text("Kanruka the Quiet says, 'For some reason, when you reforged this dagger, a small void opened up inside it. The more you used it, the larger that void became. Now that you've mastered it, the blade is hollow deep within. The Gruploks of old forged similar weaponry that was hollow on the inside to be filled up with spirits to empower it, though they never even came close to this level. The stash of our weapons the Kaezulians took was similar.")
		dialog(other, self, "*Wait her to continue*")
	elseif message:lower():find("to continue") and flag == 9 and daggerLevel == 50 then
		self:text("Kanruka the Quiet says, 'The craftsmanship is superb, and its power is immense... but filling in the void could improve it greatly. You could reforge the blade to fill the void, but a weapon made simply of metal can only go so far - don't you agree? I imagine under the same heat it was forged in, your dagger would grow significantly stronger if infused with a powerful essence. Weaker essences will do as well, though in much larger quantities.'")
		dialog(other, self, "Could you be more descriptive? I've come across all sorts of 'essences' in my days.")
	elseif message:lower():find("more descriptive") and flag == 9 and daggerLevel == 50 then
		self:text("Kanruka the Quiet hesitates quietly for a good long moment. 'Since you've helped me, I always sneak out of this village whenever the guards don't notice. I've been around this continent quite a bit, and even further beyond, if you must know. A lake to the southwest of here is home to some powerful undead. They have essence fragments you could probably use. Almost anything you could call an essence with some decent power behind it should work, though. Experiment however you like, but be careful with extremely powerful essences, and don't bother with really weak ones.'")
		other:setFlag(flagId, 10)
		other:setFlag(alignmentFlag, 0) -- how many essences (reuses the alignment flag's number because you can only do the alignment dialog if flagId == 8 (and we just set it to 10)
		other:journal("Madrick`s Dagger", 4, "Kanruka said that filling the void within my dagger with enough essences from virtually anything will make it significantly stronger.")
	end
	
	if message:match("Hail") and other:GetFlag(3000) == 7 and other:GetClass() ~= 9 then
		self:text("Kanruka the Quiet glances at you without the slightest sign of interest.");
	elseif message:match("Hail") and other:GetFlag(3000) == 7 and other:GetClass() == 9 and other:GetFlag(3002) == 0 then
		self:text("Kanruka stares at you.");
		other:dialog(self, "What?");
	elseif message:match("Hail") and other:GetClass() == 9 and other:GetFlag(3002) == 100 then
		other:addAlignment("Chaotic",10);
		other:setFlag(3002,2);
	end

	if message:match("What") and other:GetFlag(3000) == 7 and other:GetClass() == 9 and other:GetFlag(3002) == 0 then
		self:text("Kanruka hesitates. 'You... You're quite a shady character, aren't you? You're a - rogue?");
		other:dialog(self, "That's what they tell me. How did you guess?");
	end
	if message:match("That s what they tell me  How did you guess") and other:GetFlag(3000) == 7 and other:GetClass() == 9 and other:GetFlag(3002) == 0 then
		self:text("Kanruka chuckles softly. 'Call it intuition. Anyhow, I think there's something that you can do for me... if you've got the guts, and don't mind earning a profit on the side.");
		other:dialog(self, "Count me in!");
		other:dialog(self, "Why should I trust you?");
	end
	if message:match("Count me in") and other:GetFlag(3000) == 7 and other:GetClass() == 9 and other:GetFlag(3002) == 0 then
		other:addAlignment("Chaotic",2);
		other:setFlag(3002,1);
		self:text("Kanruka smirks. 'Just the answer I was looking for. Maybe you've already guessed it, but I don't belong here. The Gruploks are too busy feeling sorry for themselves and letting outsiders walk all over them to do anything with their lives. I want to be out there! Exploring, adventuring, getting myself into trouble - I have a feeling you understand what I mean. They won't let me do what I want - they won't let me leave. I can take care of myself, if they'd just let me be...");
		other:dialog(self, "I understand, but what do you need me for?");
	end
	if message:match("Why should I trust you") and other:GetFlag(3000) == 7 and other:GetClass() == 9 and other:GetFlag(3002) == 0 then
		other:setFlag(3002,1);
		self:text("Kanruka lets out a single laugh. 'Ha! I think you and I will get along just fine. Maybe you've already guessed it, but I don't belong here. The Gruploks are too busy feeling sorry for themselves and letting outsiders walk all over them to do anything with their lives. I want to be out there! Exploring, adventuring, getting myself into trouble - I have a feeling you understand what I mean. They won't let me do what I want - they won't let me leave. I can take care of myself, if they'd just let me be...");
		other:dialog(self, "I understand, but what do you need me for?");
	end
	if message:match("I understand  but what do you need me for") and other:GetFlag(3002) == 1 then
		self:say("I just need you to do a few things for me. Pretty simple, really");
		other:dialog(self, "If it's so simple, why don't you do it yourself?");
	end
	if message:match("If it s so simple  why don t you do it yourself") and other:GetFlag(3002) == 1 then
		self:say("Heh. Well, I've already earned myself a bit of a reputation here, you see. I can hardly leave my home without one of the Sentries' eyes boring into me. With the stuff you've done for the Gruploks, you can pretty much do as you please around here without raising everyone's suspicions. I want you to make use of that privilege for me, that's all. Like I said: there'll be profit in it for you, believe me");
		other:dialog(self, "Alright. What do you need me to do?");
		other:dialog(self, "What a waste of my time. If you really need something done, do it yourself and stop whining about it to me");
	end
	if message:match("Hail") and other:GetFlag(3002) == 1 then
		self:say("Maybe you've already guessed it, but I don't belong here. The Gruploks are too busy feeling sorry for themselves and letting outsiders walk all over them to do anything with their lives. I want to be out there! Exploring, adventuring, getting myself into trouble - I have a feeling you understand what I mean. They won't let me do what I want - they won't let me leave. I can take care of myself, if they'd just let me be..");
		other:dialog(self, "I understand, but what do you need me for?");
	end
	if message:match("Alright  What do you need me to do") and other:GetFlag(3002) == 1 then
		self:say("Well, for starters... that moron Guluk confiscated something from me the other day. He's probably still carrying it around - all the sentries seem to make a habit of carrying around anything important. Probably because the Kaezulian patrols would get suspicious if we made ourselves a secure storage space, I guess. Anyway, if you can manage to pinch it off him and get it back to me, I'm sure it would be the start of a profitable friendship for the both of us");
		other:journal("Kanruka`s Skulduggery",1,"Kanruka wants me to lift something of hers off of Sentry Guluk and bring it back to her. She has promised me a 'profit' if I can manage to do that.");
		other:setFlag(3002,2);
	end
	if message:match("What a waste of my time  If you really need something done  do it yourself and stop whining about it to me") and other:GetFlag(3002) == 1 then
		other:addAlignment("Evil",5);
		self:say("...");
		other:setFlag(3002,100);
	end
	if message:match("Hail") and other:GetFlag(3002) == 2 then
		self:say("Well? Did you get it yet?");
	end
	if message:match("Hail") and other:GetFlag(3002) == 3 then
		self:say("Hey there. I thought of some other things you can do for me, if you've got some time");
		other:dialog(self, "What did you have in mind?");
		other:dialog(self, "Maybe later");
	end
	if message:match("That s it") and other:GetFlag(3002) == 3 then
		self:say("Hey, money is hard to come by around here. There isn't really any economy here in Gruplok City - no one has any money, so they all just barter or share whatever they can get. I don't know if we ever had our own coinage, but I do know that our leaders would rather starve to death than trade for the coinage that the Kaezulians and Baldakans use. My little stash wasn't easy to acquire, believe me");
		other:dialog(self, "Ah");
	end
	if message:match("Ah") and other:GetFlag(3002) == 3 then
		self:say("Yeah. Anyway, I've thought of some more things you can do for me, if you're still up for it");
		other:dialog(self, "What did you have in mind?");
		other:dialog(self, "Maybe later");
	end
	if message:match("Maybe later") and other:GetFlag(3002) == 3 then
		self:text("Kanruka sighs. 'Alright. Just come talk to me whenever you get some time, okay?");
	end
	if message:match("What did you have in mind") and other:GetFlag(3002) == 3 then
		self:say("Well, first of all you could help me find a good weapon. The sentries have some rule about not letting young women like myself carry weapons. How stupid! We could protect ourselves fine if they gave us the chance - better than they could protect us, too, I'd wager. But, well, none of them are going to listen to me, and there aren't a whole lot of weapons to go around, anyway. What I need is a good weapon, something sharp and fast, but small enough that I could hide it on me without the sentries getting a whiff of it. Maybe some kind of dagger... I don't know if the ones they make in your lands would be small enough. I'm sure you'll be able to find something though, eh?");
		other:journal("Kanruka`s Skulduggery",3,"Kanruka wants me to obtain some kind of small weapon for her. She was vague on the details - maybe something from the area would do?");
		other:setFlag(3002,4);
	end
	if message:match("Hail") and other:GetFlag(3002) == 4 then
		self:say("Hey. Found me a good weapon yet?");
	end
	if message:match("No problem") and other:GetFlag(3002) == 5 then
		self:say("Ha! No problem for you, hmm? Well, that suits me just fine!");
		other:dialog(self, "Is there anything else you need from me?");
	end
	if message:match("Hail") and other:GetFlag(3002) == 5 then
		self:say("This fang is just perfect for me. Look how easily I can slip it in and out of my loincloth!");
		other:dialog(self, "Is there anything else you need from me?");
	end
	if message:match("Is there anything else you need from me") and other:GetFlag(3002) == 5 then
		self:say("Ah, indeed I do. You see, I've been studying poisons, trying to figure out what I could cook up myself that would work well against the beasts out in the wild. But I don't exactly have a lot to work with. That tattered page of mine you pinched from Guluk is all I have to go on, and I don't even know what book it's from, who wrote it, when it was written, or *anything* about it, really. It's written with all this weird, archaic syntax... for all I know it could be a thousand year old alchemist's idea of comedy. What I'm saying is I need a better source");
		other:dialog(self, "Go on");
	end
	if message:match("Go on") and other:GetFlag(3002) == 5 then
		self:say("There's one Gruplok in town that I'm sure knows way more about poisons than you or I do. His name is Gruklikh, Gruklikh the Apothecary. But he'd never teach me anything - he knows the reputation I have, and I'm sure he doesn't trust me. None of them do. Anyway, this is where you come in");
		other:dialog(self, "How do you mean?");
	end
	if message:match("How do you mean") and other:GetFlag(3002) == 5 then
		self:say("I mean you can go talk to him in my place, obviously! With all you've done, I'm sure he wouldn't mind blabbing his life story to you, and he'd probably be happy to help *you* brush up on your poison-making skills. Go talk to him and see if you can't get me a real poison manual, or at least some poison-making-related anecdotes. Or better yet, see if you can get me some components to practice with. Just, whatever you do, don't so much as mention my name to him - or to anyone, for that matter");
		other:setFlag(3002,6);
		other:journal("Kanruka`s Skulduggery",5,"Kanruka wants me to go talk to Gruklikh the Apothecary for her, to see if you can find her any useful poison-making related information or supplies.");
	end
	if message:match("Hail") and other:GetFlag(3002) == 6 then
		self:say("Did you find anything out for me yet?");
	end
	if message:match("Hail") and other:GetFlag(3002) == 7 then
		self:say("Did you find anything out for me yet?");
		other:dialog(self, "He doesn't have any kind of poison reference book");
	end
	if message:match("He doesn t have any kind of poison reference book") and other:GetFlag(3002) == 7 then
		self:say("Damn. Oh well. Still, there must be something useful he knows about poisons. Go and talk to him again!");
	end
	if message:match("Hail") and other:GetFlag(3002) == 8 then
		self:say("Well?");
		other:dialog(self, "Gruklikh has agreed to teach me how to work with the local herbs to make poisons, but I'm not done with it yet");
	end
	if message:match("Hail") and other:GetFlag(3002) == 10 then
		self:say("Well?");
		other:dialog(self, "-Teach Kanruka everything I've learned from Gruklikh-");
	end
	if message:match("Gruklikh has agreed to teach me how to work with the local herbs to make poisons  but I m not done with it yet") and other:GetFlag(3002) > 7 then
		self:say("Ah. Well, I can afford to be a little patient... Come talk to me when he's done with you. I want to know everything!");
	end
	if message:match(" Teach Kanruka everything I ve learned from Gruklikh ") and other:GetFlag(3002) == 10 then
		self:say("After listening very carefully to your explanations of where to find local poison ingredients and how to work with them, Kanruka reviews what you've told her. She's a quick study. Finally, she is confident she has learned correctly. 'Ahaha! Yes, I suppose my resource was about working with murk weed and nothing else - how useless! Anyhow, thank you so much" .. other:GetName() .. "! You've been quite a help to me. If you manage to find out anything else from Gruklikh about making poisons - he's more secretive than he makes himself out to be - I'd be happy to pay you for another little tutorial");
		other:setFlag(3002,11);
		other:giveExp(15000,0);
		other:giveCash(0,0,math.random(16),14);
		other:journal("Kanruka`s Skulduggery",8,"I taught Kanruka everything Gruklikh told me about working with poisons. She asked me to tell her if I happen to learn anything else about making poison from him...");
	end
	if message:match("Hail") and other:GetFlag(3002) == 13 then
		other:dialog(self, "Another job, huh?");
	end
	if message:match("Another job  huh") and other:GetFlag(3002) == 13 then
		self:say("Of course! Nifty as this 'living poison' stuff is, I think this job will net us an even better haul, if you can handle it. I slipped out earlier to go looking for some more of that murk fern stuff. I guess I got a little too close to the Kaezulian encampment in the North-west, 'cause a little patrol nearly walked on top of me. They didn't see me though - guess I've learned something, heh. Anyway, my curiousity got the better of me, and I followed them to their encampment, and scoped the place out as best as I could. Anyway, long story short, I found a storage box in their encampment, and none too well guard, either. I overheared a guard saying that they keep everything they confiscated from us that is of no particular use to them in it. And, well, I'm not the first shadowy Gruplok there has ever been, you get me? And if there's one thing you can count on with the Kaezulians, it's to be big and obvious in anything they do. Weapons that aren't unwieldly and inefficient don't often find their way into the hands of the Kaezulian war machine. The same goes for light, stealthy gear - they're such morons! Not that I'd care for them to be more efficient fighters, but it's just mind numbing to think about... In any case, they're loss is our gain, eh? I have reason to believe some gear that would do quite nicely in your hands and mine are in that storage box - remnants of some old cabals of Gruplok freedom fighters..");
		other:dialog(self, "What else do I need to know?");
	end
	if message:match("What else do I need to know") and other:GetFlag(3002) == 13 then
		other:setFlag(3002,14);
		self:say("I was getting to it! Like I said, the storage box doesn't seem to very important to them - it wasn't much guarded when I was there. It's definitely locked, though - and I doubt if it could be picked in any timely fashion. The Kaezulians like to lock things real tight - double locks, booby traps, the whole bit. Kinda surprising, considering how light guarded it was - seems like they put some of their worst guards there, too. I overheared one of them yapping for quiet some time. He said one of their lesser lieutenants carries the only local key. Seems they hang around in the encampment somewhere, too. The guards in general were easy enough to slip by - they didn't seem highly trained at spotting people like us. I would stay away from the soldiers though, those guys are sharp. There were some patrollers in really crappy looking armor roaming around too - they didn't seem too tough, but I could tell they had real sharp eyes. There were no soldiers around the storage, and none in the buildings that I could see, but the patrollers might pose a problem. Anyway, the rest is up to you! See if you can't snatch the key from one of their lieutenant types, find the storage box, and see if you can't get in and old with some interesting stuff, eh?");
		other:journal("Kanruka`s Skulduggery",55,"Kanruka wants me to go plunder a storage chest on the Kaezulian occupied area North-west of the swamp. I'll need to swipe a key form one of their officers first, since Kanruka thinks I won't be able to pick the lock. I've got a bad feeling about this one...");
	end
	if message:match("Hail") and other:GetFlag(3002) == 14 then
		self:say("Hey, " .. other:GetName() .. ". Paid the Kaezulians a little visit lately? Eh? Heheh");
	end
	if message:match("Hail") and other:GetFlag(3002) == 15 then
		self:say("How's it going, " .. other:GetName() .. "? Plundered any of our illustrious neighboring cities lately? Heheh");
		other:dialog(self, "I'd like to trade up my loot from that last job for a different one");
		other:dialog(self, "This stuff from that last job just isn't me - care if I let you hang on to all of it?");
	end
	if message:match("I d like to trade up my loot from that last job for a different one") and other:GetFlag(3002) == 15 then
		self:say("No problem. Just hand me yours and I'll fish another one out of its hiding place");
	end
	if message:match("This stuff from that last job just isn t me   care if I let you hang on to all of it") and other:GetFlag(3002) == 15 then
		self:say("Oh, yeah, I wouldn't mind. Are you sure you don't want any of the loot?");
		other:dialog(self, "Ah, nevermind");
		other:dialog(self, "I'm sure");
	end
	if message:match("I m sure") and other:GetFlag(3002) == 15 then
		other:setFlag(3002,16);
		self:say("Alright. I'll see they're all put to good use! Just give me the one you've got and I'll gladly take it off your hands");
	end
	if message:match("Hail") and other:GetFlag(3002) == 16 then
		self:say("How's it going, " .. other:GetName() .. "? Plundered any of our illustrious neighboring cities lately? Heheh");
	end
end

-- Vendor script for Poison Making reagent.
function EVENT_MERCHANT(self,other)
	if other:GetCon(self) <= 3 and other:GetClass() == 9 then
		self:say("I have...something you might find useful.")
		return false
	else
		self:text(self:GetName() .. " ignores you.",_G.chat.emote)
		return true
	end
end

function EVENT_ITEM(self, other, items)
	--Junior Sentry pickpocketed turn-in
	if other:GetFlag(3002) == 2 and items(20761) > 0 then
		items(20761,1);
		other:setFlag(3002,3);
		self:say("Aha! Nothing you couldn't handle, right? Here - some payment, like I promised");
		other:addCash(math.random(14),0,math.random(5),2);
		other:journal("Kanruka`s Skulduggery",2,"I gave Kanruka her confiscated possession back. She might have another job for me, too.");
		other:dialog(self, "That's it?");
	end
	--pristine co`dair canine turn-in
	if other:GetFlag(3002) == 4 and items(20760) > 0 then
		items(20760,1);
		other:setFlag(3002,5);
		self:say("This... this is perfect! It's just the right size, and even if someone found it I could claim it's just a trinket I like to carry around or some such. I'll be honest, I never expected you to find something this good. Remind me not to underestimate you again");
		other:giveExp(10000,0);
		other:addCash(0,math.random(10),math.random(5),3);
		other:journal("Kanruka`s Skulduggery",4,"I found just the right weapon for Kanruka. Maybe she has some other jobs for me?");
		other:dialog(self, "No problem");
	end
	--overflowing vial turn-in
	if other:GetFlag(3002) == 12 and items(20769) > 0 then
		items(20769,1);
		self:text("Kanruka looks down at the vial in her hand and listens quietly as you explain everything Gruklikh told you about the poison. As you finish, a smile spread across her face. 'This is awesome! Lugging dozens of vials of poisons around in a sack isn't exactly stealthy - and ignoring poisoncraft is throwing away a major advantage in battle. This is the best of both worlds, right? A single vial of poison which never runs out... the holy grial of poisoncraft! Haha! Who knows how potent the stuff is, but I'll take all the advantages I can get out in the wild. Thanks for this, " .. other:GetName() .. "! Here - we may as well share it, no? Hahaha!' Kanruka grabs a spare vial and drips a few droplets of the living poison into it, the droplets already beginning to coalesce and bubble. She puts a cap on the vial, and hands it to you. 'Here you go! I've got another job for you, if you want an opportunity to try this stuff out.");
		other:giveItem(20762,1);
		other:giveExp(20000,0);
		other:setFlag(3002,13);
		other:journal("Kanruka`s Skulduggery",50,"I finished up my poisoncrafting work with Gruklikh and gave the highly unusual resulting poison to Kanruka, who decided to share it with me. She says she has yet another job for me, if I'm interested.");
		other:dialog(self, "Another job, huh?");
	end
	if other:GetFlag(3002) == 14 and items(20821) > 0 then
		items(20821,1);
		other:setFlag(3002,15);
		self:text("Kanruka whistles. 'My, my. This is quite a stash! You didn't have any trouble getting it, did you?' She listens as you tell her about the trouble with the key. 'Oh, damn. Maybe I misheard about the 'lieutenant' bit. I guess it was a bit off, thinking anyone half-way important would keep the key to a container they barely cared enough to guard. I doubt if it was a trap - I'm sure no one saw me... Anyway, nice job, " .. other:GetName() .. "! There's some pretty nice gear for our types in here. I'll have to find somewhere to stash it so the Sentries won't notice 'em. Well, " .. other:GetName() .. ", this was my last job for ya! With this stuff I think I'll be able to do a little more on my own. I can't rely on you forever after all - and you've really done too much already. It's not right for people like us to become dependent, eh? Here. I wouldn't feel right keeping all the loot when you did all the real work! If you want to trade up, just hand your share to me - I don't care too much which one you decide to hang on to. If none of them are useful to you, just tell me, and I'll gladly put them all to the best use I can.");
		other:journal("Kanruka`s Skulduggery",100,"I plundered the Kaezulian's local storage for Kanruka, and she decided she can't rely on me any more. She's shared the loot with me, letting me hang on to one of the three useful bits I managed to swipe. I can trade mine up for another if I bring it back to her.");
		other:giveItem(20817,1);
	end
	if other:GetFlag(3002) == 15 and items(20817) > 0 then
		items(20817,1);
		self:say("Decided to trade up, " .. other:GetName() .. "? Fine with me!");
			other:giveItem(20818,1);
	end
	if other:GetFlag(3002) == 15 and items(20818) > 0 then
		items(20818,1);
		self:say("Decided to trade up, " .. other:GetName() .. "? Fine with me!");
			other:giveItem(20819,1);
	end
	if other:GetFlag(3002) == 15 and items(20819) > 0 then
		items(20819,1);
		self:say("Decided to trade up, " .. other:GetName() .. "? Fine with me!");
			other:giveItem(20817,1);
	end
	if other:GetFlag(3002) == 16 and items(20817) > 0 then
		items(20817,1);
		self:text("Kanruka takes the cloak and stashes it away in her hiding place");
		other:giveExp(50000,0);
	end
	if other:GetFlag(3002) == 16 and items(20818) > 0 then
		items(20818,1);
		self:text("Kanruka takes the ring and stashes it away in her hiding place");
		other:giveExp(50000,0);
	end
	if other:GetFlag(3002) == 16 and items(20819) > 0 then
		items(20819,1);
		self:text("Kanruka takes the dagger and stashes it away in her hiding place");
		other:giveExp(50000,0);
	end
end
