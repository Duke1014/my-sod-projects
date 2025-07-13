-- ##gertund the trapper
-- ##14010 is genklog's quest line
-- ##14011 is the trapper's
-- ##14027 is the tailoring quest flag 10 means you can make the combine.
-- ##14026 is the tailoring "hub quest" flag required to learn the recipe. 100 = ok
-- ##tailoring is skill 61 p
-- ##uses grid 3538
-- ##MAX FACTION FROM THIS QUEST 300

local trap_event = false

function EVENT_SPAWN(self)
	if self:GetY() >= 2700 then
		self:area("trap", 30)
		self:timer("fade", 1000, true)
	end
end

function EVENT_SAY(self, other, msg)
    local faction = other:GetCon(600, true)
    local hail = string.match(string.lower(msg), "hail")
    local tailor_quest = other:GetFlag(14027)
    local tailoring_skill = other:GetSkill(61)
	local curious_quest = other:GetFlag(14010)
	local trapper_quest = other:GetFlag(14011)
	local has_shield = other:GetFlag(49098)

	self:face(other)

    if other:GetFlag(3000) == 7 then
        if faction <= 5 then
			if faction <= 2 then
				if hail and has_shield == 0 then
					dialog(other, self, "I am honored to call myself an ally to the Gruploks.")

				elseif string.match(string.lower(msg), "i am honored to call myself an") and has_shield == 0 then
					other:setFlag(49098, 1)
					self:say("And we are proud to have you for one. Please accept this modest gift, "..other:GetName()..". It will remind you of us always.")
					other:giveItem(41050, 1)
					other:giveExp(250000, 0)
					if other:GetClass() == 6 or other:GetClass() == 12 then
						other:giveItem(41156, 1)
					end
				end

            elseif tailor_quest == 0 then
                if string.match(string.lower(msg), "tailor") or string.match(string.lower(msg), "sewing") or string.match(string.lower(msg), "weav") then
                    self:text("Gertund sizes you up. 'I guess Galka told you, then. Well it's true, I've been looking in to how the ancient Gruploks used the land to hunt more effectively. The swamp is far more dangerous today than it has been in my lifetime, so I need every edge available to me. The most promising tool seems to be some sort of field-blanket that offers ''perfect cover'' according to one of Galka's leaflets. I'd love to see it work, and if you're offering to help...'")
                    dialog(other, self, "That blanket sounds amazing.. of course I will help.") 

                elseif string.match(msg, "That blanket sounds amazing   of course I will help") then
                    self:say("Well, let's see if it works first before we get excited about nothing. Tell you what: you come up with a few things and I'll provide the labor. Not that I don't trust you lot to have some fairly capable tailors around.")
                    dialog(other, self, "I understand.")

                elseif string.match(msg, "I understand") then
                    self:say("Here's what you're going to do. The text is barely legible for the most part, and please keep in mind I have no idea where to find any of this as this list is probably centuries old and in a version of our language at least that ancient, but what we need is a piece of umbral cloth. Strike that.. it says enchanted umbral cloth, so I guess what you want is incredibly high quality here. The next word I thought was 'veins' for the longest time, but I have a suspicion they are using it metaphorically to mean a length of warm, red thread. Finally, we'll need something to hold it together.. here the text is unspecific and arbitrary, so I guess we can use something simple. Can you make a leather cloak? One of those will do just fine. Of course we also need the construction implement, but.. well let's say I have that already.")
                    dialog(other, self, "I'm on it!")

                elseif string.match(msg, "I m on it") then
                    self:say("Very well, then, I await your return.")
                    other:setFlag(14027, 1)
                    other:journal("Perfect Cover", 10, "Gertund asked me to find enchanted umbral cloth, a length of warm, red thread, and a leather cloak. With these, he will make a Gruplok field-blanket.")     
                end
                
            elseif tailor_quest == 2 and tailoring_skill >= 225 then
                if hail then
                    self:text("Gertund looks at you curiously...")
                    dialog(other, self, "Is something wrong?")

                elseif string.match(msg, "Is something wrong") then
                    if other:GetFlag(14026) == 0 then
                        self:say("You seem to have a knack for this sort of thing. But there is simply no way to teach an outsider to do these things. It would require knowledge from our very distant past to even consider. I would ask Goplen about it if you have a moment.")
                        other:setFlag(14026, 10)
						
                    elseif other:GetFlag(14026) == 100 then
                        self:say("I saw you watching me sew. You understood all that, didn't you? I knew you had the spark.. the ancient Gruplok knowledge... you could learn how to make the blankets yourself, if you wanted.")
                        dialog(other, self, "I would be honored!")
                    end

                elseif string.match(msg, "I would be honored") and other:GetFlag(14026) == 100 then
                    self:say("Well, I have to confess I played a small trick on you. You don't need enchanted umbral cloth, just the ordinary kind. I plan to use the one you gave me to make many smaller kits for the village though, so your hard work is appreciated. The truth is, you just need a leather cloak, a piece of umbral cloth, and the same warm, red thread. The problem is you also need one of these needles. They're harder to find, as they are technically historical relics. I can't give them to you, and I don't know anyone who would, but if you do get ahold of one, this is what you do:")
                    self:text("Gertund spends an hour showing you the intricacies of Gruplok tailoring. He is a fine teacher, and you feel you could replicate his movements with a little effort.")
                    other:giveExp(100000, 0)
                    other:journal("Perfect Cover", 100, "I can make my own weaves of existence now, with a piece of umbral cloth, a length of warm, red thread, a leather cloak, and an ancient Gruplok needle.")
                    other:setFlag(14027, 10)
                end
            end

			if curious_quest == 14 then
				if hail then
					dialog(other, self, "Genklog sent me to ask for your help.")
				elseif string.match(string.lower(msg), "genklog") then
					self:say("Genklog? That old fool begged me to have him along on a trip to the north-east. That's dangerous territory already, what with the lizards so close, but we were on the look-out for something a lot meaner. A giant, scaly beast. Colored so bright you know he doesn't care who sees him as he's top of the food chain. The fellows called him Hrugtah, meaning snake-eater, and the name stuck. If you get tired of life and want a quick end, Ravenous Hrugtah will serve it up quick mark my words! I've seen him swallow whole things that would give you a fright, I promise.")
					dialog(other, self, "He said he dropped his notes on that outing and he asked me to get them back.")

				elseif string.match(string.lower(msg), "he said he dropped") then
					self:say("Hah. You have to understand, it was a brilliant trap design. Just one-of-a-kind engineering and a mountain of good luck that trapped that beast. Now he's completely immobilized--stuck to the earth, but it doesn't matter. No one can get close enough to kill him! He's hungry as the swamp and a hundred times as deadly. If the old man sent you to toy with Ravenous Hrugtah, you just go back and tell him you appreciate the sentiment, but you enjoy having your limbs attached properly. Hah!")
					other:setFlag(14010, 15)
					other:journal("Curiouser and curiouser", 41, "Genklog was no help.. I'm going to have to find out how to get the notes from Hrugtah on my own.")
				end
			end

			if trapper_quest == 1 then
				if hail then
					self:text(self:GetName().." clears his throat and wipes hs eyes before turning to face you.")
					self:say("Listen, I heard what you did for Genklog and I have to say I'm impressed. You didn't have to go out there and help a crazy old Grup by staring death in the teeth, but you did and it's more than we could do for him. Also the way you handled Hrugtah--Hah! The crew are still laughing about that one. Look I'll admit I had the wrong idea about you and your friends, but that's all in the past. There's more important problems in this swamp and, if you'd like, you can start helping me deal with them.")
					dialog(other, self, "Sure, I'm happy to help.")

				elseif string.match(string.lower(msg), "sure  i m happy to help") then
					other:setFlag(14011,2)
					self:say("Great! The truth is we trappers are in a bit of a bind with not being able to leave the swamp. I have a feeling it would be a job just to find four or fives Grups who cared enough to make the trip! You've got a good spirit about you, though, so I'm sure you can manage this. We need materials and we need them pretty badly. Have you been out to the Remnants of Old Ikild, yet? Well, either way. If and when you do, see if you can't bring me back a big pile of spines from the co`dair out that way. A full twenty of them should keep us well-stocked for the immediate future.")
					other:journal("Gertund`s Favor", 10, "Gertund asked me to get twenty co`dair spines from the remnants of Old Ikild.")
				end

			elseif trapper_quest == 2 then
				if hail then
					self:say("Did you find those spines yet? Only twenty spines, not too big of a burden for you I hope!")
				end

			elseif trapper_quest == 3 then
				if hail then
					self:say("Well, we've recently run out of the jaws we use for the base of our uhh... 'man'-traps. I wish I had known about this sooner, maybe I would have saved you some running! You see, the jaws we use comes from the vicious-looking piranhas out there in the Remnants of Old Ikild! I know, I know, like I said, I wish I'd known. It's important that you don't just go bringing me any random piranha jaw you happen to find.. that'll not be strong enough for the pressure gauge on the trap! No, the piranhas in Old Ikild have a wider, sharper set of teeth deep on the inside. Looks worthless to the untrained eye, but if you know what you're doing, it's plain as day. I'll need twenty of these, too. What can I say? We've been cut off from proper supplies for a long time.")
					other:journal("Gertund`s Favor", 20, "I need to get twenty of the piranha jaws from the remnants of Old Ikild for Gertund.")
					other:setFlag(14011,4)
				end

			elseif trapper_quest == 4 then
				if hail then
					self:say("Any luck with those piranhas? Remember, we're not looking for ordinary piranha jaws here! They need to be from the lake in Old Ikild.")
				end

			elseif trapper_quest == 5 then
				if hail then
					self:say("I suppose you've done a lot of gathering sticks and stone for me and the others, but how would you like to try your hand in real live trapping? It's as fun as it sounds, and what you bring back will really help the village. What do you say?")
					other:setFlag(14011, 6)
					dialog(other, self, "Trapping? Sounds like fun.")
				end

			elseif trapper_quest == 6 then
				if hail then
					self:say("What do you say? Interested in trapping some live game?")
					dialog(other, self, "Trapping? Sign me up!")

				elseif string.match(string.lower(msg), "trapping") then
					self:say("Great! Today, we're after the scoprions that litter the Field of Bone. Dead ones won't do. They're stealthy, and deadly. You may need some magic sight to find them. Just sneak up on them before they sneak up on you, and use your snare-trap while they're unaware. It won't work on all of them, some have developed a resistance to our poisons, but just keep trying and you'll land a live one. If you try to trap one and it fails, there's no sense trying again, just get rid of it and look for another. A bit of *dexterity* will go a long way here. Here's one of the snare-traps made from the materials you brought. We're only looking for five live scorpions, let's not go overboard.")
					other:setFlag(14011, 7)
					other:giveItem(41018, 1)
					other:journal("Gertund`s Favor", 30, "Gertund asked me to trap five Field of Bone scorpions with the Gruplok snare. I have to ambush them with it and some are apparently wise to the trap. I'll have to be as dexterous as possible to catch them.")
				end
			
			elseif trapper_quest == 7 then
				if hail then
					if other:GetFlag(42527) == 5 then
						self:say("Splendid! Those are some feisty-looking scorpions you brought back with you. Hand me the trap I gave you.")
					else
						self:say("How are you enjoying the trapping business? Let me know when you've successfully gotten the drop on five scorpions.")
					end
				end

			elseif trapper_quest == 8 then
				if hail then
					self:say("Well I'll be honest with you: it's like I've been slowly waking up from a terrible dream over these last few days. And when the children came to me... well I'd better start at the beginning.")
					dialog(other, self, "Yes, please start at the beginning.")
					-- other:setFlag(14011,12)

				elseif string.match(string.lower(msg), "yes  please start at the beginning") then
					other:text("Gertund tells you a long story about how a particularly vicious Kaezulian, called Second Lieutenant Vaszak by his men, stormed the village ranting madly from house to house. At each house, he ordered his men to search for signs of children living there. If a toy, or drawing, or anything of the sort was found, Vaszak flew into an insane rage and tore the home to shreds. In his rantings, he yelled about conspiracies, plots and schemes, all being perpatrated by Gruplok children! Here, Gertund pauses to catch his breath...", 6)
					-- other:setFlag(14011, 13)
					dialog(other, self, "Please go on.")

				elseif string.match(string.lower(msg), "please go on") then
					self:say("Well, I can't ask you to do what I want you to do. I can't even hint at what needs to be done... what I, personally, need to see happen to that Kaezulian bastard. If the merest whisper of any action were to reach the ears of any Kaezul, they would rain down pain and misery on this village that would make us beg for the early days of conquering. No, all I can tell you is what is common knowledge. That Vaszak travels the continent searching for conspiracies. That Vaszak tours through the Northern-most pathway in the swamp out of Ikild with impunity because his entourage makes him effectively invulnerable. That without this entourage propping him up, he is in all probability one of the weaker Kaezul as evidenced by his low rank.")
					dialog(other, self, "Are you asking me to-")

				elseif string.match(string.lower(msg), "are you asking me to") then
					self:text(self:GetName().." cuts "..other:GetName().." off with a short gesture.")
					self:say("I can tell you nothing else without endangering the entire village. And, since you may not see me again, let me give you a parting gift. This is one of the traps you helped to build. With scorpion venom, co`dair spines, teeth from the piranha jaws, and some unpleasant parts of a live scorpion, the boys have managed to slap together an old Gruplok stone-trap. It hardens the muscles and stiffens the ligaments of any creature, Gruploks of long ago used this to capture beasts that could otherwise outrun us. This one probably won't hold together very long, and it's unlikely that I will be able to build you another. Still, it should suffice...")
					other:setFlag(14011, 14)
					other:giveItem(41019, 1)
					other:journal("Gertund`s Favor", 50, "Gertund gave me a trap that partially paralyzes some creatures for a short time.  He also mentioned a Kaezulian named Vaszak who travels, accompanied by a strong entourage, through the Northern-most pathway in the swamp out of Ikild. I think he has asked me to kill Vaszak.")
				end

			elseif trapper_quest == 14 and self:GetY() > 2700 and trap_event == false then
				if hail then
					self:say("Quickly, there's no time! Do you still have the trap handy?")
					dialog(other, self, "I do.")
					dialog(other, self, "Oh no... I forgot it back home!")

				elseif string.match(string.lower(msg), "i do") then
					self:say("Good. Be out of sight and use it at the right moment. If he gets too far and his guards catch notice of us, the trap will be ruined. I see him coming close, are you ready?")
					dialog(other, self, "I am ready.")
					
				elseif string.match(string.lower(msg), "i forgot it back home") or string.match(string.lower(msg), "i am ready") then
					self:say("There's no time! He's coming from the west! Good luck!")
					trap_event = true
					self:timer("event", 300000, true)
					spawn(32016, 2089.5, 2666.6, -5, 190, 300)
					spawn(32017, 2103.5, 2671.6, -5, 190, 300)
					spawn(32018, 2089.5, 2661.6, -5, 190, 300)
				end
			elseif trapper_quest == 15 then
				if hail then
					self:text(self:GetName().." winks at "..other:GetName().." and says, 'Nice to see you again!'")
				end
			end
        end
    else
        other:text("Gertund does not acknowledge you.", 0, true)
    end
