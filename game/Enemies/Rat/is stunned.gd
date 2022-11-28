extends ConditionLeaf


func tick(actor, blackboard):
	if actor.is_stunned():
		return SUCCESS
	return FAILURE
