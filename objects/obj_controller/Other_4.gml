// Set Background
build_background(WORLDS.FOREST);
play_music(WORLDS.BEACH);
	
// Set Palettes
with (obj_switch) { main_palette = get_switch_palette(switch_color); }
with (obj_switch_block_outline) {
	main_palette = get_switch_palette(switch_color);
	solid_obj = instance_create(x, y, solid_obj);
	solid_obj.depth = depth - 1;
	solid_obj.main_palette = main_palette;
	if (begin_off) { toggle_solid(); }
}
with (obj_reforming_cloud_outline) { create_cloud(); }
with (obj_tree) { initialize_tree(); }
with (obj_static_area) { get_connections_for_graphics(); }

// Draw Static Area Surface
rebuild_static_area_surface();

// Spawn and Deactivate Instances
with (obj_dynamic_object) {
	if (contents != noone) {
		contents = instance_create(0, 0, contents);
		contents.grid_remove();
		instance_deactivate_object(contents);
	}
}

// Set Dynamic Instance Palette Based on Spawned Instances
with (obj_dynamic_object) {
	if (is_carrying_key()) { original_palette = PALETTES.YELLOW; main_palette = PALETTES.YELLOW; }
}