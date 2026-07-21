trunk = [];
visible = false;

// Create Trunk
var _trunk_x_left = x, _trunk_x_right = x + sprite_get_width(sprite_index);
for (var _trunk_x = _trunk_x_left; _trunk_x < _trunk_x_right; _trunk_x += 8) {
	for (var _trunk_y = y; _trunk_y < y + 16; _trunk_y += 8) {
		var _trunk = instance_create(_trunk_x, _trunk_y, obj_wood);
		array_push(trunk, _trunk);
		with (_trunk) {
			creator = other.id;
			visual_origin_x = other.x + _trunk_x;
			visual_origin_y = other.y + _trunk_y;
			if (x == _trunk_x_left) {
				main_sprite = spr_wood_log_left;
				fuzzing_sprite = noone;
				outline_sprite = noone;
			}
			else if (x == _trunk_x_right-8) {
				main_sprite = spr_wood_log_right;
				fuzzing_sprite = noone;
				outline_sprite = noone;
			}
			else { main_sprite = spr_wood_horizontal; }
		}
	}
}

part_damaged = function(_inst) { } // Do Nothing

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
