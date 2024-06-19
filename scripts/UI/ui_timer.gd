extends Control

@onready var timer: Label = $Label
@onready var seconds: int = 0
@onready var minutes: int = 0


func _process(delta):
	if GameManager.gameover == true : 
		# Update the time in the GameManager
		GameManager.game_time = "%02d:%02d" % [minutes, seconds]
		GameManager.game_time_minutes = minutes
		GameManager.game_time_seconds = seconds
		queue_free()
	
	if seconds >= 60:
		minutes += 1
		seconds = 0
	timer.text = "%02d:%02d" % [minutes, seconds]


func _on_timer_timeout():
	seconds += 1
