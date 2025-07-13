-- Glakrin the Huntsman

function EVENT_ATTACK(self)
	self:say("Ha!")
end

function EVENT_COMBATEND(self)
	self:say("Hmph. Not worth the effort.")
end

function EVENT_SAY(self, other, msg)
    local hail = string.match(msg, "Hail")
    local myths_and_bones = other:GetFlag(3009)
    self:face(other)

    if other:GetFlag(3000) == 7 then
        if myths_and_bones < 10 then
            if hail then
                self:say("Hail. Oh, you must be that "..other:GetName().." I've been hearing about. I suppose I should thank you. I'm the last true huntsman in the village, you see, and as a result I've come into possession of the Knife of Gruthluk that you gathered pieces for. It's a good knife - perfect for cutting open the bellies of those vile murklings.")
                dialog(other, self, "I'm glad you like it.")
            
            elseif string.match(msg, "I m glad you like it") then
                self:say("Indeed. It is not so good against the szithri, however: their legs are too wispy, and they are mostly able to keep their bodies out of our reach. They say we used to be able to catch a szithri just by flicking them with our tongues - but who knows what poisons their oversized bodies are producing these days. What we really need are some good hunting spears - I'm sure I could train some of the lads to use them...' Glakrin's words trail off.")
            end

        elseif myths_and_bones == 10 then
            if hail then
                self:say("Ah, thank you for all of the hunting spears, "..other:GetName()..". We'll have plenty to train the lads with and - with any luck - to use out in the wilds as soon as their training is finished. If you find any more, we could always use some spares, I suppose.")
                dialog(other, self, "I'll keep that in mind.")
            
            elseif string.match(msg, "I ll keep that in mind") then
                self:say("Thank you. Ah, "..other:GetName().."? If you'll permit me, I have a question to ask of you...")
                dialog(other, self, "What is it?")
            
            elseif string.match(msg, "What is it") then
                self:say("These spears you've given me... you've taken them from the hands of the lingering Gruplok dead, haven't you?")
                dialog(other, self, "I have.")
            
            elseif string.match(msg, "I have") then
                self:say("I suspected as much. It pains me to think of having to fight our fallen brothers and sisters... but so long as they continue to roam the swamp, they will be a threat to our hunters. Lately, I've been speaking with Kalunepe about an old myth. We don't know the whole story, exactly, but this particular myth is about the hero Gruthluk fighting the unliving abominations of the old Empire. It seems the myth mentions some of the special weaponry he used to cleanse the abominations and send them back into the void in one sweep. I know the myths are likely not entirely true, as Grupruk liked to remind us, but if these weapons are as good as this Knife of Gruthluk you helped us make... Well, we will need to protect our hunters out in the wilds, and if we could use such weapons to clease our fallen people...")
                dialog(other, self, "Go on.")
                dialog(other, self, "[CHAOTIC] But you'll need my help, is that what you're getting at?")
            
            elseif string.match(msg, "Go on") then
                other:setFlag(3009, 11)
                self:say("I'd like you to help us attempt to recreate these weapons, if you would be willing. You'll need to talk to Kalunepe to find out exactly what is needed. Our new hunters will need all the help they can get...")
                other:journal("Myths and Bones", 1, "Glakrin wants me to help him try to recreate some potent undead-cleansing weaponry from one of the old Gruplok myths. First of all, I'll need to speak with Kalunepe to find our more about the myth.")
            
            elseif string.match(msg, "But you ll need my help  is that what you re getting at") then
                other:addAlignment("Chaotic", 1)
                other:setFlag(3009, 11)
                self:say("Well, honestly, yes. I'd like you to help us attempt to recreate these weapons, if you would be willing. You'll need to talk to Kalunepe to find out exactly what is needed. Our new hunters will need all the help they can get...")
                other:journal("Myths and Bones", 1, "Glakrin wants me to help him try to recreate some potent undead-cleansing weaponry from one of the old Gruplok myths. First of all, I'll need to speak with Kalunepe to find our more about the myth.")
            end

        elseif myths_and_bones == 11 then
            if string.match(msg, "Hail") then
                self:say("I'm no expert on the myths - you'll need to speak with Kalunepe if you want to help me and the future generations of Gruplok huntsmen.")
            end

        elseif myths_and_bones == 18 then
            if hail then
                self:say("Such marvelous weapons... we can surely use these to pure our fallen brothers and sisters to rest, when the time comes. How is yours faring you?")
                dialog(other, self, "I would like to switch mine for one of the other weapons.")
                dialog(other, self, "These weapons aren't really my kind of thing. Would you mind keeping them all? You'd get more out of them than I would.")
            
            elseif string.match(msg, "I would like to switch mine for one of the other weapons") then
                self:say("Certainly. Just hand yours to me and I'll give you one of the others.")
            
            elseif string.match(msg, "These weapons aren t really my kind of thing  Would you mind keeping them all  You d get more out of them than I would") then
                self:say("You don't want any of them? I wouldn't mind keeping all of them - they will all be of great use. But you're sure you don't want yours any longer?")
                dialog(other, self, "Ah, nevermind. I'll hang on to mine for a while longer.")
                dialog(other, self, "I'm sure.")
            
            elseif string.match(msg, "I m sure") then
                other:setFlag(3009, 20)
                self:say("Alright. Hand yours to me, and I'll make sure it finds good use in the hands of the future Gruplok huntsmen.")
            end

        elseif myths_and_bones == 20 then
            if hail then
                self:say("Were you going to return your weapon to me, "..other:GetName().."?")
                dialog(other, self, "Yes.")
                dialog(other, self, "I changed my mind.")
            
            elseif string.match(msg, "Yes") then
                self:say("Just hand it to me, then! I'll find a good home for it, once one of the younglings becomes skilled enough.")
            
            elseif string.match(msg, "I changed my mind") then
                self:say("Oh, alright then, "..other:GetName()..". If you'd like to trade your weapon for one of the others, just hand it to me, then. Or if you change your mind once more, simply tell me so.")
                other:setFlag(3009, 18)
            end
        end
    end
