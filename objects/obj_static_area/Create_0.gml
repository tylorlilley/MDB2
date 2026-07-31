event_inherited();

visible = false;
depth = STATIC_AREA_DEPTH;

is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;

is_climbable = true;

step_sound = noone;
should_draw = true;
has_square_shape = false;

main_sprite = spr_box_16x16;
outline_sprite = noone;
outline_mask_sprite = undefined;
fuzzing_sprite = noone;
visual_origin_x = x;
visual_origin_y = y;
animated = false;

is_connected_above = noone;
is_connected_below = noone;
is_connected_on_left = noone;
is_connected_on_right = noone;
is_connected_top_right = noone;
is_connected_top_left = noone;
is_connected_bottom_right = noone;
is_connected_bottom_left = noone;

is_connected_far_top = noone;
is_connected_far_bottom = noone;
is_connected_on_far_left = noone;
is_connected_on_far_right = noone;

get_connections_for_graphics = function() {
	is_connected_above = grid_array_first(instances_at_grid_position(x, y-8, 8, 8, object_index, false));
	is_connected_below = grid_array_first(instances_at_grid_position(x, y+8, 8, 8, object_index, false));
	is_connected_on_left = grid_array_first(instances_at_grid_position(x-8, y, 8, 8, object_index, false));
	is_connected_on_right = grid_array_first(instances_at_grid_position(x+8, y, 8, 8, object_index, false));

	is_connected_top_right = grid_array_first(instances_at_grid_position(x+8, y-8, 8, 8, object_index, false));
	is_connected_top_left = grid_array_first(instances_at_grid_position(x-8, y-8, 8, 8, object_index, false));
	is_connected_bottom_right = grid_array_first(instances_at_grid_position(x+8, y+8, 8, 8, object_index, false));
	is_connected_bottom_left = grid_array_first(instances_at_grid_position(x-8, y+8, 8, 8, object_index, false));
		
	is_connected_far_top = grid_array_first(instances_at_grid_position(x, y-16, 8, 8, object_index, false));
	is_connected_far_bottom = grid_array_first(instances_at_grid_position(x, y+16, 8, 8, object_index, false));
	is_connected_on_far_left = grid_array_first(instances_at_grid_position(x-16, y, 8, 8, object_index, false));
	is_connected_on_far_right = grid_array_first(instances_at_grid_position(x+16, y, 8, 8, object_index, false));
	
	is_connected_above = (instance_exists(is_connected_above) && creator == is_connected_above.creator && object_index == is_connected_above.object_index) ? is_connected_above : noone;
	is_connected_below = (instance_exists(is_connected_below) && creator == is_connected_below.creator && object_index == is_connected_below.object_index) ? is_connected_below : noone;
	is_connected_on_left = (instance_exists(is_connected_on_left) && creator == is_connected_on_left.creator && object_index == is_connected_on_left.object_index) ? is_connected_on_left : noone;
	is_connected_on_right = (instance_exists(is_connected_on_right) && creator == is_connected_on_right.creator && object_index == is_connected_on_right.object_index) ? is_connected_on_right : noone;
	
	is_connected_top_right = (instance_exists(is_connected_top_right) && creator == is_connected_top_right.creator && object_index == is_connected_top_right.object_index) ? is_connected_top_right : noone;
	is_connected_top_left = (instance_exists(is_connected_top_left) && creator == is_connected_top_left.creator && object_index == is_connected_top_left.object_index) ? is_connected_top_left : noone;
	is_connected_bottom_right = (instance_exists(is_connected_bottom_right) && creator == is_connected_bottom_right.creator && object_index == is_connected_bottom_right.object_index) ? is_connected_bottom_right : noone;
	is_connected_bottom_left = (instance_exists(is_connected_bottom_left) && creator == is_connected_bottom_left.creator && object_index == is_connected_bottom_left.object_index) ? is_connected_bottom_left : noone;
	
	is_connected_far_top = (instance_exists(is_connected_far_top) && creator == is_connected_far_top.creator && object_index == is_connected_far_top.object_index) ? is_connected_far_top : noone;
	is_connected_far_bottom = (instance_exists(is_connected_far_bottom) && creator == is_connected_far_bottom.creator && object_index == is_connected_far_bottom.object_index) ? is_connected_far_bottom : noone;
	is_connected_on_far_left = (instance_exists(is_connected_on_far_left) && creator == is_connected_on_far_left.creator && object_index == is_connected_on_far_left.object_index) ? is_connected_on_far_left : noone;
	is_connected_on_far_right = (instance_exists(is_connected_on_far_right) && creator == is_connected_on_far_right.creator && object_index == is_connected_on_far_right.object_index) ? is_connected_on_far_right : noone;
}

update_connected_graphics = function() {
	with (is_connected_above) { get_connections_for_graphics(); }
	with (is_connected_below) { get_connections_for_graphics(); }
	with (is_connected_on_left) { get_connections_for_graphics(); }
	with (is_connected_on_right) { get_connections_for_graphics(); }
	with (is_connected_top_right) { get_connections_for_graphics(); }
	with (is_connected_top_left) { get_connections_for_graphics(); }
	with (is_connected_bottom_right) { get_connections_for_graphics(); }
	with (is_connected_bottom_left) { get_connections_for_graphics(); }
	with (is_connected_far_top) { get_connections_for_graphics(); }
	with (is_connected_far_bottom) { get_connections_for_graphics(); }
	with (is_connected_on_far_left) { get_connections_for_graphics(); }
	with (is_connected_on_far_right) { get_connections_for_graphics(); }
	with (obj_ladder) { get_connections_for_graphics(); }
}

