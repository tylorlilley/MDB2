var _fps = game_get_speed(gamespeed_fps);
switch (_fps) {
	case 2: { game_set_speed(15, gamespeed_fps); break; }
	case 15: { game_set_speed(30, gamespeed_fps); break; }
	case 30: { game_set_speed(60, gamespeed_fps); break; }
	case 60: { game_set_speed(2, gamespeed_fps); break; }
}