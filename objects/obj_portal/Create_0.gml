event_inherited();

activated = false;
activation_timer = 0;
original_image_blend = c_white;
image_blend = original_image_blend;
depth = 0;
main_palette = PALETTES.PORTAL;
particle_palette = PALETTES.PORTAL;
anim_timer = 0;
anim_speed = 8;

deactivate_portal = function() {
	if (activated) {
		image_blend = c_white;
		activation_timer = 80;
		activated = false;
		play_sound(snd_warp);
		create_sparkles(2+irandom(4), particle_palette);
		create_sparkles(2+irandom(4), get_darker_palette(particle_palette));
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