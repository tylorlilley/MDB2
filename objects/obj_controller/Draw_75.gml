matrix_set(matrix_world, matrix_build_identity());
draw_set_alpha(1);
draw_set_color(c_red);
draw_rectangle(0, 0, display_get_gui_width() - 1, display_get_gui_height() - 1, true);
draw_set_color(c_lime);
draw_rectangle(gui_offset_x, gui_offset_y, gui_offset_x + SCREEN_WIDTH * gui_scale - 1, gui_offset_y + SCREEN_HEIGHT * gui_scale - 1, true);

shader_reset();
matrix_set(matrix_world, matrix_build_identity());

if (!paused) {
	fps_timer = (fps_timer + 1) % fps_ratio;
}