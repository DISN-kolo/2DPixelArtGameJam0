extends Panel

@onready var level_block_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_block_panel.tscn");
@onready var level_entry_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_entry_panel.tscn");

var current_pos: Vector2 = Vector2(0, 0);

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("esc") || event.is_action_pressed("minimap")):
		queue_free();

func _ready() -> void:
	draw_minimap()
	%MoverOfMap.position = -current_pos + size / 2;
	Signals.level_loaded.connect(redraw_minimap);

func _process(delta: float) -> void:
	%MoverOfMap.position = lerp(%MoverOfMap.position, -current_pos + size/2, delta*Settings.minimap_lerp_speed);

func draw_minimap() -> void:
	for id: int in MinimapStorage.level_pos_s.keys():
		var level_panel: Panel = level_block_ps.instantiate();
		level_panel.position = MinimapStorage.level_pos_s[id];
		level_panel.size = MinimapStorage.level_sizes[id];
		if (id == PlayerMetrics.last_level_id):
			current_pos = level_panel.position + level_panel.size/2;
			level_panel.modulate = Color(0.4, 1, 0.4);
			level_panel.z_index = 10;
		if (!(id in PlayerMetrics.visited_level_ids)):
			level_panel.visible = false;
		else:
			level_panel.visible = true;
		%MoverOfMap.add_child(level_panel);
		for j: int in range(MinimapStorage.mm_docker_pos_s[id].size()):
			var entry_panel: Panel = level_entry_ps.instantiate();
			if (id == PlayerMetrics.last_level_id):
				entry_panel.size *= 1.1;
			entry_panel.position = MinimapStorage.mm_docker_pos_s[id][j] - entry_panel.size / 2;
			level_panel.add_child(entry_panel);

func redraw_minimap() -> void:
	for child in %MoverOfMap.get_children():
		child.queue_free();
	draw_minimap();

func _on_close_map_panel_button_pressed() -> void:
	queue_free();
