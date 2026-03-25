extends Panel

@onready var level_block_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_block_panel.tscn");
@onready var level_entry_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_entry_panel.tscn");

@onready var main: Node = $"../../../../.."
# wow. terrible          ^^^^^^^^^^^^^^^^^^ FIXME

func _ready() -> void:
	Signals.level_loaded.connect(generate_panel_for_minimap);

# TODO add panels to an array, add "spawn coordinates" to panels,
# move around the levels based on which level you're in (center on the current level),
# spawn loaded levels so that their used spawnpoint overlaps with
# the corresponding exit's nearby spawnpoint in the previous level.
# this will work because exits' ids match the ids of nearby spawns.
# don't draw the spawn 0 of level 0.
# don't forget to check if all ids match.
# for every level, make the spawnpoit as close to camera boundry as possible,
# or maybe even on it sometimes. thus, level exit areas should be outside of
# the visible area...
# maybe the map data should be stored in a singleton or something. we shan't render
# it all the time, clearly, so we could store data in a singleton and re-render
# the map every time we need to see it.
# bonus thought: it shounldn't be THAT bad to just add docking nodes to the
# levels. these nodes would have the info like during the exit:
# 1. their own id 2. the id they want to connect to 3. the lvl id they want
# to connect to. the id of the level that THEY have is already present from
# main.loaded_level in generate_panel_for_minimap().
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
