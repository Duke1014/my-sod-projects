-- a strange rift - Murk

-- function EVENT_SPAWN(self)
-- 	-- if ($zonesn == kaesora && $npc_locx == 659 && $npc_locy == -162) {
-- 	-- 	scriptstatus(9)
-- 	-- 	startscript(1)
-- 	-- }
-- 	if ($zonesn == murk && $npc_locx == -1213 && $npc_locy == -393) {
-- 		scriptstatus(1)
-- 		startscript(1)
-- 	}
-- 	-- if ($zonesn == prophets) {
-- 	-- 	scriptstatus(2)
-- 	-- 	startscript(1)
-- 	-- }
-- 	-- unattackable(30063)
-- 	-- invul(30063) already invul
-- end

-- EVENT_SCRIPT {
	-- ##Spawn Settings
	-- if ($script_status == 1) {
	-- 	setsize(4)
	-- 	scriptstatus(100)
	-- }
	-- if ($script_status == 2) {
	-- 	setsize(4)
	-- 	scriptstatus(200)
	-- }
	-- if ($script_status == 9) {
	-- 	setsize(8)
	-- 	settexture(3)
	-- 	scriptstatus(900)
	-- }
	
-- 	##Prophet's
-- 	if ($script_status == 200) {
-- 		self:text(A distinctly different energy begins to coalesce nearby. The wind seems to halt as the energy becomes blotted with darkness.)
-- 		scriptstatus(201)
-- 		startscript(8000)
-- 	}
-- 	if ($script_status == 201) {
-- 		setsize(4)
-- 		spawnat(30101,0,3105,-1483,-107.3,145)
-- 		spawnat(30102,0,3111,-1482,-105.2,145)
-- 		scriptstatus(202)
-- 	}
-- }
function EVENT_TIMER(self, timer)
    if timer == "jewel_reaction" then
		self:text("Irregular bursts of a strange energy emerge from the rift. You get the feeling that something terribly wrong has happened.")
		self:setSize(8)
        self:timer("jewel_reaction2", 9000, true)
        self:spellFX(36)
    elseif timer == "jewel_reaction2" then
		self:text("The rift begins to grow and a menacing pulse beats through the air as a cloud of darkness emerges from the rift itself.")
		self:setSize(12)
        self:timer("jewel_reaction3", 10000, true)
        self:spellFX(36)
    elseif timer == "jewel_reaction3" then
		self:text("The cloud of darkness gathers together a few steps away. The air settles as the strange energy retreats back into the rift.")
        self:timer("jewel_reaction4", 8000, true)
    elseif timer == "jewel_reaction4" then
		self:setSize(4)
		spawn(30101, -1234, -378, -4.7, 91.4, 300)
    end
end

function EVENT_SAY(self, other, msg)
	local hail = string.match(string.lower(msg), "hail")

    if other:GetFlag(3025) == 6 and has_gem(other) then
        if hail then
            other:text("The rift studders briefly at the sound of your voice. The ancient jewel doesn't seem to be reacting from this distance.", 6, true)
            dialog(other, self, "-Use the jewel directly on the rift-")
    
        elseif string.match(msg, "Use the jewel directly on the rift") then
            self:text("As "..other:GetName().." brings the ancient jewel closer to the rift, the rift begins to shrink away until a sudden, violent reaction sends sparks of energy flying in all directions!")
            self:timer("jewel_reaction", 10000, true)
            self:spellFX(36)
        end

    else
	    if hail then
            other:text("Being near this rift fills you with an odd sense of foreboding.", 6, true)
        end
    end


	-- ##Prophets
	-- if ($1- =~ "Hail" && $script_status == 200 && other:GetFlag(3025) == 10 && $hasitem(20845) == 1) {
	-- 	self:text(The rift flickers in reaction to your presence.)
	-- 	dialog(-Use the jewel on the rift-)
	-- }
	-- elseif ($1- =~ "Hail" && $script_status == 200 && other:GetFlag(3025) != 10) {
	-- 	self:text(This rift seems to be drawing in the wind.)
	-- }
	-- if ($1- =~ "Use the jewel on the rift" && $script_status == 200 && other:GetFlag(3025) == 10 && $hasitem(20845) == 1) {
	-- 	self:text(A violent burst of energy juts out at "..other:GetName().." as they bring the jewel near to the rift.)
	-- 	castspell(1496,$userid)
	-- 	startscript(8000)
	-- }
end

-- EVENT_SIGNAL {
-- 	if ($signal == 1) {
-- 		scriptstatus(1)
-- 		startscript(1)
-- 	}
-- }

function has_gem(other)
    for k, v in pairs(other:GetInventory()) do
        if v:GetID() == 20843 then
            return true
        end
    end
    return false
end