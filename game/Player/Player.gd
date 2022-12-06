
extends KinematicBody2D

var GRAVITY = 35
const MAXFALLSPEED = 3000
var maxspeed = 500
const JUMPFORCE = 1150
var speed = 20
var usedflap = false
var prev_dir = false # True = Left, False = Right
var isAttacking = false

var ducky_retrieved = false
var knifeunlocked = false
# weapons
var weapon = 0
# 0 - peck, 1 - knife, 

var health = 100
var is_dead = false
var is_stunned = false
var is_immune = false
var can_attack = true
var game_over = false

var velocity = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		get_tree().change_scene("res://Scenes/World/World.tscn")
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
	if ducky_retrieved:
		game_over = true
		handle_win()
	elif is_dead:
		handle_death()
	elif is_stunned:
		play_hurt()
	if not game_over: 
		get_input()	
	velocity = move_and_slide(velocity, Vector2.UP)
	
func handle_win():
	if not is_on_floor():
		velocity.y += GRAVITY
	$Head.play("Head Win")
	$Butt.play("Win")
	#print("handling win")

func handle_death():
	$Head.play("Dead")
	
func _flip_hitboxes():
	scale.x *= -1

func _crouch():
	$CollisionShape2D2.position.y = -7
	$CollisionShape2D.position.y = 55
	$AttackRange/PeckRange.position.y = 45
	$AttackRange/PeckRange.scale.y = 0.9
	$AttackRange/KnifeRange.position.y = 20
	$AttackRange/KnifeRange.scale.y = 0.9
	$Head.position.y = -40
	
func _uncrouch():
	$CollisionShape2D2.position.y = -27
	$CollisionShape2D.position.y = 60
	$AttackRange/PeckRange.position.y = 40
	$AttackRange/PeckRange.scale.y = 1
	$AttackRange/KnifeRange.position.y = 10
	$AttackRange/KnifeRange.scale.y = 1
	$Head.position.y = -60

#func _attack():
#	isAttacking = true
#	for enemy in $Area2D.get_overlapping_bodies():
#		if enemy.is_in_group("hurtbox"):
#			print("something took damage")
#			enemy.take_damage(20)
		

func get_input():
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED
		
	velocity.x = clamp(velocity.x, -maxspeed, maxspeed)
	_uncrouch()
	
	if Input.is_action_just_pressed("attack") and can_attack and not is_stunned:		
		if weapon == 0:
			if $Head.animation != "Peck":
				$Head.play("Peck")
			$AttackRange/PeckRange.disabled = false
		elif weapon == 1:
			if $Head.animation != "Knife Attack":
				$Head.play("Knife Attack")
			$AttackRange/KnifeRange.disabled = false
		isAttacking = true
		can_attack = false
		$attack_delay.start() 
	if not isAttacking and not is_stunned:
		if weapon == 0:
			$Head.play("Head Idle")
		elif weapon == 1:
			$Head.play("Knife Idle")
	
	if Input.is_action_pressed("right"):
		if velocity.x < -maxspeed:
			velocity.x = maxspeed
		else:
			velocity.x += speed
		$Butt.play("Walk")
		if prev_dir:
			_flip_hitboxes()
		prev_dir = false
	elif Input.is_action_pressed("left"):
		if velocity.x > maxspeed:
			velocity.x = maxspeed
		else:
			velocity.x -= speed
		$Butt.play("Walk")
		if not prev_dir:
			_flip_hitboxes()
		prev_dir = true
	else:
		if Input.is_action_pressed("crouch"):
			$Butt.play("Crouch")
			_crouch()
		else:
			$Butt.play("Idle")
		velocity.x = lerp(velocity.x, 0, 0.2)
	
	if Input.is_action_pressed("run"):
		maxspeed = 600
	else: 
		maxspeed = 500
		
	if Input.is_action_just_pressed("knife") and knifeunlocked:
		weapon = 1
	elif Input.is_action_just_pressed("unequip"):
		weapon = 0
		
	if is_on_floor():
		usedflap = false
		if Input.is_action_just_pressed("jump"):
			velocity.y = -JUMPFORCE
	else: 
		$Butt.play("Falling")
		if usedflap == false and Input.is_action_just_pressed("jump"):
			velocity.y = -JUMPFORCE
			usedflap = true
		velocity.y += GRAVITY
		
func hurt(damage):
	health -= damage
	health = clamp(health, 0, 100)
	print("player hurt - current health ", health)
	get_parent().get_node("CanvasLayer/Label").text = ("HEALTH: " + str(health))
	is_stunned = true
	$stun_timer.start()
	if health <= 0:
		is_dead = true

func play_hurt():
	if $Head.animation != "Hurt":
		$Head.play("Hurt")
	$Butt.play("Hurt")

func _on_Head_animation_finished():
	if $Head.animation == "Head Win":
		get_tree().change_scene("res://Scenes/Won Cutscene/WonVideoPlayer.tscn")
	if $Head.animation == "Peck":
		$AttackRange/PeckRange.disabled = true
		isAttacking = false
	if $Head.animation == "Knife Attack":
		$AttackRange/KnifeRange.disabled = true
		isAttacking = false		
	if $Head.animation == "Dead":
		self.queue_free()
		game_over = true
		get_tree().change_scene("res://Scenes/Dead Cutscene/DeadVideoPlayer.tscn")


func _on_Area2D_body_entered(body):
	if body.is_in_group("hurtbox"):
		#print("something took damage")
		if weapon == 0:
			body.take_damage(10)
		elif weapon == 1:
			body.take_damage(25)

func _on_PickupRange_area_entered(area):
	if area.is_in_group("pickup"):
		if area.is_in_group("weapon"):
			if area.is_in_group("knife"):
				knifeunlocked = true
				area.get_parent().queue_free()
				weapon = 1
		elif area.is_in_group("item"):
			if area.is_in_group("ducky"):
				#print("duck won")
				ducky_retrieved = true
				area.get_parent().queue_free()


func _on_invincibility_timer_timeout():
	is_immune = false
	$invincibility_timer.stop()
	#print("invincibility end")
	


func _on_attack_delay_timeout():
	can_attack = true
	$attack_delay.stop()
	#print("attack delay end")


func _on_stun_timer_timeout():
	is_stunned = false
	$stun_timer.stop()
	$invincibility_timer.start()
	$Head.play("Head Idle")
	#print("stun end")
	is_immune = true
