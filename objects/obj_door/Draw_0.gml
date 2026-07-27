if (visible) {
	set_shader_palette((shine_timer == 0) ? PALETTES.ALL_WHITE : main_palette);
	draw_self();
	
	// Draw Open Door
	if (image_index == 1) {
		draw_sprite(sprite_index, image_index+2, x+16, y);
	}
}
