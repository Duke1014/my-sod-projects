-- Quest Tortured Dissident Gruklisi

function EVENT_SPAWN(self)
	self:set("playerfriendly", 1)
	self:say("My son - what is the matter? Why have you...")
end

function EVENT_CONSIDER(self, other)
    other:text("Though the ghost appears hostile, it is unlikely that it will harm you at this time...", 6, true)
end

function EVENT_ITEM(self, other, item)
	if other:GetFlag(3015) > 4 and other:GetFlag(3015) < 7 and item(20824) > 0 then
		other:setFlag(3015, 6)
		self:text("Gruklisi's form wavers for a moment. 'That... WHERE DID YOU GET THIS? I, I... So tell me, stranger, where did you get this? Why are you showing it to me in this place? Why have you upset my son?! TELL ME!")
		dialog(other, self, "Your wife gave it to me.")
    end

	if other:GetFlag(3015) == 7 and item(20824) > 0 then
		other:setFlag(3015, 8)
		item:keep(20824, 1)
		self:say("I... thank you. Come with me, my son...")
		other:journal("Woes of a Mother", 50, "I have persuaded Kruala's husband to leave this world and take his son with me. I should go tell Kruala.")
		depop(30060)
		self:depop()
    end
end

function EVENT_SAY(self, other, msg)
    self:face(other)
    if other:GetFlag(3015) == 6 then
        if string.match(msg, "Your wife gave it to me") then
            self:say("She, she... THAT TRAITOR! IF I COULD BE EMBODIED AGAIN I WOULD... She gave it to you, you say? Why? Why is that? WHY?!")
            dialog(other, self, "She wanted me to bring you out, so I could talk to you. Seems like it worked.")
        
        elseif string.match(msg, "She wanted me to bring you out") then
            self:say("SENT YOU TO TORMENT ME? SHE WANTS TO TAKE MY SON AWAY FROM MY DOESN'T SH... She wanted you to talk to me? Why... whatever for? I am not troubling her... I am not troubling anyone. They are the ones who would not fight for their own kind. They are the ones who left me to face them alone, to go up against IMPOSSIBLE ODDS,  TO SEND MYSELF TO DEATH FOR WHAT I BELIEVE IN! NONE OF THEM WILL STAND UP FOR THEMSELVES! THEY SHOULD BE THE ONES WHO ARE DEAD, THEY DESERVE IT, NOT... Why did she want you to talk to me?")
            dialog(other, self, "It's about your son.")
        
        elseif string.match(msg, "It s about your son") then
            self:say("MY... My son? He... My son. He came after me. He wanted to stand by my side... I should have stopped him, SHOULD HAVE LET HIM BELIEVE IT WASN'T WORTH FIGHTING FOR, HE DIDN'T DESERVE THIS HELL BUT HE DIDN'T DESERVE DEATH EITH... My son... What about him? What, WHAT DO YOU WANT FROM... from. What do you want from me, stranger? What did my wife send you for, really..?")
            dialog(other, self, "Her son can't leave this world... She wants him to be at peace. You, too.")
            dialog(other, self, "[CHAOTIC] Your wife wants her peace. She can't do that while you're still here, haunting things up, standing in her way and all that. I'm not sure what she'll give me in return for getting you out of here, but I aim to find out!")
            dialog(other, self, "[LAWFUL] The dead are not meant for this world. This is the world of the living, and the living alone. You are here only as an abomination. You and your son must leave this world.")
            dialog(other, self, "[GOOD] Her son can't rest in peace. He's too attached to you, and you are too attached to this world... She just wants you both to rest, to be at peace, to remove yourself from this torment.")
            dialog(other, self, "[EVIL] She wants you to leave your son the hell alone. You are keeping him here. I can't release him myself. I don't care what happens to you, just let your son go.")
        
        elseif string.match(msg, "CHAOTIC") then
            other:setFlag(3015, 7)
            other:addAlignment("Chaotic", 5)
            self:say("I CANNOT I CANN... Per, perhaps... perhaps you are right. Perhaps SHE is right. I, I... what have I been doing here? How long has it been..? I, I will leave. My son... I do not know why he has stayed. He, he will follow me, I suppose... Please, please... Let me see Kruala's heirloom one more time. Perhaps per line is not doomed yet... Perhaps she will live on without us. I, I... It is not for me to worry. I should not BE. I understand. Let me see it, one more time...")
        
        elseif string.match(msg, "LAWFUL") then
            other:setFlag(3015, 7)
            other:addAlignment("Lawful", 5)
            self:say("I CANNOT I CANN... Per, perhaps... perhaps you are right. Perhaps SHE is right. I, I... what have I been doing here? How long has it been..? I, I will leave. My son... I do not know why he has stayed. He, he will follow me, I suppose... Please, please... Let me see Kruala's heirloom one more time. Perhaps her line is not doomed yet... Perhaps she will live on without us. I, I... It is not for me to worry. I should not BE. I understand. Let me see it, one more time...")
        
        elseif string.match(msg, "GOOD") then
            other:setFlag(3015, 7)
            other:addAlignment("Good", 5)
            self:say("I CANNOT I CANN... Per, perhaps... perhaps you are right. Perhaps SHE is right. I, I... what have I been doing here? How long has it been..? I, I will leave. My son... I do not know why he has stayed. He, he will follow me, I suppose... Please, please... Let me see Kruala's heirloom one more time. Perhaps per line is not doomed yet... Perhaps she will live on without us. I, I... It is not for me to worry. I should not BE. I understand. Let me see it, one more time...")
        
        elseif string.match(msg, "EVIL") then
            other:setFlag(3015, 7)
            other:addAlignment("Evil", 5)
            self:say("I CANNOT I CANN... Per, perhaps... perhaps you are right. Perhaps SHE is right. I, I... what have I been doing here? How long has it been..? I, I will leave. My son... I do not know why he has stayed. He, he will follow me, I suppose... Please, please... Let me see Kruala's heirloom one more time. Perhaps per line is not doomed yet... Perhaps she will live on without us. I, I... It is not for me to worry. I should not BE. I understand. Let me see it, one more time...")
        
        elseif string.match(msg, "Her son can t leave this world") then
            other:setFlag(3015, 7)
            self:say("I CANNOT I CANN... Per, perhaps... perhaps you are right. Perhaps SHE is right. I, I... what have I been doing here? How long has it been..? I, I will leave. My son... I do not know why he has stayed. He, he will follow me, I suppose... Please, please... Let me see Kruala's heirloom one more time. Perhaps per line is not doomed yet... Perhaps she will live on without us. I, I... It is not for me to worry. I should not BE. I understand. Let me see it, one more time...")
        end
    end
end