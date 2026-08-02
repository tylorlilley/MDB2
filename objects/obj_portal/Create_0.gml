event_inherited();

// New Variables
masked_palette = PALETTES.INDIGO_DARK;
activation_timer = 0;
activated = false;
masked = true;

// Visual Object Overides
depth = PORTAL_DEPTH;
original_palette = masked_palette;
main_palette = masked_palette;
particle_palette  = main_palette;
player_palette = noone;

// Functions
assign_portal_color = function() {
	original_palette = get_portal_palette(global.room_portals);
	particle_palette = original_palette;
	masked = false;
}

deactivate_portal = function(_player_palette) {
	if (activated) {
		if (masked) {
			if (global.color_portals) {
				assign_portal_color()
				if (instance_exists(linked_portal)) { linked_portal.assign_portal_color(); }
				global.room_portals++;
			}
			player_palette = _player_palette;
		}
		
		activation_timer = 80;
		activated = false;
		play_sound(snd_warp);
		create_particles(1+irandom(2), PARTICLE_TYPES.SPARKLE, main_palette);
		create_particles(1+irandom(2), PARTICLE_TYPES.SPARKLE, PALETTES.GRAY_LIGHT);
	}
}

is_overlapped = function() {
	return is_inside_object(obj_dynamic_object, function(_inst) { return _inst.is_portalable; });
}

is_blocked = function() {
	return is_inside_object(obj_dynamic_object, function(_inst) { return !_inst.is_portalable && _inst.is_solid_from_all_sides(); });
}