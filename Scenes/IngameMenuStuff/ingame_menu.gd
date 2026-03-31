extends Control

@onready var quit_confirm_ps: PackedScene = preload("res://Scenes/IngameMenuStuff/quit_game_areyousure.tscn");
var quit_confirm_node: Control;

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("esc") && %QuitConfirmHandler.get_children().is_empty()):
		queue_free();

func _ready() -> void:
	Signals.unload_level.connect(on_unload);

func _on_quit_button_pressed() -> void:
	quit_confirm_node = quit_confirm_ps.instantiate();
	%QuitConfirmHandler.add_child(quit_confirm_node);

func _on_continue_button_pressed() -> void:
	queue_free();

func on_unload() -> void:
	queue_free();
