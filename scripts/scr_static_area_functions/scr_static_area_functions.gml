initialize_static_area = function() {
	depth = STATIC_AREA_DEPTH;
	visible = false;
	should_draw = true;
	
	creator = noone;
	main_sprite = spr_box_16x16;
	outline_sprite = undefined;
	outline_mask_sprite = undefined;
	fuzzing_sprite = undefined;
	
	outline_x_offset = undefined;
	outline_y_offset = undefined;
	visual_origin_x = x;
	visual_origin_y = y;
	positional_animation_offset = 0;
	animated = false;
	has_square_shape = false;
	connection_object_index = object_index;

	connected_above = noone;
	connected_below = noone;
	connected_on_left = noone;
	connected_on_right = noone;
	connected_top_right = noone;
	connected_top_left = noone;
	connected_bottom_right = noone;
	connected_bottom_left = noone;

	connected_far_top = noone;
	connected_far_bottom = noone;
	connected_on_far_left = noone;
	connected_on_far_right = noone;
	
	manager = noone;
	with (obj_static_area_manager) {
	    for (var _i = 0; _i < array_length(static_area_objects); _i++) {
	        if (other.is_a(static_area_objects[_i])) { other.manager = id; break; }
	    }
	}
}

connected_to = function(_inst) { return _inst.object_index == object_index && _inst.creator == creator; }

get_connected_instance = function(_array) {
	for (var _i = 0; _i < array_length(_array); _i++) {
		if (connected_to(_array[_i])) { return _array[_i]; }
	}
	return noone;
}

update_connections = function(_grid = global.controller.game_object_grid) {
	connected_above = get_connected_instance(instances_at_grid_position(x, y-8, 8, 8, connection_object_index, false, _grid));
	connected_below = get_connected_instance(instances_at_grid_position(x, y+8, 8, 8, connection_object_index, false, _grid));
	connected_on_left = get_connected_instance(instances_at_grid_position(x-8, y, 8, 8, connection_object_index, false, _grid));
	connected_on_right = get_connected_instance(instances_at_grid_position(x+8, y, 8, 8, connection_object_index, false, _grid));

	connected_top_right = get_connected_instance(instances_at_grid_position(x+8, y-8, 8, 8, connection_object_index, false, _grid));
	connected_top_left = get_connected_instance(instances_at_grid_position(x-8, y-8, 8, 8, connection_object_index, false, _grid));
	connected_bottom_right = get_connected_instance(instances_at_grid_position(x+8, y+8, 8, 8, connection_object_index, false, _grid));
	connected_bottom_left = get_connected_instance(instances_at_grid_position(x-8, y+8, 8, 8, connection_object_index, false, _grid));
		
	connected_far_top = get_connected_instance(instances_at_grid_position(x, y-16, 8, 8, connection_object_index, false, _grid));
	connected_far_bottom = get_connected_instance(instances_at_grid_position(x, y+16, 8, 8, connection_object_index, false, _grid));
	connected_on_far_left = get_connected_instance(instances_at_grid_position(x-16, y, 8, 8, connection_object_index, false, _grid));
	connected_on_far_right = get_connected_instance(instances_at_grid_position(x+16, y, 8, 8, connection_object_index, false, _grid));

	update_outline_offsets();
}

update_connected_graphics = function() {
	with (connected_above) { update_connections(); }
	with (connected_below) { update_connections(); }
	with (connected_on_left) { update_connections(); }
	with (connected_on_right) { update_connections(); }
	with (connected_top_right) { update_connections(); }
	with (connected_top_left) { update_connections(); }
	with (connected_bottom_right) { update_connections(); }
	with (connected_bottom_left) { update_connections(); }
	with (connected_far_top) { update_connections(); }
	with (connected_far_bottom) { update_connections(); }
	with (connected_on_far_left) { update_connections(); }
	with (connected_on_far_right) { update_connections(); }
	with (obj_ladder) { update_connections(); }
}

update_outline_offsets = function() {
	outline_x_offset = undefined;
	outline_y_offset = undefined;
	
	if (!connected_above && !connected_on_left && connected_below && connected_on_right) { // Top Left Corner
		outline_x_offset = 0;
		outline_y_offset = 0;
		if (has_square_shape && !connected_on_far_right && !connected_far_bottom) {
			outline_x_offset = 24;
			outline_y_offset = 16;
		}
	}
	else if (!connected_above && connected_on_left && connected_below && !connected_on_right) { // Top Right Corner
		outline_x_offset = 16;
		outline_y_offset = 0;
		if (has_square_shape && !connected_on_far_left && !connected_far_bottom) {
			outline_x_offset = 32;
			outline_y_offset = 16;
		}
	}
	else if (!connected_below && !connected_on_left && connected_above && connected_on_right) { // Bottom Left Corner
		outline_x_offset = 0;
		outline_y_offset = 16;
		if (has_square_shape && !connected_on_far_right && !connected_far_top) {
			outline_x_offset = 24;
			outline_y_offset = 24;
		}
	}
	else if (!connected_below && connected_on_left && connected_above && !connected_on_right) { // Bottom Right Corner
		outline_x_offset = 16;
		outline_y_offset = 16;
		if (has_square_shape && !connected_on_far_left && !connected_far_top) {
			outline_x_offset = 32;
			outline_y_offset = 24;
		}
	}
	else if (!connected_above && connected_on_left && connected_below && connected_on_right) { // Top Side
		outline_x_offset = 8;
		outline_y_offset = 0;
	}
	else if (!connected_below && connected_on_left && connected_above && connected_on_right) { // Bottom Side
		outline_x_offset = 8;
		outline_y_offset = 16;
	}
	else if (connected_below && !connected_on_left && connected_above && connected_on_right) { // Left Side
		outline_x_offset = 0;
		outline_y_offset = 8;
	}
	else if (connected_below && connected_on_left && connected_above && !connected_on_right) { // Right Side
		outline_x_offset = 16;
		outline_y_offset = 8;
	}
	else if (connected_below && !connected_on_left && connected_above && !connected_on_right) { // Bridge From Right to Left
		outline_x_offset = 0;
		outline_y_offset = 24;
	}
	else if (!connected_below && connected_on_left && !connected_above && connected_on_right) { // Bridge From Left to Right
		outline_x_offset = 8;
		outline_y_offset = 24;
	}
	else if (connected_below && !connected_on_left && !connected_above && !connected_on_right) { // Peninsula With Bottom
		outline_x_offset = 0;
		outline_y_offset = 32;
	}
	else if (!connected_below && !connected_on_left && connected_above && !connected_on_right) { // Peninsula With Top
		outline_x_offset = 8;
		outline_y_offset = 32;
	}
	else if (!connected_below && !connected_on_left && !connected_above && connected_on_right) { // Peninsula With Right
		outline_x_offset = 16;
		outline_y_offset = 32;
	}
	else if (!connected_below && connected_on_left && !connected_above && !connected_on_right) { // Peninsula With Left
		outline_x_offset = 24;
		outline_y_offset = 32;
	}
	else if (!connected_below && !connected_on_left && !connected_above && !connected_on_right) { // Alone
		outline_x_offset = 16;
		outline_y_offset = 24;
	}
}

