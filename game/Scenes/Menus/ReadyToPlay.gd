extends Control

onready var readyy = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Arrow
onready var notready = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Arrow

var current_selection = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_current_selection(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
	if Input.is_action_just_pressed("ui_down") and current_selection < 1:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)

func _on_ReadyButton_pressed():
	get_tree().change_scene("res://Scenes/World/World.tscn")

func _on_NotReadyButton_pressed():
	get_tree().change_scene("res://Scenes/Menus/Menu.tscn")

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_tree().change_scene("res://Scenes/World/World.tscn")
	elif _current_selection == 1:
		get_tree().change_scene("res://Scenes/Menus/Menu.tscn")
	elif _current_selection == 2:
		get_tree().quit()

func set_current_selection(_current_selection):
	readyy.text = ""
	notready.text = ""
	if _current_selection == 0:
		readyy.text = ">"
	elif _current_selection == 1:
		notready.text = ">"

