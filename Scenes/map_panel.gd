extends Panel

@onready var panel: Panel = $Panel
@onready var main: Node = $"../../../../.."
# wow. terrible          ^^^^^^^^^^^^^^^^^^ FIXME

func _ready() -> void:
	Signals.level_loaded.connect(generate_level);

func generate_level() -> void:
	var camlims: Vector4i = main.loaded_level.get_cam_limits();
	var tl: Vector2 = Vector2(camlims.x, camlims.y);
	var spawnsarray: Array[Vector2] = main.loaded_level.get_spawns();
	panel.size = Vector2(camlims.z - camlims.x, camlims.w - camlims.y)/Settings.minimap_scale;
	for spawn in spawnsarray:
		var temp_panel: Panel = Panel.new();
		temp_panel.pivot_offset_ratio = Vector2(0.5, 0.5);
		temp_panel.size = Vector2(10, 10);
		temp_panel.position = (spawn - tl)/Settings.minimap_scale + panel.position;
		add_child(temp_panel);
