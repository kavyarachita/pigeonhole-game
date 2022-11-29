extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")


func _on_BackButton_pressed():
	get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
