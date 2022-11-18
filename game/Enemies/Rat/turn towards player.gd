extends ActionLeaf

func tick(actor, blackboard):
	actor.turn_towards_player()
	return SUCCESS
