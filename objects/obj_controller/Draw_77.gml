matrix_set(matrix_world, matrix_build_identity());
draw_set_alpha(1);
if (surface_exists(application_surface)) {
	// Every translucent in-world draw erodes this surface's alpha, because bm_normal
	// writes the alpha channel as well as colour. Its RGB is already correctly
	// composited, so copy it verbatim instead of re-blending against the bad alpha.
	gpu_set_blendmode_ext(bm_one, bm_zero);
	draw_surface(application_surface, gui_offset_x, gui_offset_y);
	gpu_set_blendmode(bm_normal);
}