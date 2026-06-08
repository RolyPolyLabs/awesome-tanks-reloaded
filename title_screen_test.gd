extends Button

@export var normal_icon: Texture2D
@export var clicked_icon: Texture2D

@onready var icon_rect: TextureRect = $IconRect
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	# You can now freely resize the Button in the editor.
	# This script will not fight the layout anymore.
	icon_rect.texture = normal_icon
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	if audio_player.stream:
		audio_player.play()

	icon_rect.texture = clicked_icon
	await get_tree().create_timer(1.0).timeout
	icon_rect.texture = normal_icon
