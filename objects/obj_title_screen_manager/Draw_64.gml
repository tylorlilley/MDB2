draw_set_color(C_BLACK);
draw_set_font(ft_title);
draw_set_halign(fa_center);
draw_set_valign(fa_top);


var _view_x_pos = camera_get_view_x(view_camera[0]), _view_y_pos = camera_get_view_y(view_camera[0]);
draw_text(_view_x_pos + 128, 16, "MIGHTY\nDIVE BOMBER");
draw_text(_view_x_pos + 128, 15, "MIGHTY\nDIVE BOMBER");
draw_text(_view_x_pos + 128, 14, "MIGHTY\nDIVE BOMBER");
draw_text(_view_x_pos + 128, 13, "MIGHTY\nDIVE BOMBER");
draw_set_color((transition_timer % 8 == 0) ? C_RED : C_WHITE);
draw_text(_view_x_pos + 128, 12, "MIGHTY\nDIVE BOMBER");