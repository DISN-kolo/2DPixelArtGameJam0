extends CharacterBody2D


const SPEED = 300.0;
const JUMP_VELOCITY = -400.0;

const FRAMES_IN_CACHE : int = 30;

## I called it imperfect because it seems hacky and to suck from
##the frame and delta-time design pov.
var imperfect_framebased_pos_buffer: Array[Vector2] = [];

@onready var label_state: Label;
@onready var label_crouched: Label;
@onready var label_misc: Label;
@onready var label_jump_held: Label;

@onready var controllers: Node = $Controllers;

@onready var state_machine: StateMachine = $Controllers/StateMachine;
@onready var crouch_machine: StateMachine = $Controllers/CrouchMachine;

var lagging_speed_len : float = 0;

func custom_is_on_floor() -> bool:
	if ($CustomFloorCollider.has_overlapping_bodies()):
		if (!$CustomAntiFloorCollider.has_overlapping_bodies()):
			return true;
		var lower_list = $CustomAntiFloorCollider.get_overlapping_bodies();
		var upper_list = $CustomAntiFloorCollider.get_overlapping_bodies();
		var had_both : bool = false;
		for overlapper in lower_list:
			if overlapper.is_in_group("all_walls_floors"):
				if (upper_list.has(overlapper)):
					had_both = true;
					break ;
		if (had_both):
			return false;
		return true;
	return false;

func _ready() -> void:
	imperfect_framebased_pos_buffer.resize(FRAMES_IN_CACHE);
	imperfect_framebased_pos_buffer.fill(position);
	state_machine.state_changed.connect(_on_state_changed.bind(label_state));
	state_machine.init(self);
	crouch_machine.state_changed.connect(_on_state_changed.bind(label_crouched));
	crouch_machine.init(self);
	controllers.me = self;
	Signals.killzone_entered.connect(_on_killzone_entered);

func _unhandled_input(event) -> void:
	state_machine.process_input(event);
	crouch_machine.process_input(event);
	if event.is_action_pressed("jump"):
		label_jump_held.text = "HELD";
	if event.is_action_released("jump"):
		label_jump_held.text = "OFF";

func update_ifpb() -> void:
	# if this does actually tank performance, XXX: circular buffer
	imperfect_framebased_pos_buffer.pop_front();
	imperfect_framebased_pos_buffer.append(position);

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta);
	crouch_machine.process_physics(delta);
	if (is_on_floor()):
		update_ifpb();
		PlayerMetrics.last_global_pos = imperfect_framebased_pos_buffer[0];

	if (Settings.debugmode):
		label_misc.text = "";
		label_misc.text += "on floor?: %s\n" % ["yes" if is_on_floor() else "no"];
		label_misc.text += "custom fl: %s\n" % ["yes" if custom_is_on_floor() else "no"];
		label_misc.text += "on wall?:  %s\n" % ["yes" if is_on_wall() else "no"];
		label_misc.text += "coll mask: %x\n" % [collision_mask];
		label_misc.text += "aux jumps left: %d\n" % [PlayerMetrics.aux_jumps_left];
		label_misc.text += "max aux jumps : %d\n" % [PlayerMetrics.max_aux_jumps];
		label_misc.text += "
pos: %8.2f, %8.2f
lgp: %8.2f, %8.2f
vel: %8.2f, %8.2f
" % [
			position.x, position.y,
			PlayerMetrics.last_global_pos.x, PlayerMetrics.last_global_pos.y,
			velocity.x, velocity.y];

func _process(delta: float) -> void:
	state_machine.process_default(delta);
	crouch_machine.process_default(delta);

func _on_state_changed(state_name: String, label: Label) -> void:
	if (Settings.debugmode):
		label.set_text(state_name);

func _on_killzone_entered() -> void:
	position = PlayerMetrics.last_global_pos;
	velocity.y = 0;

func set_cam_limits(limits: Vector4i) -> void:
	$PCCam.limit_left = limits[0];
	$PCCam.limit_top = limits[1];
	$PCCam.limit_right = limits[2];
	$PCCam.limit_bottom = limits[3];
