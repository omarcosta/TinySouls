class_name LootResources
extends Resource

@export var name: String
@export var resource: PackedScene
@export var drop_chance: float

#func drop(loot_list: LootResources):
	#var total_drop_rate = 0
	#for item in loot_list:
		#total_drop_rate += item.drop_chance
	#
	#
	#return item 
