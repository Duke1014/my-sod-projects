-- "resurrection ritual stones"
-- acts as a cute thing that you zone on top of when you first log in an evil frog or use home gate

local frog1
local frog2
local frog3
local frog4
local frog5
local frog6

function EVENT_SPAWN(self)
    depop(60001)
    data = {name = "a Mavassi Ritualist", npcid = 60001, level = 10, texture = 11, aiclass = 4}
    skeleton_data = {name = "", aiclass = 4, untrackable = 1, bodytype = 11}
    x = self:GetX(true)
    y = self:GetY(true)
    z = self:GetZ(true) + 0.2
    frog1 = customSpawn(data, x, y + 27, z, 128)
    frog2 = customSpawn(data, x - 23.4, y + 13.5, z, 85.3)
    frog3 = customSpawn(data, x - 23.4, y - 13.5, z, 42.6)
    frog4 = customSpawn(data, x, y - 27, z, 0)
    frog5 = customSpawn(data, x + 23.4, y - 13.5, z, 213.3)
    frog6 = customSpawn(data, x + 23.4, y + 13.5, z, 170.6)
    skeleton = customSpawn(skeleton_data, self)
    frog1:setAppearance(330)
    frog2:setAppearance(330)
    frog3:setAppearance(330)
    frog4:setAppearance(330)
    frog5:setAppearance(330)
    frog6:setAppearance(330)
    skeleton:setAppearance(349)
    skeleton:setAnim(3)
    self:area("spawn", 5)
end

function frog_greeting()
    frog1:doAnim(29)
    frog2:doAnim(29)
    frog3:doAnim(29)
    frog4:doAnim(29)
    frog5:doAnim(29)
    frog6:doAnim(29)
end

function EVENT_LEAVEAREA(self, other, area)
    if other:GetRaceName(true) == "Froglok" and (other:GetClass() == 5 or other:GetClass() == 9 or other:GetClass() == 11) then
        if area == "spawn" and other:IsClient() and other:GetLevel() == 1 then
            self:text("The ritualists gathered around you rejoice, as if shocked that you've appeared before them. 'It worked! "..other:GetName().." is alive, again!")
            frog_greeting()
        end

        if area == "spawn" and other:IsClient() and other:GetLevel() > 1 then
            self:text("The ritualists say, 'Welcome back, "..other:GetName().."!")
            frog_greeting()
        end
    end
end