event_inherited();

// Create Solid AREA
solid_obj = noone;
reform_timer = 0;

main_palette = PALETTES.GRAY;
main_sprite = noone;
outline_sprite = spr_cloud_outline;
should_draw = false;
has_square_shape = true;

// Solid Area Variables
is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

drawn_x_scale = 1;
drawn_y_scale = 1;

// Override Functions

connected_to = function(_inst) { return _inst.object_index == object_index && _inst.reform_timer == reform_timer; }

reform_cloud = function() {
	create_cloud();
	solid_obj.update_connections();
	solid_obj.update_connected_graphics();
	solid_obj.create_walk_particles(2);
	solid_obj.fuzzing_image_index = irandom(sprite_get_number(solid_obj.fuzzing_sprite)-1);
	solid_obj.outline_sprite = spr_cloud_outline;
	
	play_sound(snd_reforming_cloud);
	main_sprite = noone;
	outline_sprite = spr_cloud_outline;
	should_draw = false;
	manager.should_redraw = true;
}

create_cloud = function() {
	if (!instance_exists(solid_obj)) {
		solid_obj = instance_create(x, y, obj_reforming_cloud);
		solid_obj.depth = depth - 1;
		solid_obj.main_palette = main_palette;
		solid_obj.particle_palette = main_palette;
		solid_obj.creator = id;
		solid_obj.manager.should_redraw = true;
	}
}

start_reform_timer = function() {
	reform_timer = 240;
	main_sprite = spr_cloud_area;
	outline_sprite = spr_reforming_cloud_outline;
	should_draw = true;
	update_connections();
	update_connected_graphics();
	image_index = 0;
	image_angle = irandom(3) * 90;
	drawn_x_scale = (irandom(1)) == 0 ? -1 : 1;
	drawn_y_scale = (irandom(1)) == 0 ? -1 : 1;
}

part_damaged = function(_inst) {
	solid_obj = noone;
	start_reform_timer();
	with (_inst) { instance_destroy(); }
}