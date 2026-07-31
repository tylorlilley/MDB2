function instances_at_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	var _grid_width = abs(_w) div 8, _grid_height = abs(_h) div  8;
	var _returned_instances = [], _max_x = room_width div 8, _max_y = room_height div 8, _min_x = 0, _min_y = 0;
	if (_ignore_outside_border) {
		var _border_size = (global.original_controls) ? 2 : 1;
		_max_x -= _border_size;
		_min_x += _border_size;
		_min_y += _border_size;
	}
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = (_x div 8) + _grid_x, _checked_y = (_y div 8) + _grid_y;

			if (_checked_x < _min_x || _checked_x >= _max_x || _checked_y < _min_y || _checked_y >= _max_y) {
                continue;
            }
			
			var _instances_at_grid_position = global.controller.game_object_grid[_checked_x][_checked_y];
			for (var _i = 0; _i < array_length(_instances_at_grid_position); _i++) {
				var _inst = _instances_at_grid_position[_i];
				if (instance_exists(_inst) && id != _inst && _inst.is_a(_object_index) && !array_contains(_returned_instances, _inst)) {
					array_push(_returned_instances, _inst);
				}
			}
		}
	}
	return _returned_instances;
}

// Checks if a single instance is at every position - doesn't count as an overlap of two instances with the same object index, like two ladders.
function instances_at_grid_position_exact(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	var _initial_instances = instances_at_grid_position(_x, _y, 8, 8, _object_index, _ignore_outside_border);
	var _instances_at_grid_position = [];
	array_copy(_instances_at_grid_position, 0, _initial_instances, 0, array_length(_initial_instances));
	for (var _grid_x = 0; _grid_x < _w; _grid_x += 8) {
		for (var _grid_y = 0; _grid_y < _h; _grid_y += 8) {
			var _potential_instances = instances_at_grid_position(_x+_grid_x, _y+_grid_y, 8, 8, _object_index, _ignore_outside_border);
			for (var _i = array_length(_instances_at_grid_position) - 1; _i >= 0; _i--) {
				var _inst = _instances_at_grid_position[_i]
				if (!array_contains(_potential_instances, _inst)) { array_delete(_instances_at_grid_position, _i, 1); }
			}
		}
	}
	return _instances_at_grid_position
}

function is_instance_at_grid_position(_x, _y, _inst, _ignore_outside_border = true) {
	var _instances_at_position = instances_at_grid_position(_x, _y, GRID_SIZE, GRID_SIZE, _inst.object_index, _ignore_outside_border);
	for (var _i = 0; _i < array_length(_instances_at_position); _i++) {
		if (_inst == _instances_at_position[_i]) { return true; }
	}
	return false;
}

function at_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	return array_length(instances_at_grid_position(_x, _y, _w, _h, _object_index, _ignore_outside_border)) > 0;
}

function at_each_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	for (var _grid_x = 0; _grid_x < _w; _grid_x += 8) {
		for (var _grid_y = 0; _grid_y < _h; _grid_y += 8) {
			if (!at_grid_position(_x+_grid_x, _y+_grid_y, 8, 8, _object_index, _ignore_outside_border)) { return false; }
		}
	}
	return true;
}

function at_grid_position_exact(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object, _ignore_outside_border = true) {
	return array_length(instances_at_grid_position_exact(_x, _y, _w, _h, _object_index, _ignore_outside_border)) > 0;
}

function get_objects_at(_x_pos, _y_pos, _width, _height, _pred, _ignored_objects = [], _object_index = obj_game_object) {
	var _potential_objects = instances_at_grid_position(_x_pos, _y_pos, _width, _height, _object_index), _static_objects = [];

	for (var _i = 0; _i < array_length(_potential_objects); _i++)
	{
		var _inst = _potential_objects[_i];
		if (_inst.is_a(_object_index) && !array_contains(_ignored_objects, _inst) && _pred(_inst, _ignored_objects)) { array_push(_static_objects, _inst); }
	}
	
	return _static_objects;
}

// Misc
function grid_array_first(_array) {
	return (array_length(_array) > 0) ? _array[0] : noone;
}

function draw_sprite_silhoutte(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha) {
	gpu_set_fog(true, _silhoutte_color, 0, 0);
	draw_sprite_ext(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha);
	gpu_set_fog(false, _silhoutte_color, 0, 0);
}

function set_shader_palette(_palette_to_use = undefined) {
	if (is_undefined(_palette_to_use)) { _palette_to_use = main_palette; }
	shader_set_uniform_f_array(global.u_replacement_colors, global.palette_uniform_values[_palette_to_use]);
	set_shader_clip();
}

function set_shader_clip(_sprite = noone, _subimg = 0, _left = 0, _top = 0, _x = 0, _y = 0, _width = 0, _height = 0) {
	if (_sprite == noone) { shader_set_uniform_f(global.u_clip_enabled, 0); return; }
	
	var _uvs = sprite_get_uvs(_sprite, _subimg);
	var _u_per_pixel = (_uvs[2] - _uvs[0]) / (sprite_get_width(_sprite) * _uvs[6]);
	var _v_per_pixel = (_uvs[3] - _uvs[1]) / (sprite_get_height(_sprite) * _uvs[7]);
	var _left_u = _uvs[0] + (_left - _uvs[4]) * _u_per_pixel;
	var _top_v = _uvs[1] + (_top - _uvs[5]) * _v_per_pixel;
	
	shader_set_uniform_f(global.u_clip_uvs, _left_u, _top_v, _left_u + _width * _u_per_pixel, _top_v + _height * _v_per_pixel);
	shader_set_uniform_f(global.u_clip_area, _x, _y, _width, _height);
	shader_set_uniform_f(global.u_clip_enabled, 1);
	texture_set_stage(global.u_clip_texture, sprite_get_texture(_sprite, _subimg));
}

function always_true() { return true; }

function instance_create(_x, _y, _obj) {
	return instance_create_depth(_x, _y, 0, _obj);
}

function draw_sprite_with_center_rotation(_sprite_index, _image_index, _x, _y, _x_scale, _y_scale, _angle, _color, _alpha) {
	var _sprite_x_center = sprite_get_width(_sprite_index) / 2, _sprite_y_center = sprite_get_height(_sprite_index) / 2;
	var _radius = point_distance(0, 0, _sprite_x_center, _sprite_y_center);
	var _direction = point_direction(0, 0, -_sprite_x_center, -_sprite_y_center) + _angle;
		
	draw_sprite_ext(_sprite_index, _image_index, _x + _sprite_x_center + lengthdir_x(_radius, _direction), _y + _sprite_y_center + lengthdir_y(_radius, _direction), _x_scale, _y_scale, _angle, _color, _alpha);
}