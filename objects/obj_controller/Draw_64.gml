if (creation_timer > 0) { exit; }

if (instance_number(obj_cutscene_manager) == 0) {
	// Draw HUD Bars
	if (!classic_level) {
		draw_set_alpha(0.45); //global.border_alpha);
		draw_set_color(c_black);
		draw_rectangle(0, 0, SCREEN_WIDTH, 16, false);
		/*
		if (global.original_controls) {
			draw_rectangle(0, GRID_SIZE*2, GRID_SIZE, SCREEN_HEIGHT-GRID_SIZE, false);
			draw_rectangle(SCREEN_WIDTH-GRID_SIZE, GRID_SIZE*2, SCREEN_WIDTH, SCREEN_HEIGHT-GRID_SIZE, false);
			draw_rectangle(0, SCREEN_HEIGHT-GRID_SIZE, SCREEN_WIDTH, SCREEN_HEIGHT, false);
		}
		*/
	}

	// Draw Winning Spotlight
	draw_set_alpha(1);
	var _winning_player_x = undefined;
	with (obj_player) { if (state == PLAYER_STATES.WIN) { _winning_player_x = x; } }
	if (!is_undefined(_winning_player_x)) {
		// Create Spotlight Graphics
		ensure_transition_surface();
		surface_set_target(transition_surface);
		draw_set_color(c_black);
		draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false);
		gpu_set_blendequation(bm_eq_subtract);
		draw_sprite_ext(spr_spotlight_mask, 0, _winning_player_x-16, 0, 1, 1, 0, c_white, 1);
		gpu_set_blendequation(bm_eq_add);
		surface_reset_target();
		
		// Draw Spotlight
		set_gui_matrix(false);
		draw_surface_ext(transition_surface, 0, 0, 1, 1, 0, c_white, 0.65);
		set_gui_matrix(true);
	}
	
	// Draw Level Text and Key Amounts
	//var _float_offset = get_float_value(float_timer, 1, 4 * FLOAT_OFFSET_PERIOD_FRAMES);
	var _float_offset = 0, _text_y_pos = _float_offset + ((classic_level) ? 4 : 0), _key_pos = _float_offset + ((classic_level) ? 3 : -1), _text_x_pos = (global.original_controls) ? 256-24 : 256-16;
	var _world = (level_number div 8) + 1, _level = (level_number % 8) + 1;
	
	draw_set_alpha(1);
	draw_set_font(ft_pixel);
	draw_set_color(C_WHITE);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top)
	
	draw_text_outlined(((global.original_controls) ? 12 : 4), _text_y_pos, string(_world) + "-" + string(_level) + ":");
	draw_text_outlined(((global.original_controls) ? 44 : 36), _text_y_pos, room_title);
	draw_set_halign(fa_right);
	draw_text_outlined(_text_x_pos, _text_y_pos, string(global.keys_collected) + "/" + string(global.room_keys));

	set_shader_palette(PALETTES.ALL_BLACK);
	draw_sprite(spr_key_icon, 0, _text_x_pos, _key_pos+1);
	draw_sprite(spr_key_icon, 0, _text_x_pos, _key_pos+2);
	//draw_sprite(spr_key_icon, 0, _text_x_pos, _key_pos+3);
	set_shader_palette(PALETTES.YELLOW);
	draw_sprite(spr_key_icon, 0, _text_x_pos, _key_pos);
	shader_reset();
}

// Draw Debug Mask Highlights
if (draw_game_object_grid) {
	for (var _grid_x = 0; _grid_x < array_length(game_object_grid); _grid_x++) {
		for (var _grid_y = 0; _grid_y < array_length(game_object_grid[0]); _grid_y++) {
			var _instances = game_object_grid[_grid_x][_grid_y];
			for (var _i = 0; _i < array_length(_instances); _i++) {
				var _inst = _instances[_i]
			
				with (_inst) {
					draw_sprite_ext(spr_box_16x16, 0, -8 + _grid_x * 8, -8 + _grid_y * 8, 0.5, 0.5, 1, c_teal, 0.5);
				}
			}
		}
	}
}

