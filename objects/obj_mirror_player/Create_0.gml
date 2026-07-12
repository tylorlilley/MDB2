// Inherit the parent event
event_inherited();

image_blend = make_colour_rgb(60, 60, 60);

update_controls = function() {
	key_left = key_left || keyboard_check_pressed(vk_right);
	key_right = key_right || keyboard_check_pressed(vk_left);
	key_up = key_up || keyboard_check_pressed(vk_up);
	key_down = key_down || keyboard_check_pressed(vk_down);
	key_jump = key_jump || keyboard_check_pressed(ord("Z"));
		
	// Cancel out opposite inputs
	if (key_left && key_right) {
		if (is_left) { key_right = false; }
		else { key_left = false; }
	}
	if (key_up && key_down) {
		if (is_up) { key_down = false; }
		else { key_up = false; }
	}
}
