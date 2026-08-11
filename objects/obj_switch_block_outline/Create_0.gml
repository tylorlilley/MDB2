event_inherited();

// Gameplay Variables
hits = 0;
is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

// Sprite Variables
main_palette = PALETTES.GRAY;
main_sprite = undefined;
outline_sprite = spr_switch_block_off_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = undefined;
	
// Visual Drawing Variables
animated = false;
has_square_shape = false;
has_darker_particles = false;
particle_frequency = 0;
	
// Sound Variables
step_sound = undefined;
damaged_sound = undefined;

// New Variables
solid_obj = obj_switch_block;
begin_off = false;
destroyed_sound = undefined;

// New Functions
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