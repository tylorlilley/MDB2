event_inherited();

// Create Solid AREA
solid_obj = noone;
reform_timer = 0;

main_palette = PALETTES.GRAY;
main_sprite = noone;
outline_sprite = spr_cloud_outline;

// Solid Area Variables
is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;
should_draw = false;

drawn_x_scale = 1;
drawn_y_scale = 1;

// Override Functions

connected_to = function(_inst) { return _inst.object_index == object_index && _inst.reform_timer == reform_timer; }

reform_cloud = function() {
	create_cloud();
	refresh_cloud_graphics();
	solid_obj.create_walk_particles(2);
	play_sound(snd_reforming_cloud);
	image_alpha = 1;
	main_sprite = noone;
	should_draw = false;
}

create_cloud = function() {
	if (!instance_exists(solid_obj)) {
		solid_obj = instance_create(x, y, obj_reforming_cloud);
		solid_obj.depth = depth - 1;
		solid_obj.main_palette = main_palette;
		solid_obj.particle_palette = main_palette;
		solid_obj.creator = id;
	}
}

refresh_cloud_graphics = function() {
	solid_obj.get_connections_for_graphics();
	solid_obj.update_connected_graphics();
	global.should_rebuild_static_area = true;
}

start_reform_timer = function() {
	reform_timer = 240;
	main_sprite = spr_cloud_area;
	should_draw = true;
	get_connections_for_graphics();
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