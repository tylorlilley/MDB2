static_area_objects = [];
should_redraw = false;
static_area_surface = undefined;

redraw_static_area_surface = function() {
	// Set up Surface to Draw On
	if (!surface_exists(static_area_surface)) { static_area_surface = surface_create(room_width, room_height); }
	if (!surface_set_target(static_area_surface)) { show_debug_message("ERROR SETTING SURFACE"); exit; }
	draw_clear_alpha(c_black, 0);
	
	// Draw each object type to surface
	for (var _i = 0; _i < array_length(static_area_objects); _i++) {
		var _object_index = static_area_objects[_i];
		if (!instance_exists(_object_index)) { continue; }
		
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
	}
	
	should_redraw = false;
}

draw_static_area_surface_to_application_surface = function() {
	surface_reset_target();
	shader_reset();
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface(static_area_surface, 0, 0);
	gpu_set_blendmode(bm_normal);
	shader_set(shd_palettizer);
	shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);
}