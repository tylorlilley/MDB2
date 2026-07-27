event_inherited();

activated = false;
activation_timer = 0;
depth = PORTAL_DEPTH;
anim_timer = 0;
anim_speed = 8;

portal_color = PORTAL_COLORS.TWO;
original_palette  = get_portal_palette(portal_color);
particle_palette  = original_palette;

deactivate_portal = function() {
	if (activated) {
		activation_timer = 80;
		activated = false;
		play_sound(snd_warp);
		create_particles(2+irandom(4), PARTICLE_TYPES.SPARKLE, particle_palette);
		create_particles(2+irandom(4), PARTICLE_TYPES.SPARKLE, PALETTES.GRAY_LIGHT);
	}
}

is_overlapped = function() {
	return is_inside_object(obj_player);
}

is_blocked = function() {
	return is_inside_solid(get_player_objects());
}

get_player_objects = function() {
	var _ignored_objects = []
	with (obj_player) { array_push(_ignored_objects, id); }
	return _ignored_objects;
}