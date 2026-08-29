if (progress < 0) {
	instance_destroy();
	exit;
}

// Update Current Progress
var _step = 1 / max(1, TEXTBOX_TRANSITION_TIME * global.controller.fps_ratio);
progress = clamp(progress + ((is_opening) ? _step : -_step), -1, 1);