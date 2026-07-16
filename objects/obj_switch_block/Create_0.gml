event_inherited();

// Create Solid Metal Area
solid_obj = obj_metal;
begin_off = false;

// Solid Area Variables
main_sprite = noone;
outline_sprite = spr_dotted_outline;

is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

toggle_solid = function(_create_particles = false) {
	if (instance_exists(solid_obj)) { 
		solid_obj.grid_remove();
		instance_deactivate_object(solid_obj);
		image_alpha = 0.75;
	}
	else {
		instance_activate_object(solid_obj);
		solid_obj.grid_add();
		image_alpha = 0;
	}
	
	if (_create_particles) { create_sparkles(irandom(1)); }
}