--[[
Dragonforged Convoy Controller

This GM viewable controller mob causes a convoy to spawn at the overthere zone line, path to the coastal docks NPC hub, pause, and then path back.

]]

pathing = {}
pathing[1] = { 3632, -788,   46} --Spawn near overthere
pathing[2] = { 3186,  172,  -47} --Waypoint 2
pathing[3] = { 2588,  450,  -47} --Waypoint 3
pathing[4] = { 2595,  855,  -49} --Waypoint 4
pathing[5] = { 2784, 1095,  -48} --Waypoint 5
pathing[6] = { 2800, 1435,  -47} --Waypoint 6
pathing[7] = { 1094, 2694,  -49} --Waypoint 7
pathing[8] = { -453, 2838,  -46} --Waypoint 8
pathing[9] = { -905, 3280,  -37} --Stopping point out front of docks

mob_array = {}
--         1-2    2-3    3-4    4-5    5-6    6-7    7-8    8-9
timer = {105000, 65000, 42000, 29000, 32000,210000,155000, 66000}

CONVOY_NPCID = 58427 --a dragonforged convoy
ESCORT_NPCID = 58428 --a dragonforged escort
ADVISO_NPCID = 58429 --a dragonforged advisor

wp = 1 --waypoint
direction = "walking to docks"

timer_ref = nil

function EVENT_SPAWN(self)
    depop(58427)
    depop(58428)
    depop(58429)
    if GetGlobal(35302) == 0 then
        self:timer("SPAWN CONVOY",500 ,true)
    end
end

function EVENT_TIMER(self, timer_name, timer_object)
    if timer_name == "SPAWN CONVOY" then

        for i = 1, 9 do
            local npc_id = ESCORT_NPCID
            if i == 5 or i == 8 then
                npc_id = ADVISO_NPCID
            elseif i == 1 then
                npc_id = CONVOY_NPCID
            end

            local spawn_point = {pathing[wp][1] + (math.random(40) - 20), pathing[wp][2]  + (math.random(40) - 20), pathing[wp][3] + 5}
            local best_z = self:GetBestZ(spawn_point)
            mob_array[i] = spawn(npc_id, spawn_point[1], spawn_point[2], best_z, 0)

            if i ~= 5 or i ~= 8 then
                mob_array[i]:setSize(math.random(5,6))
            end
        end

        --Start pathing
        self:timer("PATHING", 500 ,true)
    elseif timer_name == "PATHING" then

        if wp == 9 and direction == "walking to docks" then
            wp = wp - 1
            direction = "walking to zone" --Set direction to walk back to zone
            timer_ref = self:timer("PATHING", 300000 ,true)
            return
        end

        temp_timer = timer[wp] -- Set Timer
        if direction == "walking to zone" then
            temp_timer = timer[wp-1]
        end

        if direction == "walking to docks" then
            wp = wp + 1
        elseif direction == "walking to zone" then
            wp = wp - 1
        end

        for i = 1, 9 do
            if mob_array[i]:InZone() then
                local next_wp = {pathing[wp][1] + (math.random(40) - 20), pathing[wp][2]  + (math.random(40) - 20), pathing[wp][3] + 5}
                local best_z = self:GetBestZ(next_wp)
                mob_array[i]:walkTo(next_wp[1], next_wp[2], best_z)
            end
        end
            
        if wp == 1 then
            timer_ref = self:timer("DEPOP", 300000 ,true) --Walk to spawn point at zone side, and wait 5 minutes
        else
            timer_ref = self:timer("PATHING", temp_timer ,true)
        end
    elseif timer_name == "DEPOP" then
        for i = 1, 9 do
            mob_array[i]:depop()
        end
        setGlobal(35302,1)
        depopSpawn(84187, 91)
        self:respawn()
    end
end