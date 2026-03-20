extends Node;

const SAVE_PATH: String = "user://save.json";

func _ready() -> void:
	Signals.level_loaded.connect(_on_level_loaded);

func _on_level_loaded() -> void:
	write_save();

func write_save() -> void:
	var data: Dictionary = {
		"visited_level_ids": PlayerMetrics.visited_level_ids,
		"has_items": PlayerMetrics.has_items,
		"last_level_id": PlayerMetrics.last_level_id,
		"last_spawn_id": PlayerMetrics.last_spawn_id,
	};
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE);
	file.store_string(JSON.stringify(data));
	file.close();
	print("game saved to.. ", file.get_path_absolute());

func load_save() -> void:
	if (!has_save()):
		return ;
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ);
	var data: Dictionary = JSON.parse_string(file.get_as_text());
	file.close();
	PlayerMetrics.visited_level_ids.clear();
	for id in data["visited_level_ids"]:
		PlayerMetrics.visited_level_ids.append(int(id));
	PlayerMetrics.has_items.clear();
	for item in data["has_items"]:
		PlayerMetrics.has_items.append(item as Enums.PickupableID);
	PlayerMetrics.last_level_id = int(data["last_level_id"]);
	PlayerMetrics.last_spawn_id = int(data["last_spawn_id"]);
	PlayerMetrics.recompute_stats();
	print("save loaded!");

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH);

func delete_save() -> void:
	if (has_save()):
		DirAccess.remove_absolute(SAVE_PATH);
