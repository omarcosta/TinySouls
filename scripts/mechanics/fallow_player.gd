extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var speed: float = 1
# @export var player: PackedScene

var player_position: Vector2 = Vector2(0, 0) # Posição do PLAYER
var input_direction: Vector2 = Vector2(0, 0) # Vector da diferença entre a posição do PLAYER e do ENEMY
var target_velocity: Vector2 = Vector2(0, 0) # Velocidade final que será suavidada em VELOCITY


func _process(delta: float) -> void:
	rotate_sprite()


func _physics_process(delta: float) -> void:
	player_position = GameManager.player_position
	input_direction = player_position - position  
	target_velocity = input_direction.normalized() * speed * 100.0
	velocity = lerp(velocity, target_velocity, 0.2)
	move_and_slide() 


func rotate_sprite() -> void:
	if input_direction.x > 0:
		sprite.flip_h = false
	elif input_direction.x < 0:
		sprite.flip_h = true

