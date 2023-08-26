--[[
Archaeologist Azura (Jayla)
NPCID 60004
part of the 4 world bosses quest AND they way into the event
]]--

function EVENT_SPAWN(self)
	self:invul(true)
	tablet = false
	taunt = false
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

function EVENT_TIMER(self, timer_name)

	if timer_name == "tablets" then
		spawn(60009, -304.6, 2422.8, 999, 229.6)

	elseif timer_name == "taunt" then
		self:text("A whisper is heard from the cracks, 'Thank you, fools. You have made my work much easier for me...", 13)
		self:timer("taunt2", 5000, true)

	elseif timer_name == "taunt2" then
		self:say("I think not!")
		self:text("Azura conjures a strong energy that blasts the crack open wider. A large cavern appears underneath. A small, black stone falls from where the tablets sat, and you see Azura take it.", 8)
		self:timer("taunt3", 5000, true)

	elseif timer_name == "taunt3" then
		self:say("...well this got much more interesting.")
		taunt = true
		
	end
end 

function EVENT_SAY(self, other, msg)
	
	if other:GetFlag(42500) >= 5 then
	
		if string.find(msg, "Hail") then
			self:face(other)
			self:say("Would you like to go back down the caverns?")
			dialog(other, self, "Yes, please!")
		
		elseif string.find(msg, "Yes") then
			self:face(other)
			self:say("Very well. Everyone gather around me, I will illuminate the path.")
			raid = other:GetRaidMembers()			
			if raid == nil then
				self:say("Now hold on... where is your raid?!")
				other:text("NOTE: You must be in a raid before entering the caverns.", 15)
			else
				for k, v in pairs(raid) do
					if v:IsAlive() and v:GetDist(self) <= 100 and v:InZone() then
						v:zone("sundercave", 188.0, -157.4, -73.9, 63.9)
					end
				end
				
			raid = nil
			
			end	
			
		end
	
	elseif other:GetFlag(42500) == 4 then
		
		if string.find(msg, "Hail") then
			self:face(other)
			self:say("Are you prepared to venture down the tunnel? Remember, we could use all the help we could get.")
			dialog(other,self, "We are prepared, Azura.")
		
		elseif string.find(msg, "We are prepared") then
			self:say("Very well. Everyone gather around me, I will illuminate the path. Speak with me when we get farther down.")
			raid = other:GetRaidMembers()			
			if raid == nil then
				self:say("Now hold on... where is your raid?!")
				other:text("NOTE: You must be in a raid before entering the caverns.", 15)
			else
				for k, v in pairs(raid) do
					if v:IsAlive() and v:GetDist(self) <= 100 and v:InZone() then
						v:zone("sundercave", 188.0, -157.4, -73.9, 63.9)
					end
				end
			raid = nil
			end
		end
	
	elseif other:GetFlag(42500) == 3 then
		
		if tablet == false and taunt == false then
		
			if string.find(msg, "Hail") then
				self:face(other)
				self:say("I... I don't believe it. you were able to retrieve them! What did you go through for all this?")
				dialog(other,self,"*Explain your adventures finding the tablets*")
		
			elseif string.find(msg, "Explain your adventures") then
				self:face(other)
				other:text("Azura looks at you with disbelief in her eyes.")
				self:say("A set of oversized animals protected the tablets? With that much power... interesting. The Chosen must've imbued them with great power if you and your friends had to go through all that trouble.")
				dialog(other,self,"I think this is the real deal for all the trouble it was. Lets place the tablets in the seal!")
		
			elseif string.find(msg, "place the tablets in the seal") then
				self:timer("tablets", 3000, true)
				self:say("Certainly! This is so exciting, this has been my life's work!")
			end
		
		elseif tablet == true and taunt == false then
			
			if string.find(msg, "Hail") then
				self:text("Just as Azura begins to speak, a dark red mist forms underneath the broken seal of the tablets.", 8)
				self:timer("taunt", 5000, true)
				tablet = false
			end
		
		elseif tablet == false and taunt == true then
		
			if string.find(msg, "Hail") then
				self:text("Azura sees your concern for her outburst and apologizes.", 8)
				self:say("It looks that way. If we're going to find out anything about those tablets, or who or what ever took them, we will have to travel down the tunnel. Are you up for that?")
				dialog(other,self,"It seems that way. Let me prepare myself and a crew of friends to assist.")
				
			elseif string.find(msg, "Let me prepare myself and a crew") then
			
				self:say("So be it. I will attend here until you return. Please make haste as I don't know what may come out of here...")
				other:setFlag(42500, 4)
				other:journal("Secrets of the Four", 4, "Well... we placed the tablets in the seal, but now the seal took the tablets away and Azura blasted a tunnel leading to where they went. I must prepare myself with a raid if I want to continue down this path.")
				taunt = false
				
			end
		
		end
	
	elseif other:GetFlag(42500) == 2 then -- after being told to hunt for tablets
	
		if string.find(msg, "Hail") then
			self:face(other)
			self:say("How goes the tablet hunt?")
		end
	
	elseif other:GetFlag(42500) == 1 then -- after talking to Sarla
		
		if string.find(msg,"Hail") then
		
			self:face(other)
			self:say("Ahh, I was expecting you. You know the story from Sarla, I assume? This is where she was talking about.' Next to Asura is an engraving in the dug-up stone.")
			dialog(other,self,"Good to meet you. What is the situation here?")
		
		elseif string.find(msg, "situation") then
		
			self:face(other)
			self:say("Cutting to the chase, we have here 4 indents in this bit of structure, each with a different insignia.")
			self:text("You see her point at the rocks in front of you.", 19)
			self:say("The odd thing about this is that it looks as if the engraving was only etched years ago, but the shapes are precisely what the tomes say.")
			dialog(other, self, "Well this seems simple, we'll find the missing pieces and put them back in the stone and see what happens!")
		
		elseif string.find(msg, "the missing pieces") then
		
			self:face(other)
			self:say("I suppose so, something just doesn't seem right about all this.")
			dialog(other, self, "If something weird happens, my friends and I will be prepared to help in whatever way.")
		
		elseif string.find(msg, "my friends and I") then
		
			self:face(other)
			self:say("Well, I suppose... If you can find these tablets, I can consider you and your friends strong enough to handle whatever is necessary. Remember, The Chosen put the tablets around the Old World to their choosing. Find the tablets and bring them back here and we'll try to solve this puzzle.")
			other:setFlag(42500, 2)
			other:journal("Secrets of the Four", 2, "I've been tasked to find the tablets that seal a secret lost to time! But where to find them...  Azura mentioned they were placed around nature in the Old World, but what could that mean?")
		
		end
		
	end
	
end

function EVENT_SIGNAL(self, words, data)
	
	if words == "uhoh" then
		self:say("Well... I don't think that was supposed to happen.")
		tablet = true
	end
	
end

function EVENT_ITEM(self, other, items)
	
	if other:GetFlag(42500) == 2 then
		
		if items(44272) > 0 and items(44273) > 0 and items(44274) > 0 and items(44275) > 0 and other:GetFlag(42500) == 2 then
		
			items:keep(44272,1) -- 44272 = Air / stormbringer falcon
			items:keep(44273,1) -- 44273 = Water / coldwater kraken
			items:keep(44274,1) -- 44274 = Earth / spiny mole
			items:keep(44275,1) -- 44275 = Fire / volcanic arachnid
			other:setFlag(42500, 3)
			other:journal("Secrets of the Four", 3, "I delivered the tablets to Azura! Time to see what happens when placing these in the seal.")
			self:face(other)
			self:say("I... I don't believe it. you were able to retrieve them! What did you go through for all this?")
			dialog(other,self,"*Explain your adventures finding the tablets*")
			exp(other, 1000000)
		
		end
	end
	
end