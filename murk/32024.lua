-- Kallepo, the smithing tradeskill girl
-- ##14028 is the smithing quest flag 10 means you can make the combine.
-- ##14026 is the kaesora "hub quest" flag required to learn the recipe. 100 = ok
-- ##blacksmithing is skill 63

function EVENT_SAY(self, other, msg)
    local faction = other:GetFaction(600, true)
    local hail = string.match(string.lower(msg), "hail")
    local blacksmithing_quest = other:GetFlag(14028)
    local bs_skill = other:GetSkill(63)

    self:face(other)
    self:text("Kallepo remains lost in thought.")
    other:text("Kallepo's quests will be implemented at a later date.", 6, true)
	-- if other:GetFlag(3000) == 7 then
    --     if faction <= 5 then
    --         if blacksmithing_quest == 0 then
    --             if string.match(string.lower(msg), "smith") then
    --                 self:text("Kallepo's eyes slowly track over to you.  '.. Oh, I see.. yes, the Historian must have.. I see, yes.'  Kallepo looks away again, silent.")
    --                 dialog(other, self, "Yes, the Historian told me you were curious about--")
                
    --             elseif string.match(string.lower(msg), "yes  the historian told me you were") then
    --                 self:text("Kallepo interrupts: 'We'd settled that already, hadn't we?  Anyway, it's meaningless.  Pretty, worthless, ugly and unhelpful and wonderful.")
    --                 dialog(other, self, "I have no idea what you are talking--")
                
    --             elseif string.match(string.lower(msg), "i have no idea what you are talking") then
    --                 self:text("Kallepo whirls to face you. 'The beguilling blade!  It is only named once in all of Galka's collection.  But it doesn't matter for such a magnificent creation requires effort and investigation beyond what any Gruplok can muster.  Listen to this: Pure yclistinite ore?  Does that even make sense?  Thick miasma.. as though such a thing even exists.  The only part that even comes close to making sense is where it mentions a mithril dagger.. I've seen buckets of them since your folks began.. well since you arrived.  Anyway, what use is this materials list... but it's all I have and, oh, is it wonderful.")
    --                 dialog(other, self, "I can probably find those--")
                
    --             elseif string.match(string.lower(msg), "i can probably find those") then
    --                 self:say("Find them? Hah!'  Kallepo snorts loudly, 'Yes, FIND them like some scryer out of Gruthulk's legends.  FIND them like Gruthulk himself FOUND the lost cities... Hah!")
    --                 other:setFlag(14028, 1)
    --                 other:journal("Beguiling Blade", 10, "Kallepo probably would be happy if I found her some pure yclistinite ore, some thick miasma, and a mithril dagger. Probably.")
    --             end

    --         elseif blacksmithing_quest == 1 then
    --             if hail then
    --                 self:text("Kallepo is still laughing to herself.  'Oh yes, FIND them they say.  They're just sitting around the swamp in huge piles, I'm sure.  What's that over there?  Why it's just what we needed to construct something actually found only in legends.  How clumsy of me to have overlooked it for all these years.  How silly I feel!  How great you must be!")
    --             end

    --         elseif blacksmithing_quest == 2 and bs_skill >= 225 then
    --             if hail then
    --                 if other:GetFlag(14026) == 100 then
    --                     self:say("The blade, you saw how it all.. you understand, now, the whole thing..")
    --                     dialog(other, self, "That method you used to forge this is very--")
                    
    --                 elseif other:GetFlag(14026) == 0 then
    --                     self:text("Kallepo is still breathless and gazes at you in wonder.")
    --                     dialog(other, self, "That method you used to forge this is very--")
    --                 end

    --             elseif string.match(string.lower(msg), "That method you used to forge this is very") and bs_skill >= 225 then
    --                 if other:GetFlag(14026) == 100 then
    --                     self:say("Yes!  Yes it is very, very.. and you could make more, I'm sure of it.  Very sure.  Do you want to make more?  More than one of these blades.  It's unthinkable, but.. do you?")
    --                     dialog(other, self, "Yes, please show me--")
                    
    --                 elseif other:GetFlag(14026) == 0 then
    --                     self:say("Yes!  Yes it is very, very.. and you could make more, I'm sure of it.  Very sure.  But.. no..  it's not a question of your ability.. but the process requires.. knowledge.. in fact.. yes.. Goplen might help you. He might.")
    --                     other:setFlag(14026, 10)
    --                 end

    --             elseif string.match(string.lower(msg), "yes  please show me") and bs_skill >= 225 and other:GetFlag(14026) == 100 then
    --                 self:say("Simple.  But one mistake.. the ore.. what you brought was too pure.. could feel it writhing in my hands almost.. a sample less refined.. combine with the miasma like so.. then with the mithril dagger.. like this..'  Kallepo stops suddenly.  'Oh, but the totem shards.. that was all I had!  If you find another, then.. you do this like so.. and then this.  There!")
    --                 self:text("Kallepo is, after a fashion, a spectacular teacher and your skills are up to the task.")
    --                 other:giveExp(100000, 0)
    --                 other:journal("Beguiling Blade", 100, "I can now forge my own Beguiling Blades with the following recipe: raw yclistinite, thick miasma, a mithril dagger, and totem shards.")
    --                 other:setFlag(14028, 10)
                
    --             end

    --         elseif blacksmithing_quest == 10 then
    --             -- if string.match(string.lower(msg), "breakthrough") and other:GetFlag(14602) == 1 then
    --             --     self:say("Oh, so Galka couldn't keep his mouth shout yet again, huh? Well fine, since you helped me before, I'll share my breakthrough with you: I figured out how to infuse those augmentations you outsiders are so obsessed with with yclistinite to make them even stronger! And don't worry, I'm ninety percent sure that the glow is harmless!")
    --             --     other:journal("Gruplok Augmentations", 1, "I can combine a deepmetal ore, one piece of coal, a limestone, a molten core, a raw yclistinite chunk and one dose of glowing murk wax in a forge to create a Small Yclistinite-infused Deepmetal Ingot. Two of them combined with a platinum bar and a runepattern of my choice will make a new augmentation.")
    --             --     other:setFlag(14602,2)
    --             -- end
    --         end
    --     end
    -- else
    --     self:text("Kallepo remains lost in thought.")
    -- end
