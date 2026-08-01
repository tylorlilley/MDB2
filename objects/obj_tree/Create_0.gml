event_inherited();

// Visual Object Overrides
main_palette = PALETTES.BROWN;
sprite_index = spr_wood_tree_extra_bottom;
image_speed = 0;
image_index = 1;

// New Variables
leaves = [];
trunk = [];

// Functions
initialize_solids = function() {
	// Create Leaves
	var _visual_x_offset = 32, _visual_y_offset = 64;
	for (var _row = 0; _row < 12; _row++) {
		var _pair = _row div 2;
		for (var _col = 0; _col < 10; _col++) {
			var _place = false;
			switch (_pair) {
				case 0: { _place = (_col >= 2 && _col <= 7); break; }							 // Upper Canopy
				case 1: { _place = true; break; }												 // Full Bush
				case 2: { _place = (_col == 2 || _col == 3 || _col == 6 || _col == 7); break; }  // Two Clumps
				case 3: { _place = false; break; }												 // Gap
				case 4: { _place = (_col == 2 || _col == 3); break; }							 // Left Branch
				case 5: { _place = (_col == 6 || _col == 7); break; }				             // Right Branch
			}
			if (!_place) { continue; }
			var _solid_objects_at_position = get_objects_at(x + _col * 8,  y + _row * 8, 8, 8, function(_inst) { return _inst.is_solid_from_all_sides(); });
			if (array_length(_solid_objects_at_position) > 0) { continue; }

			var _leaf = instance_create(x + _col * 8, y + _row * 8, obj_leaf);
			with (_leaf) {
				creator = other;
				main_palette = other.leaf_palette;
				particle_palette = other.leaf_palette;
				depth = other.depth + 1;
			}
			array_push(leaves, _leaf);
		}
	}

	// Create Trunk
	var _trunk_y_top = y + 32, _trunk_y_bottom = _trunk_y_top + 80, _max_trunk_y = _trunk_y_top;
	for (var _trunk_y = _trunk_y_top; _trunk_y < _trunk_y_bottom; _trunk_y += 8) {
		for (var _trunk_x = x + _visual_x_offset; _trunk_x < x + _visual_x_offset + 16; _trunk_x += 8) {
			if (_trunk_y >= room_height) { break; }
			var _solid_objects_at_position = get_objects_at(_trunk_x, _trunk_y, 8, 8, function(_inst) { return _inst.is_solid_from_below; });
			if (array_length(_solid_objects_at_position) > 0) { continue; }
			
			_max_trunk_y = _trunk_y;
			var _trunk = instance_create(_trunk_x, _trunk_y, obj_wood);
			array_push(trunk, _trunk);
			with (_trunk) {
				creator = other;
				visual_origin_x =  other.x + _trunk_x;
				visual_origin_y =  other.y + _trunk_y;
				depth = other.depth + 1;
				if (y == _trunk_y_top) { 
					main_sprite = spr_wood_tree_top;
					fuzzing_sprite = noone;
					outline_sprite = noone;
				}
				else { main_sprite = spr_wood_vertical; }
			}
		}
	}
	if (array_length(trunk) >= 2) {
		for (var _i = array_length(trunk) - 2; _i < array_length(trunk); _i++) {
			var _trunk = trunk[_i];
			with (_trunk) {
				main_sprite = spr_wood_tree_bottom;
				fuzzing_sprite = noone;
				outline_sprite = noone;
			}
			y = _trunk.y + 8 - sprite_get_height(sprite_index);
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
	
	// Destroy All Leaves When Trunk is Destroyed
	if (array_length(trunk) == 0) {
		for (var _i = 0; _i < array_length(leaves); _i++) {
			with (leaves[_i]) { creator = noone; instance_destroy(); }
		}
		instance_destroy();
	}
}
