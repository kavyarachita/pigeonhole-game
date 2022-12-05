extends ActionLeaf

func tick(actor, blackboard):
	if actor.move_forward():
		return SUCCESS
	return FAILURE
