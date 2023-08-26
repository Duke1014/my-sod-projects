-- Alura, Shiritri's Chosen
-- air mini game, win to earn a free 15 second window of no damage!

startx = 1839.8
starty = 224.9
startz = 317
starth = 99.4

function EVENT_SPAWN(self)
	self:runTo(startx, starty, startz)
	self:timer("root", 20000, true)
	self:timer("spectrecheck", 1000)
	self:followArea(10)
	numSpectres = 0
end

function EVENT_AREA(self, other, area)
	if other:IsNPC() then
		if other:GetNPCID() == 60019 then
			self:doAnim(12)
			numSpectres = numSpectres + 1
			self:text("A spectre has reached Alura! ", 13, 500)
		end
	end
end

function EVENT_TIMER(self, words)
	if words == "root" then
		self:set("permarooted", 1)
	elseif words == "airtimer" then
		signal(60013, "airwin")
	elseif words == "spectrecheck" then
		if numSpectres == 1 then
			self:depop(true)
			signal(60013, "airfail")
			self:stopAllTimers()
		end
	end
end

function EVENT_SIGNAL(self, words, data)
	if words == "airphase" then
		self:timer("airtimer", 50000, true)
	end
end