event_inherited();
if (instance_exists(linked_portal) && activation_timer > 78) {
	shader_reset();
	draw_set_color(C_BLUE_PLAYER);
	draw_line_color(x + 8, y + 8, linked_portal.x + 8, linked_portal.y + 8, C_PURPLE, C_BLUE_PLAYER);
	shader_set(shd_palettizer);
	shader_set_uniform_f(global.u_tint_amount, 0.42);
}