extends Button

@export var next_room: PackedScene

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if !next_room:
		push_error("Next room scene not assigned!")
		return
	get_tree().change_scene_to_packed(next_room)
