var _area_above = at_grid_position(x, y-8, 8, 8, object_index);
var _area_below = at_grid_position(x, y+8, 8, 8, object_index);
var _area_left = at_grid_position(x-8, y, 8, 8, object_index);
var _area_right = at_grid_position(x+8, y, 8, 8, object_index);

var _x_offset = -32, _y_offset = -32;
if (_area_above && _area_below && _area_left && _area_right) { // Surrounded on All Sides
	_x_offset = 4;
	_y_offset = 4;
}
else if (!_area_above && !_area_left && _area_below && _area_right) { // Top Left Corner
	_x_offset = 0;
	_y_offset = 0;
}
else if (!_area_above && _area_left && _area_below && !_area_right) { // Top Right Corner
	_x_offset = 8;
	_y_offset = 0;
}
else if (!_area_above && _area_left && _area_below && _area_right) { // Top Side
	_x_offset = 4;
	_y_offset = 0;
}
else if (!_area_below && !_area_left && _area_above && _area_right) { // Bottom Left Corner
	_x_offset = 0;
	_y_offset = 8;
}
else if (!_area_below && _area_left && _area_above && !_area_right) { // Nottom Right Corner
	_x_offset = 8;
	_y_offset = 8;
}
else if (!_area_below && _area_left && _area_above && _area_right) { // Bottom Side
	_x_offset = 4;
	_y_offset = 8;
}
else if (_area_below && !_area_left && _area_above && _area_right) { // Left Side
	_x_offset = 0;
	_y_offset = 4;
}
else if (_area_below && _area_left && _area_above && !_area_right) { // Right Side
	_x_offset = 8;
	_y_offset = 4;
}
else if (_area_below && !_area_left && !_area_above && !_area_right) { // Peninsula With Bottom
	_x_offset = 0;
	_y_offset = 24;
}
else if (!_area_below && !_area_left && _area_above && !_area_right) { // Peninsula With Top
	_x_offset = 8;
	_y_offset = 24;
}
else if (!_area_below && !_area_left && !_area_above && _area_right) { // Peninsula With Right
	_x_offset = 16;
	_y_offset = 24;
}
else if (!_area_below && _area_left && !_area_above && !_area_right) { // Peninsula With Bottom
	_x_offset = 24;
	_y_offset = 24;
}

else if (_area_below && !_area_left && _area_above && !_area_right) { // Bridge From Right to Left
	_x_offset = 0;
	_y_offset = 16;
}
else if (!_area_below && _area_left && !_area_above && _area_right) { // Bridge From Left to Right
	_x_offset = 8;
	_y_offset = 16;
}
else if (!_area_below && !_area_left && !_area_above && !_area_right) { // Alone
	_x_offset = 16;
	_y_offset = 16;
}

// Draw Main Graphics
var _is_even_x = ((x div 8) % 2 == 0), _is_even_y = ((y div 8) % 2 == 0), _main_sprite_image_index = (hits-1 <= 0) ? 0 : hits-1;
draw_sprite_part(main_sprite, _main_sprite_image_index, ((_is_even_x) ? 0 : 8), ((_is_even_y) ? 0 : 8), 8, 8, x, y);
if (fuzzing_sprite != noone) {
	draw_sprite_part(fuzzing_sprite, fuzzing_image_index, 0, 0, 16, 16, x, y);
}

// Draw Outline Graphics
if (outline_sprite != noone) {
	draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y);
	
	// Additionally Draw Corners
	_x_offset = -1;
	_y_offset = -1;
	var _area_above_right = at_grid_position(x+8, y-8, 8, 8, object_index);
	var _area_above_left = at_grid_position(x-8, y-8, 8, 8, object_index);
	var _area_below_right = at_grid_position(x+8, y+8, 8, 8, object_index);
	var _area_below_left = at_grid_position(x-8, y+8, 8, 8, object_index);
	
	if (!_area_above_right && _area_above && _area_right) { _x_offset = 20; _y_offset = 0; draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	if (!_area_above_left && _area_above && _area_left) { _x_offset = 16; _y_offset = 0; draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	if (!_area_below_right && _area_below && _area_right) { _x_offset = 20; _y_offset = 4;  draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	if (!_area_below_left && _area_below && _area_left) { _x_offset = 16; _y_offset = 4;  draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
}
