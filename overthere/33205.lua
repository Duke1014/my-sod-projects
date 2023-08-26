-- Rorlna, Mistress of Assassins - 33205
-- The Overthere, Quest Flag: 42503

function EVENT_SPAWN(self)
end
	
function EVENT_SAY(self, other, msg)
mainflag = other:GetFlag(42503)
hail = string.find(msg, "Hail")
	if hail and mainflag == 5 then -- Upon arrival of The Overthere, The Hierophant's Apprentice
		self:say("Thank you for finding me here, "..other:GetName()..". This is what is known to the Ikildians as 'The Overthere'. Some say this land is cursed, I say this land wants revenge. The Razadians used to rest the dead in the crypts below here, and we believe that The Hierophant is harvesting power from their burial grounds. To the NorthWest lies the harbortown, where the Armada likely keeps The Oracle.", 100, other)
		dialog(other, self, "So we storm the harbor and save her?")
	
	elseif string.find(msg, "So we storm the harbor and save her?") and mainflag == 5 then
		self:say("Impossible. This harbor is a stronghold. No, you will need to discover The Oracle's whereabouts without attracting the attention of the guards. We don't need a full out war here... yet.", 100, other)
		dialog(other, self, "All of this skulking around sounds more suited to an assassin...")
		other:setFlag(42503, 6)
	
	elseif hail and mainflag == 6 then	
		self:say("This harbor is a stronghold. You will need to discover The Oracle's whereabouts without attracting the attention of the guards.", 100, other)
		dialog(other, self, "All of this skulking around sounds more suited to an assassin...")
	
	elseif string.find(msg, "All of this skulking around sounds") and mainflag == 6 then		
		self:say("Perhaps, but *this* assassin has an identity to keep, "..other:GetName()..". There is a Kaezul-loyal city in the harbor named Kaezakha. There you will find some of the Kaezulian Armada's officers who will know where The Oracle is being held.")
		dialog(other, self, "Why would they trust their secrets to someone like me?")
	
	elseif string.find(msg, "Why would they trust their secrets") and mainflag == 6 then
		self:text("Rorlna grins. 'They won't trust you, but they will trust a new recruit!. We will make you a disguise so they will accept you as one of their own, but you'll need to bring me a few things. A spell scroll for the illusion of Iksar, a tabard of the Armada, and five of the mementos the Kaezakhan people carry from their lost city, so they will recognize you as one of their own.'")
		dialog(other, self, "Where exactly would I find a tabard of the Armada?")
		dialog(other, self, "Where exactly would I find a memento of the Kaezakhan people?")
		dialog(other, self, "Where exactly would I find a scroll of the Iksar illusion?")
		other:setFlag(42503, 7)
		other:journal("The Hierophant's Apprentice", 2, "I have arrived and spoken to Rorlna in 'The Overthere'. It seems not many of the Ikildian's favor this place. In order to locate The Oracle, I need to gather a spell scroll of the Iksar Illusion, a tabard of the Armada that presides here, and five mementos of the Kaezakhan people. But where to find a tabard? I have a feeling this part won't be simple to obtain.")

	elseif hail and mainflag == 7 then		
		self:say("I cannot create your disguise until you bring me the items, "..other:GetName()..". Do not come back to me empty-handed.", 100, other)
		dialog(other, self, "Where exactly would I find a tabard of the Armada?")
		dialog(other, self, "Where exactly would I find a memento of the Kaezakhan people?")
		dialog(other, self, "Where exactly would I find a scroll of the Iksar illusion?")	
		
	elseif string.find(msg, "a tabard of the Armada") and mainflag == 7 then
		self:say("You won't be able to steal one from any of the workers in the harbor, but if you were to find one from someone already dead, maybe there's a chance you can grab their tabard.")

	elseif string.find(msg, "a memento of the Kaezakhan") and mainflag == 7 then
		self:say("There is a small settlement South of here that houses some Kaezulians. They're somewhat weaker than the ones guarding the harbor, but do not underestimate them. They may have the mementos we need.")
	
	elseif string.find(msg, "a scroll of the Iksar illusion") and mainflag == 7 then
		self:say("A scro- wait. You're kidding, right? Just... go get one from an Enchanter guild. I can't believe you asked that!")

	elseif hail and mainflag == 10 then
		self:say("Be careful with that, it will deceive their eyes but not their ears. Be careful what you say to the Kaezakhan, and gain their trust however possible.")
		dialog(other, self, "So you are leaving this all to me, then?")

	elseif string.find(msg, "So you are leaving this all") and mainflag == 10 then	
		self:say("Return to me once you've made a connection in the harbor, and find out where they are keeping the Oracle. But otherwise, try to refrain from contacting me here, so that no one makes a connection between us. It's safer for everyone.", 100, other)
		other:setFlag(42503, 11)
		other:journal("The Hierophant's Apprentice", 3, "Rorlna has some quick hands! I have a new disguise to get into the harbor undiscovered. I won't be able to talk to her again until we know where The Oracle is.")

	elseif hail and mainflag == 11 then -- text used after infiltration begins in the Harbor
		self:text("Rorlna avoids making eye contact with you as she hisses, 'I know you not, stranger.'")
		self:text("Rorlna will not speak with you until you have located The Oracle.", 8)
	