get_animated_sprite_image_index = function(_sprite) {
	if (!animated) { return 0; }
	var _total_animation_frames = sprite_get_number(_sprite);
	
	return ((anim_timer div 8) + positional_animation_offset) % _total_animation_frames;
}

draw_static_area_fill = function() {
	if (!should_draw || (is_undefined(main_sprite) && is_undefined(fuzzing_sprite))) { return; }
	
	var _is_even_x = ((visual_origin_x div 8) % 2 == 0), _is_even_y = ((visual_origin_y div 8) % 2 == 0);
	var _main_left = ((_is_even_x) ? 0 : 8), _main_top = ((_is_even_y) ? 0 : 8);
	
	//if (!is_undefined(main_sprite) && sprite_get_width(main_sprite) == 8) { _main_left = 0; }
	//if (!is_undefined(main_sprit) && sprite_get_height(main_sprite) == 8) { _main_top = 0; }
	
	var _damage_based_main_sprite_image_index = ((hits - 1 <= 0) ? 0 : hits - 1);
	var _main_sprite_image_index = (animated) ? get_animated_sprite_image_index(main_sprite) : _damage_based_main_sprite_image_index;
	
	if (!is_undefined(main_sprite)) { draw_sprite_part_ext(main_sprite, _main_sprite_image_index, _main_left, _main_top, 8, 8, x, y, 1, 1, image_blend, 1); }
	if (!is_undefined(fuzzing_sprite)) { draw_sprite_part_ext(fuzzing_sprite, fuzzing_image_index, 0, 0, 8, 8, x, y, 1, 1, image_blend, 1); }
}

draw_static_area_outline = function() {
	if (!should_draw || is_undefined(outline_sprite)) { return; }
	
	var _outline_sprite_image_index = get_animated_sprite_image_index(outline_sprite);
	
	// Draw Outer Outline
	if (!is_undefined(outline_x_offset) && !is_undefined(outline_y_offset)) {
		draw_sprite_part_ext(outline_sprite, _outline_sprite_image_index, outline_x_offset, outline_y_offset, 8, 8, x, y, 1, 1, image_blend, 1);
	}
	
	// Draw Inner Outline Images
	if (!connected_top_right && connected_above && connected_on_right) { draw_sprite_part_ext(outline_sprite, _outline_sprite_image_index, 32, 0, 8, 8, x, y, 1, 1, image_blend, 1); }
	if (!connected_top_left && connected_above && connected_on_left) { draw_sprite_part_ext(outline_sprite, _outline_sprite_image_index, 24, 0, 8, 8, x, y, 1, 1, image_blend, 1); }
	if (!connected_bottom_right && connected_below && connected_on_right) { draw_sprite_part_ext(outline_sprite, _outline_sprite_image_index, 32, 8, 8, 8, x, y, 1, 1, image_blend, 1); }
	if (!connected_bottom_left && connected_below && connected_on_left) { draw_sprite_part_ext(outline_sprite, _outline_sprite_image_index, 24, 8, 8, 8, x, y, 1, 1, image_blend, 1); }
}

draw_static_area_mask = function() {
	if (!should_draw) { return; }
	
	if (is_undefined(outline_sprite) || is_undefined(outline_x_offset) || is_undefined(outline_y_offset)) {
		// Apply Alpha to Interior Tiles with No Outline clipping
		if (image_alpha < 1) {
			draw_set_alpha(image_alpha);
			draw_rectangle(x, y, x + GRID_SIZE-1, y + GRID_SIZE-1, false);
			draw_set_alpha(1);
		}
	}
	else {
		// Draw Mask to Clip Beyond Outline And Apply Alpha
		var _outline_mask_sprite = outline_mask_sprite ?? outline_sprite;
		var _outline_mask_sprite_image_index = (animated) ? get_animated_sprite_image_index(_outline_mask_sprite) : 1;
		draw_sprite_part_ext(_outline_mask_sprite, _outline_mask_sprite_image_index, outline_x_offset, outline_y_offset, 8, 8, x, y, 1, 1, c_white, image_alpha);
	}
}
