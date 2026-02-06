extends Control
class_name EncounterProgressBar

signal value_changed(value: float)
signal threshold_reached(index: int)
signal finished_charging()

@export var max_value: float = 100.0
@export var threshold_count: int = 3
@export var smooth_speed: float = 8.0
@export var start_buffer: float = 0.5
@export var end_buffer: float = 0.5

@onready var fill := $Fill
var _fill_xsize : float

@onready var separator := $Separator

var _value := 0.0
var _triggers : Array[float] = []
var _display_value := 0.0

func _ready():
	_fill_xsize = fill.size.x
	_place_all_triggers()
	_place_all_separators()

func _process(delta):
	_display_value = lerp(_display_value, _value, delta * smooth_speed)
	_update_fill()

func add_value(delta: float):
	set_value(_value + delta)

func set_value(new_value: float):
	new_value = clamp(new_value, 0.0, max_value)
	if new_value == _value: return
	
	var oldval = _value
	_value = new_value
	_check_thresholds(oldval, new_value)
	emit_signal("value_changed", new_value)
	
	if new_value == max_value:
		emit_signal("finished_charging")

func _check_thresholds(oldval, newval):
	for i in threshold_count:
		if _triggers[i] < oldval or _triggers[i] > newval: 
			continue
		emit_signal("threshold_reached", i)

func _update_fill():
	var ratio := _display_value / max_value
	# this 0.375 it so fix a visual bug where the bar never fills fully
	# 0.375 is float friendly
	fill.size.x = _fill_xsize * ratio + 0.375

func _place_all_separators():
	var step = calc_pos_step(_fill_xsize)
	for i in threshold_count:
		var sep := separator.duplicate()
		add_child(sep)
		sep.visible = true
		sep.position.x = fill.position.x + calc_pos_offset(step, i)

func _place_all_triggers():
	var step = calc_pos_step(max_value)
	_triggers.resize(threshold_count)
	for i in threshold_count:
		_triggers[i] = calc_pos_offset(step,i)

func calc_pos_step(width):
	return width / (threshold_count-1 + start_buffer + end_buffer)

func calc_pos_offset(step, i):
	return step * (i + start_buffer)
