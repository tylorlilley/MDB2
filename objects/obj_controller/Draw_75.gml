shader_reset();
matrix_set(matrix_world, matrix_build_identity());

if (!paused) {
	fps_timer = (fps_timer + 1) % fps_ratio;
}