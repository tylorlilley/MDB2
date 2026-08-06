// Draw Title
/*
draw_set_color(C_BLACK);
draw_set_font(ft_title);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

var _view_x_pos = camera_get_view_x(view_camera[0]), _view_y_pos = camera_get_view_y(view_camera[0]);
var _selected_color = ((transition_timer div 4) % 2 == 0) ? C_RED : C_WHITE, _title_y_pos = 8;
draw_text_outlined(SCREEN_MIDDLE_X, _title_y_pos+4, "MIGHTY", _selected_color);
draw_text_outlined(SCREEN_MIDDLE_X, _title_y_pos+2, "MIGHTY", _selected_color);
draw_text_outlined(SCREEN_MIDDLE_X, _title_y_pos, "MIGHTY", _selected_color);
draw_text_outlined(SCREEN_MIDDLE_X, _title_y_pos+24+4, "DIVE BOMBER", _selected_color);
draw_text_outlined(SCREEN_MIDDLE_X, _title_y_pos+24+2, "DIVE BOMBER", _selected_color);
draw_text_outlined(SCREEN_MIDDLE_X, _title_y_pos+24, "DIVE BOMBER", _selected_color);
*/
draw_sprite_swaying(spr_title, ((transition_timer div 4) % 2), title_sway_timer, SCREEN_MIDDLE_X-sprite_get_width(spr_title)/2, 8, c_white, 1, 5);

// Draw Main Menu
if (state > TITLE_STATES.PAN_OVER) {
	draw_set_font(ft_block_blueprint);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var _option_strings = [
		 "START CLASSIC GAME",
		 "START NEW GAME",
		 "CONTINUE GAME",
		 "VIEW CONTROLS",
		 "SETTINGS",
	]
	var _cursor_sprites = [
		spr_player_hop_up,
		spr_player_hop_down,
		spr_door,
		spr_key,
		spr_gear,
	];
	var _cursor_palettes = [
		PALETTES.PLAYER,
		PALETTES.PLAYER,
		PALETTES.BROWN,
		PALETTES.YELLOW,
		PALETTES.GRAY_LIGHT,
	];
	var _selected_color = ((transition_timer div 4) % 2 == 0) ? C_RED : C_WHITE;
	for (var _i = 0; _i < array_length(_option_strings); _i++) {
		//if (i == 0) { continue; } // TODO: Unlock Option After Beating Game
		var _y_offset = _i * 12, _x_offset = 0, _option_string = _option_strings[_i], _selected = (menu_pos == _i);
		var _cursor_sprite = _cursor_sprites[_i], _cursor_palette = _cursor_palettes[_i];
		var _x_pos = SCREEN_MIDDLE_X-16, _y_pos =  SCREEN_MIDDLE_Y+4;
		if (_selected) {
			// Set Up Text Shake Values
			var _shake_x = 0, _shake_y = 0;
			if (text_shake_timer > 0) {
				_shake_x += get_shake_value(text_shake_timer);
				_shake_y += get_shake_value(text_shake_timer);
			}

			_x_offset += _shake_x;
			_y_offset += _shake_y;
			
			set_shader_palette(_cursor_palette)
			draw_sprite_swaying(_cursor_sprite, 0, cursor_sway_timer, _x_pos+_x_offset-20, _y_pos+_y_offset+1, c_white, 1, 15);
		}
		draw_text_outlined(_x_pos + _x_offset, _y_pos + _y_offset, _option_string, (_selected ? _selected_color : C_GRAY_LIGHT));
	}
}