end

function EVENT_ITEM(self, other, item, coin)
    -- hunting spear turn-in
	if other:GetFlag(3000) == 7 and item(20775) > 0 and other:GetFlag(3009) < 9 then
		item:keep(20775, 1)
		other:setFlag(3009, other:GetFlag(3009) + 1)
		other:giveFaction(600, 2)
		self:say("Oho, I've seen this before: this is a hunting spear made by old Huntsman Grakhalak! Where did you get this? Ah, but no matter - thank you for bringing this to me. If you find any more, I'll be happy to take them off your hands. The Gruploks may continue to be hunters yet...")
		other:giveExp(2000, 0)
	end
	if other:GetFlag(3000) == 7 and item(20775) > 0 and other:GetFlag(3009) == 9 then
		item:keep(20775, 1)
		other:setFlag(3009, 10)
		other:giveFaction(600, 2)
		self:say("Thank you kindly, "..other:GetName()..". We'll have plenty of spears to train with and - with any luck - to use out in the wilds, soon enough. If you find any more, we could always use some spares, I suppose.")
		other:giveExp(2000, 0)
		dialog(other, self, "I'll keep that in mind.")
	end
	if other:GetFlag(3009) > 9 and item(20775) > 0 then
		item:keep(20775, 1)
		self:say("Ah, more spears, hmm, "..other:GetName().."? It's always good to have some extras. Thank you.")
		other:giveExp(400, 0)
	end

	if other:GetFlag(3009) == 17 and item(20788) > 0 then
		item:keep(20788,1)
		other:setFlag(3009, 18)
		other:giveFaction(600, 150)
		other:setFlag(3010, other:GetFlag(3010) + 1)
		self:say("Haha! So the myth was true! These weapons.. they are glorious. I don't know how you managed to find everything that was needed - but you have my ceaseless gratitude! Ah, I must thank Kalunepe, and Kathrinka as well. They've been so much help to such a poor old coot like me. Ah, but you - you especially. I would be honored if you would keep one of these sacred weapons of myth for yourself. If you would prefer one of the others, simply hand this one back to me.")
		other:giveItem(20777, 1)
		other:journal("Myths and Bones", 100, "I have given the recreations of the mythic cleansing weapons to Glakrin, and he has allowed me to keep one of them in return. If I don't want to keep any of them, I can return them to him.")
	end
	-- Reward cycle
	if other:GetFlag(3009) == 18 and item(20777) > 0 then
		item:keep(20777, 1)
		other:giveItem(20778, 1)
	end
	if other:GetFlag(3009) == 18 and item(20778) > 0 then
		item:keep(20778, 1)
		other:giveItem(20779, 1)
	end
	if other:GetFlag(3009) == 18 and item(20779) > 0 then
		item:keep(20779, 1)
		other:giveItem(20777, 1)
	end
	-- Trade reward for exp
	if other:GetFlag(3009) == 20 and item(20777) > 0 then
		item:keep(20777, 1)
		other:giveExp(50000, 0)
    end
	if other:GetFlag(3009) == 20 and item(20778) > 0 then
		item:keep(20778, 1)
		other:giveExp(50000, 0)
	end
	if other:GetFlag(3009) == 20 and item(20779) > 0 then
		item:keep(20779, 1)
		other:giveExp(50000, 0)
    end
end