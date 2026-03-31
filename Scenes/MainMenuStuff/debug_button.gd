extends Button

func _on_pressed() -> void:
	Signals.debug_gaming.emit();
