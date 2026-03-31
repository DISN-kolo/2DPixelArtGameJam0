extends Node
class_name MainNode;

@export_file("*.tscn") var default_level_path : String = "";
@export_file("*.tscn") var default_debug_level_path : String = "";

@export var debug_level_tick: bool = false;

var loaded_level : BaseLevel;

@onready var pc_ps : PackedScene = preload("res://Character/pc.tscn");
@onready var main_menu_ps : PackedScene = preload("res://Scenes/MainMenuStuff/main_menu.tscn")

var pc : CharacterBody2D;

@onready var map_ps : PackedScene = preload("res://Scenes/MiniMapStuff/map_panel.tscn");
var map_node: Panel;

func load_level(level_path: String) -> void:
	loaded_level = load(level_path).instantiate();
	add_child(loaded_level);

func unload_level() -> void:
	loaded_level.queue_free();

func load_player(spawn_number: int) -> void:
	pc = pc_ps.instantiate();
	pc.label_state = %LabelState;
	pc.label_crouched = %LabelCrouched;
	pc.label_misc = %LabelMisc;
	pc.label_jump_held = %LabelJumpHeld;
	pc.position = loaded_level.get_spawn_loc(spawn_number);
	pc.set_cam_limits(loaded_level.get_cam_limits());
	pc.set_cam_zoom(loaded_level.cam_zoom);
	PlayerMetrics.last_global_pos = pc.position;
	add_child(pc);
	var lvl_id: int = loaded_level.level_id;
	if (!PlayerMetrics.visited_level_ids.has(lvl_id)):
		PlayerMetrics.visited_level_ids.append(lvl_id);
	PlayerMetrics.last_level_id = lvl_id;
	PlayerMetrics.last_spawn_id = spawn_number;
	Signals.level_loaded.emit();

func unload_player() -> void:
	pc.queue_free();

func spawn_main_menu() -> void:
	var main_menu_node: Control = main_menu_ps.instantiate();
	%MainControl.add_child(main_menu_node);

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("minimap")):
		if (%MapAnchor.get_children().is_empty()):
			map_node = map_ps.instantiate();
			%MapAnchor.add_child(map_node);

func _ready() -> void:
	Signals.connect("quit_game", quit_game);
	Settings.debuglevelpath = default_debug_level_path;
	Settings.startlevelpath = default_level_path;
	if (debug_level_tick):
		Settings.debugmode = true;
	else:
		Settings.debugmode = false;
	%DebugStuff.visible = Settings.debugmode;
	spawn_main_menu();
	Signals.connect("load_level", load_level);
	Signals.connect("unload_level", unload_level);
	Signals.connect("load_player", load_player);
	Signals.connect("unload_player", unload_player);
	MinimapStorage.generate();

func quit_game() -> void:
	get_tree().quit();
