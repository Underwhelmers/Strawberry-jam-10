extends Node

@onready var action_bar : EncounterProgressBar = $"../UI/ActionBar"

func _ready():
	action_bar.threshold_reached.connect(threshold_reached)

func _process(delta):
	action_bar.add_value(delta)
	
func threshold_reached(val: int):
	print_debug("We reached threshold: ", val)
