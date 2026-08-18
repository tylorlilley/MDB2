if (debug_enabled) {
	switch (window_fps_setting) {
		case 30: { window_fps_setting = 60; break; }
		case 60: { window_fps_setting = 120; break; }
		case 120: {window_fps_setting = 30; break; }
	}
	update_window_fps();
}