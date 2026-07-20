// Set Palettes
with (obj_switch) { main_palette = get_switch_palette(switch_color); }
with (obj_switch_block_outline) {
	main_palette = get_switch_palette(switch_color);
	solid_obj = instance_create(x, y, solid_obj);
	solid_obj.depth = depth - 1;
	solid_obj.main_palette = main_palette;
	if (begin_off) { toggle_solid(); }
}
with (obj_reforming_cloud_outline) { create_cloud(); }
with (obj_static_area) { get_connections_for_graphics(); }

// Draw Static Area Surface
rebuild_static_area_surface();

// Spawn and Deactivate Instances
with (obj_dynamic_object) {
	if (contents != noone) {
		contents = instance_create(0, 0, contents);
		contents.grid_remove();
		instance_deactivate_object(contents);
	}
}

// Set Dynamic Instance Palette Based on Spawned Instances
with (obj_dynamic_object) {
	if (is_carrying_key()) { original_palette = PALETTES.YELLOW; main_palette = PALETTES.YELLOW; }
}

// Set Initial Wood Graphics
var _ignored_wood_objects = []
with (obj_wood) {
	if (array_contains(_ignored_wood_objects, id)) { continue; }
	
	// Determine Area Size
	var _min_area_x = x, _min_area_y = y, _max_area_x = x, _max_area_y = y, _connected_area = get_connected_instances([id]);
	//if (!array_contains(_connected_area, id)) { array_push(_connected_area, id); }
	for (var _i = 0; _i < array_length(_connected_area); _i++) {
		var _inst = _connected_area[_i];
		_inst.main_sprite_override = false;
		_min_area_x = min(_min_area_x, _inst.x);
		_min_area_y = min(_min_area_y, _inst.y);
		_max_area_x = max(_max_area_x, _inst.x);
		_max_area_y = max(_max_area_y, _inst.y);
		array_push(_ignored_wood_objects, _inst);
	}
	
	var  _area_width = _max_area_x - _min_area_x, _area_height = _max_area_y - _min_area_y;
	var _random_direction_sprite = (irandom(1) == 0) ? spr_wood : spr_wood_horizontal;
	for (var _i = 0; _i < array_length(_connected_area); _i++) {
		var _inst = _connected_area[_i];
		if (_area_width == 8 && _area_height > 0) {
			 if (_inst.is_connected_above) { _inst.main_sprite = spr_wood; }
			else {
				_inst.main_sprite = spr_wood_end;
				_inst.main_left = (_inst.is_connected_on_left) ? 8 : 0;
				_inst.main_top = 0;
				_inst.fuzzing_image_index = noone;
			}
		}
		else if (_area_height == 8 && _area_width > 0) {
			 if (_inst.is_connected_on_left) { _inst.main_sprite = spr_wood_horizontal; }
			else {
				_inst.main_sprite = spr_wood_horizontal_end;
				_inst.main_left = 0;
				_inst.main_top = (_inst.is_connected_above) ? 8 : 0;
				_inst.fuzzing_image_index = noone;
			}
		}
		else if ( _area_width > _area_height) { _inst.main_sprite = spr_wood_horizontal; }
		else if ( _area_height > _area_width) { _inst.main_sprite = spr_wood; }
		else { _inst.main_sprite = _random_direction_sprite; }
	}
	other.should_rebuild_static_area = true;
}