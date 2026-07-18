event_inherited();

is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;

is_climbable = true;

walk_particles = 0;
step_sound = noone;

depth = 10;
visible = false;

main_sprite = spr_box_16x16;
outline_sprite = noone;
fuzzing_sprite = noone;

is_connected_above = noone;
is_connected_below = noone;
is_connected_on_left = noone;
is_connected_on_right = noone;
is_connected_top_right = noone;
is_connected_top_left = noone;
is_connected_bottom_right = noone;
is_connected_bottom_left = noone;

get_connections_for_graphics = function() {
	is_connected_above = grid_array_first(instances_at_grid_position(x, y-8, 8, 8, object_index));
	is_connected_below = grid_array_first(instances_at_grid_position(x, y+8, 8, 8, object_index));
	is_connected_on_left = grid_array_first(instances_at_grid_position(x-8, y, 8, 8, object_index));
	is_connected_on_right = grid_array_first(instances_at_grid_position(x+8, y, 8, 8, object_index));
	is_connected_top_right = grid_array_first(instances_at_grid_position(x+8, y-8, 8, 8, object_index));
	is_connected_top_left = grid_array_first(instances_at_grid_position(x-8, y-8, 8, 8, object_index));
	is_connected_bottom_right = grid_array_first(instances_at_grid_position(x+8, y+8, 8, 8, object_index));
	is_connected_bottom_left = grid_array_first(instances_at_grid_position(x-8, y+8, 8, 8, object_index));
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
	with (obj_ladder) { get_connections_for_graphics(); }
}

draw_static_area_tile = function() {
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
	var _has_outline = outline_sprite != noone && (_x_offset >= 0 ||_y_offset >= 0);
	
	if (_has_outline) {
		// Draw Main Image
		use_palette_shader();
		if (main_sprite != noone) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left, _main_top, _main_width, _main_height, _main_x, _main_y, 1, 1, image_blend, image_alpha); }
		if (fuzzing_sprite != noone) { draw_sprite_part(fuzzing_sprite, fuzzing_image_index, 0, 0, 8, 8, x, y); }
		gpu_set_blendmode(bm_normal);
		
		// Additionally Draw Inner Corners	
		if (!is_connected_top_right && is_connected_above && is_connected_on_right) { draw_sprite_part(outline_sprite, 0, 32, 0, 8, 8, x, y); }
		if (!is_connected_top_left && is_connected_above && is_connected_on_left) { draw_sprite_part(outline_sprite, 0, 24, 0, 8, 8, x, y); }
		if (!is_connected_bottom_right && is_connected_below && is_connected_on_right) { draw_sprite_part(outline_sprite, 0, 32, 8, 8, 8, x, y); }
		if (!is_connected_bottom_left && is_connected_below && is_connected_on_left) { draw_sprite_part(outline_sprite, 0, 24, 8, 8, 8, x, y); }
		
		// Use Outline as Mask to Draw
		gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
		draw_sprite_part(outline_sprite, 1, _x_offset, _y_offset, 8, 8, x, y);
		gpu_set_blendmode(bm_normal);
	
		// Draw Outline
		 { draw_sprite_part(outline_sprite, 0, _x_offset, _y_offset, 8, 8, x, y); }
	}
	else {
		// Draw Without Considering Outline
		
		use_palette_shader();
		if (main_sprite != noone) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left, _main_top, _main_width, _main_height, _main_x, _main_y, 1, 1, image_blend, image_alpha); }
		if (fuzzing_sprite != noone) { draw_sprite_part(fuzzing_sprite, fuzzing_image_index, 0, 0, 8, 8, x, y); }
	}

	gpu_set_blendmode(bm_normal);
	shader_reset();
}
