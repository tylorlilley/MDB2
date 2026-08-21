static_area_objects = [];
should_redraw = true;
static_area_surface = undefined;
uses_static_area_draw = true;

is_occluder = true;
occlusion_alpha = undefined;
occluded_surface = undefined;

redraw_static_area_surface = function() {
	// Create Static Area Surface
	if (!surface_exists(static_area_surface)) { static_area_surface = surface_create(room_width, room_height); }
	if (!surface_set_target(static_area_surface)) { show_debug_message("ERROR SETTING STATIC AREA SURFACE"); exit; }
	draw_clear_alpha(c_black, 0);
		
	// Draw each object type to scratch surface
	for (var _i = 0; _i < array_length(static_area_objects); _i++) {
		var _object_index = static_area_objects[_i];
		if (!instance_exists(_object_index)) { continue; }
		
		// Clear Surface
		if (!surface_exists(global.static_area_scratch_surface)) { global.static_area_scratch_surface = surface_create(room_width, room_height); }
		if (!surface_set_target(global.static_area_scratch_surface)) { show_debug_message("ERROR SETTING GLOBAL SCRATCH SURFACE"); surface_reset_target(); exit; }
		draw_clear_alpha(c_black, 0);
		
		// Set Palette and Draw Tiles to Surface
		var _last_palette = undefined;
		if (uses_static_area_draw) {
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
		else {
			with (_object_index) {
				if (main_palette != _last_palette) { set_shader_palette(main_palette); _last_palette = main_palette; }
				draw_self();
			}
		}
		surface_reset_target();
		
		// Draw to Static Area Surface
		draw_surface_without_shader(global.static_area_scratch_surface);
	}	

	surface_reset_target();
	if (!is_undefined(occlusion_alpha)) { split_surface_by_occlusion(); }
	should_redraw = false;
}

draw_surface_without_shader = function(_surface_to_draw, _colour = c_white, _alpha = 1) {
	shader_reset();
	gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
	draw_surface_ext(_surface_to_draw, 0, 0, 1, 1, 0, _colour, _alpha);
	gpu_set_blendmode(bm_normal);
	shader_set(shd_palettizer);
	shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);
}