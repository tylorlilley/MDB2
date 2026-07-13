event_inherited();

/*
is_solid_from_above = true;
is_solid_from_below = true;
is_solid_from_right = true;
is_solid_from_left = true;
is_climbable = true;
*/

solid_obj = noone;
image_blend = c_red;
image_alpha = 0.125;

toggle_solid = function(_create_particles) {
	if (!instance_exists(solid_obj)) {
		solid_obj = instance_create_depth(x, y, 0, obj_metal);
		solid_obj.hits = 0;
		solid_obj.image_blend = image_blend;
		solid_obj.particle_color = image_blend;
		solid_obj.depth = depth + 1;
	}
	else { instance_destroy(solid_obj, false); visible = true; }
	
	if (_create_particles) {
		particle_color = image_blend;
		create_particles(1+irandom(1), true, spr_sparkle);
	}
}