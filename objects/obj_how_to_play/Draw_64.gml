draw_set_color(C_WHITE);
draw_set_font(ft_block_blueprint);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(1);
	
if (((cutscene_timer div 8) % 2) == 0) {
	draw_set_color(C_BLACK);
	draw_set_font(ft_pixel);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text_outlined(SCREEN_MIDDLE_X, SCREEN_MIDDLE_Y + 80, cancel_string);
}