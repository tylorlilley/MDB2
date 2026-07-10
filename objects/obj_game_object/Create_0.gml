enum STATES {
	STILL,
	FALLING,
	PUSHED,
	SURFACE,
	FLOAT
}

has_gravity = false;

is_left = false;
is_up = false;

is_ground = false;
is_ceiling = false;
is_right_wall = false;
is_left_wall = false;

is_climbable = false;
is_pushable = false;
is_moving = false;
is_fragile = false;
is_connected = false;

hits = 1;
move_timer = 0;
virtual_y = y;
virtual_x = x;
transition_timer = 0;
state = STATES.STILL;
particle_color = c_white;
fall_timer = 0;
swim_timer = 0;
image_speed = 0;
destroyed_sound = snd_explosion;

grid_add = function() {
	var _grid_width = sprite_get_width(sprite_index) div 8, _grid_height = sprite_get_height(sprite_index) div  8;
	var _max_x = room_width div 8, _max_y = room_height div 8;
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = (x div 8) + _grid_x, _checked_y = (y div 8) + _grid_y;
			
			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) { continue; }
			array_push(global.controller.game_object_grid[_checked_x][_checked_y], id);
		}
	}
}

grid_add();

grid_remove = function() {
	var _grid_width = sprite_get_width(sprite_index) div 8, _grid_height = sprite_get_height(sprite_index) div  8;
	var _max_x = room_width div 8, _max_y = room_height div 8;
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = (x div 8) + _grid_x, _checked_y = (y div 8) + _grid_y;
			
			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) { continue; }
			
			var _arr = global.controller.game_object_grid[_checked_x][_checked_y];
			var _index = array_get_index(_arr, id);
			if (_index != -1) { array_delete(_arr, _index, 1); }
		}
	}
}

grid_move_to = function(_new_x, _new_y) {
	grid_remove();
	x = _new_x;
	y = _new_y;
	grid_add();
}

grid_move_horizontal = function() {
	var _x_offset = (is_left) ? -8 : 8;
	grid_move_to(x + _x_offset, y);
}

grid_move_reverse_horizontal = function() {
	var _x_offset = (is_left) ? 8 : -8;
	grid_move_to(x + _x_offset, y);
}

grid_move_up = function() {
	grid_move_to(x, y - 8);
}

grid_move_down = function() {
	grid_move_to(x, y + 8);
}

// Collision Detection
get_solid_objects_at = function(_x_pos, _y_pos, _width, _height, _pred, _only_full_solids = false) {
	var _overlapping_objects =  instances_at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index));
	var _potential_objects = instances_at_grid_position(_x_pos, _y_pos, _width, _height), _solid_objects = [];

	for (var _i = 0; _i < array_length(_potential_objects); _i++)
	{
		var _inst = _potential_objects[_i];
		if (_pred(_inst, _only_full_solids) && !array_contains(_overlapping_objects, _inst)) { array_push(_solid_objects, _inst); }
	}
	
	return _solid_objects;
}

get_relative_solid_objects = function(_x_offset, _y_offset, _pred, _only_full_solids = false) {
	return get_solid_objects_at(x + _x_offset, y + _y_offset, sprite_get_width(sprite_index), sprite_get_height(sprite_index), _pred, _only_full_solids);
}

// Get List of Specified Objects
/*
get_ground_objects_at  = function(_x_pos, _y_pos, _width = 8, _height = 8, _only_full_solids = false) {
	return get_solid_objects_at(_x_pos, _y_pos + 8, _width, _height, function(inst, ofs) {
        return inst.is_solid_from_above(ofs);
    }, _only_full_solids);
}
*/

get_ground_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(0, 8, function(inst, ofs) {
        return inst.is_solid_from_above(ofs);
    }, _only_full_solids);
}

get_left_wall_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(-8, 0, function(inst, ofs) {
        return inst.is_solid_from_right(ofs);
    }, _only_full_solids);
}

get_right_wall_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(8, 0, function(inst, ofs) {
        return inst.is_solid_from_left(ofs);
    }, _only_full_solids);
}

get_ceiling_objects = function(_only_full_solids = false) {
	return get_relative_solid_objects(0, -8, function(inst, ofs) {
        return inst.is_solid_from_below(ofs);
    }, _only_full_solids);
}

