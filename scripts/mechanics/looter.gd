extends Node

#@export var loot_list: Array[LootResources] = []
#@onready var mark = $Marker2D
#
##@onready var resource: PackedScene
##@onready var chance: float
##@export var X = [Resource]
##@export var drop_nothing: float = 50
##@export var drop_health: float = 25
##@export var drop_magic: float = 15
##@export var drop_ammo: float = 5
##
##func drop_chance():
	##var item = randf()
	##
	##
	##pass
	#
#func _ready():
	#drop()
#
#func drop() -> PackedScene:
	#var rate: float = randf()
	#var total_drop_rate: float = 0
	#var array_possible_drop: Array[PackedScene] = []
	#for loot in loot_list:
		#total_drop_rate = loot.drop_chance
	#for item in loot_list:
		#var target = item.drop_chance * total_drop_rate / 100
		#if target <= total_drop_rate * rate:
			#array_possible_drop.append(item.resource)
	#var count = randi_range(1, array_possible_drop.size()-1)
	#
	#return array_possible_drop[count]
#
#
#func _on_button_pressed():
	#var prefab: PackedScene = drop()
	#var resouce_drop = prefab.instantiate()
	#resouce_drop.global_position = mark.global_position
	#add_child(resouce_drop)
