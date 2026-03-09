extends Node2D

@export var level_id: int = 0;

func get_default_spawn_loc() -> Vector2:
	return $SpawnMarkers/DefaultSpawn.position;

func _ready() -> void:
	%ExitAreas.set_level_id_to_exits(level_id);
