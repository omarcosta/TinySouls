extends Node

@export var mob_spawner: MobSpawner
@export var initial_spawn_rate: float = 60.0 # Valor inicial do MobSpawner
@export var spawn_rate_per_minute: float = 30.0 # incremento do MobSpawner por minuto
@export_category("Wave intensity")
@export var wave_duration: float = 20.0 # Duração da onda
@export_range(0,1) var break_intensity_min: float = 0.5 # Min Intensidade/ tamanho da onda percentual
@export_range(0,1) var break_intensity_max: float = 1.0 # MAX Intensidade/ tamanho da onda percentual

var time: float = 0.0


func _process(delta):
	time += delta
	
	# Dificuldade linear com passsar do tempo
	var spawn_rate = initial_spawn_rate + spawn_rate_per_minute * (time / 60.0)
	
	# Sistema de dificuldade por ondas
	var sin_wave = sin((time * TAU) / wave_duration) # Cria uma onda senoidal, TAU = 2 * PI
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_intensity_min, break_intensity_max)
	
	# Transforma a dificuldade linear em uma dificuldade por onda senoidal
	spawn_rate *= wave_factor 
	
	# Aplica a dificuldade
	mob_spawner.mobs_per_minute = spawn_rate
