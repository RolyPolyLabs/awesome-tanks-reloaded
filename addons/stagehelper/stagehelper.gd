@tool
extends EditorPlugin

func _enter_tree() -> void:
	# 1. Get the current project width from your settings
	var stage_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	var center_value = stage_width / 2.0
	
	# 2. Inject a custom global setting into the editor
	ProjectSettings.set_setting("custom_settings/stage_width_center", center_value)
	
	# 3. Tell the editor this is a float value
	ProjectSettings.set_initial_value("custom_settings/stage_width_center", center_value)
	
	# 4. Save the settings so the editor registers it immediately
	ProjectSettings.save()
	print("Global Stage Center Initialized: ", center_value)

func _exit_tree() -> void:
	# Optional: Clean up the setting if you turn the plugin off
	if ProjectSettings.has_setting("custom_settings/stage_width_center"):
		ProjectSettings.set_setting("custom_settings/stage_width_center", null)
		ProjectSettings.save()
