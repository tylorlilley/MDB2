enum TITLE_STATES {
	BEGIN,
	PAN_OVER,
	MAIN_MENU
}

event_inherited();

depth = global.controller.depth + 1;
state = TITLE_STATES.BEGIN;
camera_x = camera_get_view_x(view_camera[0]);
camera_speed = 0;
bounce_count = 0;

key_right = false;
key_left = false;
key_up = false;
key_down = false;
key_jump = false;
key_restart = false;
