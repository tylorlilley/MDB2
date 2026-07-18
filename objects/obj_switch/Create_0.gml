event_inherited();

depth = 9;
pressed = false;
sprite_index = spr_switch;

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