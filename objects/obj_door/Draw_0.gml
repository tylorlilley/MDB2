event_inherited();

if (image_index == 1) {
	use_palette_shader();
	draw_sprite(sprite_index, image_index+2, x+16, y);
	shader_reset();
}
