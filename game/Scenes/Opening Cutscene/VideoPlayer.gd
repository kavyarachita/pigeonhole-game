extends VideoPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	play() # Replace with function body.
	_wait()
#	get_tree().change_scene("res://Menu.tscn")

func _wait():
#	play()
	var t = Timer.new()
	t.set_wait_time(31.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
