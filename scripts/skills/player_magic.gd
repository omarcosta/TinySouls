class_name Magic
extends Node

@onready var player: Player = get_parent() # Herda a classe Enemy definida no node principal CharacterBody2D
@onready var stopwatch: Timer = $Timer

@export_category("Magic settings")
@export var magic_prefab: PackedScene
@export var damage: int = 0
@export var cost: int = 0
@export_range(1,60) var interval: int = 10

var is_available = false
var no_waiting = true
var has_mp = true


func _ready():
	stopwatch.wait_time = interval
	GameManager.magic_interval = interval
	player = get_parent()
	#sprite = enemy.get_node("AnimatedSprite2D")


func _process(delta: float) -> void:
	if player.magic >= cost:
		has_mp = true
	else: 
		has_mp = false
	#if has_mp and  no_waiting:
	is_available = has_mp and no_waiting
	GameManager.magic_available = is_available
	if is_available:
		if Input.is_action_just_pressed("skill_magic"):
			var skill = magic_prefab.instantiate()
			skill.damage_amount = damage
			# skill.position = player.global_position
			get_parent().add_child(skill)
			no_waiting = false
			player.magic -= cost
			stopwatch.start()
	if not is_available:
		if Input.is_action_just_pressed("skill_magic"):
			SoundManager.sound_effect_error()

func _on_timer_timeout():
	no_waiting = true
