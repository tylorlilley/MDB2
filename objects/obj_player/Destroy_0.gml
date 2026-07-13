grid_remove();
if (x > 0 && y > 0 && x < room_width && y < room_height) {
	particle_color = death_particle_color1;
	create_particles(8 + irandom(8));
	particle_color = death_particle_color2;
	create_particles(8 + irandom(8));
	particle_color = c_white;
	var _player_particle = create_particles(1, false, death_sprite)[0]
	_player_particle.image_rotation = (_player_particle.hspeed < 0) ? 1 : -1;
	_player_particle.image_angle = 15 * _player_particle.image_rotation;
	_player_particle.image_blend = image_blend;
	_player_particle.vspeed--;
	_player_particle.hspeed /= 2;
}

play_sound(snd_player_death);
if (last_x && last_y) {
	with (global.controller) {
		last_player_x = other.last_x;
		last_player_y = other.last_y;
	}
}