-- Nalansar, Agent of Chaos. 60013
-- final boss to the quest Secrets of the Four
-- includes the 4 chosen, 60014(fire), 60015(water), 60016(air), 60017(earth)
-- each of the 4 have a mini-game associated with them:
-- 90% fire: DPS an add as hard as possible within a certain amount of time, fail = an added AoE from Nalansar, win = nalansar HP goes down a certain %
-- 70% water: heal the chosen, dont let it drop below 20% for 30 seconds (2-3 healers should be able to accomplish this alone, but it is meant to be that anyone with a heal assist), fail = raid slowed for 30s, win = extra mana.
-- 50% air: control, adds will slowly make their way to corrupt the chosen, they can be snared, rooted, mez'd, killed? too many hitting the chosen results in a fail. fail = enrage at the end, win = Nalansar is 'stunned' for 15 seconds
-- 30% earth: move to different sides of the room from earthquakes. if anyone dies during this, it results in a fail. fail = rampage/enrage added to Nalansar, win = Rending + Striking Curse on Nalansar (casted by the chosen)
-- 10% end of fight, The quester will seal Nalansar inside the gem created from the runes. "Gift of the Chosen" appears as a chest full of loot, the quester recieves The Chaos Orb, with unique properties to each class/class-set

local npcs = GetNPCList()

function EVENT_SPAWN(self)

	_G.nalansar = self

	earth_phase = false
	HP = self:GetStats("hp")

	ignia = 60014
	diplo = 60015
	alura = 60016
	gaito = 60017

	portalx = 1936.7
	portaly = 132.5
	portalz = 322
	portalh = 237.2

	self:setAppearance(622)
	self:setWeapon(60007, 7)
	self:setWeapon(60007, 8)
	self:hpTrigger(90)
	
end

function EVENT_HP(self, other, damage, hp)

	if hp == 90 then -- fire
	
		self:hpTrigger(70)
		spawn(60018, portalx, portaly, portalz, portalh)
		signal(60014, "firephase")
		self:text("Nalansar shouts, 'I will TEAR your souls apart!'", 13, 500)
		other:text("Tarhyl's Chosen shouts, 'HEROES, HELP ME DESTROY THIS ATROCITY. BURN IT DOWN WITH ALL YOUR MIGHT, QUICKLY!'", 258, 500)
		debugtext("Begin Fire Phase: 60018 spawned.")
		
	end
	
	if hp == 70 then -- water
	
		self:hpTrigger(50)
		signal(60015, "waterphase")
		self:text("Nalansar shouts, 'I will sap your essence, feeble Diplo, and crush this land in a tidal wave!'", 13, 500)
		self:text("Shojar's Chosen says, 'Heroes, the demon is draining my energy! HEAL me if you can!'", 18, 500)
		debugtext("Begin Water Phase: 60015 nuking self.")
		
	end
	
	if hp == 50 then -- air
	
		self:hpTrigger(30)
		signal(60016, "airphase")
		self:text("Nalansar shouts, 'After I'm through with this pitiful gust of wind, I'll suffocate you ALL down here!' He begins to cast a dark spell on Alura.", 13, 500)
		self:text("Shiritri's Chosen says, 'Heroes, don't let these creatures get near me! ", 326, 500)
		self:timer("airadd", 6000)
		debugtext("Begin Air Phase: spawning multiple 60019")
		
	end
	
	if hp == 30 then -- earth
	
		self:hpTrigger(10)
		self:text("Nalansar shouts, 'Enough, I will crumble this cavern and take you with it!'", 13, 500)
		self:text("Sihala's Chosen says, 'Heroes, stay SAFE inside my GROVES! Do NOT let him harm you!", 315, 500)
		self:timer("earthquake", 6000)
		self:timer("earthphasecheck", 42000, true)
		earth_phase = true
		debugtext("Begin Earth Phase: AoE's inc.")
		
	end
	
	if hp == 10 then -- win?
	
		self:say("ENOUGH!")
		self:suspendMelee()
		self:stopAllTimers()
		self:invul(true)
		self:timer("loserspeech", 5000, true)
		debugtext("Event win!")
		
	end
	
end

