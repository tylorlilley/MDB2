event_inherited();

depth = 9;
image_blend = c_red;
pressed = false;

get_pressing_objects = function(_only_full_solids = false) {
	var _height_offset = sprite_get_height(sprite_index)/2;
	var _possible_instances = instances_at_grid_position(x, y + _height_offset, sprite_get_width(sprite_index), _height_offset);
	var _pressing_instances = [];
	for (var _i = 0; _i < array_length(_possible_instances); _i++)
	{
		var _inst = _possible_instances[_i];
		if (_inst.has_gravity) { array_push(_pressing_instances, _inst); }
	}
	return _pressing_instances;
}