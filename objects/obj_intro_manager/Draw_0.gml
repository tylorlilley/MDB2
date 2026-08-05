
if (room == rm_intro && instance_number(obj_sand) > 0 && transition_timer > 24) {
	draw_set_color(C_WHITE);
	draw_set_font(ft_nirmala_ui);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text(room_width/2, room_height/2, intro_string);
	show_debug_message(string_width(intro_string));
}