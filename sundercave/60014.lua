-- Ignia, Tarhyl's Chosen
-- fire mini game, win to get a buff!

startx = 1815
starty = 185.2
startz = 316
starth = 69.1

function EVENT_SIGNAL(self, words, data)
	if words == "firephase" then
		self:runTo(1923.2, 139, 325, 87.2)
		self:timer("attack",1000)
	end
	if words == "kaboom" then
		self:depop(true)
		signal(60013, "firefail")
		self:stopTimer("attack")
	end
	if words == "firewin" then
		self:runTo(startx, starty, startz, starth)
		self:stopTimer("attack")
	end
end

function EVENT_TIMER(self, words)
	if words == "attack" then
		self:doAnim(5)
	end
end

function EVENT_SPAWN(self)
	self:runTo(startx, starty, startz)
end