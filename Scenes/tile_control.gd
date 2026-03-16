extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ts in get_children():
		ts.modulate = Color("white");
