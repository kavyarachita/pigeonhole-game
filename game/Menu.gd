extends Control

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Arrow
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Arrow
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Arrow

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


func _on_StartButton_pressed(): #pressing the Start button will start the game
	get_tree().change_scene("res://World.tscn")

func _on_OptionsButton_pressed(): #pressing the options button should show a static image of options
	var options = load("res://Menus/Options.tscn").instance()
	get_tree().current_scene.add_child(options)

func _on_QuitButton_pressed():
	get_tree().quit()

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_tree().change_scene("res://World.tscn")
	elif _current_selection == 1:
		var options = load("res://Menus/Options.tscn").instance()
		get_tree().current_scene.add_child(options)
	elif _current_selection == 2:
		get_tree().quit()

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
