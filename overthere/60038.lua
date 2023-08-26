-- a Kaezakhan sorcerer, Wizard
-- charming this mob grants a ranged pet with proficiency in casting nukes, activating a succor, and sending swarm pets at the target

function EVENT_ATTACKED(self)

	self:text(""..self:GetName().." shouts, 'My life and body for The Hierophant! For Kaezul!'")
	
end