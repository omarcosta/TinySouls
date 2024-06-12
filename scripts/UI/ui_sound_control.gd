extends Node

@onready var button_sound: Button = $Button
var img_sound_on = preload("res://addons/misc/sound-on.png")
var img_sound_off = preload("res://addons/misc/sound-off.png")

func _ready():
	chang_button_mute_img()
	

func chang_button_mute_img():
	if SoundManager.mute:
		button_sound.icon = img_sound_off
	else: 
		button_sound.icon = img_sound_on


func _on_button_pressed():
	SoundManager.mute = !SoundManager.mute
	print(SoundManager.mute)
	chang_button_mute_img()
