-- MASON KUSENET, 100 FACTION TOTAL

function EVENT_SAY(self, other, msg)

    local hail = string.match(string.lower(msg), "hail")
    local tidy_quest = other:GetFlag(14000)

    self:face(other)

    if other:GetFlag(3000) == 7 then
        if tidy_quest == 0 or tidy_quest == 10 then
            if hail then
                self:text(self:GetName().." Looks up in surprise.  She is a stout, hardy Gruplok and she seems to buzz with excitement.")
                self:say("Ah, finally "..other:GetName().." comes to see me!  Truly this is a fortunate occurrence.")
                other:setFlag(14000, 10)
                dialog(other, self, "Fortunate? Why?")
            elseif string.match(string.lower(msg), "fortunate") then
                self:say("Yes, quite!  Things have picked up around here quite a bit.  In fact, I'd say these are the best days our village has seen in a decade!  All thanks to you and your lot, of course.  Anyway, now that we aren't all busy bemoaning our lot in life, there is some work to be done and I see no reason not to ask you for your help personally!")
                dialog(other, self, "What did you have in mind?")

            elseif string.match(string.lower(msg), "what did you have") then
                self:say("Well just look at the place!  Gone straight south if you'll pardon the expression!  The walkways are rotting, the dwellings are decrepit.  Even our one source of architectural pride is breaking down.  The windmill!  Oh, we've all seen better days, but that poor device now lurches along like a... like a crippled leech! Ho!")
                dialog(other, self, "How can I help?")

            elseif string.match(string.lower(msg), "how can i help") then
                self:say("Glad you asked, glad you asked.  These floors have got to be fixed first thing!  With the Kaezulians still out in force, we still can't find any volunteers to play lumberjack.  Ha!  But I'm sure you'd do just fine!  Head to the southwest area of the swamp.  You'll know the trees when you see them: good, sturdy fellows.. and tall!  Four loads of the wood should suffice for now--at least to show we mean business!")
                other:journal("Tidying Up the Place", 10, "Mason Kusenet has asked me to bring her four loads of strong and sturdy lumber from the trees in the southwest of the swamp in order to repair the walkways of the Gruplok village.")
                other:setFlag(14000, 11)
            end

        elseif tidy_quest == 11 then
            if hail then
                self:say("Any luck with that lumber, friend?  No time to lose!")
            end

        elseif tidy_quest == 12 then
            if hail then
                self:say("Time for you to jump on my next task!")
                dialog(other, self, "Next task?  What next task?")

            elseif string.match(string.lower(msg), "next task") then
                self:say("You see these colorful buildings?  Used to be a point of pride to keep them functional and safe.  But with the lizards breathing down our backs, that stopped being important pretty quickly.  But now...")
                dialog(other, self, "Go on.")

            elseif string.match(string.lower(msg), "go on") then
                self:say("Well take a good look at them sometime!  Cracks all over the walls anyone can see, of course, but worse are the cracks down below in the support pillars.  We've been lucky so far, but those struts need repair in the worst way!")
                dialog(other, self, "How are we going to accomplish that?")

            elseif string.match(string.lower(msg), "how are we going to") then
                self:say("Ha!  Great to see you getting in to the spirit of things!  Working as a team benefits all members, I've always said.  Well, now the only thing we need to fix these walls is the only thing we can't get: stones from over in Old Ikild. Sure we used to send quarry crews over there all the time, but the wildlife--and uh, well and something else--have made that impossible for quite some time.  Good thing you're here now!")
                dialog(other, self, "Something worse than the wildlife?  I don't think-")

            elseif string.match(string.lower(msg), "something worse than the wildlife") then
                self:say("Hah! Ha, but don't you worry about that.  Just get yourself over to Old Ikild and look around the great aqueducts they have over there.  Stones strewn all around and easy to find!  Just grab four of them and bring them on back.. and if you hear a sort of thumping sound, run!")
                dialog(other, self, "That sounds like it might be dangerous I-")

            elseif string.match(string.lower(msg), "that sounds like it might be") then
                self:say("Well, then it's settled.  You should probably start out as soon as possible!")
                other:setFlag(14000, 13)
                other:journal("Tidying Up the Place", 20, "Mason Kusenet has asked me to retrieve four stones from the aqueduct area in Old Ikild.  She said they would be easy to find, but to keep my eyes and ears open for something dangerous...")
            end

        elseif tidy_quest == 13 then
            if hail then
                self:say("You found those stones for me yet?  Don't be scared, you've got nothing to worry about! Just look around the aqueducts by Old Ikild.")
            end

        elseif tidy_quest == 14 then
            if hail then
                self:say("What we need now is materials for that windmill!")
                dialog(other, self, "The windmill?")

            elseif string.match(string.lower(msg), "the windmill") then
                self:say("Of course, you've seen it.. grinding along threatening to collapse at any moment.  Hah!  Bet you can hear it from some distance off with all that racket!  Well some of your stones will help for the mechanical side of things, but the blades is more my department.")
                dialog(other, self, "What do we need in order to fix the blades?")

            elseif string.match(string.lower(msg), "what do we need in order") then
                self:say("It'll sound strange to you, I'm sure, but leaves!  Giant leaves, probably bigger than yourself.  Swamp plants just don't hold up--learned that the hard way years back.  No, you'll need to head off to the east where things get leafier.  Haven't been able to get a Gruplok through the cave since before I was born, probably.  Hah!  Good luck to you out there, friend!")
                dialog(other, self, "Giant leaves?  A cave?  What?")

            elseif string.match(string.lower(msg), "giant leaves") then
                self:say("Yep!  As big as you if not bigger!  Four is enough!  I'll be here waiting on you!")
                other:setFlag(14000, 15)
                other:journal("Tidying Up the Place", 30, "Mason Kusenet wants me to head through the cave east of Gruplok city and retrieve four giant leaves.  I have met few entities this persuasive...")
            end

        elseif tidy_quest == 15 then
            if hail then
                self:say("C'mon, friend!  If you handled the Jungle, you can handle this just fine!")
            end

        elseif tidy_quest == 16 then
            if hail then
                self:say("Sorry, friend. Nothing I need help with just yet!")
            end
        end

    else
		self:text(self:GetName().." appears to be completely uninterested.")
    end
