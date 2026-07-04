// Inherit the parent event
event_inherited();

if (image_index == 0) {
	if (instance_number(obj_key) == 0) {
		create_particles(8 + irandom(8));
		particle_color = c_white;
		create_particles(8 + irandom(8), true, spr_sparkle);
		image_index = 1;
	}
}
else {
	if (at_grid_position_exact(x, y, sprite_index, sprite_height, obj_player)) {
		// Win the Level
		room_goto_next();
	}
}