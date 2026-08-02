set_shader_palette((shine_timer == 1) ? PALETTES.ALL_WHITE : main_palette);
draw_self();
	
// Draw Open Door
if (image_index == 1) {
	draw_sprite_ext(sprite_index, image_index+2, x+16, y, 1, 1, 0, image_blend, image_alpha);
}
