// Inherit the parent event
event_inherited();

anim_timer--;
if (anim_timer == 0) {
	image_index = 1;
	anim_timer = 120 + irandom(16);
}
else {
	image_index = 0;
}

if (at_grid_position_exact(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_player)) {
	//create_particles(8 + irandom(8));
	particle_color = c_white;
	create_particles(8 + irandom(8), true, spr_sparkle);
	instance_destroy();
}