end

function EVENT_ITEM(self, other, item, coin)
	if other:GetFlag(14000) == 11 and item(41005) == 4 then
		other:giveFaction(600, 20)
		item:keep(41005, 4)
		other:setFlag(14000, 12)
		other:giveExp(15000, 0)
		other:journal("Tidying Up the Place", 15, "I've retrieved the lumber for Mason Kusenet. She's very happy, but it seems she isn't finished with me yet...")
		self:say("Fantastic.. just exactly perfect!  You've exceeded any expectation I might have had and thank you for it!  This will be put to use right away, don't you worry about that.  That means you can jump right on to the next task!")
		dialog(other, self, "Next task?  What next task?")
    end

	if other:GetFlag(14000) == 13 and item(41006) == 4 then
		other:giveFaction(600,20)
		item:keep(41006, 4)
		other:setFlag(14000, 14)
		other:giveExp(25000,0)
		other:journal("Tidying Up the Place", 25, "I managed to find give Mason Kusenet enough stones for her to start rebuilding the Gruplok buildings.. but, again, it seems she has even more work for me.")
		self:say("Hah!  See, what did I tell you?  Nothing to be afraid of out there in the jungle!  This stone will provide nicely for several of these homes.  With the crowds of you folks I've seen around here recently, this place could really start to be something... but enough about the future.  What we need now is materials for that windmill!")
		dialog(other, self, "The windmill?")
    end

	if other:GetFlag(14000) == 15 and item(41007) == 4 then
		other:giveFaction(600, 60)
		item:keep(41007, 4)
		other:setFlag(14000, 16)
		other:giveExp(35000, 0)
		other:journal("Tidying Up the Place", 35, "Retrieving those giant leaves for Mason Kusenet was more trouble than I anticipated.  It seems that, for now at least, she has no more work for me.")
		self:say("Wonderful!  Excellent!  The old fellow will be up and running in no time thanks to you and your friends.  I almost hate to say it, but you work so quickly, I've got to rush to catch up with you!  Hah!  I'll find something more, don't you worry!")
    end
end