leaves = [];
trunk = [];
visible = false;
/*

// Create Leaves
var _grid_x = x, _grid_y = y;
for (var _dir = 0; _dir < 4; _dir++) {
	if (_dir == 0 || _dir == 2) { _grid_x = x + 8; }
	else { _grid_x = x; }
	if (_dir == 2 || _dir == 3) { _grid_y = y + 8; }
	else { _grid_y = y; }
	
	array_push(leaves, instance_create(_grid_x + 16, _grid_y + 16, obj_leaf));
	array_push(leaves, instance_create(_grid_x - 16, _grid_y, obj_leaf));
	array_push(leaves, instance_create(_grid_x + 16, _grid_y - 32, obj_leaf));
	array_push(leaves, instance_create(_grid_x - 16, _grid_y - 32, obj_leaf));
	array_push(leaves, instance_create(_grid_x, _grid_y - 48, obj_leaf));
	array_push(leaves, instance_create(_grid_x + 16, _grid_y - 48, obj_leaf));
	array_push(leaves, instance_create(_grid_x - 16, _grid_y - 48, obj_leaf));
	array_push(leaves, instance_create(_grid_x + 32, _grid_y - 48, obj_leaf));
	array_push(leaves, instance_create(_grid_x - 32, _grid_y - 48, obj_leaf));
	array_push(leaves, instance_create(_grid_x, _grid_y - 64, obj_leaf));
	array_push(leaves, instance_create(_grid_x + 16, _grid_y - 64, obj_leaf));
	array_push(leaves, instance_create(_grid_x - 16, _grid_y - 64, obj_leaf));
}

// Create Trunk
for (var _trunk_x = x + 24; _trunk_x < x + 16; _trunk_x += 8) {
	for (var _trunk_y = y; _trunk_y < y + 80; _trunk_y += 8) {
		array_push(trunk, instance_create(_trunk_x, _trunk_y, obj_wood));
	}
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

// Initialze Trunk
for (var _i = 0; _i < array_length(trunk); _i++) {
	var _trunk = trunk[_i];
	with (_trunk) { creator = other.id; }
}

part_destroyed = function(_inst) {
	var _remove_from_array = noone
	if (_inst.object_index == obj_leaf) { _remove_from_array = leaves; }
	if (_inst.object_index == obj_wood) { _remove_from_array = trunk; }
	array_delete(_remove_from_array, array_get_index(_remove_from_array, _inst), 1);
	if (array_length(trunk) == 0) {
		// Destroy All Leaves
		for (var _i = 0; _i < array_length(leaves); _i++) {
			with (leaves[_i]) { instance_destroy(); }
		}
		// Destroy All Trunk
		for (var _i = 0; _i < array_length(trunk); _i++) {
			with (trunk[_i]) { instance_destroy(); }
		}
	}
}
*/