if (!global.controller.paused) {
	dim_timer--;
	if (dim_timer <= 0) { instance_destroy(); }
	else { image_alpha = (0.325 * sqr(dim_timer / total_dim_timer)); }
}