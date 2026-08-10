event_inherited();

// New Variables
masked_palette = get_world_palette(object_index);
activation_timer = 0;
activated = false;
masked = global.mask_portals;

// Visual Object Overides
depth = PORTAL_DEPTH;
original_palette = (masked) ? masked_palette : get_portal_palette(portal_color);
main_palette = original_palette;
particle_palette  = original_palette;
player_palette = noone;

// Functions
assign_portal_color = function() {
	original_palette = get_portal_palette(global.room_portals);
	particle_palette = original_palette;
	masked = false;
}

deactivate_portal = function(_player_palette) {
	if (activated) {
		if (masked && global.color_portals) {
			assign_portal_color()
			if (instance_exists(linked_portal)) { linked_portal.assign_portal_color(); }
			global.room_portals++;
		}
		
		player_palette = _player_palette;
		activation_timer = activation_time;
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