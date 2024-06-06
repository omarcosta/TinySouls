extends Control

@onready var bar_health = $HealthBar
@onready var bar_stamina = $StaminaBar
@onready var bar_magic = $MagicBar
@onready var life: int = GameManager.player_life_points
@onready var max_life: int = GameManager.player_life_points_max
@onready var stamina: int = GameManager.player_stamina_points
@onready var max_stamina: int = GameManager.player_stamina_points_max
@onready var magic: int = GameManager.player_magic_points
@onready var max_magic: int = GameManager.player_magic_points_max


func _ready():
	bar_health.max_value = max_life
	bar_stamina.max_value = max_stamina
	bar_magic.max_value = max_magic


func _process(delta):
	if GameManager.gameover == false:
		life = GameManager.player_life_points
		bar_health.value = life
		stamina = GameManager.player_stamina_points
		bar_stamina.value = stamina
		magic = GameManager.player_magic_points
		bar_magic.value = magic
	else: 
		bar_magic.value = 0
		bar_stamina.value = 0
		bar_health.value = 0
