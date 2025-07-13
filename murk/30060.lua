-- a slaughtered Gruplok youth

function EVENT_ATTACK(self) 
	self:text("The sound of a child sobbing echoes through the room.")
	-- allowtalk(0)
end

function EVENT_DEATH(self)
    pop_rare(self)
end

function EVENT_ITEM(self, other, item, coin)
	if other:GetFlag(3015) > 4 and other:GetFlag(3015) < 8 and item(20824) > 0 and check_for_dad() == false then
		self:invul(true)
        self:set("playerfriendly", 1)
		self:wipeHate()
		spawn(30100, self, 300)
        self:timer("reset", 300000, true)
    end
end

function EVENT_TIMER(self, timer)
    if timer == "reset" then
        self:respawn()
    end
end

function EVENT_SAY(self, other, msg)
    local hail = string.match(string.lower(msg), "hail")
    local woes_quest = other:GetFlag(3015)

    self:face(other)

    if woes_quest == 3 then
        if hail and other:GetFlag(3015) == 3 then
            if self:InCombat() then
                self:wipeHate()
                self:text(self:GetName().." becomes very calm.")
            end
            self:text(self:GetName().." stares at "..other:GetName()..".")
            dialog(other, self, "...You're Kruala's son, aren't you.")
        elseif string.match(msg, "You re Kruala s son  aren t you") then
            self:text(self:GetName().." quivers.")
            dialog(other, self, "Your mother wanted me to tell you something...")
        elseif string.match(msg, "Your mother wanted me to tell you something") then
            self:text(self:GetName().." hushes and stills.")
            dialog(other, self, "She wants you to leave this world.")
            dialog(other, self, "[EVIL] She wants you to go away forever and never come back so she can stop whining about your worthless existence.")
            dialog(other, self, "[LAWFUL] She wants you to leave this world of the living, to go where the dead belong rather than lingering here beyond your time.")
            dialog(other, self, "[GOOD] She wants you to be free from your torment, free from this world... She loves you, she doesn't want you to keep suffering like this.")
            dialog(other, self, "[CHAOTIC] She wants you to go away and stop weighing on her mind, so she can move on with her life already!")
        
        elseif string.match(msg, "EVIL") then
            other:addAlignment("Evil", 3)
        elseif string.match(msg, "LAWFUL") then
            other:addAlignment("Lawful", 3)
        elseif string.match(msg, "GOOD") then
            other:addAlignment("Good", 3)
        elseif string.match(msg, "CHAOTIC") then
            other:addAlignment("Chaotic", 3)
        end
        if string.match(msg, "She wants you to") then
            self:text(self:GetName().." hands you a small trinket before crumbling into dust.")
            other:giveItem(20823, 1)
            other:setFlag(3015,4)
            other:journal("Woes of a Mother",2,"I have persuaded Kruala's son to leave this world. I should show her the little wooden toy he gave me to Kruala as proof.")
            self:depop(true)
        end
    else
        if hail then
            self:text(self:GetName().." stares at "..other:GetName()..".")
        end
    end
end

function pop_rare(self)
    local chance = math.random() * 100

	if chance > 85 then
		spawn(30032,self, 300)
	
	elseif chance < 86 then
		spawn(30061,self, 300)
    end
end

function check_for_dad()
    local dad = false
    for k, v in pairs(GetNPCList()) do
        if v:GetName() == "*Tortured Dissident Gruklisi" then
            dad = true
        end
    end
    return dad
end