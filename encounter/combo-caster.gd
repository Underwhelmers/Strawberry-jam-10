extends Node

@onready var handler : InputHandler = $"../InputHandler"

func _ready():
	handler.combo_casted.connect(interpret_combo)

func interpret_combo(combo: String):
	match combo:
		"UD": thrust()
		"DU": sway()
		"UUDD": ram()
		

func thrust():
	print("Casted Thrust")

func sway():
	print("Casted Sway")

func ram():
	print("Casted ram")
	
