--[[
Name:
    Master of Inventories
    
Quest
    Part 5 of Dragon Forgers: "Ikild: Dragonforgers"
    Quest Flag 35200 is main dragonforgers quest flag (7 to 8)

Items:
    46749   wasteland berries           (forage)
    46750   wasteland grizzly flank     (wasteland grizzy drop)
    46751   razor-beak egg              (ground spawm)

    46753   An Inspected Supply Crate   (quest)

Notes:
    Dragon Forgers (NPC:687 / FAC:642)
    1 - ally			3101 to 3500	1
    2 - warmly			2701 to 3100	2
    3 - kindly			2401 to 2700	3
    4 - amiably			2101 to 2400	4
    5 - indifferent		2000 to 2100	5
    6 - apprehensive	1900 to 1999	6
    7 - dubious			1301 to 1899	7
    8 - threateningly	1001 to 1299	8
    9 - scowls		   -5000 to 1000	9

]]

function EVENT_SAY(self,other,message)
    local df_fact = other:GetCon(642)
    local df_quest = other:GetFlag(35200)

    if df_quest >= 7 then
        if string.find(message,"Hail") then
            self:say("Ahy. Speak your supplication.")
            dialog(other,self,"I have goods to be inspected.")
        elseif string.find(message,"goods to be inspected") then
            self:say("Is that so. The fee for these services you must provide. 5 marks included with the inspected items.")
            dialog(other,self,"What marks?")
            dialog(other,self,"I suppose that is fair.")
            dialog(other,self,"I do not have that many.")

        elseif string.find(message,"I suppose that is fair") then
            self:text(self:GetName().." looks at you expectantly.",_G.chat.emote)

        elseif string.find(message,"What marks") then
            self:say("Hah. You stack it high close to home. 5 Ikildian Marks. Payment for service. ")

        elseif string.find(message,"I do not have that many") then
            self:say("Well. Best head out for I charge you to work! A repay of time.")
        end
    elseif df_quest == 8 then
        if string.find(message,"Hail") then
            self:say("Your task is to forage 20 brushberries; hunt grizzly for 20 flanks of meat; and gather 20 razor-beak eggs. When you have gathered these, deliver these to our dock in the north for inspection.")
        end
    end
end


function EVENT_ITEM(self, other, items_table, coinage)
    local waste_berry = items(46749)    --wasteland berries
    local grizz_flank = items(46750)    --wasteland grizzly flank
    local razor_egg = items(46751)      --razor-beak egg
    local ikild_marks = items(46752)    --Ikildian Mark

    if waste_berry >= 20 and grizz_flank >= 20 and razor_egg >= 20 and ikild_marks >= 5 then
        items(46749,20)
        items(46750,20)
        items(46751,20)
        items(46752,5)
        local df_fact = other:GetCon(642)
        if df_fact == 7 then
            other:giveItem(46753,1) --An Inspected Supply Crate
            other:giveFaction(642,30) --Repeatable (1301 to 1899) About 10 turnins
            self:say("Looks good to me. Pays well all's well. Quartermaster will want. See to em.")
            self:text("Your faction with the Dragonforged has increased slightly",14, true)
        end
    
        local df_quest = other:GetFlag(35200)
        if df_quest == 7 then
            other:journal("Ikild: Dragonforgers", 8, "The supplies I gathered for Askala have been inspected. I am to return them to the Dragonforged Quartermaster.")
            other:setFlag(35200,8)
        end
    else
        self:say("Missing something. Not quite all there...")
    end
end