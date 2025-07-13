-- shadow "add" for shadowbinder

local start_hp = 0
local end_hp = 0

function EVENT_SIGNAL(self, msg, hp)
    self:destroyCorpse()
    if msg == "swap_stuff" then
        self:set("hp", self:GetStats().maxhp * (hp / 100))
        start_hp = self:GetStats().hp
    end
end

function EVENT_DEATH(self)
    signal(32229, "shadow_died")
    self:stopAllTimers()
end

function EVENT_SPAWN(self)
    self:timer("return", 30000, true)
end

function EVENT_TIMER(self, timer)
    if timer == "return" then
        -- start hp minus end hp = dmg to main frog
        -- depop this guy
        end_hp = self:GetStats().hp
        send_dmg = start_hp - end_hp
        debugtext("TOTAL DMG DONE: "..send_dmg)
        signal(32229, "shadow_return", send_dmg)
        self:depop()
    end
end

