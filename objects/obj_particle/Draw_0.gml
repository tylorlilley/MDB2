if (particle_type == PARTICLE_TYPES.CORPSE && has_cape) {
	set_shader_palette(PALETTES.GRAY_LIGHT);
	draw_sprite_ext(spr_cape_crushed, 0, x, y, 1, 1, image_rotation, c_white, 1);
	set_shader_palette(main_palette);
}

event_inherited();

