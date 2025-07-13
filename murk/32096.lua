-- GARTONAK THE VENDOR AND POTTERY TS
-- TELLS DUDES TO GO TO REMNANTS
-- and sells things =))
-- 14030 is pottery flag,  skill 69 is pottery

function EVENT_SAY(self, other, msg)
    local hail = string.match(string.lower(msg), "hail")
    local faction = other:GetCon(600, true)
	local pottery_quest = other:GetFlag(14030)
    local pottery = other:GetSkill(69)

    self:face(other)

    if faction <= 5 then
        if pottery_quest == 0 then
            if hail then
                self:text(self:GetName().." is fiddling with a small, clay doll.")
                dialog(other, self, "Do you know anything about pottery?")

            elseif string.match(string.lower(msg), "pottery") then
                self:say("Ahem! Pottery! Yes, well. Hrmph. Know a thing or two, I guess. Galka wouldn't steer you wrong.")
                dialog(other, self, "Indeed! I am very interested as well.")
            
            elseif string.match(string.lower(msg), "indeed  i am very interested") then
                self:say("Yes, well, naturally. An amateur such as yourself. A hm hm. The Gruploks are very potent potters and I, the most potent among them.")
                dialog(other, self, "Yes, it is clear you are a master of the craft.")
                
            elseif string.match(string.lower(msg), "yes  it is clear you are a master") then
                self:say("Of course, of course. Of course. Most folks today don't recognize a potter as thoroughly gifted as myself. Why,.. why they laugh at the notion of turning mere earth into the most useful tools. How is it any different from the celebrated smiths?! Hmm? Yes, well, quite.")
                dialog(other, self, "Surely the accomplishments of a skilled potter would put a smith to shame.")

            elseif string.match(string.lower(msg), "surely the accomplishments of a skilled potter") then
                self:say("Hrm, yes. Yes. Why, in the days of the ancient Gruploks, no tradesman was as revered as the potter. Statues were erected in honor of these tireless workers--monuments to their skill. Why, if one of these insolents saw a functioning Gruplok golem today, their tongues would drag upon the swamp in envy! Pah!")
                dialog(other, self, "A Gruplok Golem? That sounds fascinating.")

            elseif string.match(string.lower(msg), "a gruplok golem") then
                self:say("Fascinating! Pah! It's astounding! Just the tales of it. But they laugh. And with no one to hunt vibrant mistmane blood and burgundy clay powder, they will laugh forever! Why I haven't even a mug to place it in!")
                dialog(other, self, "I could probably find you these things.")

            elseif string.match(string.lower(msg), "i could probably find you these things") then
                self:say("It would serve them right. It would just serve them right if you found clay.. if you found the vibrant blood.. if you found a mug. It would serve them right to see the clay rise up under its own power and walk! Hmh! Would show me a little more respect then! Mark my words.")
                other:setFlag(14030,1)
                other:journal("Gartonak and the Golem", 10, "Gartonak asked for vibrant mistmane blood, burgundy clay powder, and a mug to make his Golem.")
			end

		elseif pottery_quest == 1 then
			if hail then
				self:say("Did you find those pieces? Find the vibrant blood, mug, and clay.")
			end

		elseif pottery_quest == 2 and pottery >= 80 then
			if hail then
				self:say("The Gruplok spirit! The master potter's eye! You are a most worthy low apprentice.")
				dialog(other, self, "I must learn how to make my own golems.")

            elseif string.match(string.lower(msg), "i must learn how to make my own golems") then
				if other:GetFlag(14026) == 0 then
					self:say("You?! Hah! Skilled you may be, my young apprentice. But to master Gruplok pottery requires more. Much more. Perhaps, yes.. I do this enormous favor for you: Seek out Goplen. He might have words for you.")
					other:setFlag(14026, 10)

				elseif other:GetFlag(14026) == 100 then
					self:say("I could sense it, of course. A fellow potter, and one in tune with the nature of Gruploks. Yes. I will be a fine teacher, and you an adequate student.")
					dialog(other, self, "Please teach me.")
				end
            
            elseif string.match(string.lower(msg), "please teach me") and other:GetFlag(14026) == 100 then
				self:say("Why, it's as simple as this! For you, of course, any mistmane blood will do. Only professionals such as I require that vibrant shade of red. Combine with the mug like so.. and. Well, we haven't any scraps of legend left, have we? Well assuming you somehow find a scrap of legends, you combine thusly with the burgundy clay powder and... just.. like so!")
				other:text("Despite his lofty attitude, Gartonak is an excellent teacher.", 6, true)
				other:giveExp(100000, 0)
				other:journal("Gartonak and the Golem", 100, "I can now make my own golems with mistmane blood, a mug, burgundy clay powder, and a scrap of ancient legend.")
				other:setFlag(14030, 10)
            end
        end
    else
        if hail then
            self:say("Hail yourself! No rations until our hunting party returns from the misty jungle to the East.")
        end
    end
end

function EVENT_ITEM(self, other, item, coin)
-- Hand IN ITEMS for pottery stuff: mug, powder, vibrant blood
	if item(3494) > 0 and item(41121) > 0 and item(41114) > 0 and other:GetFlag(14030) == 1 and other:GetSkill(69) == 100 then
		item:keep(3494, 1)
		item:keep(41121, 1)
		item:keep(41114, 1)
		self:say("Zounds! You have! I mean naturally someone of your rank would have come across these materials eventually. Why, it's a wonder you took so long as it is! But, watch, now, and see what wonders reside in the limbs of a master Gruplok potter.")
		self:text("Gartonak's hands are a blur with the clay!")
		other:setFlag(14030, 2)
		other:giveFaction(600, 80)
		other:giveExp(12000, 0)
		other:giveItem(41052, 1)  -- the golem
		self:say("Hah! Let them laugh at that!")
		other:journal("Gartonak and the Golem", 50, "Gartonak has made me a Golem!")
        if other:GetSkill(69) >= 80 then
            other:text("Gartonak looks at you with trepidation.", 6, true)
            dialog(other, self, "I must learn how to make my own golems.")
        end
	end
end