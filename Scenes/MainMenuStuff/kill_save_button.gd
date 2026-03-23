extends Button


func _on_pressed() -> void:
	print("about to move to trash: ", ProjectSettings.globalize_path(SaveManager.SAVE_PATH));
	OS.move_to_trash(ProjectSettings.globalize_path(SaveManager.SAVE_PATH));
