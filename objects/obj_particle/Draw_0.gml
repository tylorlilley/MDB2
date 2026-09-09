if (!is_head) {
	if (particle_type == PARTICLE_TYPES.CORPSE && has_cape) {
		set_shader_palette(PALETTES.GRAY_LIGHT);
		draw_sprite_ext(spr_particle_cape, 0, x, y, 1, 1, image_angle, image_blend, 1);
		set_shader_palette(main_palette);
	}

	event_inherited();
}
else {
	shader_reset();
	var _old_filter = gpu_get_texfilter();
	gpu_set_texfilter(true);
	
	draw_self();
	
	gpu_set_texfilter(_old_filter);
	shader_set(shd_palettizer);
	shader_set_uniform_f(global.u_tint_amount, global.world_tint_strength);
}

