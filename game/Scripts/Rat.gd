extends KinematicBody2D

const SPEED = 10
var GRAVITY = 25
const MAXFALLSPEED = 600
const MAXSPEED = 100

var velocity = Vector2()

var dirleft = true
var prev_dir = true # True = Left, False = Right
var loop = 0
var rng = RandomNumberGenerator.new()
var loopthres = 100
var idle = false

var health = 100
var isstunned = false

func take_damage(dmg):
	print("damaged!!!")
	$AnimatedSprite.play("Hurt")
	isstunned = true
	health -= dmg

func _flip_hitboxes():
	scale.x = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if health <= 0:
		$AnimatedSprite.play("Dead")
	else:
		loop += 1
		velocity = move_and_slide(velocity, Vector2.UP)
		
		if velocity.y > MAXFALLSPEED:
			velocity.y = MAXFALLSPEED
			
		if not is_on_floor():
			GRAVITY *= 1.009
			velocity.y += GRAVITY
		
		if dirleft and not idle:
			$AnimatedSprite.play("Walk")		
			if velocity.x < -MAXSPEED:
				velocity.x = -MAXSPEED
			else:
				velocity.x -= SPEED
			if not prev_dir:
				_flip_hitboxes()
			prev_dir = true
			if loop > loopthres:
				#print("Left?: ",dirleft,"   Idle?: ",idle,"   loop/thres: ",loop,"/",loopthres)
				idle = true
				loopthres = rng.randf_range(10,100)
				dirleft = false
				loop = 0
		elif not dirleft and not idle:
			$AnimatedSprite.play("Walk")
			if velocity.x > MAXSPEED:
				velocity.x = MAXSPEED
			else:
				velocity.x += SPEED
			if prev_dir:
				_flip_hitboxes()
			prev_dir = false
			if loop > loopthres:
				#print("Left?: ",dirleft,"   Idle?: ",idle,"   loop/thres: ",loop,"/",loopthres)
				idle = true
				loopthres = rng.randf_range(10,100)
				loop = 0
				dirleft = true
		elif not isstunned:
			$AnimatedSprite.play("Idle")
			velocity.x = lerp(velocity.x, 0, 0.2)
			if loop > loopthres:
				#print("Left?: ",dirleft,"   Idle?: ",idle,"   loop/thres: ",loop,"/",loopthres)
				idle = false
				loopthres = rng.randf_range(100,300)
				loop = 0


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Hurt":
		isstunned = false
	if $AnimatedSprite.animation == "Dead":
		self.queue_free()
				
