function EVENT_DEATH(self)
    local hl = self:GetHateList()
    for i in pairs(hl) do
        if hl[i]:IsClient() and hl[i]:InZone() then
            if has_gem(hl[i]) and hl[i]:GetFlag(3025) == 12 then
                hl[i]:setFlag(42532, hl[i]:GetFlag(42532) + 1)
                hl[i]:text("Your Tarnished Jewel of the Gruploks glows with power.", 6, true)
                if hl[i]:GetFlag(42532) == 50 then
                    hl[i]:setFlag(3025, 13)
                    hl[i]:text("Your Tarnished Jewel of the Gruploks begins to glow so intensely, it forms itself into something new!", 6, true)
                    hl[i]:takeItem(20845)
                    hl[i]:giveItem(20850)
                end
            end
        end
    end
end

function has_gem(other)
    for k, v in pairs(other:GetInventory()) do
        if v:GetID() == 20845 then
            return true
        end
    end
    return false
end