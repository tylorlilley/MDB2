var _interpolation_offset = global.controller.get_frame_progress();

// Draw Title Sprite
draw_sprite_swaying(spr_title, ((cutscene_timer div 4) % 2), title_sway_timer + _interpolation_offset, SCREEN_MIDDLE_X-sprite_get_width(spr_title)/2, 8, c_white, 1, 2);

// Draw Any key Text
if (state == TITLE_STATES.BEGIN && (cutscene_timer div 16) % 2 == 0) {
	draw_set_color(C_BLACK);
	draw_set_font(ft_pixel);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text_outlined(SCREEN_MIDDLE_X, 84, "PRESS ANY KEY TO BEGIN");
}

// Draw Version Text
if (state >= TITLE_STATES.BEGIN) {
	draw_set_alpha(0.33);
	draw_set_color(C_BLACK);
	draw_set_font(ft_pixel_small);
	draw_set_halign(fa_right);
	draw_set_valign(fa_top);
	draw_text(SCREEN_WIDTH - 12, SCREEN_HEIGHT - 16, "v. CART");
	draw_set_alpha(1);
}

// Draw Main Menu
if (state == TITLE_STATES.MAIN_MENU) {
	if (prev_state != state) {
		// Screen Flash on when Menu First Appears
		draw_set_color(C_WHITE);
	draw_rectangle(-1, -1, SCREEN_WIDTH+2, SCREEN_HEIGHT+2, false);
	}
	else {
		draw_set_font(ft_block_blueprint);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		// Draw Each Menu Option
		var _selected_color = ((cutscene_timer div 4) % 2 == 0) ? C_RED : C_WHITE;
		for (var _i = 0; _i < array_length(option_strings); _i++) {
			// Skip Menu Options that Are Not Unlocked
			if (_i == 0 && progress_level == 0) { continue; }
			if (_i == 2 && saved_room == -1) { continue; }
			
			// Setup Cursor Sprite and Position
			var _y_offset = _i * 14, _x_offset = 0, _option_string = option_strings[_i], _selected = (menu_pos == _i);
			var _cursor_sprite = cursor_sprites[_i], _cursor_palette = cursor_palettes[_i];
			var _x_pos = SCREEN_MIDDLE_X-16, _y_pos =  SCREEN_MIDDLE_Y+4;
			
			// Draw Cursor and Selected Option Effects
			if (_selected) {
				// Set Up Text Shake Values
				var _shake_x = 0, _shake_y = 0;
				if (text_shake_timer > 0) {
					_shake_x += get_shake_value(text_shake_timer);
					_shake_y += get_shake_value(text_shake_timer);
				}

				_x_offset += _shake_x;
				_y_offset += _shake_y;
				
				// Additionally Draw Player Cape for Cursor
				if (menu_pos == MENU_OPTIONS.START_GAME) {
					set_shader_palette(PALETTES.GRAY_LIGHT);
					draw_sprite_swaying(spr_cape_fall, 0, cursor_sway_timer + _interpolation_offset, _x_pos+_x_offset-20, _y_pos+_y_offset+1-4, c_white, 1, 15);
				}
				
				// Draw Cursor
				set_shader_palette(_cursor_palette);
				draw_sprite_swaying(_cursor_sprite, 0, cursor_sway_timer + _interpolation_offset, _x_pos+_x_offset-20, _y_pos+_y_offset+1, c_white, 1, 15);
			}
			
			// Draw Menu Option
			draw_text_outlined(_x_pos + _x_offset, _y_pos + _y_offset, _option_string, (_selected ? _selected_color : C_GRAY_LIGHT));
		}
	}
}
else if (state == TITLE_STATES.SETTINGS_MENU) {
	if (prev_state != state) {
		// Screen Flash on when Menu First Appears
		draw_set_color(C_WHITE);
	draw_rectangle(-1, -1, SCREEN_WIDTH+2, SCREEN_HEIGHT+2, false);
	}
	else {
		draw_set_font(ft_block_blueprint);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);

		// Draw Each Menu Option
		var _selected_color = ((cutscene_timer div 4) % 2 == 0) ? C_RED : C_WHITE, _controller = global.controller;
		for (var _i = 0; _i < array_length(settings_strings); _i++) {
			// Skip Menu Options that Are Not Unlocked
			// Setup Cursor Sprite and Position
			var _y_offset = (_i + 1) * 14, _x_offset = 0, _option_string = settings_strings[_i], _selected = (menu_pos == _i);
			var _cursor_sprite = cursor_sprites[MENU_OPTIONS.SETTINGS], _cursor_palette = cursor_palettes[MENU_OPTIONS.SETTINGS];
			var _x_pos = SCREEN_MIDDLE_X-16, _y_pos = SCREEN_MIDDLE_Y+4;
			
			// Draw Cursor and Selected Option Effects
			if (_selected) {
				// Set Up Text Shake Values
				var _shake_x = 0, _shake_y = 0;
				if (text_shake_timer > 0) {
					_shake_x += get_shake_value(text_shake_timer);
					_shake_y += get_shake_value(text_shake_timer);
				}

				_x_offset += _shake_x;
				_y_offset += _shake_y;
				
				// Draw Cursor
				set_shader_palette(_cursor_palette);
				draw_sprite_swaying(_cursor_sprite, 0, cursor_sway_timer + _interpolation_offset, _x_pos+_x_offset-20, _y_pos+_y_offset+1, c_white, 1, 15);
			}
			
			// Determine selection string
			var _selected_string = "";
			if (_i == SETTINGS_OPTIONS.FULL_SCREEN) { _selected_string = full_screen_strings[_controller.window_fullscreen_setting]; }
			else if (_i == SETTINGS_OPTIONS.SCREEN_SCALE) { _selected_string = "x" + string(_controller.window_scale_setting); }
			else if (_i == SETTINGS_OPTIONS.FPS) { _selected_string = string(_controller.window_fps_setting); }
			
			// Draw Menu Option
			var _unselected_color = (_i == SETTINGS_OPTIONS.SCREEN_SCALE && _controller.window_fullscreen_setting != FULL_SCREEN_OPTIONS.WINDOWED) ? C_GRAY_DARK : C_GRAY_LIGHT;
			if (_i < SETTINGS_OPTIONS.SKIP_THIS) { _option_string +=  ": " + _selected_string; }
			draw_text_outlined(_x_pos + _x_offset, _y_pos + _y_offset, _option_string, (_selected ? _selected_color : _unselected_color));
		}
	}
}