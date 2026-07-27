// Repeat some things instead of using event_inherited()
grid_remove();
spawn_contents();

// Handle Creating Death Particles
if (x > 0 && y > 0 && x < room_width && y < room_height) {
	create_particles(8 + irandom(8), get_darker_palette(particle_palette));
	create_particles(8 + irandom(8), get_darker_palette(get_darker_palette(particle_palette)));
	var _player_particle = create_particles(1, original_palette, death_sprite, false)[0];
	_player_particle.image_rotation = (_player_particle.hspeed < 0) ? 1 : -1;
	_player_particle.image_angle = 15 * _player_particle.image_rotation;
	_player_particle.vspeed--;
	_player_particle.hspeed /= 2;
	_player_particle.depth -= 1;
}

// Other Player Death Stuff
if (can_be_controlled) { global.controller.start_screen_shake(); }
play_sound(snd_player_death);
audio_stop_sound(fall_sound);
if (!is_undefined(last_x) && !is_undefined(last_y)) {
	global.last_player_x = last_x;
	global.last_player_y = last_y;
}
