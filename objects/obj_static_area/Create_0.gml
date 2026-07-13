event_inherited();

is_ground = true;
is_ceiling = true;
is_right_wall = true;
is_left_wall = true;

is_climbable = true;

walk_particles = 0;
step_sound = noone;

depth = 10;

main_sprite = spr_box_16x16;
outline_sprite = noone;
fuzzing_sprite = noone;

update_graphics_for_connections = function() {
	is_connected_above = grid_array_first(instances_at_grid_position(x, y-8, 8, 8, object_index));
	is_connected_below = grid_array_first(instances_at_grid_position(x, y+8, 8, 8, object_index));
	is_connected_on_left = grid_array_first(instances_at_grid_position(x-8, y, 8, 8, object_index));
	is_connected_on_right = grid_array_first(instances_at_grid_position(x+8, y, 8, 8, object_index));
	is_connected_top_right = grid_array_first(instances_at_grid_position(x+8, y-8, 8, 8, object_index));
	is_connected_top_left = grid_array_first(instances_at_grid_position(x-8, y-8, 8, 8, object_index));
	is_connected_bottom_right = grid_array_first(instances_at_grid_position(x+8, y+8, 8, 8, object_index));
	is_connected_bottom_left = grid_array_first(instances_at_grid_position(x-8, y+8, 8, 8, object_index));
}
