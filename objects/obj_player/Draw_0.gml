// Draw Player and Cape
if (!draw_with_static_area_clipping()) {
	if (has_cape && cape_depth >= depth) { draw_cape_graphics(); }
	draw_dynamic_object();
	if (has_cape && cape_depth < depth) { draw_cape_graphics(); }	
}