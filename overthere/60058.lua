-- kaezulian undead thing that attacks you in a solo event

function EVENT_SPAWN(self)
    self:setAnim(3)
end

function EVENT_SIGNAL(self, signal, data)

    if signal == "activate" then
        self:set("faction", 47)
    end

end