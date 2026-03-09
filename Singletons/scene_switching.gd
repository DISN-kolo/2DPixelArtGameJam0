extends Node;

func _ready() -> void:
	Signals.connect("goto_from", _on_goto_from);

func _on_goto_from(from_where: int, exit_id: int) -> void:
	print("asked to leave level ", from_where, " from the exit number ", exit_id);
