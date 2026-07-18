event_inherited();

// Create Solid Metal Area
solid_obj = noone;
reform_timer = 0;

main_palette = PALETTES.GRAY_DARK;
sprite_index = spr_reforming_cloud;
main_sprite = noone;
outline_sprite = noone;

// Solid Area Variables
is_solid_from_above = false;
is_solid_from_below = false;
is_solid_from_right = false;
is_solid_from_left = false;
is_climbable = false;

create_cloud = function() {
	if (!instance_exists(solid_obj)) {
		solid_obj = instance_create_depth(x, y, 0, obj_reforming_cloud);
		solid_obj.depth = depth - 1;
		solid_obj.main_palette = main_palette;
		solid_obj.creator = id;
		solid_obj.get_connections_for_graphics();
		solid_obj.update_connected_graphics();
		global.controller.should_rebuild_static_area = true;
	}
}

start_reform_timer = function() {
	reform_timer = 240;
	image_angle = irandom(3) * 90;
	drawn_x_scale = (irandom(1)) == 0 ? -1 : 1;
	drawn_y_scale = (irandom(1)) == 0 ? -1 : 1;
}