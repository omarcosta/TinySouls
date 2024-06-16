extends Node2D

#@export_enum("Path points","Path follow") var function = "Path points"
@export var mobs_list: Array[PackedScene]
@export var mobs_per_minute: float = 10
@export var mobs_total: int = 0 # Zero for infinit mobs
@export var enable: bool = false

# @onready var path_follow_2d: PathFollow2D = $PathFollow2D
# @onready var path = $Path2D
var interval: float = 0.0 # Mobs por segundo
var cooldown: float = 0.0 # Temporizador
var mobs_count: int = 0
var being_spawn: bool= true

func _process(delta: float):
	# Se o invocador está ativado
	if not enable: return
	
	# se o jogo acabar, mata todos os monstros
	if GameManager.gameover == true:
		queue_free()
	
	# limite de invoção
	if mobs_total != 0:
		if mobs_count >= mobs_total:
			return
	
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
	add_child(mob) # Atribui atribui um mob no SpawnMobs
	mobs_count += 1


func get_point() -> Vector2:
	
	var curve = self.curve
	var index = randi_range(0,curve.get_point_count()-1)
	print(curve.get_point_count())
	var point_position = curve.get_point_position(index)
	return point_position
	
	# Spawn on Path follow
	# path_follow_2d.progress_ratio = randf()
	# return path_follow_2d.global_position



#func _ready():
	#spawn_enemys()
#
#
#func spawn_enemys() -> void:
	#
	#var path = $Path2D
	#var curve = path.curve
#
	#for mob in mobs_list:
		#for i in range(curve.get_point_count()):
			#var point_position = curve.get_point_position(i)
			#var instance = mob.instantiate()
			#instance.global_position = point_position
			#add_child(instance)
