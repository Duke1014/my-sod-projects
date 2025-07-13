-- ##GRUPLOK RELIC DEALER Koliang 32092

function EVENT_SAY(self, other, msg)

    local hail = string.match(string.lower(msg), "hail")
	local ancient_quest = other:GetFlag(14026)
    local faction = other:GetCon(600, true) -- 9 - scowling, 1 - ally

	if faction < 6 then
        if hail then
            self:say("Hail and welcome to you, too.")
            if ancient_quest == 100 and (other:GetFlag(14027) == 10 or other:GetFlag(14028) == 10 or other:GetFlag(14029) == 10 or other:GetFlag(14030) == 10 or other:GetFlag(14031) == 10) then
                other:dialog(self, "I was told you might have... items for sale.")
            end

        elseif string.match(string.lower(msg), "i was told you might have") then
	        self:say("I don't know where you heard that, but a Gruplok has to do what will feed her family.")
            other:text("You may now use "..self:GetName().." as a merchant.", 6, true)
        end

    end
end

function EVENT_MERCHANT(self, other)
    local ancient_quest = other:GetFlag(14026)
	if ancient_quest == 100 and (other:GetFlag(14027) == 10 or other:GetFlag(14028) == 10 or other:GetFlag(14029) == 10 or other:GetFlag(14030) == 10 or other:GetFlag(14031) == 10) then
        other:text(self:GetName().." whispers, 'Keep this between us, okay?'", 6, true)
        
    else
        other:text(self:GetName().." ignores you.", 6, true)
        return true
    end
end