extends ActionLeaf

func tick(actor, blackboard):
	if actor.pace and actor.move_forward():
		return SUCCESS
	return FAILURE
