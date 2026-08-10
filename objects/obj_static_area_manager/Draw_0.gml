if (has_own_surface) {
	if (!surface_exists(static_area_surface)) { draw_static_areas(); }
	else { draw_static_area_surface(static_area_surface); }
}
else { draw_static_areas(); }