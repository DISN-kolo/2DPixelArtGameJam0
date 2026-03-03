extends Camera2D

var inpvec : Vector2 = Vector2(0, 0);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Settings.debugmode):
		inpvec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
		if (inpvec.length() > 0.1):
			position += inpvec * delta * 33.3;
			print(position);
