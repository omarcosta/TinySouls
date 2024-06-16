extends Control

@onready var count_waves: int = 0
@onready var death_label: Label = %CountWavesLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.gameover == false: 
		death_label.text = str(GameManager.enemies_defeated)
