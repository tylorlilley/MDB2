enum STATES {
	STILL,
	FALLING,
	PUSHED
}

is_fixed = true;

is_left = false;
is_up = false;

is_ground = false;
is_ceiling = false;
is_right_wall = false;
is_left_wall = false;

is_climbable = false;
is_pushable = false;
is_moving = false;

hits = 0;
move_timer = 0;
virtual_y = y;
virtual_x = x;
transition_timer = 0;

get_solid_objects = function(x_offset, y_offset, func, only_full_solids = false) {
	var _solid_objects = ds_list_create(), _total_potential_objects = instance_place_list(x+x_offset, y+y_offset, obj_game_object, _solid_objects, true);


	for (var i = _total_potential_objects-1; i >= 0; i--)
	{
		var obj = _solid_objects[| i];
		var _inside_obj =  place_meeting(x, y, obj);
		if (!instance_exists(obj) || obj.id == id || !method_call(method(obj.id, func), [only_full_solids]) || _inside_obj) { ds_list_delete(_solid_objects, i); }
	}
	
	return _solid_objects;
}

// Get List of Specified Objects
get_left_wall_objects = function(only_full_solids = false) {
	return get_solid_objects(-8, 0, is_solid_from_right, only_full_solids);
}

get_right_wall_objects = function(only_full_solids = false) {
	return get_solid_objects(8, 0, is_solid_from_left, only_full_solids);
}

get_ground_objects = function(only_full_solids = false) {
	return get_solid_objects(0, 8, is_solid_from_above, only_full_solids);
}

get_ceiling_objects = function(only_full_solids = false) {
	var _ceiling_objects = get_solid_objects(0, -8, is_solid_from_below, only_full_solids);
	for (var i = ds_list_size(_ceiling_objects)-1; i >= 0; i--)
	{
		var obj = _ceiling_objects[| i];
		if (obj.y >= y) { ds_list_delete(_ceiling_objects, i); }
	}
	return _ceiling_objects;
}

get_left_ceiling_objects = function() {
	return get_solid_objects(-16, -8, is_solid_from_below);
}

get_right_ceiling_objects = function() {
	return get_solid_objects(16, -8, is_solid_from_below);
}

get_left_pushable_objects = function() {
	return get_solid_objects(-8, 0, can_be_pushed_left);
}

get_right_pushable_objects = function() {
	return get_solid_objects(8, 0, can_be_pushed_right);
}

get_left_climbable_objects = function() {
	return get_solid_objects(-8, 0, can_be_climbed_from_right);
}

get_right_climbable_objects = function() {
	return get_solid_objects(8, 0, can_be_climbed_from_left);
}


// Boolean Checks
is_grounded = function(only_full_solids = false) {
	var _ground_objects = get_ground_objects(only_full_solids);
	var _on_ground = (ds_list_size(_ground_objects) > 0);
	ds_list_destroy(_ground_objects);
	return _on_ground;
}

is_under_ceiling = function(only_full_solids = false) {
	var _ceiling_objects = get_ceiling_objects(only_full_solids);
	var _under_ceiling = (ds_list_size(_ceiling_objects) > 0);
	ds_list_destroy(_ceiling_objects);
	return _under_ceiling;
}

is_blocked_on_left = function(only_full_solids = false) {
	var _wall_objects = get_left_wall_objects(only_full_solids);
	var _is_blocked = (ds_list_size(_wall_objects) > 0);
	ds_list_destroy(_wall_objects);
	return _is_blocked;
}

is_blocked_on_right = function(only_full_solids = false) {
	var _wall_objects = get_right_wall_objects(only_full_solids);
	var _is_blocked = (ds_list_size(_wall_objects) > 0);
	ds_list_destroy(_wall_objects);
	return _is_blocked;
}

get_closest_ladder = function() {
	var _closest_ladder = noone, _most_ladder_overlap = 0;
	var _ladder_objects = ds_list_create(), _total_ladder_objects = instance_place_list(x, y, obj_ladder, _ladder_objects, true);
	
	for (var i = 0; i < _total_ladder_objects; i++) {
		var _ladder = _ladder_objects[| i];
		if (x == _ladder.x) { _closest_ladder = _ladder; }
	}
	
	ds_list_destroy(_ladder_objects);
	return _closest_ladder;
}