function EVENT_SIGNAL(self, words, data)

	if words == "firefail" then
	
		self:text("Nalansar shouts, 'Imbeciles. Not even the chosen of the Gods can stop me, what chance do you have?'", 13, 500)
		self:text("You have failed Tarhyl's Chosen. Nalansar gains a fire spell!", 8, 500)
		self:timer("failnuke", 13000)
		depop(60014, true)
		debugtext("Fire Phase Failed. Fire-based AoE inc.")
		
	end
	
	if words == "firewin" then
	
		self:text("Nalansar shouts, 'AGH! No matter, I'll finish you myself.'", 13, 500)
		self:text("You successfully defeated the Shade of Chaos. Nalansar takes a hefty blow!", 8, 500)
		self:damage(self, 400000, 100, 65535, true, true)
		debugtext("Fire Phase Win! Nalansar nuked.")
		
	end
	
	if words == "waterfail" then
	
		self:text("Nalansar shouts, 'Imbeciles. Not even the chosen of the Gods can stop me, what chance do you have?'", 13, 500)
		self:text("You have failed Shojar's Chosen. Nalansar pulses a crippling slow!", 8, 500)
		hl = self:GetHateList()
		debugtext("Water Phase Failed. Raid has been debuffed.")
		
		for k,v in pairs(hl) do
			if v:InZone() then
				self:customNuke(v,"Cripple",0,0,0,"You have been crippled!",1589,1589)
			
			end
			
		end	
		
	end
	
	if words == "waterwin" then
	
		self:text("Nalansar shouts, 'Weakling, using the aid of the mortals. You'll soon be next...", 13, 500)
		self:text("You successfully healed Shojar's Chosen! Your mana is restored!", 8, 500)
		hl = self:GetHateList()
		debugtext("Water Phase Win! Mana for all!")
		
		for k,v in pairs(hl) do
			if v:InZone() then
				self:customNuke(v,"Release Mana",0,0,0,"Mana pours into you!",2753,2753)

			end
			
		end
		
	end
	
	if words == "airwin" then
	
		self:say("Fools! Don't think for one second that-")
		self:text("Alura takes the breath out of Nalansar! He is stunned for 15 seconds.", 8 ,500)
		self:suspendMelee()
		depop(60019)
		self:stopTimer("airadd")
		self:timer("stun", 15000, true)
		debugtext("Air Phase Win! Nalansar stunned.")
		
	end
	
	if words == "airfail" then
	
		self:text("Nalansar shouts, 'Imbeciles. Not even the chosen of the Gods can stop me, what chance do you have?'", 13, 500)
		self:text("You have failed Shiritri's Chosen. Nalansar prepares a deadly surprise...", 8, 500)
		self:set("SpecialAttks", 2, 1) -- enrage at the end
		self:stopTimer("airadd")
		depop(60019)
		debugtext("Air Phase Failed. Enrage activated for sub-20%")
	
	end
	
	if words == "earthfail" then
	
		self:say("Hmph, weakling. You cannot even save the dirt you walk on, slave of Sihala. Begone.", 13, 500)
		self:text("You have failed Sihala's Chosen. Nalansar goes on a rampage!", 8, 500)
		self:set("SpecialAttks", 3, 1) -- rampage
		depop(60017, true)
		self:stopTimer("earthquake")
		self:stopTimer("earthphasecheck")
		earth_phase = false
		debugtext("Earth Phase Failed. Rampage enabled.")
		
	end
	
end

