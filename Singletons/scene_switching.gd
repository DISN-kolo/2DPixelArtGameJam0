extends Node;

var just_starting: Dictionary[String, bool] = {
	"Normal": true,
	"Crouch": true
};
var last_state: Dictionary[String, String] = {
	"Normal": "Idle",
	"Crouch": "Uncrouched"
};

func _ready() -> void:
	Signals.connect("goto_from", _on_goto_from);

func change_level(path_to: String, spawn_id: int) -> void:
	print("unloading level...");
	Signals.unload_level.emit();
	print("unloading player...");
	Signals.unload_player.emit();
	print("loading level... ", path_to);
	Signals.load_level.emit(path_to);
	print("loading player...");
	Signals.load_player.emit(spawn_id);
	print("ll call done!");

func _on_goto_from(from_where: int, exit_id: int, to_where: int, spawn_id: int) -> void:
	print("asked to leave level %d from exit number %d, entering level %d into spawn number %d" %
		[from_where, exit_id, to_where, spawn_id]);
	change_level.call_deferred(
		"res://Scenes/Levels/level_%d.tscn" % [to_where],
		spawn_id
		);
