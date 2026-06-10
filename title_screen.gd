extends Node

# --- ONREADY REFERENCES ---
# Ensure these paths exactly match your Scene Tree structure
@onready var sound_prompt: Control = $SoundPrompt
@onready var music_prompt: Control = $MusicPrompt
@onready var game_canvas: Control = $GameCanvas
@onready var bg_music: AudioStreamPlayer = $"GameCanvas/Canvas Layer/Bg Music"


func _ready() -> void:
	# 1. Force correct initial visibility states on game startup
	sound_prompt.show()
	music_prompt.hide()
	game_canvas.hide()
	
	# 2. Safety check: make sure the background track isn't already playing
	bg_music.stop()


# =============================================================================
# --- STEP 1: SOUND EFFECTS (SFX) PROMPT ---
# =============================================================================

func _on_sound_on_button_pressed() -> void:
	# Locate the central SFX bus and unmute it
	var sfx_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx_index, false)
	_transition_to_music_prompt()


func _on_sound_off_button_pressed() -> void:
	# Locate the central SFX bus and mute it entirely
	var sfx_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(sfx_index, true)
	_transition_to_music_prompt()


func _transition_to_music_prompt() -> void:
	# Hide the first choice screen immediately
	sound_prompt.hide()
	
	# Create a seamless 1-second delay before moving to the next choice
	await get_tree().create_timer(1.0).timeout
	
	# Reveal the second choices screen
	music_prompt.show()


# =============================================================================
# --- STEP 2: MUSIC PROMPT ---
# =============================================================================

func _on_music_on_button_pressed() -> void:
	# Locate the central Music bus and unmute it
	var music_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_index, false)
	_start_main_game()


func _on_music_off_button_pressed() -> void:
	# Locate the central Music bus and mute it
	var music_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(music_index, true)
	_start_main_game()


# =============================================================================
# --- STEP 3: START THE MAIN GAME ---
# =============================================================================

func _start_main_game() -> void:
	# Hide the final layout configuration prompt
	music_prompt.hide()
	
	# Reveal the main game level and its components
	game_canvas.show()
	
	# Safely run the background track. 
	# If the "Music" bus is muted, Godot processes the stream silently.
	bg_music.play()
