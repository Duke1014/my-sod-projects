-- a calm plot of earth

function EVENT_SPAWN(self)
	self:set("playerfriendly", true)
	self:invul(true)
end

function EVENT_SAY(self, other, msg)
	if string.match(msg, "Hail") then
		other:text("This is an unusually calm little plot of earth.", 6, true)
	    if other:GetFlag(3025) == 5 then
    		dialog(other, self, "-Dig up the plot of earth, the jewel might be buried here-")
        end

    elseif string.match(msg, "the jewel might be buried here") and other:GetFlag(3025) == 5 then
        if check_for_chest() == true then
            self:text("There's nothing here!")
        else
            self:text(other:GetName().." digs around and quickly uncovers a chest!")
            spawn(30062, self, 300)
        end
    end
end

function check_for_chest()
    local chest = false
    for k, v in pairs(GetNPCList()) do
        if v:GetID() == 30062 then
            chest = true
        end
    end
    return chest
end