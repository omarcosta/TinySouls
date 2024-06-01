extends Node

var gameover = false
var player_position: Vector2 # Posição global do jogador
var player_life_points: int = 0 # Vida do jogador
var player_life_points_max: int = 0 # Vida máxima do jogador
var enemies_defeated: int = 0 # Quantidade de inimigos derrotados

#func _process(delta):
	#player_life_points -= delta
	#print(player_life_points)


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_CTRL:
			reload_scene()

func reload_scene():
	# Caminho da cena que você deseja recarregar
	var scene_path = "res://scenes/tests/test_player.tscn"
	
	# Usa o método change_scene para recarregar a cena
	get_tree().change_scene_to_file(scene_path)
