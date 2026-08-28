if (!global.controller.paused) {
	dim_timer--;
	if (dim_timer <= 0) { instance_destroy(); }
	else { image_alpha = (max_alpha * sqr(dim_timer / total_dim_timer)); }
}