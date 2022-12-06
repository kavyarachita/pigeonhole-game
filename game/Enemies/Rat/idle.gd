extends ActionLeaf

func tick(actor, blackboard):
	if actor.idle:
		actor.idle()
		return SUCCESS
	return FAILURE
