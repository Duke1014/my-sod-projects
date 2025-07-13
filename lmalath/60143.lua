-- Commissioner Froknut
-- the big quest guy for the noobs

function EVENT_SPAWN(self)
    self:setWeapon(60112, 7)
	self:setWeapon(60113, 8)
end

function EVENT_SAY(self, other, msg)
    if string.find(msg, "Hail") then
        self:say("Greetings, "..other:GetClassName()..". I am known as Froknut. You seem like an up-and-coming "..other:GetRaceName().." with potential. I only have minor work available, but we could use another hand around here. Are you looking for work?")
        dialog(other, self, "I seek work.")
        dialog(other, self, "What is it that you do here, Froknut?")

    elseif string.find(msg, "What is it that you do here") then
        self:say("I have been assigned by the Lucidites as the Commissioner of the Guard. I'm tasked with ensuring that our soldiers have proper training, patrols are taken seriously, and maintaining safety here in Leaga Malath. We serve as protectors of this land that once belonged to our master, Malath, should such a reason to protect ever occur. We may have failed Malath as defenders, but we will keep his legacy safe.")
        dialog(other, self, "I seek work.")

    elseif string.find(msg, "I seek work") then
        self:say("Very well. I can pay you to cull the scarabs, hunt for salamanders, or retrieve treasure from the corpses of pirates. All of these would require you to venture off to the beach. Whether you can handle such a mundane task is up to you.")
        dialog(other, self, "I will cull the scarabs.")
        dialog(other, self, "I will hunt for salamanders.")
        dialog(other, self, "I will retrieve the pirate treasure.")

    elseif string.find(msg, "cull the scarabs") then
        self:say("The scarabs have been multiplying since the barrier shattered. Go thin them out, and bring back their pincers; for each one you show to me as proof of your usefulness, you will be rewarded.")
        other:journal("Culling the Scarabs - Froknut", 1, "Commissioner Froknut has asked me to kill scarabs on the beach and bring back their pincers.")
    
    elseif string.find(msg, "hunt for salamanders") then
        self:say("Excellent, these pests have been getting into our food supplies. Cut their tails off and bring them to me; for each one you show to me as proof of your usefulness, you will be rewarded.")
        other:journal("Hunting the Salamanders - Froknut", 1, "Commissioner Froknut has asked me to kill salamanders around the beach and bring back their tails.")
    
    elseif string.find(msg, "retrieve the pirate treasure") then
        self:say("Since crash landing in this world, we've managed to crash into many ships and cause them to wreck on our land. Our main focus hasn't been scavenging their belongings, which is where you'll now come in. Bring us whatever treasures you can find from their corpses on the beach.")
        other:journal("Retrieving the Treasure - Froknut", 1, "Commissioner Froknut has asked me to scavenge treasure from the corpses of pirates on the beach.")
    end
end

function EVENT_ITEM(self, other, item, coin)
    if item(60114) > 0 then         -- 60114 = beach scarab pincer
        flag = other:GetFlag(42520)
        if flag <= 20 then
            count = item:Count(60114)
            diff = 20 - flag
            if count >= diff then
                other:setFlag(42520, flag + diff)
                item:keep(60114, diff)
                self:say("Fantastic, this should do for scarab pincers, "..other:GetName()..". Thank you for your efforts for the Master.")
                other:giveExp(250 * diff, 10)  
                other:giveExp(750, 10) 
                other:giveCash(0, 5 * diff, 0, 0)

            elseif count < diff then
                other:setFlag(42520, flag + count)
                item:keep(60114, count)
                self:say("Splendid. You may just be of use to Malath after all.")
                other:giveExp(250 * count, 10)    
                other:giveCash(0, 5 * count, 0, 0)
            
            end
        end    

    elseif item(60115) > 0 then     -- 60115 = beach salamander tail
        flag = other:GetFlag(42521)
        if flag <= 20 then
            count = item:Count(60115)
            diff = 20 - flag
            if count >= diff then
                other:setFlag(42521, flag + diff)
                item:keep(60115, diff)
                self:say("Fantastic, this should do for slaying salamanders, "..other:GetName()..". Thank you for your efforts for the Master.")
                other:giveExp(250 * diff, 10)  
                other:giveExp(750, 10) 
                other:giveCash(0, 5 * diff, 0, 0)
            elseif count < diff then
                other:setFlag(42521, flag + count)
                item:keep(60115, count)
                self:say("Splendid. You may just be of use to Malath after all.")
                other:giveExp(250 * count, 10)    
                other:giveCash(0, 5 * count, 0, 0)
            end
        end

    elseif item(60120) > 0 then     -- 60120 = beached pirate earring
        flag = other:GetFlag(42522)
        if flag <= 20 then
            count = item:Count(60120)
            diff = 20 - flag
            -- other:setFlag(42522, flag + 1)
            -- item:keep(60120, 1)
            if count >= diff then
                other:setFlag(42522, flag + diff)
                item:keep(60120, diff)
                self:say("Fantastic, this should do for scavenging the dead, "..other:GetName()..". Thank you for your efforts for the Master.")
                other:giveExp(250 * diff, 10)  
                other:giveExp(750, 10) 
                other:giveCash(0, 5 * diff, 0, 0)
            elseif count < diff then
                other:setFlag(42522, flag + count)
                item:keep(60120, count)
                self:say("Splendid. You may just be of use to Malath after all.")
                other:giveExp(250 * count, 10)    
                other:giveCash(0, 5 * count, 0, 0)
            end
        end
    end
end