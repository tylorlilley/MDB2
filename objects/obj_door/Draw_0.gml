set_shader_palette((shine_timer == 1) ? PALETTES.ALL_WHITE : main_palette);

var _winning_player = false;
with (obj_player) { if (state == PLAYER_STATES.WIN) { _winning_player = true; } }
	
if (image_index == 1 && !_winning_player) {
	var _interpolation_offset = global.controller.get_frame_progress();

	// Draw Title Sprite
	draw_sprite_swaying(sprite_index, image_index, sway_timer + _interpolation_offset, x, y, image_blend, image_alpha, 10);
} else {
	draw_self();
}
	
// Draw Open Door
if (image_index == 1) {
	draw_sprite_ext(sprite_index, image_index+2, x+14, y, 1, 1, 0, image_blend, image_alpha);
}
