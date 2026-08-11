event_inherited();

// GameMaker Engine Overrides
// main_palette declared as a variable definition
visible = false;

// New Variables
trunk = [];

// Functions
initialize_solids = function() {
	var _trunk_x_left = x, _trunk_x_right = x + sprite_get_width(sprite_index);
	for (var _trunk_x = _trunk_x_left; _trunk_x < _trunk_x_right; _trunk_x += 8) {
		for (var _trunk_y = y; _trunk_y < y + 16; _trunk_y += 8) {
			var _trunk = instance_create(_trunk_x, _trunk_y, obj_wood);
			array_push(trunk, _trunk);
			with (_trunk) {
				creator = other;
				visual_origin_x =  other.x + _trunk_x;
				visual_origin_y =  other.y + _trunk_y;
				main_palette = other.main_palette;
				
				if (x == _trunk_x_left) {
					main_sprite = (other.is_left) ? spr_wood_log_hole_left : spr_wood_log_end_left;
					fuzzing_sprite = undefined;
					outline_sprite = undefined;
				}
				else if (x == _trunk_x_right-8) {
					main_sprite = (other.is_left) ? spr_wood_log_end_right : spr_wood_log_hole_right;
					fuzzing_sprite = undefined;
					outline_sprite = undefined;
				}
				else { main_sprite = spr_wood_horizontal; }
			}
		}
	}
}

part_damaged = function(_inst) { } // Do Nothing

part_destroyed = function(_inst) {
	array_delete(trunk, array_get_index(trunk, _inst), 1);
	
	if (array_length(trunk) == 0) { instance_destroy(); }
}
