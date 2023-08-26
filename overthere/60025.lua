-- an old pirate
-- tells the player how to make quest drinks

function EVENT_SAY(self, other, msg)

	if string.find(msg, "Hail") then
	
		self:say("Oh the dream of seeing the green flash as the sun sets... never thought I'd see this day.")
		dialog(other, self, "Umm... excuse me?")
		
	elseif string.find(msg, "excuse me") then
		
		self:say("What a beautiful sight.")
		self:text("The old pirate takes a swig of his One-thumb Rum.", 8)
		
		if 
		
	end
end