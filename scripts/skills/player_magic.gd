extends Node

@onready var player: Player = get_parent() # Herda a classe Enemy definida no node principal CharacterBody2D
@onready var cooldown: Timer = $Timer

@export_category("Magic settings")
@export var magic_prefab: PackedScene
@export var damage: int = 0
@export var cost: int = 0
@export_range(1,60) var inteval: int = 10

var is_available = true
var has_mp = true


func _ready():
	cooldown.wait_time = inteval
	player = get_parent()
	#sprite = enemy.get_node("AnimatedSprite2D")


func _process(delta: float) -> void:
	if player.magic >= cost:
		has_mp = true
	else: 
		has_mp = false
	if has_mp and is_available:
		
		if Input.is_action_just_pressed("skill_magic"):
			var skill = magic_prefab.instantiate()
			skill.damage_amount = damage
			# skill.position = player.global_position
			get_parent().add_child(skill)
			is_available = false
			player.magic -= cost
			cooldown.start()


func _on_timer_timeout():
	is_available = true
