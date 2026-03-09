extends Node2D;

func set_level_id_to_exits(id: int) -> void:
	for exit_node in get_children():
		exit_node.our_level = id;
