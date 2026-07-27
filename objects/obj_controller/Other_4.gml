// Load Room Data
var _data = room_data();
room_world = _data.world;
room_title = _data.title;
global.world_tint = c_white;
build_background(room_world);
play_music(room_world);
	
// Set Palettes
with (obj_visual_object) { image_blend = global.world_tint; }
with (obj_switch) { main_palette = get_switch_palette(switch_color); particle_palette = get_darker_palette(main_palette); }
with (obj_switch_block_outline) {
	main_palette = get_switch_palette(switch_color);
	solid_obj = instance_create(x, y, solid_obj);
	solid_obj.depth = depth - 1;
	solid_obj.main_palette = main_palette;
	if (begin_off) { toggle_solid(); }
}
with (obj_reforming_cloud_outline) { create_cloud(); }
with (obj_tree) { initialize_solids(); }
with (obj_log) { initialize_solids(); }
with (obj_static_area) { get_connections_for_graphics(); }

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