extends ActionLeaf

func tick(actor, blackboard):
	if actor.can_attack_player:
		return SUCCESS
	actor.move_towards_player()
	return RUNNING
	
