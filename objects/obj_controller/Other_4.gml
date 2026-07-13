with (obj_dynamic_object) {
	if (contents != noone) {
		contents = instance_create_depth(0, 0, 0, contents);
		instance_deactivate_object(contents);
		contents.grid_move_to(other.x, other.y);
	}
}