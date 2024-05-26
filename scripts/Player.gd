extends CharacterBody2D

# Variaveis carregadas automaticamente quando o node é renderizado
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_player: Sprite2D = $Sprite

# Variaveis que vão aparacer no inspetor do player
@export var speed: float = 2.5
@export_range(0,1) var coeff_velocity_atk: float = 0.4 # Coeficiente de redução de VEL ao ATK
@export_range(1, 2.5) var coeff_velocity_run: float = 1.35 # Coeficiente de redução de VEL ao RUN
@export_range(0,1) var deadzone: float = 0.15

# Variaveis manipuladas no código
var is_attacking: bool = false
var is_running: bool = false
var attacking_cooldown: float = 0.0
var input_direction: Vector2 = Vector2(0 , 0)
var target_velocity: Vector2 = Vector2(0 , 0)


func _process(delta) -> void:
	read_input_moviment() # Obter o input de movimento
	GameManager.player_position = position
	rotate_sprite() # Change sprite side
	default_animations() # # Animações padrão do player
	update_atk_cooldown(delta) # Temporizador de ATK
	 
	# Call ATK Func
	if Input.is_action_just_pressed("atk_waek"):
		attack(0)
	elif Input.is_action_just_pressed("atk_strong"):
		attack(1)


func _physics_process(delta: float) -> void:
	# Controle de velocidade
	target_velocity = input_direction * speed * 100
	if is_attacking:
		target_velocity *= coeff_velocity_atk
	if is_running:
		target_velocity *= coeff_velocity_run
	# Suaviza o movimento
	velocity = lerp(velocity, target_velocity, 0.2) # De 0 a 1 sendo mais próximo de zero menas fricção
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


func attack(atk_type: int) -> void:
	if is_attacking: # Ignora a função se já estiver em ação de ataque
		return

	if atk_type == 0: # ATK type 0 = waek (w)
		# Animações de ATK
		if input_direction.x == 0 and input_direction.y < 0:
			animation_player.play("atk_up_w")
		elif input_direction.x == 0 and input_direction.y > 0:
			animation_player.play("atk_down_w")
		else: 
			animation_player.play("atk_side_w") 
	
	elif atk_type == 1: # ATK type 1 = strong (s)
		# Animações de ATK
		if input_direction.x == 0 and input_direction.y < 0: 
			animation_player.play("atk_up_s")
		elif input_direction.x == 0 and input_direction.y > 0:
			animation_player.play("atk_down_s")
		else: 
			animation_player.play("atk_side_s")  
	
	is_attacking = true # Define que o personagem está atacando
	attacking_cooldown = animation_player.current_animation_length + 0.2 # O cooldown será a duração da animação


func update_atk_cooldown(delta: float)-> void:
	if is_attacking:
		attacking_cooldown -= delta
		if attacking_cooldown <= 0.0:
			is_attacking = false
