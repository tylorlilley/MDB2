// Update Dynamic Object Interpolation Visuals
with (obj_dynamic_object) {
	// Update Swim Timer for Visual Bob
	swim_timer = swim_timer % FLOAT_OFFSET_PERIOD_FRAMES;
	
	// Update Virtual X and Y Positions Based on new Actual Positions
	var _x_frames = (x_transition_timer * other.fps_ratio) - other.fps_timer;
    var _y_frames = (y_transition_timer * other.fps_ratio) - other.fps_timer;
    var _x_speed = (_x_frames <= 0) ? 0 : ((x - virtual_x) / _x_frames);
    var _y_speed = (_y_frames <= 0) ? 0 : ((y - virtual_y) / _y_frames);
	
	// Apply Per Tick Set Speeds
	if (!is_undefined(x_transition_speed)) { _x_speed = x_transition_speed / other.fps_ratio; }
    if (!is_undefined(y_transition_speed)) { _y_speed = y_transition_speed / other.fps_ratio; }
	
	// TODO: do slower crushed walk speed another way
	//if (abs(_x_speed) > 0 && abs(_x_speed) < 1) { _x_speed = (x_transition_timer % 2 == 0) ? sign(_x_speed) : 0; }
	//if (abs(_y_speed) > 0 && abs(_y_speed) < 1) { _y_speed = (y_transition_timer % 2 == 0) ?  sign(_y_speed) : 0; }
	
	virtual_x += _x_speed;
	virtual_y += _y_speed;
		
	// Update Transition Timers Based on Remaining Transition Time ONLY on last tick before the next logic frame
	if (other.fps_timer == other.fps_ratio - 1) {
		if (transition_timer > 0) { transition_timer--; }
		if (x_transition_timer > 0) { x_transition_timer--; }
		if (y_transition_timer > 0) { y_transition_timer-- }
		var _new_transition_timer = 0;
		if (x_transition_timer > 0 && y_transition_timer > 0) { _new_transition_timer = max(x_transition_timer, y_transition_timer); }
		else if (x_transition_timer > 0) { _new_transition_timer = x_transition_timer; }
		else if (y_transition_timer > 0) { _new_transition_timer = y_transition_timer; }
		transition_timer = max(transition_timer, _new_transition_timer);
	}
}

// Play All Sounds in Sound Buffer
if (transition_timer <= TRANSITION_DELAY || transition_timer >= (TRANSITION_DELAY + TRANSITION_DURATION + TRANSITION_HOLD)) {
	while (array_length(frame_sounds) > 0) {
		var _entry = array_pop(frame_sounds);
		var _avg_x = _entry.x_sum / _entry.plays;
		audio_play_sound_panned(_entry.snd, _avg_x);
	}
}
else { frame_sounds = []; }

// Do Screen Resize
if (screen_resize_timer > 0) {
	screen_resize_timer--;
	if (screen_resize_timer == 0) {
		if (window_fullscreen_pending) { update_window_fullscreen(); }
		else { update_window_size(); }
		read_window_options();
		update_window_fps();
	}
}

// Do Screenshake
if (screen_shake_timer > 0) {
	var _screen_x = 8, _screen_y =  8, _cam = view_camera[0];
	if (is_logic_frame()) { screen_shake_timer--; }
	if (screen_shake_timer > 0) {
		_screen_x += get_shake_value(screen_shake_timer);
		_screen_y += get_shake_value(screen_shake_timer);
	}
	camera_set_view_pos(_cam, _screen_x, _screen_y);
}

// Handle Initial Game Boot Sequence
if (creation_timer > 0) {
	creation_timer--;
	if (creation_timer == 0) { transition_room(target_room); }
}
blank_screen = false;

// Update Control Values
global.last_gamepad_h_axis_value = gamepad_axis_value(global.gamepad, gp_axislh);
global.last_gamepad_v_axis_value = gamepad_axis_value(global.gamepad, gp_axislv);
