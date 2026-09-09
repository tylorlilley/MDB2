if (!global.controller.paused) {
	if (creator != noone && !instance_exists(creator)) { instance_destroy(); exit; }
	
	dim_timer--;
	if (dim_timer <= 0) { instance_destroy(); }
	else { 
		var _fade_amount = (use_linear_fade) ? (dim_timer / total_dim_timer) : sqr(dim_timer / total_dim_timer);
		image_alpha = max_alpha * _fade_amount;
	}
}