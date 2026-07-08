event_inherited();

var _pressed_on = array_length(get_pressing_objects()) > 0

if (_pressed_on && !pressed) {
	var _toggle_blocks = true;
	with (obj_switch) {
		if (id != other.id && image_blend == other.image_blend && array_length(get_pressing_objects()) > 0) { _toggle_blocks = false; }
	}
	
	if (_toggle_blocks) {
		with (obj_switch_block) { 
			if (image_blend == other.image_blend) { toggle_solid(true); }
		}
		with (obj_switch) { if (image_blend == other.image_blend) { pressed = !pressed; } }
	}
}

image_index = (pressed || _pressed_on) ? 1 : 0;

if (!is_grounded()) { instance_destroy(); }