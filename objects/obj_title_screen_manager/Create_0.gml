enum TITLE_STATES {
	BEGIN,
	PAN_OVER,
	MAIN_MENU
}

enum MENU_OPTIONS {
	START_CLASSIC,
	START_GAME,
	LOAD_GAME,
	CONTROLS,
	SETTINGS,
}

event_inherited();

depth = global.controller.depth + 1;
state = TITLE_STATES.BEGIN;
prev_state = state;
camera_x = camera_get_view_x(view_camera[0]);
camera_speed = 0;
bounce_count = 0;
menu_pos = noone;
text_shake_timer = 0;
title_sway_timer = irandom(23);
cursor_sway_timer = -(irandom(60) + 60);
saved_room = noone;
progress_level = 0;

key_right = false;
key_left = false;
key_up = false;
key_down = false;
key_jump = false;
key_restart = false;

// Load Saved Room
ini_open("mdb.ini");
saved_room = ini_read_real("progress", "current_level", noone);
progress_level = ini_read_real("progress", "progress_level", 0);
level_number = ini_read_real("progress", "level_number", -1);
ini_close();