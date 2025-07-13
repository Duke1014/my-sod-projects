-- Revivifier Klugnor
-- makeshift healer

local heal_price
local cure_price
local debt_price

function EVENT_SPAWN(self)
    self:setWeapon(1102, 7)

end

function check_price(other)
    if other:GetRace(true) == 330 and other:GetClass() == 5
    or other:GetRace(true) == 330 and other:GetClass() == 9
    or other:GetRace(true) == 330 and other:GetClass() == 11 then
        if other:GetLevel() <= 10 then
            heal_price = "free"
            cure_price = "free"
            debt_price = "free"
        elseif other:GetLevel() <= 20 then
            heal_price = "two copper coins"
            cure_price = "five silver coins"
            debt_price = "five gold coins"
        elseif other:GetLevel() <= 30 then
            heal_price = "one silver coin"
            cure_price = "five silver coins"
            debt_price = "two platinum coins"
        elseif other:GetLevel() <= 40 then
            heal_price = "five silver coins"
            cure_price = "five silver coins"
            debt_price = "eight platinum coins"
        elseif other:GetLevel() <= 50 then
            heal_price = "one gold coin"
            cure_price = "five silver coins"
            debt_price = "fifteen platinum coins"
        elseif other:GetLevel() <= 60 then
            heal_price = "one gold coin"
            cure_price = "five silver coins"
            debt_price = "twenty platinum coins"
        else
            heal_price = "one gold coin"
            cure_price = "five silver coins"
            debt_price = "twenty-five platinum coins"
        end
        
    else
        if other:GetLevel() <= 10 then
            heal_price = "one silver coin"
            cure_price = "five silver coins"
            debt_price = "two platinum coins"
        elseif other:GetLevel() <= 20 then
            heal_price = "five silver coins"
            cure_price = "five silver coins"
            debt_price = "eight platinum coins"
        elseif other:GetLevel() <= 30 then
            heal_price = "one gold coin"
            cure_price = "five silver coins"
            debt_price = "fifteen platinum coins"
        elseif other:GetLevel() <= 40 then
            heal_price = "one gold coin"
            cure_price = "five silver coins"
            debt_price = "twenty platinum coins"
        elseif other:GetLevel() <= 50 then
            heal_price = "one gold coin"
            cure_price = "five silver coins"
            debt_price = "twenty-five platinum coins"
        elseif other:GetLevel() <= 60 then
            heal_price = "two gold coins"
            cure_price = "one gold coin"
            debt_price = "twenty-five platinum coins"
        else
            heal_price = "two gold coins"
            cure_price = "one gold coin"
            debt_price = "fifty platinum coins"
        end

    end
end

function EVENT_SAY(self, other, msg)
    check_price(other)

    if string.find(msg, "Hail") then
        self:say("Greetings, traveler. I am Klugnor, a revivifier of the Mavassi. I've trained myself in the necromantic arts of life and death, and can use my services to aid those of our humble home.")
        dialog(other, self, "What are your services?")

    elseif string.find(msg, "What are your") then
        self:say("I can channel my lifeflow to heal your wounds for "..heal_price..", purge the ailments of your body for "..cure_price..", or remove a soul debt for "..debt_price..".")
        dialog(other, self, "Heal my wounds.")
        dialog(other, self, "Purge my body.")
        dialog(other, self, "Remove my soul debt.")

    elseif string.find(msg, "Heal my wounds") then
        if heal_price == "two copper coins" then
            if other:takeCash(2) then
                other:heal()
            else return end

        elseif heal_price == "one silver coin" then
            if other:takeCash(0,1)then
                other:heal()
            else return end

        elseif heal_price == "five silver coins" then
            if other:takeCash(0,5) then               
                other:heal()
            else return end

        elseif heal_price == "one gold coin" then
            if other:takeCash(0,0,1) then
                other:heal()
            else return end

        elseif heal_price == "two gold coins" then
            if other:takeCash(0,0,2) then
                other:heal()
            else return end

        elseif heal_price == "free" then
            other:heal()
        else return end
        
    elseif string.find(msg, "Purge my body") then
        if cure_price == "five silver coins" then
            if other:takeCash(0,5) then
                other:spellEffect(1470)
            else return end
        elseif cure_price == "one gold coin" then
            if other:takeCash(0,0,1) then
                other:spellEffect(1470)
            else return end
        elseif cure_price == "free" then
            other:spellEffect(1470)
        else return end

    elseif string.find(msg, "Remove my soul") then
        if debt_price == "five gold coins" then
            if other:takeCash(0,0,5) then
                other:setExpDebt(0)
                other:text("Your experience debt has been cleared.",15,true)
            else return end
        elseif debt_price == "two platinum coins" then
            if other:takeCash(0,0,0,2) then
                other:setExpDebt(0)
                other:text("Your experience debt has been cleared.",15,true)
            else return end
        elseif debt_price == "eight platinum coins" then
            if other:takeCash(0,0,0,8) then
                other:setExpDebt(0)
                other:text("Your experience debt has been cleared.",15,true)
            else return end
        elseif debt_price == "fifteen platinum coins" then
            if other:takeCash(0,0,0,15) then
                other:setExpDebt(0)
                other:text("Your experience debt has been cleared.",15,true)
            else return end
        elseif debt_price == "twenty platinum coins" then
            if other:takeCash(0,0,0,20) then
                other:setExpDebt(0)
                other:text("Your experience debt has been cleared.",15,true)
            else return end
        elseif debt_price == "twenty-five platinum coins" then
            if other:takeCash(0,0,0,25) then
                other:setExpDebt(0)
                other:text("Your experience debt has been cleared.",15,true)
            else return end
        elseif debt_price == "fifty platinum coins" then
            if other:takeCash(0,0,0,50) then
                other:setExpDebt(0)
                other:text("Your experience debt has been cleared.",15,true)
            else return end
        elseif debt_price == "free" then
            other:setExpDebt(0)
            other:text("Your experience debt has been cleared.",15,true)    
        else return end
    end
end
