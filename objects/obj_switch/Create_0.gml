event_inherited();

depth = 9;
pressed = false;
sprite_index = spr_switch;
image_index = 2;

get_pressing_objects = function() {
	var _possible_instances = instances_at_grid_position(x, y, sprite_get_width(sprite_index), sprite_get_height(sprite_index), obj_dynamic_object);
	var _pressing_instances = [];
	for (var _i = 0; _i < array_length(_possible_instances); _i++)
	{
		var _inst = _possible_instances[_i];
		if (_inst.has_gravity && _inst.is_grounded_state() && _inst.x == x) { array_push(_pressing_instances, _inst); }
	}
	return _pressing_instances;
}

press_switch = function() {
	var _toggle_blocks = true;
	with (obj_switch) {
		if (id != other.id && switch_color == other.switch_color && pressed != other.pressed && array_length(get_pressing_objects()) > 0) { _toggle_blocks = false; global.controller.blocked_switch_colors[switch_color] = true; }
	}
	
	if (_toggle_blocks) {
		with (obj_switch_block_outline) { 
			if (switch_color == other.switch_color) { toggle_solid(true); }
		}
		with (obj_switch_block_outline) {
			if (switch_color == other.switch_color) { solid_obj.get_connections_for_graphics(); }
		}
		with (obj_switch) { if (switch_color == other.switch_color) { pressed = !pressed; } }
	}
}