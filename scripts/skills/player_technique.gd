extends Node

@onready var player: Player = get_parent() # Herda a classe Enemy definida no node principal CharacterBody2D
@onready var cooldown: Timer = $Timer

@export_category("technique settings")
@export var technique_prefab: PackedScene
@export var damage: int = 0
@export var cost_ammo: int = 1
@export_range(0,10) var reserve_ammo: int = 0 
@export var max_reserve_ammo: int = 10 # Defini o limite
@export_range(1,60) var inteval: int = 10

var is_available = false
var no_waiting = true
var has_ammo = true


func _ready():
	cooldown.wait_time = inteval
	GameManager.technique_interval = inteval
	GameManager.technique_reserve_ammo = reserve_ammo
	GameManager.technique_max_reserver_ammo = max_reserve_ammo # Defini o limite de munição
	player = get_parent()


func _process(delta: float) -> void:
	reserve_ammo = GameManager.technique_reserve_ammo
	if reserve_ammo >= cost_ammo:
		has_ammo = true
	else: 
		has_ammo = false
	is_available = has_ammo and no_waiting
	# GameManager.tecnique_reserve_ammo = reserve_ammo
	GameManager.technique_available = is_available
	if is_available:
		if Input.is_action_just_pressed("skill_technique"):
			var skill = technique_prefab.instantiate()
			skill.damage_amount = damage
			skill.position = player.global_position
			player.get_parent().add_child(skill)
			no_waiting = false
			reserve_ammo -= cost_ammo
			print(typeof(reserve_ammo))
			GameManager.technique_reserve_ammo = reserve_ammo
			cooldown.start()


func _on_timer_timeout():
	no_waiting = true
