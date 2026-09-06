if (!global.controller.paused) {
	if (creator != noone && !instance_exists(creator)) { instance_destroy(); exit; }
	
	dim_timer--;
	if (dim_timer <= 0) { instance_destroy(); }
	else { image_alpha = (max_alpha * sqr(dim_timer / total_dim_timer)); }
}