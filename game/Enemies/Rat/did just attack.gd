extends ConditionLeaf

func tick(actor, blackboard):
	if actor.just_attacked:
		return SUCCESS
	return FAILURE
