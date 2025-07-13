-- Historian Galka
-- flag 3000 checks that they ahve done intro quests
-- flag 14300 is the historians conversation/small quest other:GetFlag

function EVENT_SAY(self, other, msg)
    local faction = other:GetCon(600, true)
	local hail = string.match(msg, "Hail")

	self:face(other)	
	
	if other:GetFlag(3000) < 7 then
		self:text("Historian Galka has his eyes buried in a dusty book, and does not look up to greet your voice.")
	
	elseif other:GetFlag(3000) == 7 then
		if other:GetFlag(14300) == 0 then
			if hail then
				self:text("Historian Galka has his eyes buried in a dusty book, and does not look up to greet your voice. 'Hmm, yes? Who is it?'")
				dialog(other, self, "Er, I'm new here, my name's-")
		
			elseif string.match(msg, "Er  I m new here  my name s") then
				self:say("Oh!  Yes, yes and welcome to our home.  It's nice to see a face that might actually be genuinely friendly for once in this great darkness.  And if you are indeed genuinely friendly, it would be est to keep that fact a secret from the Kaezulians.  Believe me as strong as you seem they would.. oh.. well they've done some pretty terrible things and I'm sure they're able to dream up plenty more for your sake.")
				self:say("This place is where we keep what little of our history the Kaezulians have let us keep.  In books and on scraps of leaves and.. and anything.  Mostly iin my head, to be honest, but plenty of information to be found.  If you ever have a question about the Gruploks or the swamp or anything, you come to me and I'll set you right if I can.")
				self:text("Historian Galka pauses for a moment.")
				other:setFlag(14300, 1)
				self:say("But, listen, and I don't mean to impose on a guest, but if you could do something a small favor for me.  Well I'd appreciate it.")
				dialog(other, self, "What sort of small favor?")
			end
		
		elseif other:GetFlag(14300) == 1 then
			if hail then
				self:text("Historian Galka looks up from his books to address you.  'Yes, anything you need to know, feel free to ask.  And, of course, if you feel up to doing me a small favor, please let me know.")
				dialog(other, self, "What sort of small favor?")
			
			elseif string.match(msg, "What sort of small favor") then
				self:say("These records here, what is left after the Kaezulian thugs made off with out history, are disintegrating.  We need new materials to write with just something dark, like crushed coal, and maybe some solvent to undo mistakes.  This would be a great help to me, and I would really appreciate it if you found time to help.  And if you kept it quiet, you understand.'  Galka looks around the room nervously.")
				dialog(other, self, "No problem, I'll be back as soon as I can.")
				other:setFlag(14300, 2)
			end

		elseif other:GetFlag(14300) == 2 then
			if hail then
				self:say("This would be a great help to me, and I would really appreciate it if you found time to help.  And if you kept it quiet, you understand.'  Galka looks around the room nervously.")
				dialog(other, self, "No problem, I'll be back as soon as I can.")

			elseif string.match(msg, "No problem  I ll be back as soon as I can") then
				self:say("Thank you so much!  I will be here to answer your questions at any time regardless.")
				other:setFlag(14300, 3)
			end

		elseif other:GetFlag(14300) >= 3 then
			if hail then
				self:text("Historian Galka looks up from his books to address you.  'Yes, anything you need to know, feel free to ask.'"..(other:GetFlag(14300) == 3 and " He drops his voice to a near whisper. 'Have you had any luck with that crushed coal and solvent?'" or ""))
			
			elseif (string.match(string.lower(msg), "tailor") or string.match(string.lower(msg), "sewing") or string.match(string.lower(msg), "weaving")) then
				self:say("We have quite an extensive section, well.. as extensive as it can be, in our humble library on the weaving and tapestries of ancient Gruploks.  Many of the tales make mention of faroff lands and so forth.  Quite fantastical in nature, really, but then that remains a hallmark of ancient Gruplok history you know ''Gruthulk smote..'' and such.  One could get the impression that, long ago, the Gruploks were relatively cosmopolitan in this part of the world!  I suspect that is not actually the case.  We have several Gruplok who have taken an interest in ancient weaving and one in particular, Gertund, would be the one to talk to, I feel.")
			
			elseif string.match(string.lower(msg), "smithing") then
				self:say("Blacksmithing? Well, I suppose we do our share of tool-making here in the swamp.  Not that any of our tools would excite one who has traveled the world like you!  We've had a few records.. scraps, really.. about Gruplok smithing from the past.  Given the penchant for Gruplok historical texts to be full of fantastic lands and magical wizardry, it's hard to determine what information is factual and what is an ancient Gruplok's flight of fancy.  One of our number came in a few years back to scrounge up information on blacksmthing for some reason.  I believe it was Kallepo.  Ask him about blacksmthing some time, I'm sure he knows as much as anyone.")
			
			elseif (string.match(string.lower(msg), "excited") or string.match(string.lower(msg), "excitement") or string.match(string.lower(msg), "augments")) then
				self:say("Oh, Kallepo seems to have had a breakthrough of sorts. You should ask him if you want to know more details!")
				other:setFlag(14602, 1)

			elseif string.match(string.lower(msg), "jewel") then
				self:say("As the swamp is full of jewels and various other ornaments once you know where to look, Gruploks have quite a history with jewelry.  Quite a history, indeed.  But, of course, that all ended when the Kaezulians arrived.  Every swamp location where gems could be found in abundance was quickly stripped clean and abandoned.  Even today, you can still find perfectly good cast-off gems around the swamp sometimes that weren't quite ''good enough'' for the Kaezul.  So if you want some information about jewelry that is actually applicable today, we must look to the past, where ancient Gruploks knew of gem caches the world over.  This is not an area that has piqued my interest much, but please ask Kirstap just over there about jewelry sometime.  You'll get quite an earful, I assure you!")
			
			elseif string.match(string.lower(msg), "alchemy") then
				self:say("Alchemy!  One of the few crafting traditions saved from the hopeless regression to utilitarianism.  Even the tales of Gruthulk are filled with such things.. potions, tinctures, unguents of the gods.  Wonderful potions are still brewed, though many are focused toward everyday life, some are extraordinary indeed!  I believe Kathrinka was speaking of a mixture both useful and fantastic just the other day.  I'm sure she would love to talk shop with you!")
			
			elseif string.match(string.lower(msg), "pottery") then
				self:say("Ah, the one true art that Gruplok hold in their bones.  No creature of the murk has anything less than reverence for the life-giving mud and to work with it to create art is universally seen as one of life's higher callings.  This is as true today as it has been for as much of Gruplok history as we have been able to scrape together.  Would you believe, centuries ago... well, no, I will let Gartonak tell you instead, he has read on the subject most voraciously.  Ask him about pottery and prepare to be astounded by the sheer genius of ancient Gruplok technology!")
			
			elseif (string.match(string.lower(msg), "gruthulk") or string.match(string.lower(msg), "hero")) then
				self:say("Gruthulk.. he's the most revered and legendary of all Gruploks.  Thousands of years ago, when the books say the whole world was swamp, Gruthulk slew many fearsome beasts, made many of them extinct, even.  He succeeded at heroic tasks, slew other gods, and so forth.  All for the protection and benefit of his people.  He was the most perfect and powerful Gruplok and in some ways still is.  Many nights here are spent fervently praying for Gruthulk to return and end this nightmare.")
				
			elseif (string.match(string.lower(msg), "culture") or string.match(string.lower(msg), "society")) then
				self:say("Whatever culture we may have had in the past, is long since lost.  All we know now is the swamp around us.  Of course, we still try to make do with what we have.  There are some ingenious Gruploks here in the village, I promise you.")
			
			elseif (string.match(string.lower(msg), "tale") or string.match(string.lower(msg), "story")) then
				self:say("Any number of Gruploks will be happy to tell you a tale -- probably of mighty Gruthulk!  In fact, Kalunepe has been regaling many newcomers with her stories.")
			
			elseif (string.match(string.lower(msg), "craft") or string.match(string.lower(msg), "tradeskill")) then
				self:say("Oh, the Gruplok are well-versed in many crafts. Judging by what I have seen from our new guests, we must have similar ideas about many of them. Did you have one in particular you wished to know more about?")

			elseif (string.match(string.lower(msg), "szithri") or string.match(string.lower(msg), "bufon") or string.match(string.lower(msg), "serpent") or string.match(string.lower(msg), "ranid") or string.match(string.lower(msg), "shrew") or string.match(string.lower(msg), "hulkwood") or string.match(string.lower(msg), "tree") or string.match(string.lower(msg), "plant") or string.match(string.lower(msg), "hrugtah") or string.match(string.lower(msg), "murkling"))then
				self:say("The flora and fauna of the swamp are more current topics than anything in these books would reference. However, there are some environment-minded Gruploks about who would welcome such inquiries.")

			elseif (string.match(string.lower(msg), "undead") or string.match(string.lower(msg), "skeleton")) then
				self:say("The appearance of undead Gruploks is new and worrying.  That there are also undead Kaezulians is depressing.  It seems that even in death we cannot escape their watch.")
			
			elseif string.match(string.lower(msg), "swampglow") then
				self:say("I have only seen tell of them in passing among these records.  One of our own was asking about them recently.. now who could it have been..")
			
			elseif string.match(string.lower(msg), "kaezul") then
				self:say("Life under the thumb of Kaezul is as bleak as you can imagine it is.  Maybe a lot more than you can imagine if you have never known suffering.  They frequently ride off with our friends and family to use as slave labor.  Usually, being a slave means they won't kill you for fun or send your children to fetch scorpions or whatever awful pleasure they've cooked up for themselves that week.  The particularly hopeless have said that the dead ones are the luckiest as they do not live in constant toil or constant fear as every Gruplok must.")
			
			elseif string.match(string.lower(msg), "ikild") then
				self:say("No Gruplok who has ever been to New Ikild has ever returned to my knowledge, so information on that whole place is scarce.")
			
			elseif string.match(string.lower(msg), "dreadlands") then
				self:say("We used to send envoys to the Dreadlands and indeed to locations all over the continent!  Now, of course, we mostly stay here.  We can't travel that great a distance by ourselves and the Kaezulians won't let us travel in groups of any reasonable size so... here we are.")
			
			elseif string.match(string.lower(msg), "elael") then
				self:say("I have never heard of ''Elael'' and that name does not appear in any of these books.  Sorry!")
			
			elseif (string.match(string.lower(msg), "gruplok") or string.match(string.lower(msg), "history"))then
				self:say("The Gruploks have always been on this continent and have, for as long, been excluded from any of the political benefits of whatever Empire happened to be in charge at the time. Before Kaezul, we were merely outcasts from the Empire. Present but not ever accounted for. While Old Ikild stood, we watched but rarely interacted with any of the goings-on in the capital.  Before that, it seems that one thing or another happened around us, good or bad, while we sat ignored in our little corner of the swamp.  Surely, Gruploks were around for eons before any other groups came to this place, but information is hard to find aside from stories about Gruthulk and so forth.")
			
			elseif string.match(string.lower(msg), "continent") then
				self:say("Most maps we had were destroyed by the Kaezulians or have fallen apart due to age and poor materials.  We know that we are near the current capital, that loathsome castle they call New Ikild.  We know we are near the old capital, which fell millennia ago.  Aside from that, we know generally where to go to find the supplies we need to go on living, materials for crafting, and so forth.  Everything else about the whole continent is a mystery again after being nearly common knowledge for thousands of years.  It only took three or four generations to start losing information and now, well...")
			
			elseif (string.match(string.lower(msg), "family") or string.match(string.lower(msg), "child") or string.match(string.lower(msg), "wife")) then
				self:say("Oh, I've no family of my own.. not anymore.  It's been years since those I had vanished into New Ikild.")

			elseif string.match(string.lower(msg), "leader") then
				self:say("We've no leader at all, really.  If one appeared, he would be killed rather quickly, I'm sure.")
			
			elseif (string.match(string.lower(msg), "puzzle") or string.match(string.lower(msg), "riddle") or string.match(string.lower(msg), "music")) then
				self:say("In my youth, I loved such things.  But now, there is no time for such frivolities as any distraction could mean our doom.")
			
			elseif string.match(string.lower(msg), "gruplok city") then
				self:say("Oh, I hate the name.  We lived for many centuries without such an appellation.. and the way they pronounce it is most insulting.  As though our very home were an insult.  I can't pretend we are more than a race of slaves, though, and our culture vanished long ago.")
			end
		end

		if faction <= 2 and other:GetFlag(14004) == 0 and (other:GetClass() == 6 or other:GetClass() == 12) then
			if hail then
				dialog(other, self, "Isn't there a way I can visit the Murk more quickly?")
			elseif string.match(msg, "isn t there a way i can visit") then
				self:say("Why, you know, there just might be!  Kalunepe and I found this while crawling through our history.  The lizards have their ways of moving about already so I doubt they would find this primitive magic too useful.  But for you... return our muddy shield and let the Gruplok gift to you be this magic.")
			end
		end
	end
