if (debug_enabled) {
	var _fps = game_get_speed(gamespeed_fps);
	switch (_fps) {
		case 30: { set_display_fps(60); break; }
		case 60: { set_display_fps(120, gamespeed_fps); break; }
		case 120: { set_display_fps(144, gamespeed_fps); break; }
		case 144: { set_display_fps(30, gamespeed_fps); break; }
	}
	set_display_fps(_fps);
}