extends Node2D

@onready var block_point: AnimationPlayer = $AnimationPlayer
@export var need_to_defeat: int = 0
# @onready var BK = $StaticBody2D/CollisionShape2D

var is_clean_path: bool = false
var enemies_defeated: int = 0

func _process(delta):
	enemies_defeated = GameManager.enemies_defeated
	if !is_clean_path:
		clean_path()
	# print(BK.disabled)

func clean_path() -> void:
	if enemies_defeated >= need_to_defeat and block_point:
		block_point.play("Go")
		is_clean_path = true
