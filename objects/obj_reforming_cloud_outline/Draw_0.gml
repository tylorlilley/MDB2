if (reform_timer > 0 && reform_timer < 60) {
	set_shader_palette();
	draw_sprite_ext(sprite_index, image_index, x, y, drawn_x_scale, drawn_y_scale, image_angle, c_white, 1);
}