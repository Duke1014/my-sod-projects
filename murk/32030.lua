-- Lamplighter Grusalk
-- ##14017 is the flag

local lighting_big_lamp = false

-- function EVENT_SPAWN(self)
-- 	if($day == 0)
-- 	{
-- 		scriptstatus(10)
-- 		startscript(10000)
-- 	}
-- end

function EVENT_SAY(self, other, msg)
    local hail = string.match(string.lower(msg), "hail")
    local lamp_quest = other:GetFlag(14017)

    
    if lighting_big_lamp == false then
        self:face(other)
    elseif lighting_big_lamp == true then
        self:text(self:GetName().."says, 'Now, let's not interrupt me at this time.  I've never done this before and I don't want it to go all wrong.'")
        return
    end

    if other:GetFlag(3000) == 7 then
        if lamp_quest == 0 then
            if hail then 
                self:text(self:GetName().." turns to face you with a troubled expression on his face.")
                self:say("I'd seen you folks around before and didn't care.  The truth is I still don't, but right now odds are you've got something I need.")
                dialog(other, self, "What do you need?")
            
            elseif string.match(string.lower(msg), "what do you need") then
                self:say("Well, I've got one job to do in this village.  It's nothing special, but it keeps the lizards off my back and that's good enough for me.  But now I can't do that job anymore so they'll come for me as sure as the rest.")
                dialog(other, self, "What is your job, then?")
            
                elseif string.match(string.lower(msg), "what is your job") then
                self:say("Well I'm a lamp lighter. I keep all the lamps around here working and I do a good job.  But the main lamp over by the entry way has gone dim and my normal materials don't work.  I asked around and was told that I'd need something called a swampglow shimmer.  I have no idea what that is or where it comes from, but the fellow gave me a net that could catch 'em.")
                dialog(other, self, "Did he tell you anything else?")
            
            elseif string.match(string.lower(msg), "did he tell you anything else") then
                self:say("Hmh, well. He didn't say much, just that if you go looking for a shimmer, you won't find any.  Also that they don't come without a fight and those who've gone unprepared haven't seen much success.  Last thing he said was you can't catch 'em until they're beat up a little.  Can't help you more than that.")
                dialog(other, self, "I'll see what I can do.")
            
            elseif string.match(string.lower(msg), "i ll see what i can do") then
                other:setFlag(14017, 1)
                self:say("Mmhmm. Here's the net, then.  Hope you get back here before they do.  Remember I need three of them and bring that net back!  It's the only one I've got.")
                other:giveItem(41027, 1)
                other:journal("Swampglow Safari", 10, "Lamplighter Grusalk asked me to find and capture three swampglow shimmers with a special net.  He said he didn't know how to find them and that they cannot be captured without a fight.")
            end

        elseif lamp_quest == 1 then
            self:say("Remember I need three of those swampglow shimmers, and bring that net back!  It's the only one I've got.")

        elseif lamp_quest == 2 then
            if hail then
                self:say("You've done a wonderful thing for me today.. for all of us, really.  That lamp being lit-- well it just makes the place look better from the swamp on up.  I never expected to even be alive at this point, so I can't say I planned any payment... but rest assured you have our gratitude.")
                other:setFlag(14017, 4)
                other:giveFaction(600, 30)
                other:giveExp(25000, 0)
                other:journal("Swampglow Safari", 100, "Grusalk's spirit have been lifted.")
				self:respawn()
            end

        elseif lamp_quest > 3 then
            self:say("Thanks again for your work and don't be surprised if I come looking for you in the future!  There's something charmed about someone who can help even one Gruplok these days.")

        end
    else
        self:text(self:GetName().." ignores you.")
    end

	if string.match(string.lower(msg), "peepee") then
		self:timer("walk_1", 5000, true)
	end
end

function EVENT_ITEM(self, other, item, coin)
	if item(41026) > 2 and item(41027) > 0 and other:GetFlag(14017) == 1 then
		item:keep(41026, 3)
		item:keep(41027, 1)
		self:say("Well I'll be strung up on a pike.  This looks like exactly what I need. Come with me, friend. Let's illuminate the city together.")
		self:timer("walk_1", 5000, true)
		other:setFlag(14017, 2)
		lighting_big_lamp = true
    end
end

function EVENT_TIMER(self, timer)
	if timer == "walk_1" then
		self:walkTo(-1456, -741, 24.6)
		self:timer("walk_2", 23000, true)
    elseif timer == "walk_2" then
		self:walkTo(-1588, -1027, 24.6)
		self:timer("walk_3", 32000, true)
	elseif timer == "walk_3" then
		self:walkTo(-1718, -1055, 24.6)
		self:timer("walk_4", 14000, true)
	elseif timer == "walk_4" then
		self:walkTo(-1745, -1174, 24.6)
		self:timer("walk_5", 13000, true)
	elseif timer == "walk_5" then
		self:walkTo(-1843, -1237, 24.6, 176)
		self:timer("walk_6", 13000, true)
	elseif timer == "walk_6" then
		self:timer("walk_7", 2000, true)
	elseif timer == "walk_7" then
		self:say("Well here we go, and good luck to all of us.")
		self:timer("walk_8", 2000, true)
	elseif timer == "walk_8" then
		spawn(32012, self, 2)		
		self:timer("walk_9", 2000, true)
	elseif timer == "walk_9" then
		spawn(32012, self, 2)	
		self:timer("walk_10", 2000, true)
	elseif timer == "walk_10" then
		spawn(32012, self, 4)	
		self:timer("walk_11", 4000, true)
	elseif timer == "walk_11" then
		zonetext("The warm light cast by the Gruploks' lantern soothes all friends of the Murk!", 14)
		self:cast(2543)
		self:timer("walk_final", 2000, true)
	elseif timer == "walk_final" then
		self:say("Well now if that isn't the prettiest thing I've ever seen. Now where did you go? The young one that did this nice thing for me.")
		lighting_big_lamp = false
    end
end