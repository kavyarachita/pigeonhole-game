extends ActionLeaf

func tick(actor, blackboard):
	actor.turn_around()
	actor.move_forward()
	return SUCCESS
