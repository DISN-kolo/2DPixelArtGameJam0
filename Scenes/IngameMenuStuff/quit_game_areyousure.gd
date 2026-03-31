extends Panel

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("esc")):
		queue_free();

func _on_yes_quit_button_pressed() -> void:
	Signals.unload_level.emit();
	Signals.unload_player.emit();
	Signals.load_menu.emit();

func _on_no_quit_button_pressed() -> void:
	queue_free();
