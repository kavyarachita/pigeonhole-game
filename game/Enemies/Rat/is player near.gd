extends ConditionLeaf

func tick(actor, blackboard):
	if actor.player_is_near:
		return SUCCESS
	return FAILURE
