extends ConditionLeaf

func tick(actor, blackboard):
	if actor.is_dead():
		return SUCCESS
	return FAILURE
