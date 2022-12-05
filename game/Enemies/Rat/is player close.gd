extends ConditionLeaf

func tick(actor, blackboard):
	if actor.can_attack_player:
		return SUCCESS
	return FAILURE
