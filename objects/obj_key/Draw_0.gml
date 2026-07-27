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
	// Sway Back and Forth
	var _sprite_x_center = sprite_get_width(sprite_index) / 2, _sprite_y_center = sprite_get_height(sprite_index) / 2;
	var _radius = point_distance(0, 0, _sprite_x_center, _sprite_y_center);
	var _offsets = [[0], [2,-2], [2,0,-2], [3,1,-1,-3], [4,2,0,-2,-4]];
	set_shader_palette((shine_timer == 0) ? PALETTES.ALL_WHITE : main_palette);
	
	var _keys_to_draw = min(_total_keys, 5), _offsets_for_total_keys = _offsets[_keys_to_draw-1];
	for (var _i = 0; _i < _keys_to_draw; _i++) {
		var _offset = _offsets_for_total_keys[_i], _angle_offset = _i * 2;
		var _angle = 15 * dsin(max(sway_timer + _angle_offset, 0) * 15);
		var _direction = point_direction(0, 0, -_sprite_x_center, -_sprite_y_center) + _angle;
		
		draw_sprite_ext(sprite_index, image_index, x + _offset + _sprite_x_center + lengthdir_x(_radius, _direction), y + _offset + _sprite_y_center + lengthdir_y(_radius, _direction), 1, 1, _angle, image_blend, image_alpha);
	}
}


