// Reset Surface
gui_scale = (window_fullscreen_setting == FULL_SCREEN_OPTIONS.WINDOWED) ? window_scale_setting : get_maximum_screen_scale();
surface_resize(application_surface, SCREEN_WIDTH * gui_scale, SCREEN_HEIGHT * gui_scale);
display_set_gui_size(SCREEN_WIDTH * gui_scale, SCREEN_HEIGHT * gui_scale);

// Load Room Data
var _data = room_data();
room_world = _data.world;
room_title = _data.title;
classic_level =  _data.is_classic;
global.world_tint = c_white;
build_world_background(room_world);
if (!is_cutscene_room()) { play_world_music(room_world); }
window_set_caption(GAME_TITLE + ": " + room_title);

if (instance_exists(obj_bg_dirt)) {
	var _cols = room_width div GRID_SIZE, _rows = room_height div GRID_SIZE, _dirt_grid = create_object_grid(_cols, _rows);
	with (obj_bg_dirt) { grid_add(_dirt_grid); }
	with (obj_bg_dirt) { update_connections(_dirt_grid); }
}
	
// Spawn and Deactivate Instances
with (obj_tree) { initialize_solids(); }
with (obj_log) { initialize_solids(); }
with (obj_switch_block_outline) {
	main_palette = get_switch_palette(switch_color);
	solid_obj = instance_create(x, y, solid_obj);
	solid_obj.main_palette = main_palette;
}
with (obj_reforming_cloud_outline) { create_cloud(); }
with (obj_dynamic_object) {
	if (contents != noone) {
		contents = instance_create(0, 0, contents);
		contents.grid_remove();
		instance_deactivate_object(contents);
	}
}

/// Set Up Palettes and Visual Variables
// Static Area Objects
with (obj_visual_object) { image_blend = global.world_tint; }
connect_static_areas_to_manager([obj_bg_dirt], BACKGROUND_DEPTH, false);
//connect_static_areas_to_manager([obj_ladder], LADDER_DEPTH, false);
connect_static_areas_to_manager([obj_metal, obj_tile, obj_brick, obj_rock, obj_sand, obj_bridge, obj_wood, obj_leaf, obj_cloud], STATIC_AREA_DEPTH, true);
connect_static_areas_to_manager([obj_lava, obj_switch_block], SWITCH_BLOCK_DEPTH, true);
connect_static_areas_to_manager([obj_reforming_cloud_outline, obj_switch_block_outline], OUTLINE_DEPTH, false);
with (obj_switch_block_outline) { if (begin_off) { toggle_solid(); } }
with (obj_switch_block) { update_connections(); }

// Other Objects
with (obj_switch) { main_palette = get_switch_palette(switch_color); particle_palette = get_darker_palette(main_palette); }
with (obj_dynamic_object) {
	if (is_carrying_key()) { original_palette = PALETTES.YELLOW; main_palette = PALETTES.YELLOW; reset_shine_timer(); }
}
with (obj_player) {
	// Robots use the variable definitions to set is_left for each room
	if (object_index == obj_player) { is_left = other.classic_level; }
	if (object_index == obj_mirror_player) { is_left = !other.classic_level; }
	powered_palette = get_world_palette(object_index);
}
with (obj_door) {
	if (global.room_keys == 0) { image_index = 1; }
}
with (obj_portal) {
	masked_palette = get_world_palette(object_index);
	original_palette = (masked) ? masked_palette : get_portal_palette(portal_color);
	main_palette = original_palette;
	particle_palette  = original_palette;
}
