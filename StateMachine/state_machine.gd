## https://shaggydev.com/2023/10/08/godot-4-state-machines/
class_name StateMachine
extends Node

@export var type_of_state: String = "";
@export var starting_state: State;

signal state_changed(state_name: String)

var current_state: State = null;

func init(actor: CharacterBody2D) -> void:
	if (SceneSwitching.just_starting[type_of_state]):
		SceneSwitching.just_starting[type_of_state] = false;
		SceneSwitching.last_state[type_of_state] = starting_state.get_name();
	for child in get_children():
		child.actor = actor;
		if (child.get_name() == SceneSwitching.last_state[type_of_state]):
			print("member me? I'm ", child.get_name());
			starting_state = child;
	change_state(starting_state);

func change_state(new_state: State) -> void:
	if (current_state):
		#print("LEAVING ", current_state.get_name());
		current_state.exit();
	if (new_state == null):
		return ;
	SceneSwitching.last_state[type_of_state] = new_state.get_name();
	state_changed.emit(new_state.get_name());
	current_state = new_state;
	#print("ENTERING ", current_state.get_name());
	new_state.enter();

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event);
	if (new_state):
		change_state(new_state);

func process_default(delta: float) -> void:
	var new_state = current_state.process_default(delta);
	if (new_state):
		change_state(new_state);

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta);
	if (new_state):
		change_state(new_state);
