-- Gaito, Sihala's Chosen
-- earth mini game, win to earn a free cast of both Nejax Striking and Rending Curse!

startx = 1858.5
starty = 240.2
startz = 318
starth = 112.8

function EVENT_SPAWN(self)
	self:runTo(startx, starty, startz)
end