extends Control

# Magic
@onready var magic_progress_bar: TextureProgressBar = %MagicProgressBar
@onready var magic_cooldown_label: Label = %MagicCooldownLabel
@onready var magic_interval: float = GameManager.magic_interval
@onready var magic_is_available: bool = true
@onready var magic_cooldown: float = 0

# Technique
@onready var technique_progress_bar: TextureProgressBar = %TechniqueProgressBar
@onready var technique_cooldown_label: Label = %TechniqueCooldownLabel
@onready var technique_reserve_label: Label = %TechniqueReserveLabel
@onready var technique_interval: float = GameManager.technique_interval
#@onready var technique_reserve: float = GameManager.tecnique_reserve_ammo
@onready var technique_is_available: bool = true
@onready var technique_cooldown: float = 0


func _ready():
	magic_progress_bar.max_value = magic_interval
	technique_progress_bar.max_value = technique_interval

	
func _process(delta: float):
	# print("interval: ", magic_interval, " | ", magic_is_available, " | reserve: ", technique_reserve)
	ui_magic_manager(delta)
	ui_technique_manager(delta)
	

func  ui_magic_manager(delta) -> void:
	# magic_is_available = magic.is_available
	magic_is_available = GameManager.magic_available
	if magic_is_available: 
		magic_cooldown = magic_interval
		magic_progress_bar.value = magic_cooldown
		magic_cooldown_label.text = ""
		return
	else:
		if magic_cooldown <= 0: 
			magic_progress_bar.value = 0
			magic_cooldown_label.text = ""
		else:
			magic_cooldown -= delta
			magic_progress_bar.value = magic_interval - magic_cooldown
			magic_cooldown_label.text = str(ceil(magic_cooldown),"s")
		

func  ui_technique_manager(delta) -> void:
	# technique_reserve = GameManager.tecnique_reserve_ammo
	# technique_reserve_label.text = str("x", ceil(technique_reserve))
	technique_reserve_label.text = str("x", ceil(GameManager.technique_reserve_ammo))
	technique_is_available = GameManager.technique_available
	if technique_is_available: 
		technique_cooldown = technique_interval
		technique_progress_bar.value = technique_cooldown
		technique_cooldown_label.text = ""
		# technique_reserve_label.text = ""
		return
	else:
		if technique_cooldown <= 0: 
			technique_progress_bar.value = 0
			technique_cooldown_label.text = ""
			# technique_reserve_label.text = ""
		else:
			technique_cooldown -= delta
			technique_progress_bar.value = technique_interval - technique_cooldown
			technique_cooldown_label.text = str(ceil(technique_cooldown),"s")
			# technique_reserve_label.text = str(ceil(technique_reserve)," ammo")
		

			
			
			
			
		#if magic_cooldown > 0:
			#magic_cooldown -= delta
			#magic_cooldown_label.text = str(ceil(magic_cooldown),"s")
		#else: 
			#magic_cooldown = 0
			#magic_cooldown_label.text = ""
		#if magic_cooldown == 0: 
			#magic_progress_bar.value = 0
		#else:
			#magic_progress_bar.value = magic_interval - magic_cooldown
	 
		
