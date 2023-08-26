--[[
Archaeologist Azura (Jayla)
NPCID 60004
INSIDE SUNDERED CAVERNS
]]--

homeX = 305.3
homeY = -157
homeZ = -95.1
homeH = 190.6

function EVENT_SPAWN(self)
	self:set("maxhp", 5000000)
	self:invul(true)
end

function EVENT_ATTACKED(self, other, damage, spell) -- dont hurt the quest mob, duh.
	HL = self:GetHateList()
	other:text("You're really going to attack a scholar of Jayla?")
		for k, v in pairs(HL) do
			self:customNuke(v, 	"YouSuck", "Jayla looks down on you in disappointment. Shame on you...", 100000)
			self:customNuke(v, 	"YouSuck", "Jayla looks down on you in disappointment. Shame on you...", 100000)
			self:customNuke(v, 	"YouSuck", "Jayla looks down on you in disappointment. Shame on you...", 100000)
		end	
end

function EVENT_TIMER(self, words, other)

	if words == "return" then
	
		self:teleport(homeX, homeY, homeZ, homeH)
		nalansardead = false
		dragondead = false
		depop(60014)
		depop(60015)
		depop(60016)
		depop(60017)
		
	end
	
end 

function EVENT_SAY(self, other, msg)
	
	if other:GetFlag(42500) == 4 then
	
		if string.find(msg, "Hail") then
	
			self:say("This is not good. Whatever is in here is strong, and certainly is expecting company. Be wary, "..other:GetName()..". And your friends, too. I will catch up to you shortly.")
			other:setFlag(42500, 5)
			
		end
		
	elseif other:GetFlag(42500) == 5 and dragondead == true then
	
		if string.find(msg, "Hail") then
		
			self:say("This is it, "..other:GetName()..". The demon that took our tablets is just past here. Keep your wits about you, I can feel a strong magic flow over there.")
			other:setFlag(42500, 6)
			dragondead = false
			
		end
		
	elseif other:GetFlag(42500) == 6 and nalansardead == true then
		
		if string.find(msg, "Hail") then
			
			self:say("We need to disable this portal, and quickly. The energy coming from it is too chaotic. Maybe...")
			dialog(other, self, "Maybe...?")
		
		elseif string.find(msg, "Maybe...?") then
		
			self:say("The stone! Here, take the stone, and use it on the portal! This stone has an unusual weight to it, something about it's properties may be able to work. It *did* come from the tablets.")
			other:giveItem(60016)
			nalansardead = false
			
		end
		
	elseif other:GetFlag(42500) == 7 then
		
		if string.find(msg, "Hail") then
		
			self:say("Huh... that worked.")
			dialog(other, self, "The stone also feels strangely warm now. It seemed to absorb some of the portal, I think.")
		
		elseif string.find(msg, "The stone also feels strangely warm") then
		
			self:say("Interesting... I have more business to tend to here, could you report back to Sarla for me? She'd love to know what happened here.")
			other:setFlag(42500, 8)
			other:journal("Secrets of the Four", 8, "Turns out the tablets were taken from us by Nalansar. I disabled his portal with the black stone that was left behind from the tablets, and now I'm off to show Sarla the stone and report back.")	
		
		end
		
	end
	
end

function EVENT_SIGNAL(self, words, data)
	
	if words == "end" then
		
		self:teleport(1936.2, 133, 321, 234.4)
		self:stopTimer("return")
		self:timer("return", 3600000, true)
		nalansardead = true
		self:say("You've done it! You defeated that evil creep! Quickly, I'll need your help with this portal.", 500)
	
	elseif words == "Uthicdead" then
	
		self:teleport(1361.7, 63.1, 259, 147)
		self:stopTimer("return")
		self:timer("return", 3600000, true)
		dragondead = true
		self:say("Friends! Come speak with me, I'm just around the corner.", 500)
		
	end
end