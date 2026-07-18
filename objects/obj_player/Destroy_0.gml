// Repeat some things instead of using event_inherited()
grid_remove();
spawn_contents();

// Handle Creating Death Particles
if (x > 0 && y > 0 && x < room_width && y < room_height) {
	create_particles(8 + irandom(8), get_darker_palette(original_palette));
	create_particles(8 + irandom(8), get_darker_palette(get_darker_palette(original_palette)));
	var _player_particle = create_particles(1, original_palette, death_sprite, false)[0];
	_player_particle.image_rotation = (_player_particle.hspeed < 0) ? 1 : -1;
	_player_particle.image_angle = 15 * _player_particle.image_rotation;
	_player_particle.vspeed--;
	_player_particle.hspeed /= 2;
}

// Other Player Death Stuff
play_sound(snd_player_death);
if (last_x != -999 && last_y != -999) {
	with (global.controller) {
		last_player_x = other.last_x;
		last_player_y = other.last_y;
	}
}