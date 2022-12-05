extends ActionLeaf


func tick(actor, blackboard):
	actor.stun()
	return SUCCESS
