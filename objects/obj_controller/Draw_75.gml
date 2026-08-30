shader_reset();
set_gui_matrix(true, true);

if (!paused) {
	fps_timer = (fps_timer + 1) % fps_ratio;
}