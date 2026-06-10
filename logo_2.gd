extends TextureRect

func _ready() -> void:
	# 1. Hide it initially by scaling down and fading out
	modulate.a = 0.0
	scale = Vector2(0.2, 0.2) # Start extra small for a more dramatic pop
	
	# Store the actual landing position, then push it down slightly
	var final_position = position
	position.y += 50 
	
	# 2. Wait a brief moment for the scene to load, then pop!
	await get_tree().create_timer(3).timeout
	animate_pop(final_position)

func animate_pop(target_pos: Vector2) -> void:
	# Run animations in parallel so scale, position, and fade happen together
	var tween = create_tween().set_parallel(true)
	
	# TRANS_BACK + EASE_OUT gives us that mandatory "overshoot and settle" physics
	tween.set_trans(Tween.TRANS_BACK)
	tween.set_ease(Tween.EASE_OUT)
	
	# Snap to full size and original position over 0.4 seconds
	tween.tween_property(self, "scale", Vector2(.5, .5), 0.4)
	tween.tween_property(self, "position", target_pos, 0.4)
	
	# Smoothly fade it in slightly faster than the movement finishes
	tween.tween_property(self, "modulate:a", 1.0, 0.15).set_trans(Tween.TRANS_LINEAR)
