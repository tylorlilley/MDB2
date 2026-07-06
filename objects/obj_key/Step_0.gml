// Inherit the parent event
event_inherited();

shine();

if (at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_player)) {
	//create_particles(8 + irandom(8));
	particle_color = c_white;
	create_particles(8 + irandom(8), true, spr_sparkle);
	play_sound(snd_key);
	instance_destroy();
}