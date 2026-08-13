event_inherited();
if (instance_exists(linked_portal) && activation_timer > 78) {
	shader_reset();
	var _original_palette = translate_uniform_values_to_color(original_palette, 1);
	var _player_palette = translate_uniform_values_to_color(player_palette, 2);
	draw_line_width_colour(x + 8, y + 8, linked_portal.x + 8, linked_portal.y + 8, 1, _original_palette, _player_palette);
	shader_set(shd_palettizer);
	shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);
}