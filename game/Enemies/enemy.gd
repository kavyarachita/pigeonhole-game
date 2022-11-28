extends KinematicBody2D

const SPEED = 10
var GRAVITY = 25
const MAXFALLSPEED = 600
const MAXSPEED = 100
const MAXCHASESPEED = 200
var health = 50
var _is_facing_left = true

var velocity = Vector2()
var _is_dying = false
var _is_stunned = false
var mob_damage = 2
var just_attacked = false

onready var _animated_sprite: AnimatedSprite = $AnimatedSprite
onready var _collision_shape: CollisionShape2D = $CollisionShape2D
onready var _player_close_area: Area2D = $PlayerCloseDetectionArea
onready var _player_near_area: Area2D = $PlayerNearDetectionArea
onready var _attack_wait_timer: Timer = $attack_timer

var player_is_near := false
var can_attack_player := false
var player: KinematicBody2D

func take_damage(dmg):
	print("damaged!!!")
	_is_stunned = true
	health -= dmg

func turn_around() -> void:
	scale.x *= -1
	_is_facing_left = !_is_facing_left


func move_towards_player() -> void:
	_move(MAXCHASESPEED)


func move_forward() -> bool:
	return _move(MAXSPEED)


func idle() -> void:	
	if _animated_sprite.animation != "Idle" or !_animated_sprite.playing:
		_animated_sprite.speed_scale = 1.0
		_animated_sprite.play("Idle")


func turn_towards_player():
	if player:
		var dist = player.global_position.x - global_position.x
		if (dist > 0 and _is_facing_left) or (dist <= 0 and not _is_facing_left):
			turn_around()


func is_dead() -> bool:
	return health <= 0

func is_stunned() -> bool:
	return _is_stunned

func hurt_by_player() -> void:
	_is_dying = true

func die() -> void:
	if _animated_sprite.animation == "Dead":
		return
	_animated_sprite.speed_scale = 1.0
	_animated_sprite.play("Dead")
	_collision_shape.disabled = true

func stun() -> void:
	if _animated_sprite.animation != "Hurt" or !_animated_sprite.playing:
		_animated_sprite.speed_scale = 1.0
		_animated_sprite.play("Hurt")
	

func _get_player() -> Node2D:
	return player

func attack() -> bool:
	if player:
		player.hurt(mob_damage)
		if _animated_sprite.animation != "Attack" or !_animated_sprite.playing:
			_animated_sprite.speed_scale = 1.0
			_animated_sprite.play("Attack")
		return true
	return false

func _move(speed: float) -> bool:
	velocity.x = speed
	
	if (_is_facing_left and velocity.x > 0) or (not _is_facing_left and velocity.x < 0):
		velocity.x *= -1.0
	
	if not is_on_floor():
		GRAVITY *= 1.009
		velocity.y += GRAVITY
	
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED
	
	if _animated_sprite.animation != "Walk":
		_animated_sprite.play("Walk")
	
	var speed_scale = abs(velocity.x) / MAXSPEED
	if _animated_sprite.speed_scale != speed_scale:
		_animated_sprite.speed_scale = speed_scale
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	return !is_on_wall()
