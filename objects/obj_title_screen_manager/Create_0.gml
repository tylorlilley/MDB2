enum TITLE_STATES {
	BEGIN,
	PAN_OVER,
	MAIN_MENU
}

event_inherited();

state = TITLE_STATES.BEGIN;

key_right = false;
key_left = false;
key_up = false;
key_down = false;
key_jump = false;
key_restart = false;
