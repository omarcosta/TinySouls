extends Node2D

@export var mobs_list: Array[PackedScene]

func _ready():
	spawn_enemys()


func spawn_enemys() -> void:
	
	var path = $Path2D
	var curve = path.curve

	for mob in mobs_list:
		for i in range(curve.get_point_count()):
			var point_position = curve.get_point_position(i)
			var instance = mob.instantiate()
			add_child(instance)
			instance.global_position = point_position
