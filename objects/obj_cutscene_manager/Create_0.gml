depth = global.controller.depth + 1;

// New Variables
cutscene_timer = 0;
cutscene_timer_max = 280;

// Input Variables
key_right = false;
key_left = false;
key_up = false;
key_down = false;
key_jump = false;
key_restart = false;

update_controls = function() {
	key_left = get_left_pressed();
	key_right = get_right_pressed();
	key_up = get_up_pressed();
	key_down = get_down_pressed();
	key_jump = get_jump_pressed();
	key_restart = get_restart_pressed();
}