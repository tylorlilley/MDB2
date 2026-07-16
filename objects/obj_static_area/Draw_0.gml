// Determine Offset
var _x_offset = -32, _y_offset = -32;
if (!is_connected_above && !is_connected_on_left && is_connected_below && is_connected_on_right) { // Top Left Corner
	_x_offset = 0;
	_y_offset = 0;
}
else if (!is_connected_above && is_connected_on_left && is_connected_below && !is_connected_on_right) { // Top Right Corner
	_x_offset = 16;
	_y_offset = 0;
}
else if (!is_connected_above && is_connected_on_left && is_connected_below && is_connected_on_right) { // Top Side
	_x_offset = 8;
	_y_offset = 0;
}
else if (!is_connected_below && !is_connected_on_left && is_connected_above && is_connected_on_right) { // Bottom Left Corner
	_x_offset = 0;
	_y_offset = 16;
}
else if (!is_connected_below && is_connected_on_left && is_connected_above && !is_connected_on_right) { // Bottom Right Corner
	_x_offset = 16;
	_y_offset = 16;
}
else if (!is_connected_below && is_connected_on_left && is_connected_above && is_connected_on_right) { // Bottom Side
	_x_offset = 8;
	_y_offset = 16;
}
else if (is_connected_below && !is_connected_on_left && is_connected_above && is_connected_on_right) { // Left Side
	_x_offset = 0;
	_y_offset = 8;
}
else if (is_connected_below && is_connected_on_left && is_connected_above && !is_connected_on_right) { // Right Side
	_x_offset = 16;
	_y_offset = 8;
}
else if (is_connected_below && !is_connected_on_left && is_connected_above && !is_connected_on_right) { // Bridge From Right to Left
	_x_offset = 0;
	_y_offset = 24;
}
else if (!is_connected_below && is_connected_on_left && !is_connected_above && is_connected_on_right) { // Bridge From Left to Right
	_x_offset = 8;
	_y_offset = 24;
}
else if (!is_connected_below && !is_connected_on_left && !is_connected_above && !is_connected_on_right) { // Alone
	_x_offset = 16;
	_y_offset = 24;
}
else if (is_connected_below && !is_connected_on_left && !is_connected_above && !is_connected_on_right) { // Peninsula With Bottom
	_x_offset = 0;
	_y_offset = 32;
}
else if (!is_connected_below && !is_connected_on_left && is_connected_above && !is_connected_on_right) { // Peninsula With Top
	_x_offset = 8;
	_y_offset = 32;
}
else if (!is_connected_below && !is_connected_on_left && !is_connected_above && is_connected_on_right) { // Peninsula With Right
	_x_offset = 16;
	_y_offset = 32;
}
else if (!is_connected_below && is_connected_on_left && !is_connected_above && !is_connected_on_right) { // Peninsula With Left
	_x_offset = 24;
	_y_offset = 32;
}

// Calculate Outline Position
var _is_even_x = ((x div 8) % 2 == 0), _is_even_y = ((y div 8) % 2 == 0), _main_sprite_image_index = (hits-1 <= 0) ? 0 : hits-1;
var _main_left = ((_is_even_x) ? 0 : 8), _main_top = ((_is_even_y) ? 0 : 8), _main_width = 8, _main_height = 8, _main_x = x, _main_y = y;

if (outline_sprite != noone) {
	if (!is_connected_below) { _main_height--; }
	if (!is_connected_above) { _main_height--; _main_top++; _main_y++; }
	if (!is_connected_on_right) { _main_width--; }
	if (!is_connected_on_left) { _main_width--; _main_left++; _main_x++; }
}

// Draw Main Sprite
var _cut = 2; // corner size in px

var _cut_tl = (!is_connected_above && !is_connected_on_left);
var _cut_tr = (!is_connected_above && !is_connected_on_right);
var _cut_bl = (!is_connected_below && !is_connected_on_left);
var _cut_br = (!is_connected_below && !is_connected_on_right);

use_palette_shader();
if (main_sprite != noone) {
	if (!has_corners || (!_cut_tl && !_cut_tr && !_cut_bl && !_cut_br)) {
		// Fast path: no corners exposed, single draw
		draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left, _main_top, _main_width, _main_height, _main_x, _main_y, 1, 1, image_blend, image_alpha);
	}
	else {
		// Top band
		var _tb_l = _main_left  + (_cut_tl ? _cut : 0);
		var _tb_x = _main_x     + (_cut_tl ? _cut : 0);
		var _tb_w = _main_width - (_cut_tl ? _cut : 0) - (_cut_tr ? _cut : 0);
		draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _tb_l, _main_top, _tb_w, _cut, _tb_x, _main_y, 1, 1, image_blend, image_alpha);

		// Middle band (full width)
		var _mid_h = _main_height - _cut * 2;
		if (_mid_h > 0) {
			draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left, _main_top + _cut, _main_width, _mid_h, _main_x, _main_y + _cut, 1, 1, image_blend, image_alpha);
		}

		// Bottom band
		var _bb_l = _main_left  + (_cut_bl ? _cut : 0);
		var _bb_x = _main_x     + (_cut_bl ? _cut : 0);
		var _bb_w = _main_width - (_cut_bl ? _cut : 0) - (_cut_br ? _cut : 0);
		draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _bb_l, _main_top + _main_height - _cut, _bb_w, _cut, _bb_x, _main_y + _main_height - _cut, 1, 1, image_blend, image_alpha);
		
		// Restore the diagonal pixel of each rounded corner
		if (_cut_tl) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left + 1, _main_top + 1, 1, 1, _main_x + 1, _main_y + 1, 1, 1, image_blend, image_alpha); }
		if (_cut_tr) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left + _main_width - 2, _main_top + 1, 1, 1, _main_x + _main_width - 2, _main_y + 1, 1, 1, image_blend, image_alpha); }
		if (_cut_bl) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left + 1, _main_top + _main_height - 2, 1, 1, _main_x + 1, _main_y + _main_height - 2, 1, 1, image_blend, image_alpha); }
		if (_cut_br) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left + _main_width - 2, _main_top + _main_height - 2, 1, 1, _main_x + _main_width - 2, _main_y + _main_height - 2, 1, 1, image_blend, image_alpha); }
	}
}
if (fuzzing_sprite != noone) { draw_sprite_part(fuzzing_sprite, fuzzing_image_index, 0, 0, 8, 8, x, y); }

// Draw Outline Graphics
if (outline_sprite != noone) {
	if (_x_offset >= 0 && _y_offset >= 0) { draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	
	// Additionally Draw Corners	
	if (!is_connected_top_right && is_connected_above && is_connected_on_right) { draw_sprite_part(outline_sprite, 0, 32, 0, 8, 8, x, y); }
	if (!is_connected_top_left && is_connected_above && is_connected_on_left) { draw_sprite_part(outline_sprite, 0, 24, 0, 8, 8, x, y); }
	if (!is_connected_bottom_right && is_connected_below && is_connected_on_right) { draw_sprite_part(outline_sprite, 0, 32, 8, 8, 8, x, y); }
	if (!is_connected_bottom_left && is_connected_below && is_connected_on_left) { draw_sprite_part(outline_sprite, 0, 24, 8, 8, 8, x, y); }
}


shader_reset();