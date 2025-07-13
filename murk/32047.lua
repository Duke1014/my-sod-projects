-- ##demented grup for grup spells
-- ##comment: this script owns
-- ##flag 14302 quest giver flag
-- ##flag == 0: no glossary, no quest, etc.
-- ##flag == 1: glossary gotten, quest accepted
-- ##flag == 2: sticky clay orb (ground spawn in Murk) turned in
-- ##flag == 3: orb from foremen in BQ turned in
-- ##flag == 4: hailed after above, flags for ebadlands event
-- ##flag == 5: defeated badlands event
-- ##flag == 6: hailed after above, flags for badlands event part 2
-- ##flag == 6-9: doing badlands part 2
-- ##flag == 10: ready for boss mob in badlands 2
-- ##flag == 11: badlands 2 boss defeated
-- ##flag == 12: orb from badlands boss handed in
-- ##flag == 13: hailed after aboved, flagged for unseen in kaesora
-- ##flag == 14: killed unseen in kaesora, has 4th orb
-- ##flag == 15: turned in 4th piece now has four symbols, flagged for penultimate turn-in.aa
-- ##flag == 16: has turned 4 pieces in to the old grup, flagged for final turn in.
-- ##flag == 20: quest complete.

function EVENT_SAY(self, other, msg)
	-- if(other:GetFlag(14302) == 20 and $hasitem(41132) == 0 and $scribedspell(4024) == 0 and $uclass == 11 and string.match(string.lower(msg), "hail" then -- This is for when the Necromancer spell used to be part of the Scent line, and was changed to the AoE DD spell
	-- 	self:text("A scroll appears in your inventory.  The demented gruplok looks at you inscrutably.")
	-- 	other:giveItem(41132,1)
	-- 	self:say("Glurp.")
	-- }

	local hail = string.match(string.lower(msg), "hail")
	local voices_quest = other:GetFlag(14302)
	
	self:face(other)

	if other:GetFlag(3000) == 7 then
		if has_book(other) == true then
			other:text("You struggle to translate the Gruplok's strange speech.", 6, true)
			if voices_quest == 0 then
				if hail then
					self:say("You and.. this vessel controlled, we.. must have them.. no nonsense.. please.")
					dialog(other, self, "Tige grokl hadd?")

				elseif string.match(string.lower(msg), "tige grokl hadd") then
					self:say("Yes.  Who we are.. we are only Control.. we only are Communicate.. are Observe.")
					dialog(other, self, "Glurt hatl tapu get nal.")

				elseif string.match(string.lower(msg), "glurt hatl tapu get nal") then
					self:say("What we want is.. from legend of Gruplok.. the ancient.. deep magic.. deep swamp we search and..  Lost.. all lost.")
					dialog(other, self, "Urqa fahu caen tuyej.")

				elseif string.match(string.lower(msg), "urqa fahu caen tuyej") then
					self:say("You.. volunteer?  Search.. swamp for deep.. evidence of magic.. give to vessel, we... Communicate..")
					other:setFlag(14302, 1)
					other:journal("Voices", 10, "A strange voice projected from a Gruplok instructed you to search for evidence of deep magic within the Murk.")
				end

			elseif voices_quest == 1 then
				if hail then
					self:say("You.. find evidence.. we Observe.. same... in the swamp.. deep..")
				end

			elseif voices_quest == 2 then
				if hail then
					self:say("Deep... in the ground.. buried.. hundreds of years.. taken by a thief..")
				end

			elseif voices_quest == 3 then
				if hail then
					self:say("Glurrp... error!  This power is.. corrupt... too.. Hel`Xup..")
					dialog(other, self, "Klur?")

				elseif string.match(string.lower(msg), "klur") then
					self:say("Hel`Xup!  Fraploth!.... confounding.. something terrible.. a long distance away... a wide open plain.. where the sun rises.. atop a hill.. destroy it before.. Hel`Xup..")
					other:journal("Voices", 30, "The voice asked you to destroy something terrible far, far away...")
					other:setFlag(14302, 4)
				end

			elseif voices_quest == 4 then
				if hail then
					self:say("Where the sun.. rise.. you destroy the.. atop a hill... the terrible.. Hel`Xup..")
				end

			elseif voices_quest == 5 then
				if hail then
					self:say("We felt.. the error repaired.. the item before.. silver... has this become...")
					other:giveItem(41033, 1)
					self:say("The Hel`Xup.. within you.. not a good.. but.. reveal.. return to the Hel`Xup.. there is one.. hidden within others..  you have eyes.. to see now..")
					other:journal("Voices", 40, "You are to return to the .. Hel`Xup.. and find something hidden.")
					other:setFlag(14302, 6)
				end

			elseif voices_quest == 6 then
				if hail then
					self:say("Hel`Xup... hidden within others.. by Hel`Xup... you can see.. the piece within...")
				end

			elseif voices_quest > 6 and voices_quest < 12 then
				if hail then
					self:say("Found one.. but still.. Hel`Xup... hidden.. by Hel`Xup... you can see.. the piece within...")
				end

			elseif voices_quest == 12 then
				if hail or string.match(string.lower(msg), "orta gik velt") then
					self:say("The symbols.. lack a finality.. one last.. would be.. invisible.. remnant of creature.. from beyond..")
					other:journal("Voices", 50, "The last piece is held by an invisible creature from beyond.")
					other:setFlag(14302, 13)
				end
			elseif voices_quest == 13 then
				if hail then
					self:say("Not visible... from beyond.. find.. last piece.. of this.. secret magic..")
					other:journal("Voices", 50, "The last piece is held by an invisible creature from beyond.")
				end

			elseif voices_quest == 15 then
				if hail then
					self:say("Confounding... puzzle.. all symbols.... accounted yet... no solution.. one more familiar with.. Gruplok.. history..")
				end
			end
		else
			if hail then
				self:say("Erp, gleen fowt.  Jaare mof tongu.. il frit hoyk yat bij.. Hatto kla!")
				dialog(other, self, "Tije, groql hat!  Umlo guj korwe fen?")
			elseif string.match(string.lower(msg), "tije  groql hat") then
				self:say("Kolom! Hreu ynea juttaq refno ket hidda.  Janli yurp nez heqra "..other:GetClassName().." tohen gilap et tokleb va.")
				dialog(other, self, "Glurb harl totu gep nar.")
			elseif string.match(string.lower(msg), "glurb harl totu") then
				self:say("Kla!! Fo megrat jugh qeital epz hinonn "..other:GetClassName().." falm ress topu jin app.")
				dialog(other, self, "Urta faju cair tuy-")
			elseif string.match(string.lower(msg), "urta faju") then
				self:say("Kaoli!! Ghurn walno tid gethnu vi chanyo!!!")
			end
		end
	else
		self:say("Glurp.")
	end
end

function EVENT_ITEM(self, other, item, coin)
	if has_book(other) == false and other:GetFlag(14302) > 0 then
		other:text("Now where did you put that Glossary...", 6, true)
		return
	end

	-- ##item from the murk returns piece 1
	if item(41030) > 0 and other:GetFlag(14302) >= 1 then
		item:keep(41030, 1)
		other:text("The Gruplok's hands perform a series of complex gestures around the clay orb.. it glows and hardens. He hands you the result.", 6, true)
		self:say("Ex.. ... great.. power in this but... potential only.. the source.... taken from the ground... stolen... chhhh.")
		other:giveItem(41031, 1)
		if other:GetFlag(14302) == 1 then
			other:journal("Voices", 20, "You are to find a source of Gruplok magic 'stolen' from the ground.")
			other:setFlag(14302, 2)
			other:giveExp(25000, 0)
		end
	end
	
	-- ##item from slave foremen 18203 18204 in bq (NOW IN FOB FROM BANDITS)
	if item(41032) > 0 and other:GetFlag(14302) == 2 then
		item:keep(41032, 1)
		other:text("The Gruplok's hands perform a series of complex gestures around the orb...", 6, true)
		self:say("Glurrp... error!  This power is.. corrupt... too.. Hel`Xup..")
		other:setFlag(14302, 3)
		other:giveExp(25000, 0)
		dialog(other, self, "Klur?")
	end

	-- ##item from the hidden Hel`Xup returns piece 3
	if item(41034) > 0 and other:GetFlag(14302) == 11 then
		item:keep(41034, 1)
		other:text("The Gruplok's hands perform a series of complex gestures around the orb.. it changes form.", 6, true)
		self:say("Becomes clear.. the.. fundamental.. missing but one piece.. ")
		other:giveItem(41035, 1)
		other:setFlag(14302, 12)
		other:giveExp(25000, 0)
		dialog(other, self, "Orta gik velt.")
	end

	-- ##item from the Unseen returns piece 4
	if item(41036) > 0 and other:GetFlag(14302) == 14 then
		item:keep(41036, 1)
		other:text("The Gruplok's hands perform a series of complex gestures around the orb.. it changes form.", 6, true)
		self:say("Extrapolation.. indicates.. finality.. message uncertain.. what is..")
		other:giveItem(41037, 1)
		other:setFlag(14302, 15)
		other:giveExp(25000, 0)
	end

	-- ##Final Turn In
	if item(41038) > 0 and other:GetFlag(14302) == 16 then
		item:keep(41038, 1)
		self:text("The Gruplok stares for a moment at the ancient text, making indecipherable sounds.")
		other:text("Now, he speaks to you, in your own language!", 6, true)
		self:say("Yes, this is indeed a foundation of the ancient Gruplok magics. May it serve them half as well as this knowledge will certainly serve us. Though worthless to you in its pure form, we have transcribed a suitable portion as a reward for your efforts. We cannot hope to buy your silence with such a gift, but perhaps do us the favor of keeping our presence unknown for now. We predict our paths may cross again, though you may not realize it.")
		give_spell(other)
		self:say("Thank you once again, kind "..other:GetClassName()..". You have helped more than you can know. We now leave this vessel.")
		other:setFlag(14302, 20)
		other:giveExp(250000, 0)
		other:journal("Voices", 100, "You are now in possession of a fragment of ancient Gruplok magic.")
	end
end

function give_spell(other)
	if other:GetClass() == 1 then			-- Warrior
		other:giveItem(49303)
	elseif other:GetClass() == 2 then		-- Cleric
		other:giveItem(41130)
	elseif other:GetClass() == 3 then		-- Paladin
		other:giveItem(46335)
	elseif other:GetClass() == 4 then		-- Ranger
		other:giveItem(41079)
	elseif other:GetClass() == 5 then		-- Shadowknight
		other:giveItem(41077)
	elseif other:GetClass() == 6 then		-- Druid
		other:giveItem(41135)
	elseif other:GetClass() == 7 then		-- Monk
		other:giveItem(49287)
	elseif other:GetClass() == 8 then 		-- Bard
		other:giveItem(41082)
	elseif other:GetClass() == 9 then		-- Rogue
		other:giveItem(49304)
	elseif other:GetClass() == 10 then		-- Shaman
		other:giveItem(41131)
	elseif other:GetClass() == 11 then		-- Necromancer
		other:giveItem(41132)
	elseif other:GetClass() == 12 then		-- Wizard
		other:giveItem(21799)
	elseif other:GetClass() == 13 then		-- Magician
		other:giveItem(41136)
	elseif other:GetClass() == 14 then		-- Enchanter
		other:giveItem(41134) 
	elseif other:GetClass() == 15 then		-- Beastlord
		other:giveItem(41081)
	end
end

function has_book(other)
	for k, v in pairs(other:GetInventory()) do
		if v:GetID() == 41039 then
			return true
		end
	end
	return false
end