can_ladder_up = function() {
	var _closest_ladder = get_closest_ladder();
	return (
		instance_exists(_closest_ladder) &&
		(y > _closest_ladder.y || place_meeting(x, _closest_ladder.y-sprite_height, obj_ladder))
	);
}

can_ladder_down = function() {
	var _closest_ladder = get_closest_ladder();
	return (
		instance_exists(_closest_ladder) &&
		(!is_grounded() || place_meeting(x, y, obj_solid) ||  place_meeting(x, _closest_ladder.y+sprite_height, obj_ladder))
	);
}

can_start_laddering = function() {
	var _closest_ladder = get_closest_ladder();
	return (instance_exists(_closest_ladder) && x == _closest_ladder.x && y == _closest_ladder.y);
}

can_be_pushed_left = function() {
	if (!is_pushable || !is_grounded()) { return false; }
	
	// Check if blocked by a right wall
	var _wall_list = get_left_wall_objects(), _can_be_pushed = ds_list_empty(_wall_list);
	ds_list_destroy(_wall_list);
	return _can_be_pushed;
}

can_be_pushed_right = function() {
	if (!is_pushable || !is_grounded()) { return false; }
	
	// Check if blocked by a right wall
	var _wall_list = get_right_wall_objects(), _can_be_pushed = ds_list_empty(_wall_list);
	ds_list_destroy(_wall_list);
	return _can_be_pushed;
}

can_be_climbed_from_left = function() {
	if (!is_climbable) { return false; }
	
	// Check if blocked by a left ceiling
	var _ceiling_list = get_left_ceiling_objects(), _can_be_climbed = ds_list_empty(_ceiling_list);
	ds_list_destroy(_ceiling_list);
	return _can_be_climbed;
}

can_be_climbed_from_right = function() {
	if (!is_climbable) { return false; }
	
	// Check if blocked by a left ceiling
	var _ceiling_list = get_right_ceiling_objects(), _can_be_climbed = ds_list_empty(_ceiling_list);
	ds_list_destroy(_ceiling_list);
	return _can_be_climbed;
}

is_solid_from_below = function(only_full_solids = false) {
	return is_ceiling && (is_solid_from_all_sides() || !only_full_solids);
}

is_solid_from_above = function(only_full_solids = false) {
	return is_ground && (is_solid_from_all_sides() || !only_full_solids);
}

is_solid_from_left = function(only_full_solids = false) {
	return is_left_wall && (is_solid_from_all_sides() || !only_full_solids);
}

is_solid_from_right = function(only_full_solids = false) {
	return is_right_wall && (is_solid_from_all_sides() || !only_full_solids);
}

is_solid_from_all_sides = function() {
	return is_right_wall && is_left_wall && is_ceiling && is_ground;
}

instance_overlap_area = function(other_instance) {
	if (other_instance == noone) { return 0; }

	var _left = x - (sprite_width/2), _top = y - (sprite_height/2), _right = x + (sprite_width/2), _bottom = y + (sprite_height/2);
	var _other_left = other_instance.x - (other_instance.sprite_width/2), _other_top = other_instance.y - (other_instance.sprite_height/2);
	var _other_right = other_instance.x + (other_instance.sprite_width/2), _other_bottom = other_instance.y + (other_instance.sprite_height/2);
	var _overlap_left = max(_left, _other_left), _overlap_top = max(_top, _other_top), _overlap_right = min(_right, _other_right), _overlap_bottom = min(_bottom, _other_bottom);
	
	if (_overlap_right > _overlap_left && _overlap_bottom > _overlap_top) { return ((_overlap_right - _overlap_left) * (_overlap_bottom - _overlap_top)); }
	else { return 0; }
}

is_overlapping = function(other_instance) {
	return (instance_overlap_area(other_instance) >= 2 * (sprite_width/2) * (sprite_height/2));
}

x_move = function(amount) {
	for (var i = 0; i < abs(amount); i++) {
		if (amount > 0) {
			if (!is_blocked_on_right()) { x++; }
			else { return i; }
		}
		else {
			if (!is_blocked_on_left()) { x--; }
			else {return i; }
		}
	}
}

y_move = function(amount) {
	for (var i = 0; i < abs(amount); i++) {
		if (amount > 0) {
			if (!is_grounded()) { y++; }
			else { return i; }
		}
		else {
			if (!is_under_ceiling()) { y--; }
			else {return i; }
		}
	}
}