// Reset Surface
surface_resize(application_surface, SCREEN_WIDTH * 4, SCREEN_HEIGHT * 4);
display_set_gui_size(SCREEN_WIDTH, SCREEN_HEIGHT);

// Load Room Data
var _data = room_data();
room_world = _data.world;
room_title = _data.title;
global.world_tint = c_white;
build_background(room_world);
var _transition_room = false;
with (obj_transition_manager) { _transition_room = true; }
if (!_transition_room) {
	play_music(room_world);
	// Save Current Room
	ini_open("mdb.ini");
	ini_write_real("progress", "current_level", room);
	ini_write_real("progress", "level_number", level_number);
	ini_write_real("progress", "progress_level", 1);
	ini_close();
}

// Spawn Background Layers
/*
if (instance_number(obj_bg_dirt) > 1) {
	var _cols = room_width div GRID_SIZE, _rows = room_height div GRID_SIZE;
	var _background_surface_manager = instance_create(x, y, obj_surface_manager);
	_background_surface_manager.depth = BACKGROUND_DEPTH;
	_background_surface_manager.initialize_game_object_grid(_cols, _rows);
	with (obj_bg_dirt) { grid_add(_background_surface_manager.game_object_grid); manager = _background_surface_manager; } // instance_destroy(); }
}
*/
	
// Spawn and Deactivate Instances
with (obj_tree) { initialize_solids(); }
with (obj_log) { initialize_solids(); }
with (obj_switch_block_outline) {
	main_palette = get_switch_palette(switch_color);
	solid_obj = instance_create(x, y, solid_obj);
	solid_obj.depth = depth - 1;
	solid_obj.main_palette = main_palette;
	if (begin_off) { toggle_solid(); }
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
static_area_objects_to_draw = [];
for (var _i = 0; _i < array_length(STATIC_AREA_OBJECT_INDEX_DEPTH_ORDER); _i++) {
	var _obj_index = STATIC_AREA_OBJECT_INDEX_DEPTH_ORDER[_i], _obj_type_exists = false;
	with (_obj_index) {
		depth = STATIC_AREA_DEPTH - _i; // TODO: Change this and places it is used to something unique rather than overloading GM depth
		if (fuzzing_sprite != noone) { fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1); }
		if (animated) { positional_animation_offset = ((((visual_origin_x div 8) - (visual_origin_y div 8)) % 4 + 4) % 4) * 2; }
		update_connections();
		main_palette = get_world_palette(object_index) ?? main_palette; // TODO: Does setting this per-instance matter if the controller is owning the draw? What else is this used for?
		particle_palette = (object_index == obj_sand) ? main_palette: get_darker_palette(main_palette);
		_obj_type_exists = true;
	}
	if (_obj_type_exists) { array_push(static_area_objects_to_draw, _obj_index); }
}

with (obj_bg_dirt) {
	if (fuzzing_sprite != noone) { fuzzing_image_index = irandom(sprite_get_number(fuzzing_sprite)-1); }
	update_connections();
	main_palette = get_world_palette(object_index) ?? main_palette;
}
with (obj_visual_object) { image_blend = global.world_tint; }
with (obj_switch) { main_palette = get_switch_palette(switch_color); particle_palette = get_darker_palette(main_palette); }
with (obj_dynamic_object) {
	if (is_carrying_key()) { original_palette = PALETTES.YELLOW; main_palette = PALETTES.YELLOW; }
}
with (obj_player) { is_left = !other.classic_levels; }
with (obj_door) {
	if (global.room_keys == 0) { image_index = 1; }
}