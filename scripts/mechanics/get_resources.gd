extends Node2D

@export var resource_type: String = ""
@export var regenerator: int = 0

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
			var player: Player = body
			player.get_resources(regenerator, resource_type)
			queue_free()
			
