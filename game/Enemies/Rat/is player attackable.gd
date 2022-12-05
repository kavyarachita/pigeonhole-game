extends ConditionLeaf

func tick(actor, blackboard):
	if actor.just_attacked or actor.player.is_stunned or actor.player.is_immune:
		return FAILURE
	return SUCCESS
