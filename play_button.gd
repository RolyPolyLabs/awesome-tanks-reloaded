extends Button

# This automatically grabs a reference to the AudioStreamPlayer child node
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	# Connect the button's "pressed" signal to our custom function below
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Play the assigned audio file
	if audio_player.stream:
		audio_player.play()
	else:
		push_warning("Don't forget to assign an audio file to the AudioStreamPlayer's Stream property!")
