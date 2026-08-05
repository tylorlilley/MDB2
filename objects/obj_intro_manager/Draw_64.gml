if (room == rm_intro && instance_number(obj_sand) > 0) {
	draw_set_color(C_WHITE);
	draw_set_font(ft_nirmala_ui);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_alpha(lerp(0, 1, min(transition_timer / 24, 1)));
	
	draw_text(SCREEN_MIDDLE_X, SCREEN_MIDDLE_Y, intro_string);
}