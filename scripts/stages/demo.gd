extends Node

# @export var hud: CanvasLayer
# @export var gameover_scene: CanvasLayer
@onready var hud: CanvasLayer
@onready var activate_gameover_screen = false

var  cooldown_reload: float = 7.0 # 5 segundos para reiniciar o jogo + 2 segundos de animação


func _ready():
	if $HUD:
		hud = get_node("HUD")
	else: 
		hud = null


func _process(delta):
	if GameManager.gameover:
		delete_hud()
		enable_gameover_scene()
		cooldown_reload -= delta
		if cooldown_reload <= 0: # sin
			if Input.is_action_just_pressed("atk_waek") or Input.is_action_just_pressed("atk_waek"):
				reload_game()

func delete_hud():
	if hud:
		hud.queue_free()
		hud = null 


func enable_gameover_scene():
	if not activate_gameover_screen:
		var gameover_scene_prefab = preload("res://scenes/ui/ui_game_over.tscn")
		var gameover_scene = gameover_scene_prefab.instantiate()
		add_child(gameover_scene)
		activate_gameover_screen = true


func reload_game():
	GameManager.reset()
	get_tree().reload_current_scene()