draw_static_area_tile = function() {	
	if (!should_draw) { return; }
	
	// Determine Offset
	var _x_offset = undefined, _y_offset = undefined;
	if (!is_connected_above && !is_connected_on_left && is_connected_below && is_connected_on_right) { // Top Left Corner
		_x_offset = 0;
		_y_offset = 0;
		if (has_square_shape && !is_connected_on_far_right && !is_connected_far_bottom) {
			_x_offset = 24;
			_y_offset = 16;
		}
	}
	else if (!is_connected_above && is_connected_on_left && is_connected_below && !is_connected_on_right) { // Top Right Corner
		_x_offset = 16;
		_y_offset = 0;
		if (has_square_shape && !is_connected_on_far_left && !is_connected_far_bottom) {
			_x_offset = 32;
			_y_offset = 16;
		}
	}
	else if (!is_connected_below && !is_connected_on_left && is_connected_above && is_connected_on_right) { // Bottom Left Corner
		_x_offset = 0;
		_y_offset = 16;
		if (has_square_shape && !is_connected_on_far_right && !is_connected_far_top) {
			_x_offset = 24;
			_y_offset = 24;
		}
	}
	else if (!is_connected_below && is_connected_on_left && is_connected_above && !is_connected_on_right) { // Bottom Right Corner
		_x_offset = 16;
		_y_offset = 16;
		if (has_square_shape && !is_connected_on_far_left && !is_connected_far_top) {
			_x_offset = 32;
			_y_offset = 24;
		}
	}
	else if (!is_connected_above && is_connected_on_left && is_connected_below && is_connected_on_right) { // Top Side
		_x_offset = 8;
		_y_offset = 0;
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
	else if (!is_connected_below && !is_connected_on_left && !is_connected_above && !is_connected_on_right) { // Alone
		_x_offset = 16;
		_y_offset = 24;
	}
	
	// Calculate Outline Position
	var _is_even_x = ((visual_origin_x div 8) % 2 == 0), _is_even_y = ((visual_origin_y div 8) % 2 == 0);
	var _main_left = ((_is_even_x) ? 0 : 8), _main_top = ((_is_even_y) ? 0 : 8), _outline_mask_sprite = (is_undefined(outline_mask_sprite) ? outline_sprite : outline_mask_sprite);
	var _anim_frames = (animated) ? sprite_get_number(outline_sprite) : 1;
	var _column_phase = (((visual_origin_x div 8) - (visual_origin_y div 8)) % 4 + 4) % 4;
	var _anim_image_index = (animated) ? ((anim_timer div 8) + _column_phase * 2) % _anim_frames : 0;

	var _main_sprite_image_index = (animated) ? (_anim_image_index % sprite_get_number(main_sprite)) : ((hits - 1 <= 0) ? 0 : hits - 1);
	var _outine_sprite_image_index = (animated) ? _anim_image_index : 0;
	var _outline_mask_sprite_image_index = (animated) ? _anim_image_index : 1;
	var _has_outline = outline_sprite != noone && (!is_undefined(_x_offset) && !is_undefined(_y_offset));
	
	if (_has_outline) {
		// Draw Main Image, Clipped to This Tile's Own Outline Shape
		var _mask_image_index = (animated) ? _anim_image_index : min(1, sprite_get_number(_outline_mask_sprite) - 1);
		set_shader_palette();
		set_shader_clip(_outline_mask_sprite, _mask_image_index, _x_offset, _y_offset, x, y, 8, 8);
		if (main_sprite != noone) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left, _main_top, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
		if (fuzzing_sprite != noone) { draw_sprite_part_ext(fuzzing_sprite, fuzzing_image_index, 0, 0, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
		
		// Draw the Outline Itself, Unclipped
		set_shader_clip();
		draw_sprite_part_ext(outline_sprite, _outine_sprite_image_index, _x_offset, _y_offset, 8, 8, x, y, 1, 1, image_blend, image_alpha);
	}
	else {
		// Draw Without Considering Outline
		set_shader_palette(main_palette);
		if (main_sprite != noone) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left, _main_top, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
		if (fuzzing_sprite != noone) { draw_sprite_part_ext(fuzzing_sprite, fuzzing_image_index, 0, 0, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
	}
	
	// Additionally Draw Inner Corners	
	if (!is_connected_top_right && is_connected_above && is_connected_on_right) { draw_sprite_part_ext(outline_sprite, _outine_sprite_image_index, 32, 0, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
	if (!is_connected_top_left && is_connected_above && is_connected_on_left) { draw_sprite_part_ext(outline_sprite, _outine_sprite_image_index, 24, 0, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
	if (!is_connected_bottom_right && is_connected_below && is_connected_on_right) { draw_sprite_part_ext(outline_sprite, _outine_sprite_image_index, 32, 8, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
	if (!is_connected_bottom_left && is_connected_below && is_connected_on_left) { draw_sprite_part_ext(outline_sprite, _outine_sprite_image_index, 24, 8, 8, 8, x, y, 1, 1, image_blend, image_alpha); }
		

	gpu_set_blendmode(bm_normal);
}
