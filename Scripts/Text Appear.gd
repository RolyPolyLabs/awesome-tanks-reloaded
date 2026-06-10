extends Node2D  # Or Control, depending on your root node type
@onready var texture_rect: TextureRect = $TextureRect
@onready var timer: Timer = $Timer

func _ready() -> void:
	# Double insurance: force the pivot to the center and shrink it to start
	texture_rect.pivot_offset = texture_rect.size / 2.0
	texture_rect.scale = Vector2.ZERO

func _on_timer_timeout() -> void:
	var tween = create_tween()
	
	# 1. EXPAND: Instantly grows huge to "fill the screen"
	tween.tween_property(texture_rect, "scale", Vector2(4.0, 4.0), 0.15)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	
	# 2. SLAM DOWN: Shrinks back to normal size with a heavy bounce impact
	tween.tween_property(texture_rect, "scale", Vector2(1.0, 1.0), 0.25)\
		.set_trans(Tween.TRANS_BOUNCE)\
		.set_ease(Tween.EASE_OUT)
