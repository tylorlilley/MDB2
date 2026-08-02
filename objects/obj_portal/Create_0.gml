event_inherited();

// New Variables
portal_color = PORTAL_COLORS.TWO;
activation_timer = 0;
activated = false;
masked = true;

// Visual Object Overides
depth = PORTAL_DEPTH;
original_palette = (masked) ? PALETTES.INDIGO_DARK : get_portal_palette(portal_color);
main_palette = (masked) ? PALETTES.INDIGO_DARK : original_palette;
particle_palette  = main_palette;
player_palette = noone;

// Functions
assign_portal_color = function(_player_palette) {
	original_palette = get_portal_palette(global.room_portals);
	particle_palette = original_palette;
	player_palette = _player_palette;
	masked = (global.color_portals) ? false : true;
}

deactivate_portal = function(_player_palette) {
	if (activated) {
		if (masked) {
			assign_portal_color(_player_palette);
			if (instance_exists(linked_portal)) { linked_portal.assign_portal_color(_player_palette); }
			global.room_portals++;
		}
		
		activation_timer = 80;
		activated = false;
		play_sound(snd_warp);
		create_particles(2+irandom(4), PARTICLE_TYPES.SPARKLE, main_palette);
		create_particles(2+irandom(4), PARTICLE_TYPES.SPARKLE, PALETTES.GRAY_LIGHT);
	}
}

is_overlapped = function() {
	return is_inside_object(obj_dynamic_object, function(_inst) { return _inst.is_portalable; });
}

is_blocked = function() {
	return is_inside_object(obj_dynamic_object, function(_inst) { return !_inst.is_portalable && _inst.is_solid_from_all_sides(); });
}