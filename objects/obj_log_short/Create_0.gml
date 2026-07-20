trunk = [];
visible = false;

// Create Trunk
for (var _trunk_x = x; _trunk_x < x + sprite_get_width(sprite_index); _trunk_x += 8) {
	for (var _trunk_y = y; _trunk_y < y + 16; _trunk_y += 8) {
		var _trunk = instance_create(_trunk_x, _trunk_y, obj_wood);
		_trunk.creator = id;
		array_push(trunk, _trunk);
	}
}

part_destroyed = function(_inst) {
	array_delete(trunk, array_get_index(trunk, _inst), 1);
	
	if (array_length(trunk) == 0) {
		// Destroy All Trunk
		for (var _i = 0; _i < array_length(trunk); _i++) {
			with (trunk[_i]) { creator = noone; instance_destroy(); }
		}
		instance_destroy();
	}
}
