// Solid Grid Functions
grid_move_to = function(_new_x, _new_y) {
	grid_remove();
	x = _new_x;
	y = _new_y;
	grid_add();
}

grid_remove = function() {
	var _grid_width = sprite_get_width(sprite_index) div GRID_SIZE, _grid_height = sprite_get_height(sprite_index) div  GRID_SIZE;
	var _max_x = room_width div GRID_SIZE, _max_y = room_height div GRID_SIZE;
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = x div GRID_SIZE + _grid_x, _checked_y = y div GRID_SIZE + _grid_y;
			
			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) { continue; }
			
			var _arr = global.controller.game_object_grid[_checked_x][_checked_y];
			var _index = array_get_index(_arr, id);
			if (_index != -1) { array_delete(_arr, _index, 1); }
		}
	}
}

// State Querying Functions
is_fully_on_ground = function() {
	var _sprite_width = sprite_get_width(sprite_index), _sprite_height = sprite_get_height(sprite_index);
	for (var _x = x; _x < x + _sprite_width; _x += GRID_SIZE) {
		if (array_length(get_objects_at(_x, y + _sprite_height, GRID_SIZE, GRID_SIZE, function(_inst) { return _inst.is_solid_from_above; })) == 0) { return false; }
	}
	return true;
}

get_relative_objects = function(_x_offset, _y_offset, _pred, _ignored_objects = [], _object_index = obj_game_object) {
	var _sprite_width = sprite_get_width(sprite_index), _sprite_height = sprite_get_height(sprite_index);
	var _x = x + _x_offset, _y = y + _y_offset, _width = _sprite_width, _height = _sprite_height;
	
	
	if (_x_offset > 0) { _x += _sprite_width - GRID_SIZE; }
	if (_y_offset > 0) { _y += _sprite_height - GRID_SIZE; }
	if (_x_offset != 0) { _width = GRID_SIZE; }
	if (_y_offset != 0) { _height = GRID_SIZE; }
	
	return get_objects_at(_x, _y, _width, _height, _pred, _ignored_objects, _object_index);
}

get_left_ceiling_objects = function(_ignored_objects = []) {
	return get_relative_objects(-GRID_SIZE, -GRID_SIZE, function(_inst) {
        return _inst.is_solid_from_below;
    }, _ignored_objects);
}

get_right_ceiling_objects = function(_ignored_objects = []) {
	return get_relative_objects(GRID_SIZE, -GRID_SIZE, function(_inst) {
        return _inst.is_solid_from_below;
    }, _ignored_objects);
}

get_inside_objects = function(_object_index = obj_game_object, _pred = always_true, _ignored_objects = []) {
	return get_relative_objects(0, 0, _pred, _ignored_objects, _object_index);
}

is_inside_object = function(_object_index = obj_game_object, _pred = always_true, _ignored_objects = []) {
	return array_length(get_inside_objects(_object_index, _pred, _ignored_objects)) > 0;
}

get_inside_solids = function(_ignored_objects = []) {
	return get_inside_objects(obj_game_object, function(_inst) {
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
	
	return (!is_connected || !at_grid_position(x-GRID_SIZE, y, GRID_SIZE, GRID_SIZE, object_index));
}

can_be_climbed_from_right = function(_ignored_objects = []) {
	if (!is_climbable) { return false; }
	if (array_length(get_right_ceiling_objects(_ignored_objects)) > 0) { return false; }
	
	return (!is_connected || !at_grid_position(x+GRID_SIZE, y, GRID_SIZE, GRID_SIZE, object_index));
}

is_solid_from_all_sides = function() {
	return is_solid_from_right && is_solid_from_left && is_solid_from_below && is_solid_from_above;
}

// Visual Effect Functions
get_float_offset = function() { return 0; }

part_destroyed = function() { }

part_damaged = function() { }

update_virtual_y_offset = function() { }

reset_shine_timer = function() {
	shine_timer = 120 + irandom(16);
}

draw_liquid = function() {
	var _area_above = at_grid_position(x, y-GRID_SIZE, GRID_SIZE, GRID_SIZE, object_index, false), _y_offset = (_area_above) ? 0 : 4;

	set_shader_palette();
	
	draw_sprite_part_ext(spr_box_8x8, 0, 0, _y_offset, GRID_SIZE, GRID_SIZE-_y_offset, x, y+_y_offset, 1, 1, image_blend, image_alpha);
	if (!_area_above) {
		var _x_offset = (anim_timer div 8 % 8);
		draw_sprite_part_ext(spr_water_outline, 0, _x_offset, 0, GRID_SIZE-_x_offset, _y_offset, x, y, 1, 1, image_blend, image_alpha);
		draw_sprite_part_ext(spr_water_outline, 0, 0, 0, _x_offset, _y_offset, x+(GRID_SIZE-_x_offset), y, 1, 1, image_blend, image_alpha);
	}
}

// Game Action Functions
deal_damage = function() { }

walk_on = function() {
	if (audio_exists(step_sound)) { play_sound(step_sound); }
	
	create_walk_particles();
}

fall_on = function(_fall_dist) {
	if (is_fragile) { get_damaged(); }
	else if (audio_exists(step_sound)) { play_sound(step_sound); }
	
	if (instance_exists(id)) { create_walk_particles(_fall_dist/16); }
}

fly_into = function(_fall_dist) {
	fall_on(_fall_dist);
}

create_walk_particles = function(_particle_amount = 1) {
	if (particle_frequency <= 0) { return; }

	var _particle_frequency = sqr(particle_frequency) / 32.0;
	if (random(1) < _particle_frequency) { create_particles(_particle_amount); }
}

powerfall_on = function(_other = noone) {
	get_damaged();
	global.controller.start_screen_shake();
	if (is_connected) {
		var _connected_instances = get_connected_instances([id]);
		for (var _i = 0; _i < array_length(_connected_instances); _i++) {
			var _inst = _connected_instances[_i];
			if (!instance_exists(_inst) || id == _inst) { continue; }
			else { _inst.get_damaged(); }
		}
	}
}

powerfly_into = function(_other = noone) {
	powerfall_on(_other);
}

get_damaged = function() {
	if (instance_exists(creator)) { creator.part_damaged(id); }
	if (!instance_exists(id)) { return; } // Guard in case destroyed by part_damaged in creator
	
	// Hanlde invulnerable objects explicitly
	if (hits <= 0) { play_sound(damaged_sound); return; }
	
	hits--;
	if (hits > 0) { play_sound(damaged_sound); create_particles(2) }
	else { instance_destroy(); }
}

get_connected_instances = function(_connected_instances) {
	for (var _dir = 0; _dir < 4; _dir++) {
		var _x_offset = 0, _y_offset = 0;
		if (_dir == 0) { _x_offset = GRID_SIZE; }
		if (_dir == 1) { _x_offset = -GRID_SIZE; }
		if (_dir == 2) { _y_offset = GRID_SIZE; }
		if (_dir == 3) { _y_offset = -GRID_SIZE; }
			
		var _instances_to_check = instances_at_grid_position(x+_x_offset, y+_y_offset, 8, 8, object_index, false);
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