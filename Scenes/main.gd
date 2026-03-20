extends Node

@export_file("*.tscn") var default_level_path : String = "";
@export_file("*.tscn") var default_debug_level_path : String = "";

@export var debug_level_tick: bool = false;

var default_level : Node2D;
var loaded_level : Node2D;

@onready var pc_ps : PackedScene = preload("res://Character/pc.tscn");
var pc : CharacterBody2D;

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

func _ready() -> void:
	Signals.connect("load_level", load_level);
	Signals.connect("unload_level", unload_level);
	Signals.connect("load_player", load_player);
	Signals.connect("unload_player", unload_player);
	if (debug_level_tick):
		load_level(default_debug_level_path);
	else:
		load_level(default_level_path);
	load_player(0);
