event_inherited();

depth = BACKGROUND_DEPTH - 1;
main_palette = PALETTES.ALL_WHITE;


set_dim_timer = function(_val) {
	total_dim_timer = _val;
	dim_timer = total_dim_timer;
}

set_dim_timer(90);