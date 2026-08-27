with (obj_door) {
	// Draw Open Door
	if (visible && image_index == 1) {
		set_shader_palette(main_palette);
		var _ignored_objects = [];
		with (obj_player) { array_push(_ignored_objects, id); }
		if (!is_inside_solid(_ignored_objects)) {
			draw_sprite_ext(sprite_index, image_index+2, x+14, y, 1, 1, 0, image_blend, image_alpha);
		}
	}
}