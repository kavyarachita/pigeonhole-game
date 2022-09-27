extends KinematicBody2D

const SPEED = 10
var GRAVITY = 15
const MAXFALLSPEED = 600
const MAXSPEED = 100

var velocity = Vector2()

var dirleft = false

var loop = 0
var rng = RandomNumberGenerator.new()
var loopthres = 100
var idle = false

var health = 100
var isdead = false
var handlingdeath = false

func take_damage(dmg):
	print("damaged!!!")
	health -= dmg

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if health <= 0:
		isdead = true
	if isdead and not handlingdeath:
		handlingdeath = true
		loop = 0
		loopthres = 30
		$AnimatedSprite.flip_v = true
	elif isdead and handlingdeath:
		loop += 1
		if loop > loopthres:
			self.queue_free()
	else:
		loop += 1
		velocity = move_and_slide(velocity, Vector2.UP)
		
		if velocity.y > MAXFALLSPEED:
			velocity.y = MAXFALLSPEED
			
		if not is_on_floor():
			GRAVITY *= 1.009
			velocity.y += GRAVITY
		
		if dirleft and not idle:
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = false
			if velocity.x < -MAXSPEED:
				velocity.x = -MAXSPEED
			else:
				velocity.x -= SPEED
			if loop > loopthres:
				print("Left?: ",dirleft,"   Idle?: ",idle,"   loop/thres: ",loop,"/",loopthres)
				idle = true
				loopthres = rng.randf_range(10,100)
				dirleft = false
				loop = 0
		elif not dirleft and not idle:
			$AnimatedSprite.play("walk")
			$AnimatedSprite.flip_h = true
			if velocity.x > MAXSPEED:
				velocity.x = MAXSPEED
			else:
				velocity.x += SPEED
			if loop > loopthres:
				print("Left?: ",dirleft,"   Idle?: ",idle,"   loop/thres: ",loop,"/",loopthres)
				idle = true
				loopthres = rng.randf_range(10,100)
				loop = 0
				dirleft = true
		else:
			$AnimatedSprite.play("idle")
			velocity.x = lerp(velocity.x, 0, 0.2)
			if loop > loopthres:
				print("Left?: ",dirleft,"   Idle?: ",idle,"   loop/thres: ",loop,"/",loopthres)
				idle = false
				loopthres = rng.randf_range(100,300)
				loop = 0