get_left_ceiling_objects = function() {
	return get_relative_solid_objects(-8, -8, function(inst) {
        return inst.is_solid_from_below();
    });
}

get_right_ceiling_objects = function() {
	return get_relative_solid_objects(8, -8, function(inst) {
        return inst.is_solid_from_below();
    });
}

get_left_ground_objects = function() {
	return get_relative_solid_objects(-8, 8, function(inst) {
        return inst.is_solid_from_above();
    });
}

get_right_ground_objects = function() {
	return get_relative_solid_objects(8, 8, function(inst) {
        return inst.is_solid_from_above();
    });
}

get_left_pushable_objects = function() {
	return get_relative_solid_objects(-8, 0, function(inst) {
        return inst.can_be_pushed_left();
    });
}

get_right_pushable_objects = function() {
	return get_relative_solid_objects(8, 0, function(inst) {
        return inst.can_be_pushed_right();
    });
}

get_left_climbable_objects = function() {
	return get_relative_solid_objects(-8, 0, function(inst) {
        return inst.can_be_climbed_from_right();
    });
}

get_right_climbable_objects = function() {
	return get_relative_solid_objects(8, 0, function(inst) {
        return inst.can_be_climbed_from_left();
    });
}

// Boolean Checks
is_grounded = function(_only_full_solids = false) {
	return array_length(get_ground_objects(_only_full_solids)) > 0;
}

is_under_ceiling = function(_only_full_solids = false) {
	return array_length(get_ceiling_objects(_only_full_solids)) > 0;
}

is_blocked_on_left = function(_only_full_solids = false) {
	return array_length(get_left_wall_objects(_only_full_solids)) > 0;
}

is_blocked_on_right = function(_only_full_solids = false) {
	return array_length(get_right_wall_objects(_only_full_solids)) > 0;
}

is_fully_submerged = function() {
	return at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_water);
}

is_partially_submerged = function() {
	return (at_grid_position(x, y+sprite_get_height(sprite_index)/2, sprite_get_width(sprite_index), sprite_get_height(sprite_index)/2, obj_water) &&
								!at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index)/2, obj_water));
}

get_inside_solids = function() {
	return get_relative_solid_objects(0, 0, function(inst) {
        return inst.is_solid_from_all_sides();
    });
}

is_inside_solid = function() {
	return array_length(get_inside_solids()) > 0;
}

get_closest_ladder = function() {
	var _closest_ladder = noone, _ladder_objects = instances_at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder);
	
	for (var _i = 0; _i < array_length(_ladder_objects); _i++) {
		var _ladder = _ladder_objects[_i];
		if (x == _ladder.x) { _closest_ladder = _ladder; }
	}
	
	return _closest_ladder;
}

can_ladder_up = function() {
	var _closest_ladder = get_closest_ladder();
	return (
		instance_exists(_closest_ladder) &&
		x == _closest_ladder.x &&
		(y > _closest_ladder.y || at_grid_position(x, _closest_ladder.y-sprite_get_height(sprite_index), sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder))
	);
}

/**
 * Function Description
 * @returns {bool} Description
 */
can_ladder_down = function() {
	var _closest_ladder = get_closest_ladder();
	return (
		instance_exists(_closest_ladder) &&
		x == _closest_ladder.x &&
		(!is_grounded(true) || at_grid_position(x, y + sprite_get_height(sprite_index), sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder))
	);
}

can_start_laddering = function() {
	return at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_ladder);
}

can_be_pushed_left = function() {
	if (!is_pushable || !is_grounded()) { return false; }
	
	return array_length(get_left_wall_objects()) == 0;
}

can_be_pushed_right = function() {
	if (!is_pushable || !is_grounded()) { return false; }

	return array_length(get_right_wall_objects()) == 0;
}

can_be_climbed_from_left = function() {
	if (!is_climbable) { return false; }
	if (array_length(get_right_ceiling_objects()) > 0) { return false; }
	
	return (!is_connected || !at_grid_position(x-8, y, 8, 8, object_index));
}

can_be_climbed_from_right = function() {
	if (!is_climbable) { return false; }
	if (array_length(get_right_ceiling_objects()) > 0) { return false; }
	
	return (!is_connected || !at_grid_position(x+8, y, 8, 8, object_index));
}