-- text used after finding where The Oracle is held
	elseif hail and mainflag == 12 then
		if other:GetInventory("ammo") == 41304 then
			self:text("Rorlna avoids making eye contact with you as she hisses, 'I know you not, stranger.'")
			other:text("Rorlna will not speak to you, if you are wearing the Kaezulian Disguise.", 15, true)

		else
			self:say("That look in your eye. Were you able to find The Oracle?", 100, other)
			dialog(other, self, "Yes, but it's heavily guarded.")

		end		
		
	elseif string.find(msg, "Yes") and mainflag == 12 then
		self:say("Then it's time to take action. I have still not seen any sign of The Hierophant so evacuating The Oracle is time sensitive.")
		dialog(other, self, "How do you suppose we dispose of the guards so we can rescue her?")
		other:setFlag(42503, 13)

	elseif hail and mainflag == 13 then
		self:say("It's time to take action. I have still not seen any sign of The Hierophant so evacuating The Oracle is time sensitive.")
		dialog(other, self, "How do you suppose we dispose of the guards so we can rescue her?")
		
	elseif string.find(msg, "How do you suppose") and mainflag == 13 then
		self:say("The best course of action is to break The Oracle out of there while placing the blame on the guards. Perhaps we knock them unconscious, and draw the attention away from us.", 100, other)
		dialog(other, self, "What do you have in mind to knock them out without making a scene?")
		
	elseif string.find(msg, "What do you have in mind to knock them out") and mainflag == 13 then
		self:say("Use your disguise and go find out what their favorite drink is. We can combine it with a small dose of this!' She hands you a small vial. 'Combine this with their drinks and you'll have just enough time to get The Oracle out of there.", 100, other)
		other:setFlag(42503, 14)
		other:journal("The Hierophant's Apprentice", 5, "I need to find out what these guards like to drink, then get The Oracle out of her captivity. Once I get their drinks, I'll brew it with the vial that Rorlna gave me.")
		
	elseif hail and mainflag == 14 then
		self:say("Go, get The Oracle! Stop wasting time!", 100, other)
		
	end
end

function EVENT_ITEM(self, other, item)
-- Hand in Tabard, Illusion: Iksar spell scroll, 5 Mementos of Old Kaezakha
	if item(15243) > 0 and item(1227) > 0 and item(41301) > 4 and mainflag == 7 then
		item:keep(15243,1)
		item:keep(1227,1)
		item:keep(41301,5)
		other:setFlag(42503,10)
		self:text("Rorlna takes the items and quickly fashions together a basic disguise. As she hands it to you, she grabs your wrist. 'Be careful with this, it will deceive their eyes but not their ears. Be careful what you say to the Kaezakhan, and gain their trust however possible.")
		other:giveItem(41304) -- Summons Kaezulinite Disguise
		dialog(other, self, "So you are leaving this all to me, then?")
	end
end