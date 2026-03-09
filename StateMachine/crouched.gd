extends State

@export var controllers: Node;

@export var uncrouched_state: State;

func enter() -> void:
	controllers.crouched = true;
	super();

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_released("crouch"):
		controllers.gain_drop_collision();
		return uncrouched_state;
	return null
