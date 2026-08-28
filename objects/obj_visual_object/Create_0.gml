// Game Maker Variables
image_blend = global.world_tint;
image_speed = 0;
shine_timer = 0;
virtual_y = y;
virtual_x = x;
virtual_y_offset = 0;

// New Variables
if (!variable_instance_exists(id, "main_palette")) { main_palette = undefined; }
particle_palette = main_palette;

grid_add = function(_grid_to_add = global.controller.game_object_grid) {
	if (!instance_exists(id)) { return false; }
	
	var _grid_width = sprite_get_width(sprite_index) div GRID_SIZE, _grid_height = sprite_get_height(sprite_index) div  GRID_SIZE;
	var _max_x = room_width div GRID_SIZE, _max_y = room_height div GRID_SIZE;
	
	for (var _grid_x = 0; _grid_x < _grid_width; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _grid_height; _grid_y++) {
			var _checked_x = x div GRID_SIZE + _grid_x, _checked_y = y div GRID_SIZE + _grid_y;
			
			if (_checked_x < 0 || _checked_x >= _max_x || _checked_y < 0 || _checked_y >= _max_y) { continue; }
			array_push(_grid_to_add[_checked_x][_checked_y], id);
		}
	}
	return true;
}

is_a = function(_object_index) {
	return (object_index == _object_index || object_is_ancestor(object_index, _object_index));
}

set_depth = function(_depth) {
	depth = _depth;
	interaction_depth = _depth;
}

get_x_draw_offset = function() {
	return ((is_left) ? sprite_get_width(sprite_index) : 0);
}

get_left_value = function() {
	return ((is_left) ? -1 : 1);
}

draw_dynamic_object = function(_x_offset = 0, _y_offset = 0, _image_alpha = undefined) {
	_image_alpha ??= image_alpha;
	set_shader_palette((shine_timer == 1) ? PALETTES.ALL_WHITE : main_palette);
	draw_sprite_with_center_rotation(sprite_index, image_index, virtual_x + get_x_draw_offset() + _x_offset, virtual_y + virtual_y_offset + _y_offset, get_left_value(), 1, image_angle, image_blend, _image_alpha);
}

set_dim_timer = function(_val) {
	total_dim_timer = _val / global.controller.fps_ratio;
	dim_timer = total_dim_timer;
}


// Initial Create Code
set_depth(VISUAL_OBJECT_DEPTH);