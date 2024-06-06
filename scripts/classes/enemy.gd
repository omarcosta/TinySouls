class_name Enemy
extends Node2D

@export_category("Enemy")
@export_group("Enemy attributes")
@export var health: int = 0
@export var damage: int = 0
@export var speed:  float = 0.0 # Será multiplicada por 100

@export_group("Prefabs")
@export var view_damage_prefab: PackedScene
@export var death_prefab: PackedScene

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func suffered_damage(amount: int) -> void: 
	health -= amount
	reaction_to_damage()
	
	
	# View Damage
	var view_damage = view_damage_prefab.instantiate()
	view_damage.value = amount
	if %ViewDamageMarker:
		view_damage.global_position = %ViewDamageMarker.global_position
	else:
		view_damage.global_position = global_position
	get_parent().add_child(view_damage) # Coloca a cena no node que executa o script 
	
	
	
	# Enemy death
	if health <= 0:
		die()
	
	
func die() -> void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		# death_object.scale = scale
		get_parent().add_child(death_object)
	GameManager.enemies_defeated += 1
	queue_free()


func reaction_to_damage() -> void:
	modulate = Color.FIREBRICK
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)

