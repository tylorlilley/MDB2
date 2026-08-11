// Repeat some things instead of using event_inherited()
grid_remove();
spawn_contents();

// Handle Creating Death Particles
if (x > 0 && y > 0 && x < room_width && y < room_height) {
	create_particles(8 + irandom(8), PARTICLE_TYPES.DEBRIS, get_darker_palette(particle_palette));
	create_particles(8 + irandom(8), PARTICLE_TYPES.DEBRIS, get_darker_palette(get_darker_palette(particle_palette)));
	create_particles(1, PARTICLE_TYPES.CORPSE, original_palette, undefined, undefined, death_sprite);
}

// Other Player Death Stuff
if (can_be_controlled) { global.controller.start_screen_shake(); }
play_sound(destroyed_sound);
if (fall_sound != undefined) { audio_stop_sound(fall_sound); }
if (last_x != undefined && last_y != undefined) {
	global.controller.x = last_x;
	global.controller.y = last_y;
}
