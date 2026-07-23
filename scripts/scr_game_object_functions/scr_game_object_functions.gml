// Solid Grid Functions
grid_move_to = function(_new_x, _new_y) {
	grid_remove();
	x = _new_x;
	y = _new_y;
	grid_add();
}

grid_add = function() {
	var _grid_width = sprite_get_width(sprite_index) div 8, _grid_height = sprite_get_height(sprite_index) div  8;
	var _max_x = room_width div 8, _max_y = room_height div 8;
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = x div 8 + _grid_x, _checked_y = y div 8 + _grid_y;
			
			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) { continue; }
			array_push(global.controller.game_object_grid[_checked_x][_checked_y], id);
		}
	}
}

grid_remove = function() {
	var _grid_width = sprite_get_width(sprite_index) div 8, _grid_height = sprite_get_height(sprite_index) div  8;
	var _max_x = room_width div 8, _max_y = room_height div 8;
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = x div 8 + _grid_x, _checked_y = y div 8 + _grid_y;
			
			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) { continue; }
			
			var _arr = global.controller.game_object_grid[_checked_x][_checked_y];
			var _index = array_get_index(_arr, id);
			if (_index != -1) { array_delete(_arr, _index, 1); }
		}
	}
}

// State Querying Functions
get_objects_at = function(_x_pos, _y_pos, _width, _height, _pred, _ignored_objects = [], _object_index = obj_game_object) {
	var _potential_objects = instances_at_grid_position(_x_pos, _y_pos, _width, _height), _static_objects = [];

	for (var _i = 0; _i < array_length(_potential_objects); _i++)
	{
		var _inst = _potential_objects[_i];
		if (is_a(_inst, _object_index) && !array_contains(_ignored_objects, _inst) && _pred(_inst, _ignored_objects)) { array_push(_static_objects, _inst); }
	}
	
	return _static_objects;
}

is_fully_on_ground = function() {
	var _sprite_width = sprite_get_width(sprite_index), _sprite_height = sprite_get_height(sprite_index);
	for (var _x = x; _x < x + _sprite_width; _x += 8) {
		if (array_length(get_objects_at(_x, y + _sprite_height, 8, 8, function(_inst) { return _inst.is_solid_from_above; })) == 0) { return false; }
	}
	return true;
}

get_relative_objects = function(_x_offset, _y_offset, _pred, _ignored_objects = [], _object_index = obj_game_object) {
	var _sprite_width = sprite_get_width(sprite_index), _sprite_height = sprite_get_height(sprite_index);
	var _x = x + _x_offset, _y = y + _y_offset, _width = _sprite_width, _height = _sprite_height;
	if (_x_offset > 0) { _x += _sprite_width - 8; }
	if (_y_offset > 0) { _y += _sprite_height - 8; }
	if (_x_offset != 0) { _width = 8; }
	if (_y_offset != 0) { _height = 8; }
	
	return get_objects_at(_x, _y, _width, _height, _pred, _ignored_objects, _object_index);
}

get_left_ceiling_objects = function(_ignored_objects = []) {
	return get_relative_objects(-8, -8, function(_inst) {
        return _inst.is_solid_from_below;
    }, _ignored_objects);
}

get_right_ceiling_objects = function(_ignored_objects = []) {
	return get_relative_objects(8, -8, function(_inst) {
        return _inst.is_solid_from_below;
    }, _ignored_objects);
}

get_inside_objects = function(_object_index = obj_game_object, _ignored_objects = []) {
	return get_relative_objects(0, 0, always_true, _ignored_objects, _object_index);
}

is_inside_object = function(_object_index = obj_game_object, _ignored_objects = []) {
	return array_length(get_inside_objects(_object_index, _ignored_objects)) > 0;
}

get_inside_solids = function(_ignored_objects = []) {
	return get_relative_objects(0, 0, function(_inst) {
        return _inst.is_solid_from_all_sides();
    }, _ignored_objects);
}

is_inside_solid = function(_ignored_objects = []) {
	return array_length(get_inside_solids(_ignored_objects)) > 0;
}

