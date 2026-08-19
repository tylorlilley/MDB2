event_inherited();

// Overwritten Variables
// These are overwritten by obj_controller at room start when connecting to the static area manager,
// but need to be here because create_cloud reads from them. Keep these in sync with the manager assign.
set_depth( OUTLINE_DEPTH - 1);

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
outline_sprite = spr_cloud_outline;
outline_mask_sprite = undefined;
fuzzing_sprite = undefined;
	
// Visual Drawing Variables
should_draw = false;
animated = false;
has_square_shape = true;
has_darker_particles = false;
particle_frequency = 0;
	
// Sound Variables
step_sound = undefined;
damaged_sound = undefined;
destroyed_sound = undefined;

// New Variables
drawn_x_scale = 1;
drawn_y_scale = 1;
solid_obj = noone;
reform_timer = 0;

// Overriden Functions
connected_to = function(_inst) { return _inst.object_index == object_index && _inst.reform_timer == reform_timer; }

part_damaged = function(_inst) {
	solid_obj = noone;
	start_reform_timer();
	with (_inst) { instance_destroy(); }
}

// New Functions
reform_cloud = function() {
	create_cloud();
	solid_obj.update_connections();
	solid_obj.update_connected_graphics();
	solid_obj.create_walk_particles(2);
	solid_obj.fuzzing_image_index = irandom(sprite_get_number(solid_obj.fuzzing_sprite)-1);
	solid_obj.outline_sprite = spr_cloud_outline;
	solid_obj.mark_manager_for_redraw();
	
	play_sound(snd_reforming_cloud);
	main_sprite = undefined;
	outline_sprite = spr_cloud_outline;
	should_draw = false;
	mark_manager_for_redraw();
}

create_cloud = function() {
	if (!instance_exists(solid_obj)) {
		solid_obj = instance_create(x, y, obj_reforming_cloud);
		solid_obj.set_depth(STATIC_AREA_DEPTH - 8); // Keep this in sync with the manager assignment in controller
		solid_obj.main_palette = main_palette;
		solid_obj.particle_palette = main_palette;
		solid_obj.creator = id;
	}
}

start_reform_timer = function() {
	reform_timer = 272;
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