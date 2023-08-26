--[[ a demonic corruptor
charms players on hate list]]--

function EVENT_TIMER(self,words)
	  if words == "charm" then
		self:timer("charm",25000, true)
        local charmtargets = {}
        for k,v in pairs(self:GetHateList()) do
            if v and v:InZone() and not v:IsPet() then
                table.insert(charmtargets,v)
            end
        end
        local targ = charmtargets[math.random(#charmtargets)]
        self:text(targ:GetName() .. " is overcome by corruption.",15,200)
        self:cast(1707,targ,0)
	end
	if words == "nuke" then
		self:timer("nuke",10000, true)
		cl = self:GetHateList()
		for k,v in pairs(cl) do
			--if not v:IsPet() and v ~= self:GetTarget() then
			if not v:IsPet() then
				self:customNuke(v, "nuke", "A magic haze creeps over you.", 2400)
			end
		end
	end
end
	
function EVENT_ATTACK(self,other)
	self:timer("charm",25000, true)	
	self:timer("nuke",10000, true)
end
	
function EVENT_DEATH(self)	
	self:stopAllTimers()
end

function EVENT_COMBATEND(self)
	self:stopAllTimers()
	self:respawn()
end

