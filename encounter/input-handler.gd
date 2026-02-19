extends Node
class_name InputHandler

signal combo_casted(String)

var comboing := false
var current_combo := ""
@onready var action_bar : EncounterProgressBar = $"../UI/ActionBar"

func _ready():
	action_bar.threshold_reached.connect(threshold_reached)
	action_bar.finished_charging.connect(cast_combo)

func _process(delta):
	if comboing: action_bar.add_value(delta)
	elif Input.is_action_just_pressed("ui_left"): start_combo()
	elif Input.is_action_just_pressed("ui_right"): start_combo()
	elif Input.is_action_just_pressed("ui_up"): start_combo()
	elif Input.is_action_just_pressed("ui_down"): start_combo()

func threshold_reached(_val: int):
	if Input.is_action_pressed("ui_left"):
		current_combo += "L"
	elif Input.is_action_pressed("ui_right"):
		current_combo += "R"
	elif Input.is_action_pressed("ui_up"):
		current_combo += "U"
	elif Input.is_action_pressed("ui_down"):
		current_combo += "D"
	else: 
		cast_combo()

func start_combo():
	current_combo = ""
	comboing = true
	action_bar.visible = true

func cast_combo():
	print("Combo: ", current_combo)
	combo_casted.emit(current_combo)
	comboing = false
	action_bar.visible = false
	action_bar.set_value(0.0)
