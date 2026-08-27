set_shader_palette((shine_timer == 1) ? PALETTES.ALL_WHITE : main_palette);
if (image_index == 1 && !winning_player) {
	var _interpolation_offset = global.controller.get_frame_progress();

	// Draw Title Sprite
	draw_sprite_swaying(sprite_index, image_index, sway_timer + _interpolation_offset, x, y, image_blend, image_alpha, 5);
} else {
	draw_self();
}
	
