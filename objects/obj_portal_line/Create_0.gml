event_inherited();

depth = PARTICLE_DEPTH + 1;
player_palette = undefined;
dest_x = undefined;
dest_y = undefined;

set_dim_timer = function(_val) {
	total_dim_timer = _val;
	dim_timer = total_dim_timer;
}

set_dim_timer(8);