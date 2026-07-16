// Draw Debug Mask Highlights
if (draw_game_object_grid) {
	for (var _grid_x = 0; _grid_x < array_length(game_object_grid); _grid_x++) {
		for (var _grid_y = 0; _grid_y < array_length(game_object_grid[0]); _grid_y++) {
			var _instances = game_object_grid[_grid_x][_grid_y];
			for (var _i = 0; _i < array_length(_instances); _i++) {
				var _inst = _instances[_i]
			
				with (_inst) {
					draw_sprite_ext(spr_box_16x16, 0, _grid_x * 8, _grid_y * 8, 0.5, 0.5, 1, c_teal, 0.5);
				}
			}
		}
	}
}

// Draw Static Areas
	if (!surface_exists(static_area_surface)) { rebuild_static_area_surface(); }
	draw_surface(static_area_surface, 0, 0);

// Draw Transition
if (transition_timer > transition_delay) {
	// Determine Transition Parameters
	var _max_scale = room_width;
	var _fade_pos_x = last_player_x+8, _fade_pos_y = last_player_y+8;
	if (_fade_pos_x < 0 || _fade_pos_x > room_width) { _fade_pos_x = room_width/2; }
	if (_fade_pos_y < 0 || _fade_pos_y > room_height) {	_fade_pos_y = room_height/2; }
		
	var _scale = 0;
	if (transition_timer < transition_duration + transition_delay) { _scale = power((1-((transition_timer - transition_delay) / transition_duration)), 4); }
	else if (transition_timer > transition_duration + transition_hold + transition_delay) { _scale = power(((transition_timer - transition_duration - transition_hold - transition_delay) / (transition_duration)), 4); }
		
	// Create Transition Graphics
	if (!surface_exists(transition_surface)) { transition_surface = surface_create(room_width, room_height); }
		
	surface_set_target(transition_surface);
	draw_set_color(c_black);
	draw_rectangle(0, 0, room_width, room_height, false);
	gpu_set_blendequation(bm_eq_subtract);
	draw_sprite_ext(spr_transition_mask, 0, _fade_pos_x, _fade_pos_y, _max_scale*_scale, _max_scale*_scale, 0, c_white, 1);
	gpu_set_blendequation(bm_eq_add);
	surface_reset_target();
		
	// Draw Transition
	draw_surface(transition_surface, 0, 0);
}