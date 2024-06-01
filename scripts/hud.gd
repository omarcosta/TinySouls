extends CanvasLayer

@onready var mission: Label = $StageInfo/Mission
@onready var progress: Label = $StageInfo/Progress
@onready var hud_life = $ViewPlayer/ContainerLife/MaxLife/Life
#@onready var hud_stamina = $ViewPlayer/ContainerStamina/MaxStamina/Stamina
#@onready var hud_magic = $ViewPlayer/ContainerMagic/MaxMagic/Magic
@onready var life: float = GameManager.player_life_points
@onready var max_life: float = GameManager.player_life_points_max
#@onready var stamina: float = GameManager.player_stamina_points
#@onready var max_stamina: float = GameManager.player_stamina_points_max
#@onready var magic: float = GameManager.player_magic_points
#@onready var max_magic: float = GameManager.player_magic_points_max

@export_range(1,200) var target_mission: int = 4
@onready var enemies_defeated: int = 0


func _ready():
	mission.text = "Kill all enimies."

func _process(delta):
	life = GameManager.player_life_points
	enemies_defeated = GameManager.enemies_defeated
	progress.text = str(enemies_defeated) + " / " + str(target_mission)
	#stamina = GameManager.player_stamina_points
	#magic = GameManager.player_magic_points
	hud_player_management(hud_life, life, max_life)
	#hud_player_management(hud_stamina, stamina, max_stamina)
	#hud_player_management(hud_magic, magic, max_magic)
	if enemies_defeated >= target_mission:
		$Victory.visible = true

func hud_player_management(element_hud, attribute, max_attribute) -> void:
	if attribute / max_attribute > 0:
		element_hud.scale.x = attribute / max_attribute
	else: 
		element_hud.scale.x = 0

