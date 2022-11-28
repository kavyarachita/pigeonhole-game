extends ActionLeaf

func tick(actor, blackboard):
	actor.attack()
	return RUNNING
