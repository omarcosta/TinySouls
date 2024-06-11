extends Node2D

@export var damage_amount: int = 0


func deal_damage() -> void:
	var bodies = %Area2D.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			enemy.suffered_damage(damage_amount) # 100% do dano
		if body.is_in_group("player"):
			var player: Player = body
			player.suffered_damage(damage_amount/2) # 50% do dano


func audio_explosion_play():
	SoundManager.sound_effect_explosive_barrel()
