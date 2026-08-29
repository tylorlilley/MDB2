// Draw Blinking Demo String
if (((cutscene_timer div 16) % 2) == 0) {
	draw_set_color(C_BLACK);
	draw_set_font(ft_pixel);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	draw_text_outlined(SCREEN_MIDDLE_X + 32, SCREEN_MIDDLE_Y + 104, cancel_string);
}

// Draw Activated Controls
set_shader_palette(PALETTES.GRAY_LIGHT);
draw_sprite(spr_controls_down, ((shown_key_down) ? 1 : 0), 4 + 16, SCREEN_HEIGHT - 4 - 16);
draw_sprite(spr_controls_up, ((shown_key_up) ? 1 : 0), 4 + 16, SCREEN_HEIGHT - 4 - 16 - 16);
draw_sprite(spr_controls_left, ((shown_key_left) ? 1 : 0), 4, SCREEN_HEIGHT - 4 - 8 - 16);
draw_sprite(spr_controls_right, ((shown_key_right) ? 1 : 0), 4 + 16 + 16, SCREEN_HEIGHT - 4 - 8 - 16);
