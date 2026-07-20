function instances_at_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object) {
	var _grid_width = abs(_w) div 8, _grid_height = abs(_h) div  8;
	var _returned_instances = [], _max_x = room_width div 8, _max_y = room_height div 8;
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = (_x div 8) + _grid_x, _checked_y = (_y div 8) + _grid_y;

			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) {
                continue;
            }
			
			var _instances_at_grid_position = global.controller.game_object_grid[_checked_x][_checked_y];
			for (var _i = 0; _i < array_length(_instances_at_grid_position); _i++) {
				var _inst = _instances_at_grid_position[_i];
				if (instance_exists(_inst) && id != _inst.id && is_a(_inst, _object_index) && !array_contains(_returned_instances, _inst.id)) {
					array_push(_returned_instances, _inst.id);
				}
			}
		}
	}
	return _returned_instances;
}

function instances_at_grid_position_exact(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object) {
	var _initial_instances = instances_at_grid_position(_x, _y, 8, 8, _object_index);
	var _instances_at_grid_position = [];
	array_copy(_instances_at_grid_position, 0, _initial_instances, 0, array_length(_initial_instances));
	for (var _grid_x = 0; _grid_x < _w; _grid_x += 8) {
		for (var _grid_y = 0; _grid_y < _h; _grid_y += 8) {
			var _potential_instances = instances_at_grid_position(_x+_grid_x, _y+_grid_y, 8, 8, _object_index);
			for (var _i = array_length(_instances_at_grid_position) - 1; _i >= 0; _i--) {
				var _inst = _instances_at_grid_position[_i]
				if (!array_contains(_potential_instances, _inst.id)) { array_delete(_instances_at_grid_position, _i, 1); }
			}
		}
	}
	return _instances_at_grid_position
}

function at_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object) {
	return array_length(instances_at_grid_position(_x, _y, _w, _h, _object_index)) > 0;
}

function at_each_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object) {
	for (var _grid_x = 0; _grid_x < _w; _grid_x += 8) {
		for (var _grid_y = 0; _grid_y < _h; _grid_y += 8) {
			if (!at_grid_position(_x+_grid_x, _y+_grid_y, 8, 8, _object_index)) { return false; }
		}
	}
	return true;
}

function at_grid_position_exact(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object) {
	return array_length(instances_at_grid_position_exact(_x, _y, _w, _h, _object_index)) > 0;
}

function grid_array_first(_array) {
	return (array_length(_array) > 0) ? _array[0] : noone;
}

function draw_sprite_silhoutte(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha) {
	gpu_set_fog(true, _silhoutte_color, 0, 0);
	draw_sprite_ext(_sprite_index, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _silhoutte_color, _image_alpha);
	gpu_set_fog(false, _silhoutte_color, 0, 0);
}

function use_palette_shader() {
	if (main_palette != PALETTES.GRAY || shine_timer == 0) {
		shader_set(shd_palettizer);
		var _palette_to_use = ((shine_timer == 0) ? PALETTES.ALL_WHITE : main_palette);
		shader_set_uniform_f_array(global.controller.u_replacement_colors, global.palette_uniform_values[_palette_to_use]);
	}
}

function is_a(_inst, _object_index) {
	return (_inst.object_index == _object_index || object_is_ancestor(_inst.object_index, _object_index));
}

function always_true() { return true; }

function instance_create(_x, _y, _obj) {
	instance_create_depth(_x, _y, 0, _obj);
}