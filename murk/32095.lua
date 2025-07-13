-- 14031 is the jc quest flag 10 means you can make the combine.
-- 14026 is the tradeskill flag required to learn the recipe. 100 = ok
-- jc is skill 68 p
-- 32095 jewelry kirstap

function EVENT_SAY(self, other, msg)
    local hail = string.match(string.lower(msg), "hail")
    local jewelry_quest = other:GetFlag(14031)
    local jewelcraft = other:GetSkill(68)
    local faction = other:GetCon(600, true)

    self:face(other)

    if faction <= 5 then
        if jewelry_quest == 0 then
            if hail then
                self:text("The eldery Gruplok is focused, attempting to carve a piece of driftwood.")
                dialog(other, self, "Excuse me, are you by chance a jewelcrafter?")

            elseif string.match(string.lower(msg), "jewel") then
                self:text(self:GetName().."'s knife slips suddenly!")
                self:say("These blasted knives!  Jewelry!  I wish you wouldn't sneak up on an old woman lake that, but I can't blame you for the knives.  These things are awful.  Any sharper, though, and fooop!  The lizards whisk you away and send back your limbs.  FAH!")
                dialog(other, self, "I'm sorry for startling you.")

            elseif string.match(string.lower(msg), "i m sorry for startling") then
                self:say("Oh, I'm not mad at you or anything.  Just that what I do with my day has shrunk down to carving driftwood and with these blunt slabs of metal, I can't even do that anymore!'  She throws the knife expertly, but it clangs off the floor outside and vanishes into the swamp.  'Oh well, good riddance.  Maybe if we get rid of all our knives we won't need anymore driftwood carved and I can spend my days wishing I could take up my old profession.")
                dialog(other, self, "What was your old profession?")

            elseif string.match(string.lower(msg), "what was your old") then
                self:say("You mean before I became the foremost carver of driftwood in the whole swamp?  I was a jeweler, friend, as Galka must have told you.  But the lizards ate up all the gems and ran off with all our texts.  As if some ancient Gruplok magic were somehow hiding in a pretty stone.  Ridiculous.")
                dialog(other, self, "They won't let you work with gems anymore?")

            elseif string.match(string.lower(msg), "they won t let you work with") then     
                self:say("Let?  There's no 'let' about it, friend.  There are just plain no more jewels!  Oh, I've seen a few appear in Gartonak's wares over the past few weeks, but I'm sure those are from your lot bringing them in from far-off lands.  No, the gems found in the swamps are gone and all I have left to do with my life is fiddle with knives so dull, it is almost obscene to call them 'tools'.  It's a shame, too, since one problem could solve another.  If I had an old faceted swamp diamond, I could whip these knives into shape and no one would ever know.")
                dialog(other, self, "A faceted swamp diamond?")

            elseif string.match(string.lower(msg), "a faceted swamp diamond") then
                self:say("Sure!  Don't tell me you lot have never seen one of these beauties.  Makes anything sharp as diamond-edge but then fades.  The lizards would never even know I had it.  I've even got some of the wax stored away.  Still, you can't make one without some eldritch rune patterns to guide the process-.. oh and a diamond set in an electrum ring as a base.  The worst part, though, is the giant shark tooth.  Heavens knows where you can get one of those these days without being eaten alive...")
                dialog(other, self, "I bet I could find those things.")

            elseif string.match(string.lower(msg), "i bet i could find") then
                self:say("Do you now!  Well, it would be most welcome.  Honestly, I never want to see a piece of driftwood again.  But if my lot in life is to carve it, it would be much more tolerable with working knives.  Let me know when you rounded up this laundry list of good, I'll be here waiting.")
                other:setFlag(14031, 1)
                other:journal("Swamp Diamond", 10, "Old Kirstap asked me to find a giant shark tooth, eldritch rune pattern, and an electrum diamond ring.")
            end
            
        elseif jewelry_quest == 1 then
            if hail then
                self:say("Welcome back, "..other:GetName().."!  Any luck finding those items?")
            end

        elseif jewelry_quest == 2 then
            if hail then
                if jewelcraft >= 225 then
                    self:text("Kirstap looks at you appraisingly.")
                    dialog(other, self, "That is amazing.")
                else
                    self:say("I hope you've been able to play with that diamond!")
                end

            elseif string.match(string.lower(msg), "that is amazing") and jewelcraft >= 225 then
                if other:GetFlag(14026) == 100 then
                    self:say("Is it?  Well it's nothing I couldn't teach one willing to learn.  You look like someone who has the learning spirit.. what do you say?  Interested in learning to make these on your own?")
                    dialog(other, self, "You'd better believe it!")
                elseif other:GetFlag(14026) == 0 then
                    self:say("It's always made me happy, yes, and it's not hard to learn... for a Gruplok that is.  I can't explain it, but Goplen might be able to.  He's always running on about the Gruplok Spirit and other lofty ideas.")
                    other:setFlag(14026, 10)
                end

            elseif string.match(string.lower(msg), "you d better believe it") and jewelcraft >= 225 and other:GetFlag(14026) == 100 then
                self:say("Hah!  That's what I like to hear.  Now, to make one of these ordinarily, you just need any size of shark tooth from the Forest.  That large tooth is good for me because I need it to last forever.  But the real way to make them is with dull shark teeth.  Also, I have no idea where to get more wax.  But assuming you can find some more, this is what you do.")
                self:text("Kirstap is an amazing teacher and you absorb the process readily.")
                other:giveExp(100000,0)
                other:journal("Swamp Diamond", 100, "I can make my own faceted swamp diamonds with dull Ikisith shark teeth, eldritch rune patterns, gruplok wax, and an electrum diamond ring.")
                other:setFlag(14031,10)
            end
        end
    end
end

function EVENT_ITEM(self, other, item, coin) 
-- quill - 41108 NEEDS CHANGED
-- eldritch rune pattern - 41122
-- Electrum Diamond Ring - 16829 / 16600
-- SHARK TOOTH - 60166
	if item(60166) > 0 and item(41122) > 0 and (item(16829) > 0 or item(16600) > 0) and other:GetFlag(14031) == 1 then
		item:keep(60166, 1)
		item:keep(41122, 1)
		item:keep(16831, 1)
	        item:keep(16600, 1)
		item:keep(16829, 1)
		self:say("My goodness!  If only everyone was as accommodating!  Well, let's get to work.")
		self:text("Kirstap's hands are a flurry of activity.")
		other:setFlag(14031,2)
		other:giveFaction(600,80)
		other:giveExp(12000,0)
		other:giveItem(41054,1)
		other:journal("Swamp Diamond", 50, "Kirstap made me a Faceted Swamp Diamond.")
        if other:GetSkill(68) >= 225 then
    		self:text("Kirstap looks at you appraisingly.")
	    	dialog(other, self, "That is amazing.")
        end
    end
end
