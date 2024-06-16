extends Node

var sprite: AnimatedSprite2D # Obtem a animação da sprite
var enemy: Enemy # Herda a classe Enemy definida no node principal CharacterBody2D
var player_position: Vector2 = Vector2(0, 0) # Posição do PLAYER
var input_direction: Vector2 = Vector2(0, 0) # Vector da diferença entre a posição do PLAYER e do ENEMY
var target_velocity: Vector2 = Vector2(0, 0) # Velocidade final que será suavidada em VELOCITY
var is_moving = true

func _ready():
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")


func _process(delta: float) -> void:
	rotate_sprite()


func _physics_process(delta: float) -> void:
	
	player_position = GameManager.player_position
	# input_direction = player_position - enemy.position
	input_direction = player_position - enemy.global_position   
	target_velocity = input_direction.normalized() * enemy.speed * 100.0
	
	if is_moving:
		enemy.velocity = lerp(enemy.velocity, target_velocity, 0.2)
		enemy.move_and_slide() 


func rotate_sprite() -> void:
	if input_direction.x > 0:
		sprite.flip_h = false
	elif input_direction.x < 0:
		sprite.flip_h = true
