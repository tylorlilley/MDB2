with (obj_dynamic_object) {
	if (contents != noone) {
		contents = instance_create_depth(0, 0, 0, contents);
		contents.grid_remove();
		instance_deactivate_object(contents);
	}
}
with (obj_crate) {
	if (is_carrying_key()) { sprite_index = spr_gold_crate; }
}
