event_inherited();
main_palette = PALETTES.GRAY;
hits = 2;

parent_get_connections_for_graphics = get_connections_for_graphics;

get_connections_for_graphics = function() {
	parent_get_connections_for_graphics(false);
}