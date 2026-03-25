extends Panel

@onready var level_block_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_block_panel.tscn");
@onready var level_entry_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_entry_panel.tscn");

@onready var main: Node = $"../../../../.."
# wow. terrible          ^^^^^^^^^^^^^^^^^^ FIXME

func _ready() -> void:
	Signals.level_loaded.connect(generate_panel_for_minimap);

func generate_panel_for_minimap() -> void:
	if (main.loaded_level.level_id in PlayerMetrics.generated_panels_for_level_ids):
		return ;
	else:
		PlayerMetrics.generated_panels_for_level_ids.append(main.loaded_level.level_id);
	var temp_level_panel: Panel = level_block_ps.instantiate();
	var camlims: Vector4i = main.loaded_level.get_cam_limits();
	var tl: Vector2 = Vector2(camlims.x, camlims.y);
	var spawnsarray: Array[Vector2] = main.loaded_level.get_spawns();
	temp_level_panel.size = Vector2(camlims.z - camlims.x, camlims.w - camlims.y)/Settings.minimap_scale;
	temp_level_panel.position = size/2;
	add_child(temp_level_panel);
	for spawn in spawnsarray:
		var temp_entry_panel: Panel = level_entry_ps.instantiate();
		temp_entry_panel.position = (spawn - tl)/Settings.minimap_scale;
		temp_entry_panel.position -= temp_entry_panel.size/2;
		temp_level_panel.add_child(temp_entry_panel);
