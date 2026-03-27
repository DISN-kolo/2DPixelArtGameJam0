extends Panel

@onready var level_block_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_block_panel.tscn");
@onready var level_entry_ps: PackedScene = preload("res://Scenes/MiniMapStuff/level_entry_panel.tscn");

@onready var main: MainNode = $"../../../../.."
var ll: BaseLevel;
# wow. terrible          ^^^^^^^^^^^^^^^^^^ FIXME

func _ready() -> void:
	Signals.level_loaded.connect(generate_panel_for_minimap);

func get_docker_pos_s(dockers: Array[Docker]) -> Array[Vector2]:
	var ret: Array[Vector2] = [];
	for docker in dockers:
		ret.append(docker.position);
	return ret;

func get_dockers_info(dockers: Array[Docker]) -> Array[Array]:
	var ret: Array[Array] = [];
	for docker in dockers:
		ret.append([docker.connect_to_level_id, docker.connect_to_docker_id]);
	return ret;

func generate_panel_for_minimap() -> void:
	ll = main.loaded_level;
	var id = ll.level_id;
	var eid = PlayerMetrics.last_spawn_id;
	if (id in PlayerMetrics.generated_panels_for_level_ids):
		return ;
	else:
		PlayerMetrics.generated_panels_for_level_ids.append(id);
	var temp_level_panel: Panel = level_block_ps.instantiate();
	var camlims: Vector4i = ll.get_cam_limits();
	var tl: Vector2 = Vector2(camlims.x, camlims.y);
	if (!(id in MinimapStorage.tl_s.keys())):
		MinimapStorage.tl_s[id] = tl;
	var dockers: Array[Docker] = ll.get_dockers();
	temp_level_panel.size = Vector2(camlims.z - camlims.x, camlims.w - camlims.y)/Settings.minimap_scale;
	if (!(id in MinimapStorage.dockers_info.keys())):
		MinimapStorage.dockers_info[id] = get_dockers_info(dockers);
	if (!(id in MinimapStorage.docker_pos_s.keys())):
		MinimapStorage.docker_pos_s[id] = get_docker_pos_s(dockers);
	if (id != 0):
		var prev_id: int = MinimapStorage.dockers_info[id][eid][0];
		var old_level_tl: Vector2 = MinimapStorage.tl_s[prev_id]/Settings.minimap_scale;
		var old_level_pos: Vector2 = MinimapStorage.level_pos_s[prev_id];
		var old_docker_pos: Vector2 = MinimapStorage.docker_pos_s[prev_id][dockers[eid].connect_to_docker_id]/Settings.minimap_scale;
		var this_docker_pos: Vector2 = MinimapStorage.docker_pos_s[id][eid]/Settings.minimap_scale;
		temp_level_panel.position = (
			(old_docker_pos - old_level_tl + old_level_pos)
			- (this_docker_pos - tl/Settings.minimap_scale)
		);
	if (!(id in MinimapStorage.level_pos_s.keys())):
		MinimapStorage.level_pos_s[id] = temp_level_panel.position;
	add_child(temp_level_panel);
	for docker in dockers:
		var temp_entry_panel: Panel = level_entry_ps.instantiate();
		temp_entry_panel.position = (docker.position - tl)/Settings.minimap_scale;
		temp_entry_panel.position -= temp_entry_panel.size/2;
		temp_level_panel.add_child(temp_entry_panel);
