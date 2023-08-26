--[[
NAME:	A razor-beaked harrow

Flying mob that patrols

]]


local east_loc_array = {}
east_loc_array[1] = {-3445, -3492, 653}
east_loc_array[2] = {-3800, -524, 366}
east_loc_array[3] = {-3723, -896, 310}
east_loc_array[4] = {-3593, -2137, 255}
east_loc_array[5] = {-3548, -3182, 170}

local west_loc_array = {}
east_loc_array[1] = {3757, 1394, 150}
east_loc_array[2] = {3780, 1272, 158}
east_loc_array[3] = {3932, 646, 251}
east_loc_array[4] = {3802, 387, 171}
east_loc_array[5] = {3303, -2324, 186}
east_loc_array[5] = {3554, -3581, 536}

--These center locations will have grids associated with them
local center_loc_array = {}
center_loc_array[1] = {1704,-1124,84}
center_loc_array[2] = {2110, -235, 116}
center_loc_array[3] = {3141, -552,125}
center_loc_array[4] = {429,-557,83}
center_loc_array[5] = {-630,-1567, 70}
center_loc_array[6] = {-1214,-2426,184}
center_loc_array[7] = {-2746, -2551, 145}
center_loc_array[8] = {-2117, -599, 140}
center_loc_array[9] = {-1586, 692, 88}
center_loc_array[10] = {-1869, 1433, 156}
center_loc_array[11] = {-2492, 2424, 88}
center_loc_array[12] = {-1665, 3210, 124}

local sector_array = {east_loc_array, west_loc_array, center_loc_array}

function EVENT_SPAWN(self)
	self:timer("setup",100,true)	--Delay to avoid setup failures from bad spawn
	self:timer("CalcRoam",1000,true)	--Delay to avoid setup failures from bad spawn
end

function EVENT_TIMER(self,ability)
	--Setup timers
	if ability == "setup" then
		self:spellEffect(2602)									--Self NPC_Levitate
		self:timer("float",1000000,true)
	elseif ability == "float" then
		self:spellEffect(2602)
		self:timer("float",1000000,true)
	elseif ability == "CalcRoam" then
		CALC_ROAM()
	end
end

function CALC_ROAM()
	--Iterate through each sector array, insert the tables that are a max distance from your location
end