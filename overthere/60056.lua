-- the oracle - imprisoned (location 341, -253, -521)
-- wisp: 60057
-- undead: 60058
-- Hierophant: 60105

-- TODO: untrackable, 60105 timers, spawn 60058 zombies to attack player
local player
local playerName

function EVENT_SPAWN(self) -- spawns undead around her
	depop(60058)
	spawn(60058, 253, 92, -518, 225)
	spawn(60058, 233, 73,  -518, 225)
end

function EVENT_SAY(self, other, msg)
	if string.find(msg, "Hail") and other:GetFlag(42507) == 2 then
		self:say("I'm sorry, "..other:GetName()..". I tried telling her not to come for me, it was a trap...")
		player = other
		playerName = other:GetName()
		self:timer("talky-1", 4000, true)
	end	
end

function EVENT_TIMER(self, timer)
	if timer == "talky-1" then
		player:text("A large, foreboding presence enters the room...")
		spawn(60105, 388, -100, -518, 128)
		self:timer("talky-2", 4000, true)
		
	elseif timer == "talky-2" then
		player:text("Kaezakha says, 'As expected, the great "..playerName.." has come to save the poor Oracle... what a fool you are.'")
		self:timer("talky-3", 6000, true)
		
	elseif timer == "talky-3" then
		player:text("Kaezakha says, 'Unfortunate timing, meeting you here. You'd make a great servant! It was nice to meet you, however I must be brief and take our friend away.'")
		self:timer("talky-4", 6000, true)
		
	elseif timer == "talky-4" then
		player:text("Kaezakha says, 'Farewell, weakling, begone from my lands. Kaezul will not have the disgrace of seeing you!'")
		self:timer("talky-5", 6000, true)
		
	elseif timer == "talky-5" then
		player:text("Kaezakha says, 'Come, Oracle! I have unfinished business with you before Kaezul throws you away.'")
		player:text("Kaezakha begins to cast a spell.")
		self:timer("talky-6", 7000, true)
		
	elseif timer == "talky-6" then
		player:text("A voice peers into your mind, '"..playerName.."! Don't worry about me, we will see each other again, but first you must escape here and get back to Rorlna!'")
		player:text("Kaezakha and the Oracle fade away as a rustling is heard from the other room.")
		player:teleport(243, 83, -518)
		player:setFlag(42507, 100)
		player:setFlag(42503, 20)
		player:journal("The Hierophant's Apprentice", 6, "ah shit dude")
		signal(60058, "activate")
		self:depop()
	end
end