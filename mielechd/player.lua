--mielechd player.lua

local bitten = true

function EVENT_SPAWN(self)
	--make sure the mielc/mield questline quest npc is not up, and then spawn him if not
	local destloc = {476.1, 382.8, 27.7, 252.5}
	if (self:GetFlag(14824) == 14 or self:GetFlag(14824) == 15) and self:GetDist(destloc) < 20 then 
		local nl = GetNPCList()
		local count = 0
		for k,v in pairs(nl) do
			if v:GetNPCID() == 56818 then
				--count = count + 1
				v:depop()
			end
		end
		if count == 0 then 
			local questnpcloc = {474, 467.6, 11.7, 128.6}
			spawn(56818,questnpcloc)
		end 
	end 
end

function look_for_debuff(self)
	for i, j in pairs(self:GetBuffs()) do
		if j:GetID() == 2320 then
			bitten = true
			return true
		end
	end
	return false
end

function EVENT_SPELL(self, other)
	if look_for_debuff(self) and self:InCombat() and self:GetStats().hpratio == 100 then
		self:text(self:GetName().." regenerates the flesh from the bug bite!")
		bitten = false
		self:removeBuff(2320)
	end
end

function EVENT_FADEBUFF(self, spell_name, spell_id)
	if bitten and spell_id == 2320 then
		signal(32240, "natural_fade", self)
	end
end