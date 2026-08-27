event_inherited();

// The off-screen row beneath the last visible row must go too, or it shows up during a screen shake.
if (y == room_height - (GRID_SIZE * 2)) {
	var _below = instances_at_grid_position(x, y + GRID_SIZE, GRID_SIZE, GRID_SIZE, object_index, false);
	for (var _i = 0; _i < array_length(_below); _i++) {
		if (connected_to(_below[_i])) { with (_below[_i]) { instance_destroy(); } }
	}
}

mark_manager_for_redraw();
update_connected_graphics();