can_be_pushed_left = function() {
	if (!is_pushable || !is_on_ground()) { return false; }
	
	return array_length(get_left_wall_objects()) == 0;
}

can_be_pushed_right = function() {
	if (!is_pushable || !is_on_ground()) { return false; }

	return array_length(get_right_wall_objects()) == 0;
}

can_be_climbed_from_left = function(_ignored_objects = []) {
	if (!is_climbable) { return false; }
	if (array_length(get_left_ceiling_objects(_ignored_objects)) > 0) { return false; }
	
	return (!is_connected || !at_grid_position(x-8, y, 8, 8, object_index));
}

can_be_climbed_from_right = function(_ignored_objects = []) {
	if (!is_climbable) { return false; }
	if (array_length(get_right_ceiling_objects(_ignored_objects)) > 0) { return false; }
	
	return (!is_connected || !at_grid_position(x+8, y, 8, 8, object_index));
}

is_solid_from_all_sides = function() {
	return is_solid_from_right && is_solid_from_left && is_solid_from_below && is_solid_from_above;
}

// Visual Effect Functions
get_float_offset = function() { return 0; }

part_destroyed = function() { }

part_damaged = function() { }

create_particles = function(_total_particles, _palette = noone, _particle_sprite = spr_particle, _randomize = true) {
	if (_palette == noone) { _palette = (particle_palette == noone) ? get_darker_palette(main_palette) : particle_palette; }
	
	var  _move_left = irandom(1), _particles = [];
	for (var _i = 0; _i < _total_particles; _i++) {
		var _p = instance_create(x+sprite_get_width(sprite_index)/2, y+sprite_get_height(sprite_index)/2, obj_particle);
		array_push(_particles, _p);
		with (_p) {
			main_palette = _palette;
			sprite_index = _particle_sprite;
			image_speed = (_particle_sprite != spr_particle) ? 1 : 0; // TODO: make this a param
			depth = -9999;
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

create_sparkles = function(_max_amount, _palette = PALETTES.GRAY) {
	create_particles(_max_amount, _palette, spr_sparkle, true);
}

shine_periodically = function() {
	shine_timer--;
	if (shine_timer < 0) { shine_timer = 120 + irandom(16); if (visible) { create_sparkles(irandom(4)); } }
}

draw_liquid = function() {
	var _area_above = at_grid_position(x, y-8, 8, 8, object_index), _y_offset = (_area_above) ? 0 : 4;

	set_shader_palette();
	
	draw_sprite_part_ext(spr_box_8x8, 0, 0, _y_offset, 8, 8-_y_offset, x, y+_y_offset, 1, 1, image_blend, image_alpha);
	if (!_area_above) {
		var _x_offset = (anim_timer div 8 % 8);
		draw_sprite_part_ext(spr_water_outline, 0, _x_offset, 0, 8-_x_offset, _y_offset, x, y, 1, 1, image_blend, image_alpha);
		draw_sprite_part_ext(spr_water_outline, 0, 0, 0, _x_offset, _y_offset, x+(8-_x_offset), y, 1, 1, image_blend, image_alpha);
	}
}

// Game Action Functions
get_damaged = function() {
	if (instance_exists(creator)) { creator.part_damaged(id); }
	if (hits >= 1) { global.controller.screen_shake(); }
	hits--;
	if (hits == 0) { instance_destroy(); }
	else { play_sound(damaged_sound); }
	global.controller.should_rebuild_static_area = true;
}

fall_on = function(_fall_dist) {
	if (is_fragile) { get_damaged(); }
	else if (walk_particles > 0) {
		for (var _i = 0; _i < (_fall_dist % 4)+2; _i++) { create_walk_particles(); }
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
			var _inst =  _instances_to_check[_i]
			if (_inst.creator == creator && !array_contains(_connected_instances, _inst)) {
				array_push(_connected_instances, _inst);
				_inst.get_connected_instances(_connected_instances);
			}
		}
	}

	return _connected_instances;
}