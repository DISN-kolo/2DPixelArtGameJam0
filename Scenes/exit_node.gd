extends Area2D;

@export var exit_id: int = 0;
var our_level: int = 0;

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("player")):
		Signals.goto_from.emit(our_level, exit_id);
