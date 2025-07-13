-- Rations Distributer Gralak

local food = {
    20754, --   Murk Leech Meat	
    20772, --   Quality Serpent Meat
    40906, --   Co`dair Meat
    41056, -- 	Fatty Leech Meat
    20805, -- 	Mature Murk Leech Meat
    20774, -- 	Wild Murk Mushroom
    40900, -- 	Szithri Innards
    40904, -- 	Shrew Bits
    38007, --   Elhasaur Fat
    40914,  --	Meaty Scorpion Tail
    43637, -- 	Lean Shark Meat
    46029, --   Fresh lacertail Meat
    46030, --	Fresh Cryospine Meat	
    46028, -- 	Cryospine Egg
    40902, --   Murkwater Giblets
    40908, --   Cockatrice Innards
}

function EVENT_SAY(self, other, msg)
    self:face(other)

    if other:GetFlag(3000) == 7 then
        if other:GetFlag(3005) == 0 then
            if string.match(string.lower(msg), "hail") then
                self:say("Hm? Ah, you must be the one who brought us those leech meats, yes?")
                dialog(other, self, "Yes, I am.")

            elseif string.match(msg, "Yes  I am") then
                self:say("I would be glad to shake your hand. Haha! Yes, you certainly got us out of a spot - I had nearly driven myself mad trying to find something, anything we could use to eat. I kept going over the same numbers in my head, knowing we'd only be able to feed half the town at most for the day and then have nothing left for the next, knowing too that all my ventures and all the headman's suggestions had failed to turn up another supply - I had almost finished convincing myself to set one of the baths boiling and cook myself alive to provide a day or two of food for everyone else when, unbelievably, Grupruk came up from the murkwaters with your miraculous bounty. I hadn't heard of your gift of the knife with all my panicking, and I was too busy babbling to understand that an outsider had provided the meats Grupruk had brought, but now that I do know: thank you, thank you, thank you!")
                dialog(other, self, "Ah, don't mention it!")
                dialog(other, self, "[GOOD] After hearing about your predicament, how could I have done any less?")

            elseif string.match(msg, "Ah  don t mention it") then
                other:setFlag(3005, 1)
                self:say("Ah, you'll have to forgive my sputtering, but it really was nothing short of a miracle for us. In fact, we still haven't found a good source of food. If you'd be willing to provide any food that you can find out in the swamp, we would be most honored to receive it - we could really use any help we can get, at least until we've trained some of the lads to hunt properly - not easy to do when they're all starving, you know!")
                dialog(other, self, "I'll keep an eye out. What sort of food do you have in mind?")

            elseif string.match(msg, "After hearing about your predicament  how could I have done any less") then
                other:setFlag(3005, 1)
                other:addAlignment("Good", 1)
                self:say("Ah, such a kind soul. We could use more of your kind around here! Ah, but please forgive my sputtering - your gesture really was nothing short of a miracle for us. In fact, we still haven't found a good source of food. If you'd be willing to provide any food that you can find out in the swamp, we would be most honored to receive it - we could really use any help we can get, at least until we've trained some of the lads to hunt properly - not easy to do when they're all starving, you know!")
                dialog(other, self, "I'll keep an eye out. What sort of food do you have in mind?")
            end

        elseif other:GetFlag(3005) == 1 then
            if string.match(string.lower(msg), "hail") then
                self:say("Ah, find anything edible lately "..other:GetName().."?")
                dialog(other, self, "I'll keep an eye out. What sort of food do you have in mind?")

            elseif string.match(msg, "I ll keep an eye out  What sort of food do you have in mind") then
                self:text("Gralak pokes through some stored leech meat as he ponders for a moment. 'Krukin likes to tell me that szithri dishes have been considered a delicacy for hundreds of years, but in terms of feeding power they are mostly worthless. More murk leech meat would be good. They aren't exactly tasty, but they last well enough and are easy to prepare. Meat from murkwater serpents would be even better, however - their meat is very resilient and much more suited to the Gruplok palate! Perhaps some meat from the neighboring areas would be worth a try, but I've never heard of a Gruplok eating them - and then we'd have to figure out how to prepare them. Perhaps some of the fungus in the area isn't poisonous? In any case, bring me anything you think seems promising, and I'll be very grateful. We all will be!'")
            end
        end
    end
end

function EVENT_ITEM(self, other, item, coin)
    for k, v in pairs(food) do
        debugtext(v)
        debugtext(item(v))
        if item(v) > 0 then
            self:say("Excellent! This food will do wonders for the health of our village.")
            other:giveFaction(600, 2 * item(v))
            if other:GetFlag(3006) < 20 then
                other:setFlag(3006, other:GetFlag(3006) + item(v))
                other:giveExp(1500 * item(v), 0)
            end
            item:keep(v, item(v))
            return
        end
    end
end