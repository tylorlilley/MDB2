// Get Set of Keys at Position
var _keys_at_position = instances_at_grid_position_exact(x, y, sprite_get_width(sprite_width), sprite_get_height(sprite_height), object_index);
var _key_position = 0, _total_keys = 0;
for (var _i = 0; _i < array_length(_keys_at_position); _i++) {
	var _inst = _keys_at_position[_i];
	if (_inst.object_index == object_index) { _total_keys++; }
	if (_inst.id == id) { _key_position = _total_keys; }
}

// Draw Full Set of Keys Once
if (_key_position == 0) {
	use_palette_shader();
	
	if (_total_keys > 1) { draw_sprite(sprite_index, 0, x-4, y-4); } // Draw Top Left
	if (_total_keys > 3) { draw_sprite(sprite_index, 0, x+4, y-4); } // Draw Top Right
	if (_total_keys > 3) { draw_sprite(sprite_index, 0, x-4, y+4); } // Draw Bottom Left
	if (_total_keys > 2) { draw_sprite(sprite_index, 0, x+4, y+4); } // Draw Bottom Right
	if (_total_keys % 2 == 1) { draw_self(); } // Draw Center
}