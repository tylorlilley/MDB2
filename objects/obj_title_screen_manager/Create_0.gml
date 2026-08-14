event_inherited();

enum TITLE_STATES {
	BEGIN,
	PAN_OVER,
	MAIN_MENU,
	SETTINGS_MENU,
}

enum MENU_OPTIONS {
	START_CLASSIC,
	START_GAME,
	LOAD_GAME,
	CONTROLS,
	SETTINGS,
}

enum SETTINGS_OPTIONS {
	FULL_SCREEN,
	SCREEN_SCALE,
	SKIP_THIS,
	RETURN,
}

/// New Variables
option_strings = [
	"START CLASSIC GAME",
	"START NEW GAME",
	"CONTINUE GAME",
	"VIEW CONTROLS",
	"SETTINGS",
]
settings_strings = [
	"SCREEN TYPE",
	"SCREEN SCALE",
	"",
	"SAVE AND RETURN"
];
full_screen_strings = [
	"FULL SCREEN",
	"BOARDERLESS FULL SCREEN",
	"WINDOWED"
];
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
menu_pos = MENU_OPTIONS.START_CLASSIC;

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
saved_room = ini_read_real("progress", "current_level", -1); // TODO: reset to undefined after credits
progress_level = ini_read_real("progress", "progress_level", 0); // TODO: increase by 1 after credits
level_number = ini_read_real("progress", "level_number", 0); // TODO: Add this to room values information map instead
full_screen_option = ini_read_real("settings", "full_screen", FULL_SCREEN_OPTIONS.BORDERLESS_FULL_SCREEN);
screen_scale_option = ini_read_real("settings", "screen_scale", 4);
ini_close();

// Determine maximum window size
max_scaling_size = get_maximum_screen_scale();
