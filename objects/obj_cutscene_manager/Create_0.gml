depth = global.controller.depth + 1;

// New Variables
cutscene_timer = 0;
cutscene_timer_max = 280;

// Input Variables
reset_controls = function() {
	key_right = false;
	key_left = false;
	key_up = false;
	key_down = false;
	key_jump = false;
	key_restart = false;
	
	key_restart_releasded = false;
	key_jump_released = false;
}

update_controls = function() {
	key_left = key_left || get_left_pressed();
	key_right = key_right || get_right_pressed();
	key_up = key_up || get_up_pressed();
	key_down = key_down || get_down_pressed();
	key_jump = key_jump || get_jump_pressed();
	key_restart = key_restart || get_restart_pressed();
	
	key_jump_released = key_jump_released || get_jump_released();
	key_restart_released = key_jump_released || get_restart_released();
}

// Creation Code
reset_controls();