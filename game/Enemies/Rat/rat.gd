extends "res://Enemies/enemy.gd"


func _on_PlayerCloseDetectionArea_body_entered(body):
	if body.is_in_group("player"):
		can_attack_player = true
		player = body


func _on_PlayerCloseDetectionArea_body_exited(body):
	if body.is_in_group("player"):
		can_attack_player = false
		player = null


func _on_PlayerNearDetectionArea_body_entered(body):
	if body.is_in_group("player"):
		player_is_near = true
		player = body


func _on_PlayerNearDetectionArea_body_exited(body):
	if body.is_in_group("player"):
		player_is_near = false
		player = null
		

func _on_AnimatedSprite_animation_finished():
	if _animated_sprite.animation == "Dead":
		self.queue_free()
	elif _animated_sprite.animation == "Hurt":
		_is_stunned = false
