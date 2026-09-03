event_inherited();

// New Variables
activation_timer = 0;
activated = false;
masked = global.mask_portals;

// Visual Object Overides
set_depth(PORTAL_DEPTH);
masked_palette = undefined; // Needs to be set by controller at Room Start
original_palette = (masked) ? masked_palette : get_portal_palette(portal_color);
main_palette = original_palette;
particle_palette  = original_palette;
player_palette = undefined;

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
		create_particles(5+irandom(5), PARTICLE_TYPES.SPARKLE, [main_palette, player_palette]);
		var _portal_line = instance_create(x, y, obj_portal_line);
		
		_portal_line.main_color = _portal_line.get_color_with_world_tint(translate_uniform_values_to_color(original_palette, 1));
		_portal_line.player_color = _portal_line.get_color_with_world_tint(translate_uniform_values_to_color(player_palette, 2));
		_portal_line.dest_x = linked_portal.x;
		_portal_line.dest_y = linked_portal.y;
	}
}

is_portalable = function(_inst) { return _inst.is_portalable; }
is_solid_and_not_portalable = function(_inst) { return !_inst.is_portalable && _inst.is_solid_from_all_sides(); }
is_overlapped = function() {
	/*
	var _nearest_dynamic_object = instance_nearest(x + GRID_SIZE, y + GRID_SIZE, obj_dynamic_object);
	if (!instance_exists(_nearest_dynamic_object)) { return false; }
	var _dist_to_nearest_dynamic_object = point_distance(x + GRID_SIZE, y, _nearest_dynamic_object.x + GRID_SIZE, _nearest_dynamic_object.y + GRID_SIZE);
	return (_dist_to_nearest_dynamic_object < GRID_SIZE * 2);
	*/
	return array_length(get_relative_overlapping_objects(is_portalable, obj_dynamic_object)) > 0
}

is_blocked = function() {
	return array_length(get_relative_overlapping_objects(is_solid_and_not_portalable, obj_dynamic_object)) > 0
}