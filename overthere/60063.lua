-- Overthere, Oracle controller
-- script is used primarily to function the Oracle escape

function EVENT_SPAWN(self)
	
	_G.OracleEvent = self
	spawnOracle()
	
end

function spawnOracle()

	spawn(60056, 366, -249.7, -520.2, 240.2) -- The Oracle
	
end