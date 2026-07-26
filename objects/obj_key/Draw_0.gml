// Get Set of Keys at Position
var _keys_at_position = instances_at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), object_index);
var _key_position = 0, _total_keys = 0;
array_push(_keys_at_position, id);
array_sort(_keys_at_position, true);
for (var _i = 0; _i < array_length(_keys_at_position); _i++) {
	var _inst = _keys_at_position[_i];
	if (_inst.object_index == object_index) { _total_keys++; }
	if (_inst.id == id) { _key_position = _i; }
}

// Draw Full Set of Keys Once
if (_key_position == 0) {
	visible = true;
	
	// Sway Back and Forth
	var _sprite_x_center = sprite_get_width(sprite_index) / 2, _sprite_y_center = sprite_get_height(sprite_index) / 2;
	var _angle = 15 * dsin(shine_timer * 15 + sway_offset);
	var _radius = point_distance(0, 0, _sprite_x_center, _sprite_y_center);
	var _direction = point_direction(0, 0, -_sprite_x_center, -_sprite_y_center) + _angle;
	
	set_shader_palette();
	if (_total_keys == 1) { draw_sprite_ext(sprite_index, image_index, x + _sprite_x_center + lengthdir_x(_radius, _direction), y + _sprite_y_center + lengthdir_y(_radius, _direction), 1, 1, _angle, image_blend, image_alpha); }
	else if (_total_keys == 2) {
		draw_sprite(sprite_index, 0, x+2, y+2);
		draw_sprite(sprite_index, 0, x-2, y-2);
	}
	else if (_total_keys == 3) {
		draw_sprite(sprite_index, 0, x+2, y+2);
		draw_sprite(sprite_index, 0, x, y);
		draw_sprite(sprite_index, 0, x-2, y-2);
	}
	else if (_total_keys == 4) {
		draw_sprite(sprite_index, 0, x+3, y+3);
		draw_sprite(sprite_index, 0, x+1, y+1);
		draw_sprite(sprite_index, 0, x-1, y-1);
		draw_sprite(sprite_index, 0, x-3, y-3);
	}
	else if (_total_keys >= 5) {
		draw_sprite(sprite_index, 0, x+4, y+4);
		draw_sprite(sprite_index, 0, x+2, y+2);
		draw_sprite(sprite_index, 0, x, y);
		draw_sprite(sprite_index, 0, x-2, y-2);
		draw_sprite(sprite_index, 0, x-4, y-4);
	}
	
}
else { visible = false; }

