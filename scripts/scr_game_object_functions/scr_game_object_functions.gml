function instances_at_grid_position(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object) {
	var _grid_width = abs(_w) div 8, _grid_height = abs(_h) div  8;
	var _instances_at_current_position = [], _max_x = room_width div 8, _max_y = room_height div 8;
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = (_x div 8) + _grid_x, _checked_y = (_y div 8) + _grid_y;

			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) {
                continue;
            }
			
			var _instances_at_grid_position = global.controller.game_object_grid[_checked_x][_checked_y];
			for (var _i = 0; _i < array_length(_instances_at_grid_position); _i++) {
				var _inst = _instances_at_grid_position[_i];
				if (instance_exists(_inst) && id != _inst.id && _inst.is_a(_object_index) && !array_contains(_instances_at_current_position, _inst.id)) {
					array_push(_instances_at_current_position, _inst.id);
				}
			}
		}
	}
	return _instances_at_current_position;
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

function at_grid_position_exact(_x, _y, _w = 8, _h = 8, _object_index = obj_game_object) {
	return array_length(instances_at_grid_position_exact(_x, _y, _w, _h, _object_index)) > 0;
}

function grid_array_first(_array) {
	return (array_length(_array) > 0) ? _array[0] : noone;
}
