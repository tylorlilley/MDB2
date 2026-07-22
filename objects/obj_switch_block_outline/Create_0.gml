event_inherited();

// Create Solid Metal Area
solid_obj = obj_switch_block;
begin_off = false;

// Solid Area Variables
main_sprite = noone;
outline_sprite = noone;

is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

toggle_solid = function(_create_particles = false) {
	if (instance_exists(solid_obj)) { 
		solid_obj.grid_remove();
		instance_deactivate_object(solid_obj);
		image_alpha = 1 //0.75;
	}
	else {
		instance_activate_object(solid_obj);
		solid_obj.grid_add();
		image_alpha = 0;
	}
	global.controller.should_rebuild_static_area = true;
	if (_create_particles) { create_sparkles(irandom(1)); }
}