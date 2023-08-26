--60012, portal, chest mob

function EVENT_SPAWN(self)

	self:setAppearance(426, 2)
	self:invul(true)
	self:suspendMelee()
	
end

function EVENT_CONSIDER(self,other)

	other:text("The portal is surrounded by dark tendrils, Nalansar is corrupting the Soul Pool! Be careful of what may come out of it...", 13, true)
	
end

function EVENT_ATTACK(self, other)

	if self:IsInvul() == true then
		self:wipeHate()
	end
end

function EVENT_ITEM(self, other, items)
    if other:GetFlag(42500) == 6 then
        if items(60016) > 0 then
            special_npcs_up = 0
            npc_list = GetNPCList()
            for k, v in pairs(npc_list) do
                npc_id = v:GetNPCID()
                if npc_id == 60014 or
                   npc_id == 60015 or
                   npc_id == 60016 or
                   npc_id == 60017 then
                    special_npcs_up = special_npcs_up + 1
                end
            end
            if special_npcs_up == 4 then
                self:addLoot(60007) -- Apocalypse, true ending loot
            end

            other:setFlag(42500, 7)
            self:text("The stone takes in the radiation of the portal, the energy from it calms.")
            other:say("Friends, break down this portal while it's not active!")
            self:set("maxhp", 10000)
            self:invul(false)
            other:journal("Secrets of the Four", 5, "The black stone found after putting the tablets in the indent was able to absorb the radiation power coming from the portal, thus minimizing any damage in the caverns, and to Sundered Mountains. Now to figure out what to do with this stone.")
        end      
    end
end