extends ActionLeaf


func tick(actor, blackboard):
	actor.die()
	return SUCCESS
