if (!global.controller.paused) {
	if (creator != noone) {
		if (!instance_exists(creator)) { instance_destroy(); exit; }
		else { y = creator.y + creator.virtual_y_offset + 1; main_palette = creator.main_palette; }
	}
	
	dim_timer--;
	if (dim_timer <= 0) { instance_destroy(); }
	else { image_alpha = (max_alpha * sqr(dim_timer / total_dim_timer)); }
}