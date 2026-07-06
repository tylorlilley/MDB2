if (x > 0 && y > 0 && x < room_width && y < room_height) {
	particle_color = make_color_rgb(60, 188, 255);
	create_particles(8 + irandom(8));
	particle_color = make_color_rgb(0, 0, 255);
	create_particles(8 + irandom(8));
	particle_color = c_white;
	var _player_particle = create_particles(1, false, spr_player_dying_particle)[0]
	_player_particle.image_rotation = (_player_particle.hspeed < 0) ? 1 : -1;
	_player_particle.image_angle = 15 * _player_particle.image_rotation;
	_player_particle.vspeed--;
	_player_particle.hspeed /= 2;
}

play_sound(snd_player_death);
with (global.controller) {
	last_player_x = other.last_x;
	last_player_y = other.last_y;
}
instance_destroy();