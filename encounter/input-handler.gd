extends Node

@onready var action_bar : EncounterProgressBar = $"../UI/ActionBar"

func _process(delta):
	action_bar.add_value(delta)
	
