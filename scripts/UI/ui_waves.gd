extends Control

@onready var count_waves: int = 0
@onready var waves_label: Label = %CountWavesLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.gameover == false: 
		waves_label.text = str(GameManager.waves)
