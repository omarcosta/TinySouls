extends Node2D

@export var mobs_list: Array[PackedScene]
@export var mobs_per_minute: float = 10

@onready var path_follow_2d: PathFollow2D = %PathFollow2D

var interval: float = 0.0
var cooldown: float = 0.0

func _process(delta: float):
	# Temporizador
	cooldown -= delta
	if cooldown > 0: return
	
	# Frequência
	interval = 60.0 / mobs_per_minute
	cooldown = interval
	
	# Intanciar uma criatuara
	var index = randi_range(0, mobs_list.size()-1)
	var mob_scene = mobs_list[index]
	var mob = mob_scene.instantiate()
	mob.global_position = get_point() # Chama a função que gera posição aleatória
	get_parent().add_child(mob) # Atribui a cena ao pai do SpawnMobs
	

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position
