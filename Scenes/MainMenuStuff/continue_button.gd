extends Button

func _on_pressed() -> void:
	SaveManager.load_save();
	Signals.emit_signal("load_level", "res://Scenes/Levels/level_" + str(PlayerMetrics.last_level_id) + ".tscn");
	Signals.emit_signal("load_player", PlayerMetrics.last_spawn_id);
