-- a sea turtle hatchling
-- if you're on the first part of the lmalath quest you kill 5 of these

function EVENT_DEATH(self, other)
    if other:GetFlag(42523) == 1 then
        local hl = self:GetHateList()
        for i in pairs(hl) do
            if hl[i]:IsClient() and hl[i]:GetFlag(42524) < 5 and hl[i]:GetFlag(42523) == 1 then
                hl[i]:text("You have slain "..(hl[i]:GetFlag(42524) + 1).." hatchlings in the name of Malath!")
                hl[i]:setFlag(42524, hl[i]:GetFlag(42524) + 1)
            end
        end
    end
end