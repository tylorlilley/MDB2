// Inherit the parent event
event_inherited();

is_ground = true;
is_ceiling = true;
is_right_wall = true;
is_left_wall = true;

is_climbable = true;
has_gravity = true;

walk_particles = 0;
step_sound = noone;

depth = 9;

get_float_offset = function() {
	var _ampliutude = 2, _period = 30, _swim_bob = round(_ampliutude * sin(swim_timer*(pi / _period)));
	swim_timer = swim_timer % _period;
	
	var _y_offset = (is_floating_state()) ? _swim_bob : 0;
	if (is_grounded_state()) {
		_y_offset = 999;
		var _ground_objects = get_ground_objects();
		for (var _i = 0; _i < array_length(_ground_objects); _i++) {
			var _inst = _ground_objects[_i];
			if (instance_exists(_inst) && object_is_ancestor(_inst.object_index, obj_dynamic_game_object) && (_inst.is_floating_state() || _inst.is_grounded_state())) {
				with (_inst) {
					_y_offset = min(_y_offset, get_float_offset());
				}
			}
		}
		if (_y_offset == 999) { _y_offset = 0; }
	}
	
	return _y_offset;
}

is_grounded_state = function() {
	return (state == STATES.PUSHED || state == STATES.STILL);
}

is_floating_state = function() {
	return state == STATES.FLOAT;
}
