// Draw Player and Cape
if (!draw_with_ladder_silhouette()) {
	if (visible && has_cape && cape_depth >= depth) { draw_cape_graphics(); }
	draw_dynamic_object();
	if (visible && has_cape && cape_depth < depth) { draw_cape_graphics(); }	
}