extends "res://Enemies/enemy.gd"

var rng = RandomNumberGenerator.new()

func _ready():
	health = 75
	mob_damage = 5


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
	if _animated_sprite.animation == "Hurt":
		_is_stunned = false
	if _animated_sprite.animation == "Attack":
		$attack_timer.start()
		idle()

func _on_attack_timer_timeout():
	just_attacked = false
	$attack_timer.stop()

func _on_idle_timer_timeout():
	turn_around()
	pace = true
	idle = false
	$pace_timer.wait_time = rng.randf_range(3,10)
	$idle_timer.stop()
	$pace_timer.start()


func _on_pace_timer_timeout():
	idle = true
	pace = false
	$pace_timer.stop()
	$idle_timer.start()
