extends Node

# Game control
@onready var gameover = false

# Player
@onready var player_position: Vector2 # Posição global do jogador
@onready var player_life_points: int = 100 # Vida do jogador
@onready var player_life_points_max: int = 100 # Vida máxima do jogador
@onready var player_stamina_points: int = 100 # Vida do jogador
@onready var player_stamina_points_max: int = 100 # Vida máxima do jogador
@onready var player_magic_points: int = 100 # Vida do jogador
@onready var player_magic_points_max: int = 100 # Vida máxima do jogador

# Stage
@onready var waves: int = 0 # Ondas de inimigos
@onready var enemies_defeated: int = 0 # Quantidade de inimigos derrotados

func _process(delta):
	player_lives()
	# player_life_points -= delta/100
	# player_stamina_points -= delta/100
	# player_magic_points -= delta/100
	

func player_lives() -> void:
	if player_life_points <= 0:
		gameover = true

#func _input(event):
	#if event is InputEventKey:
		#if event.pressed and event.keycode == KEY_CTRL:
			#reload_scene()
#
#func reload_scene():
	## Caminho da cena que você deseja recarregar
	#var scene_path = "res://scenes/tests/test_player.tscn"
	#
	## Usa o método change_scene para recarregar a cena
	#get_tree().change_scene_to_file(scene_path)
