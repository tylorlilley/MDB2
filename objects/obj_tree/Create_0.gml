leaves = [];
trunk = [];

main_palette = PALETTES.BROWN;
shine_timer = 1;

depth = 11;
sprite_index = spr_wood_tree_extra_bottom;
image_speed = 0;
image_index = 1;

initialize_tree = function() {
	// Create Leaves
	var _visual_x_offset = 32, _visual_y_offset = 64;
	for (var _row = 0; _row < 12; _row++) {
		var _pair = _row div 2;
		for (var _col = 0; _col < 10; _col++) {
			var _place = false;
			switch (_pair) {
				case 0: _place = (_col >= 2 && _col <= 7); break;              // Upper Canopy
				case 1: _place = true; break;                                  // Full Bush
				case 2: _place = (_col == 2 || _col == 3 || _col == 6 || _col == 7); break; // Two Clumps
				case 3: _place = false; break;                                 // Gap
				case 4: _place = (_col == 2 || _col == 3); break;              // Left Branch
				case 5: _place = (_col == 6 || _col == 7); break;              // Right Branch
			}
			if (!_place || at_grid_position(x + _col * 8,  y + _row * 8, 8, 8, obj_static_area)) { continue; }

			var _leaf = instance_create(x + _col * 8, y + _row * 8, obj_leaf);
			_leaf.main_palette = PALETTES.YELLOW;
			_leaf.particle_palette = PALETTES.YELLOW;
			_leaf.creator = id;
			_leaf.depth = 12;
			array_push(leaves, _leaf);
		}
	}

	// Create Trunk
	var _trunk_y_top = y + 32, _trunk_y_bottom = _trunk_y_top + 80, _max_trunk_y = _trunk_y_top;
	for (var _trunk_x = x + _visual_x_offset; _trunk_x < x + _visual_x_offset + 16; _trunk_x += 8) {
		for (var _trunk_y = _trunk_y_top; _trunk_y < _trunk_y_bottom; _trunk_y += 8) {
			if (at_grid_position(_trunk_x, _trunk_y, 8, 8, obj_static_area)) { continue; }
			if (_trunk_y >= room_height) { break; }
			
			_max_trunk_y = _trunk_y;
			var _trunk = instance_create(_trunk_x, _trunk_y, obj_wood);
			array_push(trunk, _trunk);
			with (_trunk) {
				creator = other.id;
				visual_origin_x = other.x + _trunk_x;
				visual_origin_y = other.y + _trunk_y;
				_trunk.depth = 12;
				if (y == _trunk_y_top) { 
					main_sprite = spr_wood_tree_top;
					fuzzing_sprite = noone;
					outline_sprite = noone;
				}
				else { main_sprite = spr_wood_vertical; }
			}
		}
	}
	for (var _i = array_length(trunk) - 2; _i < array_length(trunk); _i++) {
		var _inst = trunk[_i];
		_inst.main_sprite = spr_wood_tree_bottom;
		_inst.fuzzing_sprite = noone;
		_inst.outline_sprite = noone;
		y = _inst.y + 8 - sprite_get_height(sprite_index);
	}


	// Initialize Leaves
	for (var _i = 0; _i < array_length(leaves); _i++) {
		var _leaf = leaves[_i];
		with (_leaf) {
			main_palette = PALETTES.YELLOW;
			particle_palette = PALETTES.YELLOW;
			creator = other.id;
		}
	}
}

part_damaged = function(_inst) {
	if (_inst.object_index == obj_wood) { image_index = 0; }
}

part_destroyed = function(_inst) {
	var _remove_from_array = noone
	if (_inst.object_index == obj_leaf) { _remove_from_array = leaves; }
	if (_inst.object_index == obj_wood) { _remove_from_array = trunk; }
	array_delete(_remove_from_array, array_get_index(_remove_from_array, _inst), 1);
	
	if (array_length(trunk) == 0) {
		// Destroy All Leaves
		for (var _i = 0; _i < array_length(leaves); _i++) {
			with (leaves[_i]) { creator = noone; instance_destroy(); }
		}
		// Destroy All Trunk
		for (var _i = 0; _i < array_length(trunk); _i++) {
			with (trunk[_i]) { creator = noone; instance_destroy(); }
		}
		instance_destroy();
	}
}
