static_area_objects = [];
has_own_surface = false;
static_area_surface = noone;

draw_static_areas = function() {
	var _static_area_surface = (has_own_surface) ? static_area_surface : global.static_area_surface;

	// Regenerate Surface if Room Size has Changed
	if (surface_exists(_static_area_surface) && (surface_get_width(_static_area_surface) != room_width || surface_get_height(_static_area_surface) != room_height)) { surface_free(_static_area_surface); _static_area_surface = noone; }
	
	for (var _i = 0; _i < array_length(static_area_objects); _i++) {
		var _object_index = static_area_objects[_i];
		if (!instance_exists(_object_index)) { continue; }
		
		// Set up Surface to Draw On
		if (!surface_exists(_static_area_surface)) { _static_area_surface = surface_create(room_width, room_height); }
		if (!surface_set_target(_static_area_surface)) { show_debug_message("ERROR SETTING SURFACE"); continue; }
		draw_clear_alpha(c_black, 0);
		
		// Set Palette and Draw Tiles to Surface
		var _last_palette = undefined;
		with (_object_index) {
			if (main_palette != _last_palette) { set_shader_palette(main_palette); _last_palette = main_palette; }
			draw_static_area_fill();
		}
		_last_palette = undefined;
		with (_object_index) {
			if (main_palette != _last_palette) { set_shader_palette(main_palette); _last_palette = main_palette; }
			draw_static_area_outline();
		}
		gpu_set_blendmode_ext(bm_zero, bm_src_alpha);
		with (_object_index) { draw_static_area_mask(); }
		gpu_set_blendmode(bm_normal);
		
		// Draw Surface to Application Surface
		draw_static_area_surface(_static_area_surface);
	}
}

draw_static_area_surface = function(_surface) {
	surface_reset_target();
	shader_reset();
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface(_surface, 0, 0);
	gpu_set_blendmode(bm_normal);
	shader_set(shd_palettizer);
	shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);
}