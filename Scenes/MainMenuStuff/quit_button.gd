extends Button

func _on_pressed() -> void:
	Signals.quit_game.emit();
