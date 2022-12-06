extends VideoPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	play() # Replace with function body.
	_wait()
#	get_tree().change_scene("res://Menu.tscn")

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
#	if Input.is_action_just_pressed("ui_accept"):
#		get_tree().change_scene("res://Scenes/Menus/ReadyToPlay.tscn")

func _wait():
#	play()
	var t = Timer.new()
	t.set_wait_time(33)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_SkipToMenu_pressed():
	get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