is_solid_from_below = function(_only_full_solids = false) {
	return is_ceiling && (is_solid_from_all_sides() || !_only_full_solids);
}

is_solid_from_above = function(_only_full_solids = false) {
	var _falling_state = false;
	_falling_state = false // (object_is_ancestor(object_index, obj_dynamic_game_object)) ? (!is_floating_state() && !is_grounded_state()) : false;
	return !_falling_state && is_ground && (is_solid_from_all_sides() || !_only_full_solids);
}

is_solid_from_left = function(_only_full_solids = false) {
	return is_left_wall && (is_solid_from_all_sides() || !_only_full_solids);
}

is_solid_from_right = function(_only_full_solids = false) {
	return is_right_wall && (is_solid_from_all_sides() || !_only_full_solids);
}

is_solid_from_all_sides = function() {
	return is_right_wall && is_left_wall && is_ceiling && is_ground;
}

get_float_offset = function() { return 0; }

create_particles = function(_total_particles, _randomize = true, _particle_sprite = spr_particle) {
	var  _move_left = irandom(1), _particles = [];
	for (var _i = 0; _i < _total_particles; _i++) {
		var _p = instance_create_depth(x+sprite_get_width(sprite_index)/2, y+sprite_get_height(sprite_index)/2, -5, obj_particle);
		array_push(_particles, _p);
		with (_p) {
			sprite_index = _particle_sprite;
			image_speed = (_particle_sprite != spr_particle) ? 1 : 0; // TODO make this a param
			depth = -9999;
			image_blend = other.particle_color;
			image_alpha = other.image_alpha;
			hspeed = random(4) / 2 * ((_move_left) ? -1 : 1);
			vspeed = (random(6) / 2 * -1) - 2;
			gravity = 0.5;
			
			if (_randomize) {
				if (irandom(3) == 0) { image_index = 1; }
				image_angle = irandom(3) * 90;
				image_xscale = (irandom(1) == 0) ? -1 : 1;
				image_yscale = (irandom(1) == 0) ? -1 : 1;
			}
			
			_move_left = !_move_left;
		}
	}
	return _particles;
}

// Game Action Functions
get_damaged = function() {
	hits--;
	if (hits == 0) { instance_destroy(); }
}

fall_on = function() {
	if (is_fragile) { get_damaged(); }
	else if (walk_particles > 0) {
		for (var _i = 0; _i < (fall_timer % 4)+2; _i++) { create_walk_particles(); }
	}
	if (audio_exists(step_sound)) { play_sound(step_sound); }
}

walk_on = function() {
	if (walk_particles > 0) { create_walk_particles(); }
	if (audio_exists(step_sound)) { play_sound(step_sound); }
}

create_walk_particles = function() {
	if (walk_particles <= 0) { return; }
	
	var _rand = irandom(8);
	if (_rand % (8/walk_particles) == 0) {
		create_particles(1);
	}
}

fly_into = function() {
	if (is_fragile) { get_damaged(); }
	else { create_particles(irandom(1)); }
}

powerfall_on = function() {
	powerfly_into();
}

powerfly_into = function() {
	get_damaged();
	if (is_connected) {
		var _connected_instances = get_connected_instances([id]);
		for (var _i = 0; _i < array_length(_connected_instances); _i++) {
			var _inst = _connected_instances[_i];
			if (!instance_exists(_inst) || id == _inst.id) { continue; }
			else { _inst.get_damaged(); }
		}
	}
}

get_connected_instances = function(_connected_instances) {
	for (var _dir = 0; _dir < 4; _dir++) {
		var _x_offset = 0, _y_offset = 0;
		if (_dir == 0) { _x_offset = 8; }
		if (_dir == 1) { _x_offset = -8; }
		if (_dir == 2) { _y_offset = 8; }
		if (_dir == 3) { _y_offset = -8; }
			
		var _instances_to_check = instances_at_grid_position(x+_x_offset, y+_y_offset, 8, 8, object_index);
		for (var _i = 0; _i < array_length(_instances_to_check); _i++) {
			var _inst_id =  _instances_to_check[_i].id
			if (!array_contains(_connected_instances, _inst_id)) {
				array_push(_connected_instances, _inst_id);
				array_concat(_connected_instances, _inst_id.get_connected_instances(_connected_instances));
			}
		}
	}

	return _connected_instances;
}