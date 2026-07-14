event_inherited();

/*
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_climbable = true;
*/

switch_color = SWITCH_COLORS.RED;

// Create Solid Metal Area
solid_obj = instance_create_depth(x, y, 0, obj_metal);
solid_obj.depth = depth - 1;

// Solid Area Variables
main_sprite = noone;
outline_sprite = spr_dotted_outline;

is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

toggle_solid = function(_create_particles) {
	if (instance_exists(solid_obj)) { 
		solid_obj.grid_remove();
		instance_deactivate_object(solid_obj);
	}
	else {
		instance_activate_object(solid_obj);
		solid_obj.grid_add();
	}
	
	if (_create_particles) { create_sparkles(irandom(1)); }
}