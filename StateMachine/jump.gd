extends State

@export var controllers: Node

@export var fall_state: State
@export var walk_state: State
@export var idle_state: State

func enter() -> void:
	actor.velocity.y = -controllers.jump_velocity;
	controllers.gain_drop_collision();
	super();

var input_dir: float = 0.0;

func process_physics(delta: float) -> State:
	input_dir = controllers.input_dir_normalizer(
		Input.get_vector("mov_left", "mov_right", "mov_up", "mov_down").x);
	controllers.last_direction = input_dir;
	var temp_fullmultiplier: float = (
		input_dir
		* controllers.speed_default
		* controllers.speed_modifier
		* delta);
	actor.velocity.x = lerp(
		actor.velocity.x,
		temp_fullmultiplier,
		8*delta);
	if (actor.velocity.y >= Settings.terminal_velocity):
		actor.velocity.y = Settings.terminal_velocity;
	else:
		actor.velocity.y += Settings.gravity;
	actor.move_and_slide();
	
	if (!actor.is_on_floor()):
		return fall_state;
	if (abs(input_dir) > 0.1):
		return walk_state;
	return idle_state;
