if (state == 2) { instance_destroy(); }
else if (state == 0) {
	state = 1;
	sprite_index = spr_particle_drip;
	set_engine_speeds(0, 0, 0.35, 8, 0);
}