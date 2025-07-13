-- an island fish
-- This script is used to give the NorthWest section of Leaga Malath a little more life and color

function EVENT_SPAWN(self)
    size = math.random(5, 20)
    texture = math.random(0, 3)
    helm = math.random(0, 3)
    
    self:setSize(size)
    self:setAppearance(24, 2, texture, helm)
end