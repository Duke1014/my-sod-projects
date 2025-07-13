-- Slar`thith`la - Murk, first encounter 

function EVENT_SPAWN(self)
    self:text("The darkened form reveals itself to be a whirling pile of bones. The skeleton's eye sockets somehow convey a sense of momentary confusion, followed by a pleased smirk.")
end

function EVENT_TIMER(self, timer)
    if timer == "exit" then
		self:say("You remember, don't you: the place we first fought one another? Such a lovely place. If your city and your people are still precious to you, Gruthluk, come find me there. I will be waiting...' Slar`thith`la and her minion vanish.")
        spawn(30104, -1207, -198, -26.6, 0, 300)
		spawn(30104, -1201, -188, -28.4, 0, 300)
		spawn(30104, -1253, -215, -25.5, 0, 300)
		spawn(30104, -1221, -195, -27.8, 0, 300)
		depop(30102)
        self:depop()
    end
end

function EVENT_SAY(self, other, msg)
    local talk_over = false

    self:face(other)

    if other:GetFlag(3025) == 6 and talk_over == false then
        if string.match(string.lower(msg), "hail") then
            self:say("Ohoho! If it isn't my old nemesis, hmm? Gruthluk the Spineless. Still carrying that old soothsayer's bauble? You of all the worthless toads should know that 'luck' cannot protect you.")
            dialog(other, self, "Uh... huh?")

        elseif string.match(msg, "Uh") then
            self:say("Surprised to see me, are you Gruthluk? Hah! You thought a little death would be the end? A momentary detour, at most! I swore I would have my vengeance, Gruthluk - you may have defeated me once, but it will not happen again. I WILL see you burn, and every last toad with you.")
            dialog(other, self, "Who the hell are you?")

        elseif string.match(msg, "Who the hell") then
            self:say("Hah! Even a vapid little toady could not forget. Such a primitive thing cannot hope to confuse the greatest necromancer in all the Empire! You should learn your place, Gruthluk, though I know you never will - not until you lay dying at my hands, in any case.")
            dialog(other, self, "I don't know what's going on, but I am NOT Gruthluk.")

        elseif string.match(msg, "NOT Gruthluk") then
            self:text("Slar`thith`la raises a menacing skeleton. 'Hahaha! How quickly my powers are returning to me. I have missed you in the void, Zak`ril. A shame you could not join me. Ah, little Gruthluk, the plans I made for you during my stay there. SUCH lovely plans! I'm sure you will enjoy them.' Slar`thith`la snickers wolfishly.")
            dialog(other, self, "...You're that witch, aren't you? From the myth!")
            spawn(30102, -1235, -367, -6, 97.6, 300)

        elseif string.match(msg, "that witch") then
            talk_over = true
            other:setFlag(3025, 7)
            self:say("Oho, you made quite a mistake in killing me, Gruthluk. I can feel my power growing even now! My experiences in the void have only improved my necromancy. It will take some time for me to harness my power in full, but I have much in mind to entertain us in the mean time, you have my word. Here - a little trick to mark my return. I hope you enjoy them.")
            self:timer("exit", 8000, true)
        end
    end
end