event_inherited();

depth = PLAYER_DEPTH + 1;
max_alpha = 0.75;
image_alpha = max_alpha;

main_color = undefined;
player_color = undefined;
dest_x = undefined;
dest_y = undefined;

set_dim_timer(8);

get_color_with_world_tint = function(_color) {
	return merge_color(_color, global.world_tint, global.world_tint_strength);
}