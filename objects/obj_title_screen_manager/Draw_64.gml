draw_set_color(C_BLACK);
draw_set_font(ft_title);
draw_set_halign(fa_center);
draw_set_valign(fa_top);


var _view_x_pos = camera_get_view_x(view_camera[0]), _view_y_pos = camera_get_view_y(view_camera[0]);
draw_text(128, 16, "MIGHTY\nDIVE BOMBER");
draw_text(128, 15, "MIGHTY\nDIVE BOMBER");
draw_text(128, 14, "MIGHTY\nDIVE BOMBER");
draw_text(128, 13, "MIGHTY\nDIVE BOMBER");
draw_set_color((transition_timer % 8 == 0) ? C_RED : C_WHITE);
draw_text(128, 12, "MIGHTY\nDIVE BOMBER");

if (state > TITLE_STATES.PAN_OVER) {
	draw_set_font(ft_pixel);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(C_BLACK);
	
	draw_text(128 - 16, 120 + 16 + 1, "START NEW GAME");
	draw_text(128 - 16, 120 + 16 + 2, "START NEW GAME");
	draw_text(128 - 16, 120 + 16 + 3, "START NEW GAME");
	draw_text(128 - 16, 120 + 16 + 4, "START NEW GAME");
	draw_text(128 - 16, 120 + 32 + 1, "CONTINUE GAME");
	draw_text(128 - 16, 120 + 32 + 2, "CONTINUE GAME");
	draw_text(128 - 16, 120 + 32 + 3, "CONTINUE GAME");
	draw_text(128 - 16, 120 + 32 + 4, "CONTINUE GAME");
	draw_text(128 - 16, 120 + 48 + 1, "VIEW CONTROLS");
	draw_text(128 - 16, 120 + 48 + 2, "VIEW CONTROLS");
	draw_text(128 - 16, 120 + 48 + 3, "VIEW CONTROLS");
	draw_text(128 - 16, 120 + 48 + 4, "VIEW CONTROLS");
	draw_text(128 - 16, 120 + 64 + 1, "SETTINGS");
	draw_text(128 - 16, 120 + 64 + 2, "SETTINGS");
	draw_text(128 - 16, 120 + 64 + 3, "SETTINGS");
	draw_text(128 - 16, 120 + 64 + 4, "SETTINGS");
	
	draw_set_color(C_WHITE);
	draw_text(128 - 16, 120 + 16 + 1, "START NEW GAME");
	draw_text(128 - 16, 120 + 16, "START NEW GAME");
	draw_text(128 - 16, 120 + 32 + 1, "CONTINUE GAME");
	draw_text(128 - 16, 120 + 32, "CONTINUE GAME");
	draw_text(128 - 16, 120 + 48 + 1, "VIEW CONTROLS");
	draw_text(128 - 16, 120 + 48, "VIEW CONTROLS");
	draw_text(128 - 16, 120 + 64 + 1, "SETTINGS");
	draw_text(128 - 16, 120 + 64, "SETTINGS");
}