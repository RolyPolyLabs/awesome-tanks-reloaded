extends Node2D

# Drag and drop your background node here, or ensure the name matches exactly
@onready var background = $Background
# How far the background can drift (Higher = more movement)
@export var shift_strength: float = 20.0

# How smoothly it transitions (Higher = faster follow)
@export var smoothness: float = 5.0

var screen_center: Vector2 = Vector2.ZERO

func _ready():
	screen_center = get_viewport_rect().size / 2.0

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Calculate mouse distance from center
	var target_offset = (mouse_pos - screen_center) / screen_center
	
	# Calculate the new position for the background
	var target_pos = target_offset * shift_strength
	
	# Smoothly slide the background to that position
	background.position = background.position.lerp(target_pos, smoothness * delta)
