extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		"""
		Pauses or unpauses everything. Makes pause screen visible/invisible
		"""
		var new_pause_state = not get_tree().paused 
		get_tree().paused = new_pause_state
		visible = new_pause_state
	
func _physics_process(delta):
	if Input.is_action_just_pressed("esc"):
		"""
		Unpauses game if paused and goes to menu
		"""
		get_tree().paused = false
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")

func _on_StartPauseButton_pressed(): #pressing the Start button will start the game
	get_tree().paused = false
	visible = false

func _on_MenuButton_pressed():
	get_tree().paused = false 
	get_tree().change_scene("res://Scenes/Menus/Menu.tscn")

func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/World/World.tscn")


func _on_PauseButton_pressed():
	var new_pause_state = not get_tree().paused 
	get_tree().paused = new_pause_state
	visible = new_pause_state
