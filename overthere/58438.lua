--[[
Name:
    a dragonforged huntress
    
Quest

Notes:
    Dragon Forgers (NPC:687 / FAC:642)
    1 - ally			3101 to 3500	1
    2 - warmly			2701 to 3100	2
    3 - kindly			2401 to 2700	3
    4 - amiably			2101 to 2400	4
    5 - indifferent		2000 to 2100	5
    6 - apprehensive	1900 to 1999	6
    7 - dubious			1301 to 1899	7
    8 - threateningly	1001 to 1299	8
    9 - scowls		   -5000 to 1000	9

]]

function EVENT_SPAWN(self)
	self:setWeapon(46748,7)
end
