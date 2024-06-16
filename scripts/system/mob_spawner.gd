class_name MobSpawner
extends Node2D

@export var mobs_list: Array[PackedScene]
@export var mobs_per_minute: float = 5

@onready var path_follow_2d: PathFollow2D = %PathFollow2D

var interval: float = 0.0 # Mobs por segundo
var cooldown: float = 0.0 # Temporizador

func _process(delta: float):
	# Temporizador
	cooldown -= delta
	if cooldown > 0: return
	
	# Frequência
	interval = 60.0 / mobs_per_minute
	cooldown = interval
	
	# Checa se o ponto é válido (sem nenhuma colissão
	var point: Vector2 = get_point()
	var world_state = get_world_2d().direct_space_state # Pega todas as collisoes acontencendo no jogo
	var parameters = PhysicsPointQueryParameters2D.new() # Cria um parametro paseado em ponto (coordenada) em um ambiente 2D
	parameters.position = point 
	# parameters.collision_mask = 0b1001 # Passa a mascara de colisão em BIT, nesse caso layer 1 e 4
	var result: Array = world_state.intersect_point(parameters, 2) # Cria uma lista de collisoes no ponto gerado aleatoriamente
	if not result.is_empty(): return # Não cria mosntros se tiver colisão no ponto gerado
	
	# Intanciar uma criatuara
	var index = randi_range(0, mobs_list.size()-1)
	var mob_scene = mobs_list[index]
	var mob = mob_scene.instantiate()
	mob.global_position = point # Chama a função que gera posição aleatória
	get_parent().add_child(mob) # Atribui a cena ao pai do SpawnMobs
	

func get_point() -> Vector2:
	path_follow_2d.progress_ratio = randf()
	return path_follow_2d.global_position
