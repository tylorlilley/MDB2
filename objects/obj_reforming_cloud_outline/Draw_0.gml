if (reform_timer > 0 && reform_timer < 60) {
	use_palette_shader();
	draw_sprite_ext(sprite_index, image_index, x, y, drawn_x_scale, drawn_y_scale, image_angle, c_white, 1);
	shader_reset();
}