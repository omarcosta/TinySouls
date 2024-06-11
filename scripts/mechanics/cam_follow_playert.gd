extends Camera2D

@onready var area2d: Area2D = $Area2D

var areas
var player_position: Vector2
var find_player: bool = false

	
func _physics_process(delta):
	
	if not find_player: 
		var bodies = $Area2D.get_overlapping_bodies() # Obtem todos os corpos f[isicos na area. Pode ser mudado para pegar a area
		for body in bodies:
			if body.is_in_group("player"):
				position = lerp(position,GameManager.player_position,0.1)
				find_player = true
			else:
				position = GameManager.player_position
	
	
	
	#if not find_player: 
		#var bodies = $Area2D.get_overlapping_bodies() # Obtem todos os corpos f[isicos na area. Pode ser mudado para pegar a area
		#for body in bodies:
			#if body.is_in_group("player"):
				#position = GameManager.player_position
				#find_player = true
			#else:
				#position = GameManager.player_position
			

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_position = GameManager.player_position
		position = lerp(position,player_position,0.1)
