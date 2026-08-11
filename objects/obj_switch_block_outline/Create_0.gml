event_inherited();

// Create Solid Metal Area
solid_obj = obj_switch_block;
begin_off = false;
//depth = SWITCH_BLOCK_DEPTH;

// Solid Area Variables
main_sprite = undefined;
outline_sprite = spr_switch_block_off_outline;

is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

toggle_solid = function(_create_particles = false) {
	if (instance_exists(solid_obj)) { 
		solid_obj.grid_remove();
		if (!instance_exists(solid_obj.manager)) { solid_obj.manager = manager; }
		solid_obj.mark_manager_for_redraw();
		instance_deactivate_object(solid_obj);
		should_draw = true;
		mark_manager_for_redraw();
	}
	else {
		instance_activate_object(solid_obj);
		solid_obj.grid_add();
		if (!instance_exists(solid_obj.manager)) { solid_obj.manager = manager; }
		solid_obj.mark_manager_for_redraw();
		should_draw = false;
		mark_manager_for_redraw();
	}
	if (_create_particles) {
		//if (irandom(3) == 0) { create_particles(1, PARTICLE_TYPES.SPARKLE, get_lighter_palette(main_palette)); }
		solid_obj.main_palette = PALETTES.ALL_WHITE;
	}
}