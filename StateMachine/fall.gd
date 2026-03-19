extends State

@export var controllers: Node

@export var jump_state: State
@export var walk_state: State
@export var idle_state: State

func enter() -> void:
	super();

var input_dir: float = 0.0;

func process_input(event: InputEvent) -> State:
	if (Input.is_action_just_pressed("jump") && PlayerMetrics.aux_jumps_left > 0):
		PlayerMetrics.aux_jumps_left -= 1;
		return jump_state;
	return null;

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
		6*delta);
	controllers.fall_vel_processor();
	if (Input.is_action_pressed("jump")):
		if controllers.crouched:
			controllers.lose_drop_collision();
	elif (Input.is_action_just_released("jump")):
		controllers.gain_drop_collision();
	actor.move_and_slide();
	
	# holy shit.
	if (actor.is_on_floor()):
		#if (actor.is_on_wall() && !actor.custom_is_on_floor()):
			#print("detected that i'm on floor, from fall, while also on wall and not on floor.");
			#print("this is THE bug");
			#for i in actor.get_slide_collision_count():
				#var collision = actor.get_slide_collision(i);
				#if (abs(collision.get_normal().x) > 0.1):
					#actor.global_position += collision.get_normal()*delta*100;
			#return null;
		print("detected that i'm on floor, from fall");
		if (Input.is_action_pressed("jump")):
			PlayerMetrics.aux_jumps_left = PlayerMetrics.max_aux_jumps;
			return jump_state;
		if (abs(input_dir) > 0.1):
			return walk_state;
		return idle_state;
	return null;
