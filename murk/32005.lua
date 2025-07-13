require'ikild_bounty'

local status = 0;
function EVENT_SPAWN(self)
	self:set("aiclass", 1)
	-- self:set("damage", 6000)
end

function EVENT_SPELL(self, other, name, id)
	if id == 2281 and not active then
		self:set("permarooted", 0)
		self:set("damage", 1200)
		active = true;
		self:addHate(other, 50000)
		self:text("Hrugtah breaks free of his snare and charges after you hungrily!")
		
		self:timer("check", 2000, false, function()
			if self:GetDist(3786, 110, self:GetZ()) < 50 then
			
				if status == 0 then
					self:set("permarooted", 1)
					self:set("aggrorange", 0)
					self:set("playerfriendly", 1)
					self:wipeHate()
				elseif status == 1 then
					self:text(self:GetName() .. " goes into a feeding frenzy on the young snakes!", _G.chat.emote, 300)
					self:doAnim(1)
				elseif status == 2 then
					self:text(self:GetName() .. " continues feeding.. a small object falls from his jaws!", _G.chat.emote, 300)
					self:doAnim(1)
					createGroundSpawn(41013, {3785,110,87}, 1, 60);
				elseif status < 6 then
					self:doAnim(1)
				elseif status == 7 then
					self:text(self:GetName() .. " slows his pace.", _G.chat.emote, 300)
					self:doAnim(1)
				elseif status == 8 then
					self:text("His hunger sated for the moment, Hrugtah returns to his perch.", _G.chat.emote, 300)
					self:respawn()
				end
				
				status = status + 1;
			end
		end)
	end
end

function EVENT_COMBATEND(self)
	if self:GetX() > 2500 and self:GetX() < 2600 then
		self:respawn()
	end
end

function EVENT_DEATH(self)
	ikild_bounty(GetClientList(), self, 5, "This monster's head is too big to put on your pike. Instead, you take his massive snout and attach it to your pike. Should be good enough..")
end