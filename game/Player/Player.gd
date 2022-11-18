extends KinematicBody2D

var GRAVITY = 35
const MAXFALLSPEED = 3000
var maxspeed = 500
const JUMPFORCE = 1000
var speed = 20
var usedflap = false
var prev_dir = false # True = Left, False = Right
var isAttacking = false

var knifeunlocked = false
# weapons
var weapon = 0
# 0 - peck, 1 - knife, 

var velocity = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
	
	get_input()	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
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
	
	if Input.is_action_just_pressed("attack"):
		print("attacking")
		
		if weapon == 0:
			$Head.play("Peck")
			$AttackRange/PeckRange.disabled = false
		elif weapon == 1:
			$Head.play("Knife Attack")
			$AttackRange/KnifeRange.disabled = false
		isAttacking = true
		
	if not isAttacking:
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
		if usedflap == false and Input.is_action_just_pressed("jump"):
			velocity.y = -JUMPFORCE
			usedflap = true
		velocity.y += GRAVITY


func _on_Head_animation_finished():
	if $Head.animation == "Peck":
		$AttackRange/PeckRange.disabled = true
		isAttacking = false
	if $Head.animation == "Knife Attack":
		$AttackRange/KnifeRange.disabled = true
		isAttacking = false


func _on_Area2D_body_entered(body):
	if body.is_in_group("hurtbox"):
		print("something took damage")
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
