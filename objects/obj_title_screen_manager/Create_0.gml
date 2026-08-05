enum TITLE_STATES {
	BEGIN,
	PAN_OVER,
	MAIN_MENU
}

event_inherited();

state = TITLE_STATES.BEGIN;
camera_speed = 0;
bounce_count = 0;

key_right = false;
key_left = false;
key_up = false;
key_down = false;
key_jump = false;
key_restart = false;
