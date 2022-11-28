extends ConditionLeaf

func tick(actor, blackboard):
	actor.idle_after_attack()
	return RUNNING
