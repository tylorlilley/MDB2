// Inherit the parent event
event_inherited();

is_left = false;
sprite_index = spr_player_idle;
original_palette = PALETTES.GRAY;
powered_palette = PALETTES.RED;
main_palette = original_palette;

update_controls = function() {
	key_left = key_left || keyboard_check(vk_right);
	key_right = key_right || keyboard_check(vk_left);
	key_up = key_up || keyboard_check(vk_up);
	key_down = key_down || keyboard_check(vk_down);
	key_jump = key_jump || keyboard_check(ord("Z"));
		
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