function EVENT_TIMER(self, words)

	if words == "failnuke" then
	
		hl = self:GetHateList()
		
		for k,v in pairs(hl) do
			if v:InZone() then
				self:customNuke(v, "Chaotic Firestorm", "Nalansar uses the power of the chosen to rain fire upon you.", 2200, 2, -700)
			end
		end
		
	end
	
	if words == "airadd" then
	
		spawn(60019, portalx, portaly, portalz)
		
	end	
	
	if words == "stun" then
	
		self:suspendMelee(false)
		
	end
	
	if words == "earthquake" then
	
		z = 325
		grove = math.random(1,8)		 	-- flowers spawn that do a frontal nuke
		if grove == 1 then		 			-- near the portal
			spawn(60020, 1939.6, 145, z, 92)
			spawn(60020, 1934.3, 157, z, 3.2)
			spawn(60020, 1924,9, 147.4, z, 177.6)
		elseif grove == 2 then 				-- the rock on the side of the peninsula
			spawn(60020, 1900.5, 170.3, z, 91.1)
			spawn(60020, 1890.5, 187.8, z, 6.8)
			spawn(60020, 1880.3, 172.5, z, 177.2)
		elseif grove == 3 then 				-- base of the peninsula
			spawn(60020, 1865.8, 198, z, 52.8)
			spawn(60020, 1849.2, 197.5, z, 219)
			spawn(60020, 1856.3, 185.3, z, 133.5)
		elseif grove == 4 then 				-- southern-most
			spawn(60020, 1773.6, 166.7, z, 193.1)
			spawn(60020, 1784, 158.1, z, 113)
			spawn(60020, 1788.4, 170.5, z, 28.2)
		elseif grove == 5 then 				-- between fire/water
			spawn(60020, 1815.1, 200.1, z, 102.6)
			spawn(60020, 1809.8, 218.4, z, 8.4)
			spawn(60020, 1798.9, 206.8, z, 181.4)
		elseif grove == 6 then 				-- next to the boulder
			spawn(60020, 1796.7, 240.9, z, 180.8)
			spawn(60020, 1807.1, 234.1, z, 111)
			spawn(60020, 1803.8, 250.9, z, 254.6)
		elseif grove == 7 then				-- next to earth
			spawn(60020, 1831.1, 273.2, z, 238.1)
			spawn(60020, 1837.5, 259.2, z, 141.9)
			spawn(60020, 1846.8, 271.6, z, 46.6)
		else 								-- northern-most
			spawn(60020, 1900.6, 277.5, z, 60.2)
			spawn(60020, 1890.6, 284.7, z, 242.1)
			spawn(60020, 1888.3, 269.8, z, 151.6)
		end		
		
	end
	
	if words == "earthphasecheck" then
	
		self:text("Nalansar shouts, 'WHY WONT YOU DIE?!'", 13, 500)
		self:text("You survived the earth barrage! Nalansar looks weaker!")		
		self:set("resists", "10 10 10 10 10")
		self:stopTimer("earthquake")
		earth_phase = false
		
	end
	
	-- The fight is won, Nalansar makes a losing speech and escapes
	
	if words == "loserspeech" then
		self:say("I have what I came for, none of you can take the power I've absorbed so far.' Nalansar gestures towards the portal.")
		self:timer("loserspeech2", 6000, true)
	end
	
	if words == "loserspeech2" then
		self:say("It's only inevitable that the portal collapses the mountain onto itself.")
		self:timer("loserspeech3", 6000, true)
	end
	
	if words == "loserspeech3" then
		self:say("Oh, and don't forget. These chosen weren't sent here to help you. They were sent to keep the Soul Pool from all of us. Don't you think the Four should share the power they contain with others? Don't you think they have TOO much power?!")
		self:timer("loserspeech4", 6000, true)
	end
	
	if words == "loserspeech4" then
		self:say("Farewell, adventurers. IF we were to meet again, don't expect a pleasant welcome. Dalaya WILL fall to darkness.")
		self:timer("loserspeech5", 6000, true)
	end
	
	if words == "loserspeech5" then
		self:text("Nalansar disappears in a cloud of darkness.")
		self:SendAppearanceEffect(289)
		self:doAnim(2)
		signal(60004, "end")
		depop(60059) -- begin respawn timer
		self:depop()
	end
	
end

function EVENT_SLAY(self, other, damage, spell)

	if other and other:IsClient() then
	
		if earth_phase == true then
		
			self:say("Hmph, weakling. You cannot even save the dirt you walk on, slave of Sihala. Begone.", 500)
			self:text("You have failed Sihala's Chosen. Nalansar goes on a rampage!", 8, 500)
			self:set("SpecialAttks", 3, 1) -- rampage
			depop(60017, true)
			self:stopTimer("earthquake")
			self:stopTimer("earthphasecheck")
			earth_phase = false
			npc_list = GetNPCList()
            for k, v in pairs(npc_list) do
                npc_id = v:GetNPCID()
                if npc_id == 60020 then
					signal(60020, "failed")
				end
			end
		end
		
	end
	
end

function EVENT_COMBATEND(self)

	--respawn(81404) --doesnt exist
	--respawn(81327) --60004
	self:depop()
	depop(60012)
	depop(60014)
	depop(60015)
	depop(60016)
	depop(60017)
	depop(60018)
	depop(60019)
	depop(60020)	
	self:stopAllTimers()
	spawn(60010, 1923, 154, 317, 108)
end

function EVENT_INSIGHT(self, other)

	zonetext("FIRE: Kill the shade of chaos.", 258)
	zonetext("--- Win: Nalansar gets nuked.", 258)
	zonetext("--- Fail: Nalansar gains a fire nuke.", 258)
	zonetext("WATER: Heal the Chosen.", 18)
	zonetext("--- Win: Raid is rewarded mana.", 18)
	zonetext("--- Fail: Nalansar slows the raid.", 18)
	zonetext("AIR: Stop spectres from reaching the Chosen.", 326)
	zonetext("--- Win: Nalansar is stunned.", 326)
	zonetext("--- Fail: Nalansar enrages at 20%.", 326)
	zonetext("EARTH: Survive.", 315)
	zonetext("--- Win: Nalansar is weaker to magic.", 315)
	zonetext("--- Fail: Nalansar rampages.", 315)
	
end