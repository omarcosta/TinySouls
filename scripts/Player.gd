class_name Player
extends CharacterBody2D

# Variaveis carregadas automaticamente quando o node é renderizado
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_player: Sprite2D = $Sprite
@onready var sword_area: Area2D = $SwordArea
@onready var hit_area: Area2D = $HitArea
@export var death_prefab: PackedScene

@export_category("Player") # Caracteristicas do player
@export_group("Player attributes")
@export_range(0, 999) var health: int = 100
@export_range(0, 999) var max_health: int = 100
#@export_range(0, 999) var stamina: int = 50
#@export_range(0, 999) var max_stamina: int = 50
#@export_range(0, 999) var magic: int = 50
#@export_range(0, 999) var max_magic: int = 50
@export_range(1, 99) var attack_points: int = 2
@export var speed: float = 2.5

@export_group("Balancing coefficients") # Coeficientes
@export_range(0,1) var coeff_velocity_atk: float = 0.25 # Redução de VEL ao ATK
@export_range(1, 2.5) var coeff_velocity_run: float = 1.35 # Redução de VEL ao RUN
@export_range(0,1) var deadzone: float = 0.15 # Zona que será ignorada para evitar problemas em controles com analógicos

# Variaveis manipuladas no código
var is_attacking: bool = false # O jogador esta atacando
var is_running: bool = false # O Jogar está correndo
var is_hit: bool = false # O jogador está levando dano
var attacking_cooldown: float = 0.0 # Contador de tempo para atacar
var hit_cooldown: float = 0.0 # Contador de tempo para levar dano
var attacking_orientation: String = "RIGHT" # Define qual o lado do ataque: right, left, up, down
var input_direction: Vector2 = Vector2(0 , 0)
var target_velocity: Vector2 = Vector2(0 , 0)

func _ready():
	GameManager.player_life_points_max = max_health

func _process(delta) -> void:
	GameManager.player_position = position
	GameManager.player_life_points = health
	read_input_moviment() # Obter o input de movimento
	rotate_sprite() # Change sprite side
	default_animations() # # Animações padrão do player
	update_atk_cooldown(delta) # Temporizador de ATK
	update_hit_cooldown(delta) # Teporizador de levar dano
	# Call ATK Func
	if Input.is_action_just_pressed("atk_waek"):
		attack("w")
	elif Input.is_action_just_pressed("atk_strong"):
		attack("s")
	deal_damage_to_player()
	game_over()


func _physics_process(delta: float) -> void:
	# Controle de velocidade
	target_velocity = input_direction * speed * 100
	if is_attacking:
		target_velocity *= coeff_velocity_atk
	if is_running:
		target_velocity *= coeff_velocity_run
	# Suaviza o movimento
	velocity = lerp(velocity, target_velocity, 0.1) # De 0 a 1 sendo mais próximo de zero menas fricção
	move_and_slide() # Renderiza o código na tela


func read_input_moviment() -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# Aplicar daadzone ao input de movimento 
	if abs(input_direction.x) < deadzone:
		input_direction.x = 0
	if abs(input_direction.y) < deadzone:
		input_direction.y = 0


func rotate_sprite() -> void:
	if !is_attacking:
		if input_direction.x > 0:
			sprite_player.flip_h = false
		elif input_direction.x < 0:
			sprite_player.flip_h = true


func default_animations() -> void: 
	if not input_direction.is_zero_approx() and !is_attacking:
		if Input.is_action_pressed("move_run"):
			animation_player.play("run")
			is_running = true
		else: 
			animation_player.play("walk")
			is_running = false
	elif input_direction.is_zero_approx() and !is_attacking: 
		animation_player.play("idle")


func attack(atk_type: String) -> void:
	if is_attacking: # Ignora a função se já estiver em ação de ataque
		return
	attack_type_and_orientation(atk_type)
	is_attacking = true # Define que o personagem está atacando
	attacking_cooldown = animation_player.current_animation_length + 0.2 # O cooldown será a duração da animação


func attack_type_and_orientation(type: String) -> void:
	# ATK type "w" = waek | ATK type "s" = strong
	if input_direction.x == 0 and input_direction.y < 0: 
		animation_player.play(str("atk_up_",type)) # Reproduz animação
		attacking_orientation = "UP" # Difine orientação
	elif input_direction.x == 0 and input_direction.y > 0:
		animation_player.play(str("atk_down_",type))
		attacking_orientation = "DOWN"
	else: 
		animation_player.play(str("atk_side_",type))
		if sprite_player.flip_h:
			attacking_orientation = "LEFT"
		else:
			attacking_orientation = "RIGHT"


func update_atk_cooldown(delta: float)-> void:
	if not is_attacking: return
	attacking_cooldown -= delta
	if attacking_cooldown <= 0.0:
		is_attacking = false


func update_hit_cooldown(delta: float)-> void:
	if not is_hit: return
	hit_cooldown -= delta
	if hit_cooldown <= 0.0:
		is_hit = false


func deal_damage_to_enemies() -> void:
	var bodies = sword_area.get_overlapping_bodies() # Obtem todos os corpos f[isicos na area. Pode ser mudado para pegar a area
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			var direction_to_enemy = (enemy.position - position).normalized()
			var attack_direction: Vector2
			match attacking_orientation:
				"UP":
					attack_direction = Vector2.UP
				"DOWN":
					attack_direction = Vector2.DOWN
				"LEFT":
					attack_direction = Vector2.LEFT
				_: # Right
					attack_direction = Vector2.RIGHT
			var dot_product = direction_to_enemy.dot(attack_direction)
			if dot_product >= 0.75:
				enemy.suffered_damage(attack_points)


func deal_damage_to_player() -> void:
	if is_hit: return
	var bodies = hit_area.get_overlapping_bodies() # Obtem todos os corpos f[isicos na area. Pode ser mudado para pegar a area
	for body in bodies:
		if body.is_in_group("enemies"):
			var enemy: Enemy = body
			suffered_damage(enemy.damage)
			is_hit = true
			hit_cooldown = 1
			print(health)


func suffered_damage(amount: int) -> void: 
	health -= amount
	reaction_to_damage()
	#if life_points <= -0:
		#die()
		#GameManager.gameover = true
	
	
func die() -> void:
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = position
		# death_object.scale = scale
		get_parent().add_child(death_object)
	queue_free()


func reaction_to_damage() -> void:
	modulate = Color.FIREBRICK
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)

func game_over() -> void: 
	if health > 0: 
		return
	GameManager.player_life_points = health
	GameManager.gameover = true
	die()

func helth_regenerator_by_resources(amount: int) -> int:
	if health + amount < max_health:
		health += amount
	else:
		health = max_health
	print("O Jogador tem: ", health)
	return health
