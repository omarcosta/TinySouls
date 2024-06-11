extends Node2D

@export var damage_amount: int = 10


func deal_damage() -> void:
	var bodies = %Area2D.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			enemy.suffered_damage(damage_amount)

func audio_play():
	SoundManager.sound_effect_roar()