end

-- function EVENT_ITEM(self, other, item, coin)
-- -- HANd IN ITEMS for smithign stuff: yclistinite ore, miasma, mithril dagger
-- 	if item(41112) > 0 and item(41119) > 0 and item(18252) > 0 and other:GetFlag(14028) == 1 and bs_skill == 250 then
-- 		item:keep(41112, 1)
-- 		item:keep(41119, 1)
-- 		item:keep(18252, 1)
-- 		self:doAnim(14)
-- 		self:text("Kallepo nearly topples over in shock.  'But this... I mean this can't actually be.. is that Yclisti.. is.. what?  It is cold-forged and I have.. wait I can..")
-- 		self:text("Kallepo is a flurry of activity and the smithing process is very intricate, but you easily follow her motions.")
-- 		other:setFlag(14028, 2)
-- 		other:giveFaction(600, 80)
-- 		other:giveExp(12000, 0)
-- 		self:text("I can't.. It's beautiful I just.. It's yours of course but just to see it.. to know that the legends are.. this is..")
-- 		other:giveItem(41053, 1)  -- the charm knife
-- 		other:journal("Beguiling Blade",50,"Sufficiently impressed, Kallepo has made a Beguiling Blade.")
-- 		if bs_skill >= 225 then
--             self:text("Kallepo is still breathless and gazes at you in wonder.")
-- 	    	dialog(other, self, "That method you used to forge this is very--")
--         end
--     end
-- end