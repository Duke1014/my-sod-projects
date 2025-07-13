-- Skirish`ka - trigger npc

function EVENT_SAY(self, other, msg)
	if string.match(string.lower(msg), "hail") then
		self:text(self:GetName().." turns and stares at "..other:GetName().." with empty eye-sockets. She speaks with a strained yet cavernous voice. 'Know you of Gruthluk?'")
		dialog(other, self, "Who?")
		dialog(other, self, "I do.")

    elseif string.match(msg, "Who") then
		self:say("Gruthluk, that impudent little frog from that wretched little backwater they dare to call a city -- a city that dares to send their little revolutionaries against the might of the deathless Empire! Curse them all to rot in the void forever and longer, as they are due. But that is not why I mention him. Gruthluk's torment cannot wait for his death.")
		dialog(other, self, "Why is that?")

	elseif string.match(msg, "I do") then
		self:say("Do you? Tell me where he is, immediately, worthless foreigner. He must be captured at once.")
		dialog(other, self, "Why is that?")

    elseif string.match(msg, "Why is that") then
		self:say("Because he tormented my sister, drove my sister mad, tore her from her rightful place at the seat of the Imperial Legion! BECAUSE HE MURDERED MY SISTER! Why have you not answered, worthless ones?! ARE YOU IN LEAGUE WITH GRUTHLUK AS WELL?!")
		spawn(30106, self)
        self:depop()
    end
end