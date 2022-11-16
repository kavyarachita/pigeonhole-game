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
		get_tree().change_scene("res://Menu.tscn")

#onready var selector_one = $CanvasLayer/Pause/CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Label
#onready var selector_two = $CanvasLayer/Pause/CenterContainer/VBoxContainer/CenterContainer4/VBoxContainer/CenterContainer/HBoxContainer/Label
#onready var selector_three = $CanvasLayer/Pause/CenterContainer/VBoxContainer/CenterContainer3/VBoxContainer/CenterContainer/HBoxContainer/Label
"""
var current_selection = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_current_selection(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 2:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)

"""
func _on_StartPauseButton_pressed(): #pressing the Start button will start the game
	get_tree().paused = false
	visible = false

func _on_MenuButton_pressed():
	get_tree().paused = false 
	get_tree().change_scene("res://Menu.tscn")

func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://World.tscn")

"""
func handle_selection(_current_selection):
	if _current_selection == 0:
		get_tree().paused = false
	elif _current_selection == 1:
		get_tree().change_scene("res://Menu.tscn")
	elif _current_selection == 2:
		get_tree().change_scene("res://World.tscn")
		
func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
"""
