-- my bestest fuckin' friend

function EVENT_SAY(self, other, msg)
	if other:GetAccountStatus() > 50 then
		if string.find(msg, "Hail") then
			self:text("Here's a list of what I can do for ya, friend! Frooooak!")
			dialog(other, self, "Respawn the Child")
			dialog(other, self, "Check my Inventory")
			dialog(other, self, "Test the alien AoE nuke")
			dialog(other, self, "Send me flying!")
			dialog(other, self, "Ammo Test")

		elseif string.find(msg, "Ammo Test") then
			inv = other:GetEquipped()
			for k,v in pairs(inv) do
			if v:GetID() == 41304 then
				self:text("ding ding ding!")
			end
		end
		
		elseif string.find(msg, "Respawn the Child") then		
			self:text("Done! Check for error/debug messages below.", 16)
			respawn(81627)
			depop(60033)
			
		elseif string.find(msg, "Check my Inventory") then
			self:text("Checking inventory for 1. One-thumb Rum:")
			if other:GetPersonalInventory(60058) == true then
				self:text("You have one One-thumb Rum!")
			else
				self:text("Failed to find One-thumb Rum.")
			end
			
		elseif string.find(msg, "Test the alien AoE nuke") then
			self:timer("kaboom", 5000, true)
			self:addHate(other, 1)
			self:set("permarooted", 1)
			
		elseif string.find(msg, "Send me") then
			self:text("What kind of knockback would you like?")
			dialog(other, self, "Knockback")
			dialog(other, self, "NPC Unresistable Knockback")
			dialog(other, self, "Avatar Knockback")
			
		elseif string.find(msg, "Avatar Knockback") then
			self:cast(905, other)
		elseif string.find(msg, "Knockback") then
			self:cast(904, other)
		elseif string.find(msg, "NPC Unresistable Knockback") then
			self:cast(2647, other)
		end
		
	end
	
end

function EVENT_TIMER(self, timer)
	if timer == "kaboom" then
		hl = self:GetHateList() -- set up aggro table
		for k, v in pairs(hl) do
			if v:IsClient() then -- punch all players (not pets)
				distance = self:GetDist(v)
				if distance > 300 or distance == 300 then
					return
				elseif distance < 300 then -- 100 ish = bad. u r ded	
					self:customNuke(v, "Seething Tar", "Tar sears into your flesh.", (20000 - (distance*67)))
				end
			end
		end
	end
end