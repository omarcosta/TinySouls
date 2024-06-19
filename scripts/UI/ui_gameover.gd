extends CanvasLayer

@onready var label_time: Label = %Time
@onready var label_defeat: Label = %Defeat
@onready var label_restart: Label = %LabelRestart

var cooldown_restart: float = 7.0

func _ready():
	label_time.text = str(GameManager.game_time)
	label_defeat.text = str(GameManager.enemies_defeated)
	
func _process(delta):
	cooldown_restart -= delta
	if cooldown_restart > 0:
		label_restart.text = str("Restarting game in ", ceil(cooldown_restart), " seconds")
	else: 
		label_restart.text = "Press ATTACK to play again"
