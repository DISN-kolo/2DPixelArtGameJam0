extends Control

func _ready() -> void:
	Signals.level_loaded.connect(self_destruction_on_lvl_ldd);

func _process(delta: float) -> void:
	if (SaveManager.has_save()):
		%ContinueButton.visible = true;
	else:
		%ContinueButton.visible = false;
	if (Settings.debugmode):
		%DebugButton.visible = true;
	else:
		%DebugButton.visible = false;

func self_destruction_on_lvl_ldd() -> void:
	call_deferred("queue_free");
