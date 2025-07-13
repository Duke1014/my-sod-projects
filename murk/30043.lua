-- Kruala the Barren

function EVENT_SAY(self, other, msg)
    local hail = string.match(string.lower(msg), "hail")
    local woes_quest = other:GetFlag(3015)

    self:face(other)

    if other:GetFlag(3000) == 7 then
        if woes_quest == 0 then      
            if hail then
                self:text(self:GetName().." stares blankly into the distance, a null expression on her face. She doesn't seem to have heard you.")
                dialog(other, self, "Are you okay?")
            elseif string.match(msg, "Are you okay") then
                self:say("...What? Who is it..?' Kruala blinks at you feebly. She seems to be having trouble focusing. 'Nevermind, it doesn't matter. Please... just leave me be.")
                dialog(other, self, "What's troubling you..?")
            elseif string.match(msg, "What s troubling you") then
                self:text("Kruala ignores you, staring distantly.")
                other:setFlag(3015, 1)
            end
        elseif woes_quest == 1 then
            if hail then
                self:text("Kruala ignores you, staring distantly.")
            end
        elseif woes_quest == 2 then
            if hail then
                self:text("Kruala ignores you, staring distantly.")
                dialog(other, self, "I know what happened to your family.")
            elseif string.match(msg, "I know what happened to your family") then
                self:text("Kruala turns and looks at with a tormented gaze, quiet tears welling in her eyes.")
                dialog(other, self, "I know what happened to your husband, what happened to your son. Is there anything I can do for you?")
            elseif string.match(msg, "I know what happened to your husband  what happened to your son  Is there anything I can do for you") then
                other:setFlag(3015,3)
                self:text("Kruala sighs heavily and stares at the ground while she talks to you. There is just a hint of relief in her voice. 'My son... You did not know him. No one knew him, no one except my husband and I... Hey was such a brimming boy, so much energy... He always carried a toy sword with him, everywhere we went. He was going to be a sentry, a noble fighter, a patriarch to all the Gruploks and the leader of his long line! But... they took him. Why would they? He was just a boy... They didn't know him, they couldn't have know what he would become... But - but he is still out there. No, I know he is not still alive - I am not so lost, yet. But he is still in pain, STILL, after so long, so very long... If you - you stranger, you worthless foreigner!! - if, if you really... Pardon, pardon, but if you want to help.. Find my son... Put him to rest.")
                other:journal("Woes of a Mother",1,"Kruala wants me to find her murdered son, and put him to rest once and for all.")
            end
        elseif (woes_quest == 3 or woes_quest == 4) then
            if hail then
                self:say("Find my son... Put him to rest, I beg you! If I could find him myself... Please.")
            end
        elseif (woes_quest >= 5 and woes_quest <= 7) then
            if hail then
                self:say("My husband.. Please find my husband and make him quit this world...")
            end
        
        elseif woes_quest == 8 then
            if hail then
                self:say(other:GetName().."! Something, something has changed... Tell me, did you find my husband..?")
                dialog(other, self, "Well...")
            elseif string.match(msg, "Well") then
                self:text("Kruala listens as you relate what happened. 'Oh! My son... my husband... Did he really say that? That my line may not be doomed? Perhaps were all doomed in this place... But, he fought for us, and he stayed with us in spite of everything. Maybe he always thought *he* was doomed, even while he lived... But after everything, even he had some hope left. And that hope has set him and our son free from their torment. Thank you, "..other:GetName().."... I'll never forget what you've done for me... and my family.")
                other:giveExp(20000,0)
                other:giveFaction(600,75)
                other:setFlag(3015,9)
                other:journal("Woes of a Mother",100,"I have freed Kruala's family from the torment of undeath.")
            end
        elseif woes_quest == 9 then
            if hail then
                self:say("Good day to you, "..other:GetName().."!")
            end
        end 
    end
end

function EVENT_ITEM(self, other, item, coin)
	if other:GetFlag(3015) == 4 and item(20823) > 0 then
		item:keep(20823,1)
		other:setFlag(3015,5)
		self:say("This... My son, you have seen him? Put to rest... No! I still feel him - he is still out there. You may have broken his body, but his spirit has not been freed. He still lingers.. I am certain of it. But why? Is it... could it be - my husband? My husband's spirit lingers too... Perhaps my son is with his father, perhaps he clings to this world because his father clings to it. My husband - you must free my husband! His spirit lingers near my son, I know it. I can almost hear his cries... Please, take this, show it to my son, show it to my husband and convince them - convince them however you can! - convince them to leave this world and be at peace... Their lives are over. Mine is, as well... Tell them there is no more reason to linger, that I will join them soon...", 100, other)
		other:giveItem(20824,1)
		other:journal("Woes of a Mother",3,"I thought I had put Kruala's son to rest, but she says his spirit is still lingering with that of her husband's. She wants me to find her son again, draw out her husband, and try to convince him to rest in peace.")
    end
end