extends VideoPlayer


var aspect_ratio = 16.0/9.0


# Called when the node enters the scene tree for the first time.
func _ready():
	var vsize = get_viewport_rect().size
	get_parent().get_node("ColorRect").set_size(vsize)
	
	if vsize.y < vsize.x/aspect_ratio:
		set_size(Vector2(vsize.y * aspect_ratio, vsize.y))
		set_position(Vector2((vsize.x - vsize.y * aspect_ratio)/2.0))
	else:
		set_size(Vector2(vsize.x, vsize.x/aspect_ratio))
		set_position(Vector2(0, (vsize.y - vsize.x / aspect_ratio)/2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_VideoPlayer_finished():
	get_parent().queue_free()
	get_tree().change_scene("res://Cut Scenes/CutSceneMenu.tscn")

func _on_SkipButton_pressed():
	get_parent().queue_free()
	get_tree().change_scene("res://Cut Scenes/CutSceneMenu.tscn")
