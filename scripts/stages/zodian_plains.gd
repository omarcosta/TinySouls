extends Node

@onready var spawn_wave_one: Path2D = $WaveOne/Path2D
@onready var spawn_wave_survival: Path2D = $WaveSurvival/Path2D
# @onready var block_point_wave_survival: Node2D = $WaveSurvival/BlockPoint

# @onready var block_point_wave_survival_collision: CollisionShape2D = $WaveSurvival/BlockPoint/StaticBody2D/CollisionShape2D

func _ready():
	spawn_wave_one.enable = true
	# block_point_wave_survival.visible = false
	# block_point_wave_survival_collision.disabled = !block_point_wave_survival_collision.disabled


func _on_area_2d_body_entered(body):
	if not spawn_wave_survival.enable:
		if body.is_in_group("player"):
			# var block_point_position: Vector2 = (1240, 310)
			create_block_point(Vector2(1240, 310), $WaveSurvival)
			# (1240, 310)
			# block_point_wave_survival.visible = true
			# block_point_wave_survival_collision.disabled = !block_point_wave_survival_collision.disabled
			# print(block_point_wave_survival_collision.disabled)
			spawn_wave_survival.enable = true
		

func create_block_point(position_bk: Vector2, father):
	var block_point_scene = preload("res://scenes/misc/block_point.tscn")
	var block_point = block_point_scene.instantiate()
	block_point.position = position_bk
	block_point.need_to_defeat = 1000000
	father.add_child(block_point) 

func _on_timer_timeout():
	spawn_wave_survival.mobs_per_minute += 1
	# print(spawn_wave_survival.mobs_per_minute)
	# Replace with function body.
