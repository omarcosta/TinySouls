extends Node

@onready var audio_tracks_scene = preload("res://scenes/audio_tracks.tscn")

var mute: bool = true

# Game audio
var audio_tracks: Node
var audio_game_track: int = 0
var audio_game_track_1: AudioStreamPlayer
var audio_game_track_2: AudioStreamPlayer
var audio_game_track_3: AudioStreamPlayer

# Player audio
var audio_atk_weak: AudioStreamPlayer
var audio_atk_strong: AudioStreamPlayer
var audio_heartbeats: AudioStreamPlayer
var audio_explosive_barrel: AudioStreamPlayer
var audio_magic_roar: AudioStreamPlayer
var audio_take_damage: AudioStreamPlayer
var audio_not_stamina: AudioStreamPlayer
var audio_death: AudioStreamPlayer

# System
var audio_system_error: AudioStreamPlayer
var audio_system_pop: AudioStreamPlayer


func _ready():
	# Create node
	audio_tracks = audio_tracks_scene.instantiate()
	self.add_child(audio_tracks)
	
	# Game
	audio_game_track_1 = audio_tracks.get_node("GameMusic_1")
	audio_game_track_2 = audio_tracks.get_node("GameMusic_2")
	audio_game_track_3 = audio_tracks.get_node("GameMusic_3")
	
	# Player
	audio_atk_weak = audio_tracks.get_node("AtkWeak")
	audio_atk_strong = audio_tracks.get_node("AtkStrong")
	audio_heartbeats = audio_tracks.get_node("Heart")
	audio_explosive_barrel = audio_tracks.get_node("ExplosiveBarrel")
	audio_magic_roar = audio_tracks.get_node("WarriorRoar")
	audio_take_damage = audio_tracks.get_node("TakeDamage")
	audio_not_stamina = audio_tracks.get_node("NotStamina")
	audio_death = audio_tracks.get_node("Death")
	
	# System
	audio_system_error = audio_tracks.get_node("Error")
	audio_system_pop = audio_tracks.get_node("Pop")
	

func _process(delta):
	if not mute:
		# Verifica se alguma faixa de ambiente está tocando
		if !audio_game_track_1.playing and !audio_game_track_2.playing and !audio_game_track_3.playing:
			environment_music_play()
		# Sons de batida de coração
		heartbeats()
	else: 
		audio_game_track_1.stop()
		audio_game_track_2.stop()
		audio_game_track_3.stop()
		audio_heartbeats.stop()
		


func environment_music_play() -> void:
	match audio_game_track:
		1:
			audio_game_track_1.play()
			audio_game_track = 2
			print(audio_game_track)
		2:
			audio_game_track_2.play()
			audio_game_track = 3
			print(audio_game_track)
		3:
			audio_game_track_3.play()
			audio_game_track = 1
			print(audio_game_track)
		_:
			audio_game_track = 1
			print(audio_game_track)


func heartbeats():
	if GameManager.player_life_points < (GameManager.player_life_points_max * 0.1):
		if !audio_heartbeats.playing:
			audio_heartbeats.play()
	else: 
		if audio_heartbeats.playing:
			audio_heartbeats.stop()


# Sounds Effects - Invoked of other scenes

func sound_effect_explosive_barrel():
	if not mute:
		audio_explosive_barrel.play()


func sound_effect_roar():
	if not mute:
		audio_magic_roar.play()
		

func sound_effect_player_atk(type: String):
	if not mute:
		if type == "weak":
			audio_atk_weak.play()
		elif type == "strong":
			audio_atk_strong.play()


func sound_effect_player_not_stamina():
	if not mute:
		if not audio_not_stamina.playing:
			audio_not_stamina.play()


func sound_effect_player_received_damage():
	if not mute:
		audio_take_damage.play()


func sound_effect_player_death():
	if not mute:
		audio_death.play()


func sound_effect_error():
	if not mute:
		audio_system_error.play()


func sound_effect_pop():
	if not mute:
		audio_system_pop.play()