if (room_transition_timer > TRANSITION_DELAY) {
	// Determine Transition Parameters
	var _max_scale = SCREEN_WIDTH, _camera = view_camera[0];
	var _fade_pos_x = x + GRID_SIZE - camera_get_view_x(_camera), _fade_pos_y = y + GRID_SIZE - camera_get_view_y(_camera);
		
	var _scale = 0, _interpolation_offset = get_frame_progress();
	if (room_transition_timer < TRANSITION_DURATION + TRANSITION_DELAY) { _scale = power((1-(((room_transition_timer + _interpolation_offset) - TRANSITION_DELAY) / TRANSITION_DURATION)), 4); }
	else if (room_transition_timer > TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD) { _scale = power((((room_transition_timer + _interpolation_offset) - TRANSITION_DURATION - TRANSITION_HOLD - TRANSITION_DELAY) / (TRANSITION_DURATION)), 4); }
	_scale = clamp(_scale, 0, 1);
		
	// Create Transition Graphics
	if (!surface_exists(transition_surface)) { transition_surface = surface_create(SCREEN_WIDTH, SCREEN_HEIGHT); }
		
	ensure_transition_surface();
	surface_set_target(transition_surface);
	draw_set_color(C_BLACK);
	draw_rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, false);
	draw_set_color(C_WHITE);
	draw_set_font(ft_pixel);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	var _quip_width = SCREEN_WIDTH - (GRID_SIZE*4), _quip_length = string_width(latest_quip);
	while (_quip_length > _quip_width) { _quip_length /=2; _quip_length += 16; }
	draw_text_ext(SCREEN_MIDDLE_X, SCREEN_MIDDLE_Y, latest_quip, 12, _quip_length);
	gpu_set_blendequation(bm_eq_subtract);
	draw_sprite_ext(((room == rm_intro_eih) ? spr_transition_circle : spr_transition_mask), 0, _fade_pos_x, _fade_pos_y, _max_scale*_scale, _max_scale*_scale, 0, c_white, 1);
	gpu_set_blendequation(bm_eq_add);
	surface_reset_target();
		
	// Draw Transition
	set_gui_matrix(false);
	draw_surface(transition_surface, 0, 0);
	set_gui_matrix(true);
}

/*
if (debug_enabled) {
	draw_set_font(ft_pixel);
	draw_set_color(C_WHITE);
	draw_text_outlined(SCREEN_WIDTH-12, SCREEN_HEIGHT-12, fps);
}
*/

// Draw Pause Box
if (paused) {
	var _max_pause_box_width = SCREEN_WIDTH - (GRID_SIZE * 3), _max_pause_box_height = GRID_SIZE * 7, _pause_string = (room == rm_title) ? TITLE_PAUSE_MESSAGE_STRING : PAUSE_MESSAGE_STRING;
	var _pause_box_width = (pause_timer / (8 * fps_ratio)) * _max_pause_box_width, _pause_box_height = (pause_timer / (8 * fps_ratio)) * _max_pause_box_height;
	if (_pause_box_width < _max_pause_box_width || _pause_box_height < _max_pause_box_height) { _pause_string = ""; }
	_pause_box_width = clamp(_pause_box_width, 0, _max_pause_box_width);
	_pause_box_height = clamp(_pause_box_height, 0, _max_pause_box_height);
	
	draw_set_color(C_BLACK);
	draw_set_alpha(0.85);
	draw_rectangle(SCREEN_MIDDLE_X - _pause_box_width/2, SCREEN_MIDDLE_Y - _pause_box_height/2, SCREEN_MIDDLE_X + _pause_box_width/2, SCREEN_MIDDLE_Y + _pause_box_height/2, false);
	
	if (string_length(_pause_string) > 0) {
		draw_set_color(C_WHITE);
		draw_set_font(ft_pixel);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_center);
		draw_text_ext(SCREEN_MIDDLE_X, SCREEN_MIDDLE_Y, _pause_string, 12, _pause_box_width - GRID_SIZE);
	}
}