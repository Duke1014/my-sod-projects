-- Boud`Ika					prolly not gonna use this :(
--[[

function EVENT_SPAWN(self)

	self:say("So, where should we go?")
	
end

function EVENT_SAY(self, other, msg)

local mainflag = other:GetFlag(42504)

	if mainflag == 4 then
	
		if string.find(msg, "Hail") then
			self:say("Thanks again for helping me, "..other:GetName()..". Here, this belonged to my daddy. He had to wear this when he went to work. I don't think he really liked it, but it'd look great on you!")
			other:setFlag(42504, 5)
			other:giveItem(60036)
			dialog(other, self, "Thank you, Boud`Ika. This means a lot. Are you going to stick around with me?")
		
		end
		
	elseif mainflag == 5 then
	
		if string.find(msg, "Are you going to stick around with") then
			self:say("Oh, don't worry, friend! My daddy taught me how to be super stealthy, just like him! Don't worry about me, I'll see you later!")
			other:setFlag(42504, 6)
			depop(self)			
		end
	
	end
	
end