end

function EVENT_AREA(self, other, area)
	if area == "trap" then
		if other:IsClient() and other:GetFlag(14011) == 14 then
			self:fade(false)
			self:timer("fade", 60000, true)
			self:say("Shhh... Over here, "..other:GetName().."!")
		end
	end
end

function EVENT_ITEM(self, other, item, coin)
	if item(38010) >= 20 then	-- spines
		other:giveFaction(600, 50)
		other:giveExp(15000, 0)
		item:keep(38010, 20)
		other:setFlag(14011, 3)
		self:say("Excellent! You do pretty good work for someone new to this place. In the old days, these spines were used for every kind of trap. Snares, paralyzers, stone-fall, anything. These days, we're forced by circumstance to use only the crudest methods possible... and that really shortens the list of things we can capture reliably, believe me. This load of spines will do a lot of good! Thanks plenty and remember there's always more work to do.")
		other:journal("Gertund`s Favor", 15, "I got the spines for Gertund. He says there is always more work to do!")
	end

	if item(38011) >= 20 then
		other:giveFaction(600, 50)
		other:giveExp(15000, 0)
		other:setFlag(14011, 5)
		item:keep(38011, 20)
		self:say("Phew! I guess I had forgotten how bad these things smell. I hope you didn't mind carrying them all the way back here, though I bet none of the swamp beasts were brave enough to get close to someone carrying jaws that powerful! Hah! I sure wish I'd had these when I went out for old Hrugtah, would have made things a lot easier that's for sure. Anyway, thanks again and remember: if you've got the spare time, I've got work to fill it.")
		other:journal("Gertund`s Favor", 25, "Gertund was happy to receive the pile of piranha jaws, as sharp as they were. He mentioned that there was more work to be done if I had the time.")
	end

	if other:GetFlag(42527) == 5 and item(41018) > 0 then -- trap + flags
		other:giveFaction(600, 50)
		other:giveExp(15000, 0)
		item:keep(41016, item(41016))
		item:keep(41018, 1)
		other:setFlag(14011, 8)
		self:text(self:GetName().." is startled by the sound of your voice.")
		self:say("Whoa! Careful where you point those things! Just because those scorpions are trapped in there doesn't mean those stingers won't pack a punch if you let 'em. Hah! I was going to let you in on what these beauties are for, but if you can't see the trapping applications of a beast whose very eyes can turn a living creature to stone, well, you're beyond my help. I'll tell you, things have been uh.. getting a little crazy about here, I.. well I guess there's more you can do I just.. Hmm.. Yes, this is perfect.. I do have another thing for you to do, I do. But.. you know hold on a moment.")
		cya(self)
		other:journal("Gertund`s Favor", 35, "I gave my captured scorpions to Gertund, who seemed oddly distracted. He says there is more work to do, though.")
	end

	if other:GetFlag(14011) == 15 and item(41020) > 0 then	-- iksar guy's head
		other:giveFaction(600, 100)
		other:giveExp(150000, 0)
		item:keep(41020, 1)
		other:setFlag(14011, 15)
		self:text(self:GetName().." looks at you for a moment, as though he were studying your face. Then he speaks in a slightly unfamiliar voice.")
		self:say("Hah! Er.. Thank you for doing what I asked you to do! I've been asked to give you this by a mutual friend. See you around the village!")
		other:giveItem(41150, 1)
		other:journal("Gertund`s Favor", 100, "I've facilitated Gertund's vengeance and he's run off to find the answers to his questions. Maybe we'll meet again someday.")
	end

	if item(41110) > 0 and item(41118) > 0 and item(10547) > 0 and other:GetFlag(14027) == 1 then
		item:keep(41110, 1)
		item:keep(41118, 1)
		item:keep(10547, 1)
		self:say("Ahhh, perfect! You'll have to tell me where you found all this stuff... not that it would do me any good I guess. Anyway, you've done the hard part, so now...")
		self:text("Gertund's fingers move like lightning... but you are able to follow along quite well.")
		other:setFlag(14027, 2)
		other:giveFaction(600, 80)
		other:giveExp(12000, 0)
		other:giveItem(41076, 1)
		other:journal("Perfect Cover", 50, "Gertund made a weave of existence for me.")
		if other:GetSkill(61) >= 225 then
			self:text("Gertund looks at you curiously...")
			dialog(other, self, "Is something wrong?")
		else
			self:say("There you go, "..other:GetName()..", one perfect blanket! I hope it works as well as they say for covering your tracks.")
		end
	end
end

function cya(self)
	self:text(self:GetName().." hurries off to another part of the village.")
	self:fade(true)
	self:timer("unfade", 30000, true)
end

function EVENT_TIMER(self, timer)
	if timer == "unfade" then
		self:fade(false)
	end

	if timer == "fade" then
		self:fade(true)
	end

	if timer == "event" then
		trap_event = false
	end
end

-- function check_for_shield(player)
-- 	local inv = player:GetInventory()

-- 	for k, v in pairs(inv) do
-- 		if v:GetID() == 41050 then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end