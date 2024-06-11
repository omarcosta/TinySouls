extends Control

@onready var timer: Label = $Label
@onready var seconds: int = 0
@onready var minutes: int = 0


func _process(delta):
	if seconds >= 60:
		minutes += 1
		seconds = 0
	timer.text = "%02d:%02d" % [minutes, seconds]


func _on_timer_timeout():
	seconds += 1
