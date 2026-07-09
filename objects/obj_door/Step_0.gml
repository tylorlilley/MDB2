// Inherit the parent event
event_inherited();

if (image_index <= 1) {
	shine();

	if (instance_number(obj_key) == 0) {
		create_particles(8 + irandom(8));
		particle_color = c_white;
		create_particles(8 + irandom(8), true, spr_sparkle);	
		particle_color = make_color_rgb(136, 112, 0);
		image_index = 2;
		play_sound(snd_door_open);
		play_sound(snd_explosion);
	}
}
