function EVENT_SPAWN(self)
    self:destroyCorpse()
    self:suspendMelee()
end

function EVENT_DEATH(self)
    signal(60279, "totem_death")
end

