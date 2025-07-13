-- a slumbering Murk flower, The Murk edition:tm:

local cuisine_quest = false
local pendant_most_pure_quest = false

function EVENT_SPAWN(self)
    self:set("permarooted", 1)
    protect(self)
end

function EVENT_ITEM(self, other, item, coin)
    if cuisine_quest == false and pendant_most_pure_quest == false then
        if item(20804) > 0 then -- krukin the cook quest
            cuisine_quest = true
            item:keep(20804, 1)
            self:addHate(other)
            activate(self)
        end
        if item(20814) > 0 then -- pendant quest
            pendant_most_pure_quest = true
            item:keep(20814,1)
            self:addHate(other)
            activate(self)
        end
    end
end

function EVENT_TIMER(self, timer)
    if timer == "plaguewind" then
		self:text(self:GetName().." shakes its leaves, spreading an ancient pestilence into the air.")
		self:cast(3332, self:GetTarget())
    elseif timer == "droplet_1" then
		self:text(self:GetName().." shudders and spews huge globs of poison as its body begins to reject them.")
		spawn(30097, math.random(self:GetX() - 5, self:GetX() + 5), math.random(self:GetY() - 5, self:GetY() + 5), self:GetBestZ(self), 0, 600)
		spawn(30097, math.random(self:GetX() - 5, self:GetX() + 5), math.random(self:GetY() - 5, self:GetY() + 5), self:GetBestZ(self), 0, 600)
        self:timer("droplet_2", 45000, true)
    elseif timer == "droplet_2" then
		self:text(self:GetName().." retches and spews out another glob of poison.")
		spawn(30097, math.random(self:GetX() - 5, self:GetX() + 5), math.random(self:GetY() - 5, self:GetY() + 5), self:GetBestZ(self), 0, 600)
        self:timer("droplet_1", 30000, true)
    end
end

function EVENT_SIGNAL(self, signal) 
	if signal == "droplet_death" and pendant_most_pure_quest == true then -- envenomed droplet dies, flower loses 15% hp
		self:text(self:GetName().." shrieks as more of its body becomes purified.")
        if self:GetStats().hpratio <= 15 then
            self:set("HP", 1)
        else
            self:set("HP", self:GetStats().hp - (self:GetStats().maxhp * 0.15))
        end
    end
end

function EVENT_DEATH(self)
    self:stopAllTimers()
    depop(30097)
	if pendant_most_pure_quest == true then
		self:text(self:GetName().." spasms for a moment before collapsing, the last of its energies pouring into its ripened fruit.")
        self:setAppearance(162, 2, 8)
    else
        self:text(self:GetName().." withers and dies." )
    end
    
    -- Retrieve the hate list to identify participating players for direct quest item rewards.
    local hate_list = self:GetHateList()
    if hate_list then
        for _, player in pairs(hate_list) do
            if player and player:IsClient() then
                if pendant_most_pure_quest == true then
                    if player:GetFlag(3011) == 8 then
                        player:text("As the flower's final essence perfects it, the fruit hangs ripe and pure before you. You reach out and gently pluck the Blemishless Fruit.", 263, true)
                        player:giveItem(20812) -- Blemishless Fruit
                    end
                end
                if cuisine_quest == true then
                    if player:GetFlag(3008) == 8 then
                        player:text("As the murk flower withers into decay, you carefully pluck a few of its surprisingly delicate leaves from the fading bloom.", 263, true)
                        player:giveItem(20806) -- Delicate Murk Flower Leaves
                    end
                end
            end
        end
    end
end

function EVENT_COMBATEND(self)
    self:stopAllTimers()
    depop(30097)
    cuisine_quest = false
    pendant_most_pure_quest = false
    self:respawn()
end

function protect(self)
	self:set("aggrorange", 0) -- mob is not supposed to attack people
    self:text(self:GetName().." curls its leaves, protecting itself from the wilds.")
    self:invul(true)
    self:setAnim(1)
end

function activate(self)
	self:set("aggrorange", 60) -- mob attacks once it activates
    self:invul(false)
    self:setAnim(0)

    if cuisine_quest == true then
        -- self:addLoot(20806, 1)
        self:set("maxhp", 100000)
        self:heal()
        self:text(self:GetName().." comes to life and shudders violently before turning its razor sharp thorns on "..self:GetTarget():GetName()..".")
        self:timer("plaguewind", 45000)

    elseif pendant_most_pure_quest == true then
        -- self:addLoot(20812,1)
        self:set("specialattks", 1, 10) -- does not summon
        self:set("ac", 1750, 0)
        self:set("specialattks", 5, 9) -- reflects
        self:set("maxhp", 500000)
        self:heal()
        self:setAppearance(162, 2, 2)
        self:text(self:GetName().." shrieks and gurgles violently, its features beginning to pulsate and brighten. It defends itself with great ferocity as its fruits start to reveal themselves against its will.")
        self:timer("droplet_1", 30000, true)
    end
end