-- Korbglaw, the Lifebinder

-- brings life to add every x seconds, 
-- all adds can be wizard destroyed, enchanter/bard/necro mezzed, stunned
-- all adds can NOT be rooted, charmed, feared

-- life totems: 
-- - does aoe dmg (Disease)
-- - gives boss more power when killed
-- - kills any alive adds when killed

-- flies:
-- - annoying gnats that don't do a lot of damage but will transfer life to the boss

-- cubes:
-- - phantom strike

-- spores:
-- - disease stuff idk yet

aoe_dmg = 1500
boss_dmg = 1400

add_timer = 20000
nuke_timer = 25000

totem_hp = 20000

fly_model = 265
cube_model = 31
spore_model = 28

local add_race = 0
local add_hp = 30000
local add_size = 5
local add_path = 1

totem_id = 2801
add_id = 2802

totem_spawn_loc = {
    {-455, 882, -18},
    {-455, 936, -18},
}

add_spawn_loc = {
    {-434, 966, -18},
    {-380, 966, -18},
    {-325, 966, -18},
    {-434, 850, -18},
    {-380, 850, -18},
    {-325, 850, -18},
}

totem = {name = "a lifebound totem", level = 65, race = 514, gender = 2, size = 10, npcid = totem_id, faction = 70, perm}

function EVENT_SPAWN(self)
    cleanup(self)
    setup(self)
end

function setup(self)
    self:set("permarooted", true)
    totem_one = customspawn(totem, totem_spawn_loc[1])
    totem_two = customspawn(totem, totem_spawn_loc[2])
    totem_one:set("permarooted", true)
    totem_two:set("permarooted", true)
end

function EVENT_ATTACK(self, other)
    self:text(self:GetName().." croaks a cursed ritual as she leaps towards "..other:GetName().."!")
    self:timer("add", add_timer, true)
    self:timer("nuke", nuke_timer, true)
end

function EVENT_TIMER(self, timer)
    if timer == "add" then
        spawn_add(self)
    elseif timer == "nuke" then
        nuke(self)
    end
end

function EVENT_SIGNAL(self, signal, data)
    if signal == "totem_death" then
        add_boss_dmg(self)
        lower_aoe_dmg(self)
        clear_adds(self)
    end
end

function spawn_add(self)
    local random_loc_index = math.random(1, #add_spawn_loc)
    add = {name = "a lifebound creation", level = 54, race = 0, gender = 2, hp = add_hp, size = add_size, npcid = add_id, faction = 70, aggrorange = 150, maxdmg = 400}

    customSpawn(add, add_spawn_loc[random_loc_index])

    if add_timer > 5000 then
        add_timer = add_timer - 500
    end

    self:timer("add", add_timer, true)
end

function nuke(self)
    local hl = self:GetHateList()
    for k, v in pairs(hl) do
        if v:IsClient() and v:InZone() then
            customnuke(self, v, "Putrid Pulse", aoe_dmg, 5, -150, "A putrid essence washes over you from the totem.")
        end
    end
    self:timer("nuke", nuke_timer, true)
end

function cleanup(self)
    depop(add_id)
    depop(totem_id)
end

function clear_adds(self)
    depop(add_id)
end

function EVENT_COMBATEND(self)
    cleanup(self)
end

function EVENT_DEATH(self)
    cleanup(self)
end

function add_boss_dmg(self)
    boss_dmg = boss_dmg + 500
    self:set("maxdmg", boss_dmg)
end

function lower_aoe_dmg(self)
    aoe_dmg = aoe_dmg - 750
    if aoe_dmg == 0 then
        self:stopTimer("nuke")
    end
end

function EVENT_INSIGHT(self, other)
    other:text(self:GetName()..":", 13)
    other:text(" * Destroying her totems disrupts the life flow she gives to her creations, but she will absorb the power of the totem.", 13)
    other:text(" * The totems themselves pulse a deadly force of disease.", 13)
end