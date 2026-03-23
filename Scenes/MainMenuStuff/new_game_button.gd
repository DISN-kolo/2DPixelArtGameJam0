extends Button

signal are_you_sure_new_game;

func _on_pressed() -> void:
	if (SaveManager.has_save()):
		are_you_sure_new_game.emit();
	else:
		Signals.emit_signal("load_level", Settings.startlevelpath);
		Signals.emit_signal("load_player", 0);
