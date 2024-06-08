extends Node

@onready var player: Player = get_parent() # Herda a classe Enemy definida no node principal CharacterBody2D
@onready var cooldown: Timer = $Timer

@export_category("technique settings")
@export var technique_prefab: PackedScene
@export var damage: int = 0
@export var cost_ammo: int = 1
@export_range(0,15) var reserve_ammo: int = 0
@export_range(1,60) var inteval: int = 1

var is_available = true
var has_ammo = true


func _ready():
	cooldown.wait_time = inteval
	player = get_parent()


func _process(delta: float) -> void:
	if reserve_ammo >= cost_ammo:
		has_ammo = true
	else: 
		has_ammo = false
	
	if has_ammo and is_available:	
		if Input.is_action_just_pressed("skill_technique"):
			var skill = technique_prefab.instantiate()
			skill.damage_amount = damage
			skill.position = player.global_position
			player.get_parent().add_child(skill)
			is_available = false
			reserve_ammo -= cost_ammo
			cooldown.start()


func _on_timer_timeout():
	is_available = true
