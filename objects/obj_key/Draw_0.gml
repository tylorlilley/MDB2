// Get Set of Keys at Position
var _keys_at_position = instances_at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), object_index, false);
var _key_position = 0, _total_keys = 0, _float_offset = get_float_value(float_timer, 1, 4 * FLOAT_OFFSET_PERIOD_FRAMES);
array_push(_keys_at_position, id);
array_sort(_keys_at_position, true);
for (var _i = 0; _i < array_length(_keys_at_position); _i++) {
	var _inst = _keys_at_position[_i];
	if (_inst.object_index == object_index) { _total_keys++; }
	if (_inst == id) { _key_position = _i; }
}

// Draw Full Set of Keys Once
if (_key_position == 0) {
	// Sway Back and Forth
	set_shader_palette((shine_timer == 1) ? PALETTES.ALL_WHITE : main_palette);
	
	var _keys_to_draw = min(_total_keys, 5), _offsets_for_total_keys = draw_offsets[_keys_to_draw-1];
	for (var _i = 0; _i < _keys_to_draw; _i++) {
		var _offset = _offsets_for_total_keys[_i], _angle_offset = _i * 2;
		draw_sprite_swaying(sprite_index, image_index, sway_timer, x + _offset, y + _offset + _float_offset, image_blend, image_alpha, 15, _angle_offset);
	}
}


