// Reset Surface
surface_resize(application_surface, SCREEN_WIDTH * 4, SCREEN_HEIGHT * 4);
display_set_gui_size(SCREEN_WIDTH, SCREEN_HEIGHT);

// Load Room Data
var _data = room_data();
room_world = _data.world;
room_title = _data.title;
global.world_tint = c_white;
build_background(room_world);
if (!is_cutscene_room()) { play_music(room_world); }

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
	solid_obj.depth = depth - 1;
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

// Set Up Palettes and Visual Variables
for (var _i = 0; _i < array_length(global.static_area_object_index_depth_order); _i++) {
	var _obj_index = global.static_area_object_index_depth_order[_i], _obj_type_exists = false;
	with (_obj_index) {
		depth = STATIC_AREA_DEPTH - _i; // TODO: Change this and places it is used to something unique rather than overloading GM depth
		if (fuzzing_sprite != noone) { fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1); }
		if (animated) { positional_animation_offset = ((((visual_origin_x div 8) - (visual_origin_y div 8)) % 4 + 4) % 4) * 2; }
		if (_obj_index != obj_bg_dirt) { update_connections(); } // TODO: Base this on something else
		main_palette = get_world_palette(object_index) ?? main_palette;
		particle_palette = (object_index == obj_sand) ? main_palette: get_darker_palette(main_palette);
		_obj_type_exists = true;
	}
}
with (obj_switch_block_outline) { if (begin_off) { toggle_solid(); } }
with (obj_visual_object) { image_blend = global.world_tint; }
with (obj_switch) { main_palette = get_switch_palette(switch_color); particle_palette = get_darker_palette(main_palette); }
with (obj_dynamic_object) {
	if (is_carrying_key()) { original_palette = PALETTES.YELLOW; main_palette = PALETTES.YELLOW; }
}
with (obj_player) { is_left = !other.classic_levels; }
with (obj_door) {
	if (global.room_keys == 0) { image_index = 1; }
}