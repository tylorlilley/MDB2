initialize_surface_manager = function() {
	game_object_grid = [];
	static_area_surface = noone;
}

initialize_game_object_grid = function(_cols, _rows) {
	game_object_grid = array_create(_cols);
	for (var _x = 0; _x < _cols; _x++) {
		game_object_grid[_x] = array_create(_rows);
		for (var _y = 0; _y < _rows; _y++) {
	        game_object_grid[_x][_y] = [];
	    }
	}
}


draw_static_areas = function() {
	// Regenerate Surface if Room Size has Changed
	if (surface_exists(static_area_surface) && (surface_get_width(static_area_surface) != room_width || surface_get_height(static_area_surface) != room_height)) { surface_free(static_area_surface); static_area_surface = noone; }
	
	var _new_static_area_objects_to_draw = [];
	for (var _i = 0; _i < array_length(static_area_objects_to_draw); _i++) {
		var _object_index = static_area_objects_to_draw[_i], _obj_type_exists = false;
		
		// Set up Surface to Draw On
		if (!surface_exists(static_area_surface)) { static_area_surface = surface_create(room_width, room_height); }
		if (!surface_set_target(static_area_surface)) { show_debug_message("ERROR SETTING SURFACE"); }
		draw_clear_alpha(c_white, 0);
		
		// Set Palette and Draw Tiles to Surface
		set_shader_palette(get_world_palette(_object_index) ?? _object_index.main_palette);
		with (_object_index) {
			draw_static_area_tile();
			_obj_type_exists = true;
		}
		
		// Draw Surface to Application Surface
		surface_reset_target();
		draw_surface(static_area_surface, 0, 0); // TODO: should this use draw_surface_ext and apply any per-object-type alpha here when the surface is drawn, instead of using alpha in draw_static_area_tile?
		
		if (_obj_type_exists) { array_push(_new_static_area_objects_to_draw, _object_index); }
	}
	static_area_objects_to_draw = _new_static_area_objects_to_draw;
	//shader_reset(); // TODO: Does this need to be called  if controller always calls it at Draw End anyway?
}

/*
rebuild_surface = function(_object_index = obj_visual_object) {
	// Set up Surface to Draw
	if (surface_exists(static_area_surface) && (surface_get_width(static_area_surface) != room_width || surface_get_height(static_area_surface) != room_height)) { surface_free(static_area_surface); static_area_surface = noone; }
	if (!surface_exists(static_area_surface)) { static_area_surface = surface_create(room_width, room_height); }
	if (!surface_set_target(static_area_surface)) { show_debug_message("ERROR SURFACE"); return noone; }
	shader_set(shd_palettizer);
	draw_clear_alpha(0, 0);
	
	// Draw Tiles in Depth Order
	var _instances_to_draw = [];
	var _max_x = room_width div GRID_SIZE, _max_y = room_height div GRID_SIZE;
	for (var _grid_x = 0; _grid_x < _max_x; _grid_x++) {
		for (var _grid_y = 0; _grid_y < _max_y; _grid_y++) {
			var _arr = game_object_grid[_grid_x][_grid_y];
			for (var _i = 0; _i < array_length(_arr); _i++) {
				var _inst = _arr[_i];
				if (!instance_exists(_inst)) { continue; }
				if (_inst.is_a(_object_index)) { array_push(_instances_to_draw, _inst) };
			}
		}
	}
	array_sort(_instances_to_draw, function(_a, _b) {
		if (_a.depth != _b.depth) { return _b.depth - _a.depth; }
		if (_a.y != _b.y) { return _a.y - _b.y; }
		if (_a.x != _b.x) { return _a.x - _b.x; }
		return real(_a.id) - real(_b.id);
	});
	for (var _i = 0; _i < array_length(_instances_to_draw); _i++) {
		_instances_to_draw[_i].draw_static_area_tile();
	}
	
	// Reset Surface
	shader_reset();
	surface_reset_target();
}
