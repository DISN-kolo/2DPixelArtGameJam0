extends Node;

var has_items : Array[Enums.PickupableID];
var aux_jumps_left: int = 0;
var max_aux_jumps: int = 0;
var last_global_pos: Vector2 = Vector2(0, 0);
var visited_level_ids: Array[int];
var last_level_id: int = 0;
var last_spawn_id: int = 0;

func _ready() -> void:
	Signals.pickupable_picked_up.connect(_on_picked_up);

func _on_picked_up(id: Enums.PickupableID, gpos: Vector2) -> void:
	if (!has_items.has(id)):
		print("pu'd ", id, " at ", gpos);
		has_items.append(id);
		if (id == Enums.PickupableID.JUMP_BOOTS):
			max_aux_jumps += 1;
			aux_jumps_left = max_aux_jumps;
	else:
		print("tried to pu ", id, " at ", gpos, ", but already had that");

func recompute_stats() -> void:
	max_aux_jumps = 0;
	for item in has_items:
		if (item == Enums.PickupableID.JUMP_BOOTS):
			max_aux_jumps += 1;
	aux_jumps_left = max_aux_jumps;
