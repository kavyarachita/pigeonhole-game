extends KinematicBody2D

var GRAVITY = 35
const MAXFALLSPEED = 3000
const MAXSPEED = 500
const JUMPFORCE = 1000
var SPEED = 20
var usedflap = false

var velocity = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Menu.tscn")
	
	get_input()	
	velocity = move_and_slide(velocity, Vector2.UP)

func get_input():
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED
	
	velocity.x = clamp(velocity.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("right"):
		if velocity.x < -MAXSPEED:
			velocity.x = MAXSPEED
		else:
			velocity.x += SPEED
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("left"):
		if velocity.x > MAXSPEED:
			velocity.x = MAXSPEED
		else:
			velocity.x -= SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Walk")
	else:
		if Input.is_action_pressed("crouch"):
			$AnimatedSprite.play("Crouch")
		else:
			$AnimatedSprite.play("Idle")
		velocity.x = lerp(velocity.x, 0, 0.2)
		
	if is_on_floor():
		usedflap = false
		if Input.is_action_just_pressed("jump"):
			velocity.y = -JUMPFORCE
	else: 
		if usedflap == false and Input.is_action_just_pressed("jump"):
			velocity.y = -JUMPFORCE
			usedflap = true
		velocity.y += GRAVITY
	

func _on_Area2D_body_entered(body):
	print("something hit")
	if body.is_in_group("hurtbox"):
		print("sometihin took damage")
		body.take_damage(35)
