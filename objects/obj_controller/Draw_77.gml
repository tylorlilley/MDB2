matrix_set(matrix_world, matrix_build_identity());
draw_set_alpha(1);
if (surface_exists(application_surface)) {
	draw_surface(application_surface, gui_offset_x, gui_offset_y);
}