extends Node2D

@export var health_regenerator: int = 0


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
			var player: Player = body
			player.helth_regenerator_by_resources(health_regenerator)
			queue_free()
			
	
	
