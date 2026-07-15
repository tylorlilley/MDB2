with (obj_dynamic_object) {
	if (contents != noone) {
		contents = instance_create_depth(0, 0, 0, contents);
		contents.grid_remove();
		instance_deactivate_object(contents);
	}
	if (is_carrying_key()) { original_palette = global.PALETTE_YELLOW; main_palette = global.PALETTE_YELLOW; }
}
with (obj_switch_block) {
	main_palette = get_switch_palette(switch_color);
	solid_obj.main_palette = main_palette;
}
with (obj_static_area) { update_graphics_for_connections(); }
