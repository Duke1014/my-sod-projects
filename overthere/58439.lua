--[[
Name:
    Askala, Wild One
    
Quest
    Part 4 of Dragon Forgers: "Ikild: Dragonforgers"
    Quest Flag 35200 is main dragonforgers quest flag (6 to 7)

Items:
    46749   wasteland berries           (forage)
    46750   wasteland grizzly flank     (wasteland grizzy drop)
    46751   razor-beak egg              (ground spawm)

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

function EVENT_SPAWN(self)
	self:setWeapon(46748,7)
end

function EVENT_SAY(self,other,message)
    local df_fact = other:GetCon(642)
    local df_quest = other:GetFlag(35200) --5+ means entrance quest done

    if df_quest == 6 then
        if string.find(message,"Hail") then
            self:say("Good day to you.")
            dialog(other,self,"I have been sent to help.")
        elseif string.find(message,"I have been sent to help") then
            self:say("A recruit? Seems we do have some new help. Very well. The tasks of the fields are simple, but we cannot live without them. As the foundations of the order are the sacrifices of the unseen, you must prove your loyalty in service. First, forage 20 brushberries from the fields. Second, hunt the wasteland grizzly for 20 flanks of their meat. And finally, gather 20 eggs of the razor-beak.")
            dialog(other,self,"I will return when I have completed this task.")
            dialog(other,self,"What if I am not skilled in foraging?")
            dialog(other,self,"Where can I find razor-beak eggs?")
        elseif string.find(message,"I will return when I have completed this task") then
            self:say("Do not waste your time. You will deliver these to our dock in the north for inspection. The inspection comes at a price of ikildian marks.")
            other:journal("Ikild: Dragonforgers", 7, "I, or someone who can, must forage 20 brushberries; hunt grizzly for 20 flanks of meat; and gather 20 razor-beak eggs. I am to deliver these for inspection at the dock in overthere.")
            other:setFlag(35200,7)
        elseif string.find(message,"not skilled in foraging") then
            self:say("Then you must find one of the fold who will aid you in this task. Together we rise or fall. Remember this.")
        elseif string.find(message,"Where can I find razor") then
            self:say("They lay amongst the shurbs of the field in eastern Overthere. Hard to see to the untrained eye.")
        end
    elseif df_quest == 7 then
        if string.find(message,"Hail") then
            self:say("Your task is to forage 20 brushberries; hunt grizzly for 20 flanks of meat; and gather 20 razor-beak eggs. When you have gathered these, deliver these to our dock in the north for inspection.")
        end
    end
end
