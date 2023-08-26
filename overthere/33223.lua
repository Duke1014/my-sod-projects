-- a partially formed golem
-- killing all of these in the eastern-most mud pit forms the Tar Monster

function EVENT_DEATH(self)
	spawn(60028, self)
	signal(32266, "tar_countdown")
end

function EVENT_SPAWN(self)
	self:destroyCorpse()
end

