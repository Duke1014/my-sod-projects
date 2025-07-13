-- TS QUEST MAIN KAESORA LEG quest dude 32091
-- Goplen
-- 14026 is generic TS flag
-- pc is sent here from the ts-specific grup who verifes 225-ness in a ts (setting 14026 to 1)

function EVENT_SAY(self, other, msg)
	local hail = string.match(string.lower(msg), "hail")
	local ancient_quest = other:GetFlag(14026)

	self:face(other)

	if ancient_quest == 0 then
		if hail then
			self:text(self:GetName().." looks up at "..other:GetName()..".  'Do I know you?  No, I think not.'  He returns to his studies.")
		end

	elseif ancient_quest == 10 then
		if hail then
			self:say("Ah, hello, and welcome.  Our mutual friend tells me you are interested in uncovering that which even our, erm, hosts have been unable to recover.")
			dialog(other, self, "That's right.. I need to know all there is about my craft.")

		elseif string.match(string.lower(msg), "that s right   i need to know") then
			self:say("Well, so must we all, I suppose.  They tried, you know, our reptilian friends.  We don't hear much here in the swamp, through our lives, but even we Gruplok could feel the magical tremors all those years ago.  It appears in several journals of the times.  Well, appeared, I guess, past tense, since most of our records have gone the way of ash and flame.  This miniature cataclysm came about long after they stole our important texts by legerdemain.. oh for the days where we were merely swindled out of our heritage!  Either way, much later, that same group of Iksar went hunting for deeper secrets and what they found instead must have been quite horrific.  The sights and sounds that day were well-described and rather violently intriguing.")
			dialog(other, self, "Where is this information hidden?")

		elseif string.match(string.lower(msg), "where is this information hidden") then
			self:say("If you asked the Gruplok from decades before, they wouldn't know because they were not that concerned with what other societies did.  If you ask a Gruplook today, they won't know because they are no longer allowed to know what goes on outside the swamp.  I'm sorry, but that information does not exist.  Still, where you find the graves of this foolhardy team of Iksar is no doubt where you will find whatever remains of our lost Gruplok lore.")
			dialog(other, self, "I will find this place.")

		elseif string.match(string.lower(msg), "i will find this place") then
			self:say("When you do, please come and tell me where it is and what you find.  I'm as curious as anyone about the goings-on all those years ago.  No Gruplok will ever again make the mistake of being so uninformed of the outside world.. I will hear all that you tell me.")
			other:setFlag(14026, 14)
			other:journal("Ancient Gruploks", 10, "Goplen asked me to find where an Iksar research team was entombed with ancient Gruplok texts.")
		end

	elseif ancient_quest == 14 then
		if hail then
			self:say("So, have you found where the Iksar were buried along with our texts?  If so, do not keep me in the dark!  Let me know where!")
			other:journal("Ancient Gruploks", 10, "Goplen asked me to find where an Iksar research team was entombed with ancient Gruplok texts.")
		end

	elseif ancient_quest == 15 then
		if hail then
			self:say("So, have you found where the Iksar were buried along with our texts?  If so, do not keep me in the dark!  Let me know where!")
			dialog(other, self, "Yes, I found a peculiar Iksar in Kaesora.")

		elseif string.match(string.lower(msg), "kaesora") then
			self:say("Kaesora... I do not recognize the name.  Still, you sound confident.  What experience did you have there that made you decide that this must be the place?")
			dialog(other, self, "Well, inside we found...")
	

		elseif string.match(string.lower(msg), "well  inside we found") then
			self:say("Ah, say no more.  I am convinced!  This is quite a find, quite a find.  Whoever maintained control of this team would surely be most likely to possess fragments of information even in death!  And I think I know a way we can trick that particular spirit into handing that information over.")
			dialog(other, self, "What's the plan?")

		elseif string.match(string.lower(msg), "what s the plan") then
			other:giveItem(41021,1)
			self:say("Take this, "..other:GetName()..", and wear it.  It is one of the remaining relics of the ancient Gruploks.  I think it most likely that the spirit you want in Kaesora is bound to that place by his quest for information.  That hunger cost him his mortal existence, but I'm sure death has done nothing to curb his appetite.  Seek him out, and he will come for that necklace, believe me.  He will want to take it, but instead you must take from him.. by force!")
			dialog(other, self, "I guess it's off to Kaesora, then.")
			other:setFlag(14026, 18)
				
		elseif string.match(string.lower(msg), "i guess it s off") then
			self:say("Good luck to you!")
			other:journal("Ancient Gruploks", 20, "Goplen told me to scour Kaesora to try and draw out a spirit hungry for information.")
			other:setFlag(14026, 18)
		end

	elseif ancient_quest == 18 then
		if hail and (other:GetFlag(14021) + other:GetFlag(14022) + other:GetFlag(14023) + other:GetFlag(14024) + other:GetFlag(14025)) == 0 then
			self:say("This must be what amounts to a thorough examination of Kaesora.  While you search for him, he must also be searching for the necklace.  If you dash from place to place, the two of you will surely never meet!  Take it slow.")

		elseif hail and (other:GetFlag(14021) + other:GetFlag(14022) + other:GetFlag(14023) + other:GetFlag(14024) + other:GetFlag(14025)) > 0 and (other:GetFlag(14021) + other:GetFlag(14022) + other:GetFlag(14023) + other:GetFlag(14024) + other:GetFlag(14025)) < 5 then
			self:say("Ahh.. run into him, have you?  You have quite the air of secret knowledge around you, but he must have more to give.  Hunt him down and make him tell what he knows.")
			other:journal("Ancient Gruploks",30,"I must hunt Rothgha until all of his secrets are mine.")
		end

	elseif ancient_quest == 19 then
		if hail then
			self:say("I can already tell: you've found the secrets of the ancient Gruploks.  You carry yourself more like a Gruplok now, but proudly!  If there are more mysteries about the ancient Gruploks, you might consult Koliang.  She keeps what we have safe.")
			other:journal("Ancient Gruploks", 100, "The knowledge of ancient Gruploks flows through me.")
			other:setFlag(14026,100)
			other:giveFaction(600,80)
			other:giveExp(75000,0)
		end
	end
end