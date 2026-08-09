event_inherited();

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

/// New Variables
option_strings = [
	"START CLASSIC GAME",
	"START NEW GAME",
	"CONTINUE GAME",
	"VIEW CONTROLS",
	"SETTINGS",
]
cursor_sprites = [
	spr_player_classic,
	spr_player_fall,
	spr_door,
	spr_key,
	spr_gear,
];
cursor_palettes = [
	PALETTES.PLAYER,
	PALETTES.PLAYER,
	PALETTES.BROWN,
	PALETTES.YELLOW,
	PALETTES.GRAY_LIGHT,
];

// State Variables
state = TITLE_STATES.BEGIN;
prev_state = state;
menu_pos = 0;

// Camera Variables
camera_x = camera_get_view_x(view_camera[0]);
camera_speed = 0;
bounce_count = 0;

// Timer Variables
text_shake_timer = 0;
title_sway_timer = irandom(23);
cursor_sway_timer = -(irandom(60) + 60);

// Loaded Variables
ini_open("mdb.ini");
saved_room = ini_read_real("progress", "current_level", noone); // TODO: reset to undefined after credits
progress_level = ini_read_real("progress", "progress_level", 0); // TODO: increase by 1 after credits
level_number = ini_read_real("progress", "level_number", -1); // TODO: Add this to room values information map instead
ini_close();