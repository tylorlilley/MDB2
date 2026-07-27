event_inherited();

// New Variables
portal_color = PORTAL_COLORS.TWO;
activation_timer = 0;
activated = false;

// Visual Object Overides
depth = PORTAL_DEPTH;
original_palette  = get_portal_palette(portal_color);
main_palette = original_palette;
particle_palette  = original_palette;

// Functions
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
	return is_inside_object(obj_dynamic_object, function(_inst) { return _inst.is_portalable; });
}

is_blocked = function() {
	return is_inside_object(obj_dynamic_object, function(_inst) { return !_inst.is_portalable && _inst.is_solid_from_all_sides(); });
}