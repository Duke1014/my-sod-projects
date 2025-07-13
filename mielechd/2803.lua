-- blood of mielech, from Krazkak, the Bloodbinder

walk_1 = {-13.6, 1283, -60}
walk_2 = {{-61, 1283, -53}, {34, 1283, -53}}
walk_3 = {{-76, 1295, -53}, {51.5, 1295, -53}}
walk_4 = {{-76, 1323, -46}, {51.5, 1323, -46}}
walk_5 = {{-63, 1340, -43}, {36, 1340, -43}}
walk_6 = {{-35, 1340, -37}, {10, 1340, -37}}
walk_7 = {-14, 1340, -39}

random_walk = 1
current_walk = walk_1

function EVENT_SPAWN(self)
    self:destroyCorpse()
    self:suspendMelee()
    self:set("AIClass", 14)
    self:timer("walk_1", 1500, true)
    self:timer("walk_full_duration", 38000, true)
    self:set("Immunities", 2, 1) -- stun immune
    self:set("Immunities", 3, 1) -- stun immune
    self:set("Immunities", 4, 1) -- stun immune
    self:set("Immunities", 5, 1) -- stun immune
    self:set("Immunities", 6, 1) -- stun immune
    self:set("Immunities", 8, 1) -- stun immune
    self:set("Immunities", 9, 1) -- stun immune
end

function EVENT_ATTACK(self, other)
	self:wipeHate()
end

function EVENT_TIMER(self, timer)
    if timer == "check_for_pot" then
        check_for_pot(self)

    elseif timer == "walk_1" then
        self:walkTo(walk_1)
        self:timer("walk_2", 6000, true)

    elseif timer == "walk_2" then
        random_walk = math.random(1,2)
        self:walkTo(walk_2[random_walk])
        self:timer("walk_3", 7000, true)

    elseif timer == "walk_3" then
        self:walkTo(walk_3[random_walk])
        self:timer("walk_4", 5000, true)

    elseif timer == "walk_4" then
        self:walkTo(walk_4[random_walk])
        self:timer("walk_5", 5000, true)

    elseif timer == "walk_5" then
        self:walkTo(walk_5[random_walk])
        self:timer("walk_6", 5000, true)

    elseif timer == "walk_6" then
        self:walkTo(walk_6[random_walk])
        self:timer("walk_7", 5000, true)

    elseif timer == "walk_7" then
        random_walk = 1
        self:walkTo(walk_7)

    elseif timer == "walk_full_duration" then
        signal(2804, "absorbed")
        self:stopAllTimers()
        self:depop()
    end
end

function EVENT_DEATH(self)
    self:stopAllTimers()
end