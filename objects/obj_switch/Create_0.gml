event_inherited();

// Game Maker Variable Overrides
depth = SWITCH_DEPTH;
sprite_index = spr_switch;
image_index = 0;

// New Variables
pressed = false;

// New Functions
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
		if (id != other.id && switch_color == other.switch_color && pressed != other.pressed && array_length(get_pressing_objects()) > 0) { _toggle_blocks = false; global.controller.blocked_switch_colors[other.switch_color] = true; }
	}
	 global.controller.toggled_switch_colors[other.switch_color] = _toggle_blocks;
	//if (_toggle_blocks) { toggle_switch_color(switch_color); }
	
/*
	if (_toggle_blocks && !array_contains(global.controller.pending_switch_colors, switch_color)) {
		array_push(global.controller.pending_switch_colors, switch_color);
	}
*/
}

toggle_switch_color = function(_color) {
	play_sound(snd_switch);
	global.controller.blocked_switch_colors[_color] = false;
	global.controller.toggled_switch_colors[_color] = false;
	with (obj_switch) { if (switch_color == _color) { pressed = !pressed; } }
	with (obj_switch_block_outline) { if (switch_color == _color) { toggle_solid(true); } }
	with (obj_switch_block_outline) { if (switch_color == _color) { solid_obj.update_connections(); } }
}