end

function EVENT_ITEM(self, other, item, coin)
	local faction = other:GetCon(600, true)

	-- if other:GetFlag(14044) == 0 and faction <= 2 and item(41050) > 0 and (other:GetClass() == 6 or other:GetClass() == 12) then
	-- 	item:keep(41050, 1)
	-- 	self:say("Farewell, "..other:GetName()..". Please use discretion in bringing your friends to visit. The Gruplok cannot afford to drop their guard for an instant even for our most trusted friends.", 100, other)
	-- 	other:giveItem(41156, 1)
	-- 	other:setFlag(14044, 1)
    -- end

	if item(1853) > 0 and item(1864) > 0 and other:GetFlag(14300) == 3 then
		item:keep(1853, 1)
		item:keep(1864, 1)
		other:giveExp(1000, 0)
		other:giveFaction(600, 10)
		self:say("Oh thank you, THANK you!  This is perfect!'  Galka takes a deep breath.  'Yes, very well.  You have my gratitude.'", 100, other)
		other:setFlag(14300, 4)
    end 

	if item(41031) > 0 and item(41033) > 0 and item(41035) > 0 and item(41037) > 0 and other:GetFlag(14302) == 15 then
		item:keep(41031, 1)
		item:keep(41033, 1)
		item:keep(41035, 1)
		item:keep(41037, 1)
		self:text("The Gruplok's eyes light up in fascination.  'A puzzle!  It has been years since my mind was put to any test.  Let's see now.. this one..'.")
		self:text("Galka's hands are a blur and he mutters while he works furiously.  'At last!  Why.. this is.. the text appears to be in a very ancient writing system.  I'll not ask where you found this, but let me make quick copy and... There!'")
		other:giveItem(41038, 1)
		other:setFlag(14302, 16)
		other:giveExp(25000, 0)
		other:journal("Voices", 99, "Historian Galka connected the four symbols into what appears to be very ancient Gruplok text.")
		self:say("This knowledge may be a boon to us or dangerous if word gets out. Please be careful.")
    end
end