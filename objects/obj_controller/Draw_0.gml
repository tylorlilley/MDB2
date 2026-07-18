// Draw Debug Mask Highlights
if (draw_game_object_grid) {
	for (var _grid_x = 0; _grid_x < array_length(game_object_grid); _grid_x++) {
		for (var _grid_y = 0; _grid_y < array_length(game_object_grid[0]); _grid_y++) {
			var _instances = game_object_grid[_grid_x][_grid_y];
			for (var _i = 0; _i < array_length(_instances); _i++) {
				var _inst = _instances[_i]
			
				with (_inst) {
					draw_sprite_ext(spr_box_16x16, 0, _grid_x * 8, _grid_y * 8, 0.5, 0.5, 1, c_teal, 0.5);
				}
			}
		}
	}
}

// Draw Static Areas
if (!surface_exists(static_area_surface) || should_rebuild_static_area) { rebuild_static_area_surface(); }
draw_surface(static_area_surface, 0, 0);