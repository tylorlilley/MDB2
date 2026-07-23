enum WORLDS {
	BEACH,
	FOREST,
	FACTORY,
	CASTLE,
	SKY
}

function build_background(_world) {
	switch(_world) {
		case WORLDS.BEACH: {
			// BG Sky Layer
			var _sky_layer = layer_create(100, "Beach_Sky");
			var _sky_bg = layer_background_create(_sky_layer, bg_sky);
			layer_background_htiled(_sky_layer, true);
			layer_background_vtiled(_sky_layer, true);
			layer_hspeed(_forest_canopy_bg, 0.125);
			layer_vspeed(_forest_canopy_bg, 0.038);
			layer_set_visible(_sky_layer, visible);
			
			break;
		}
		case WORLDS.FOREST: {
			// Background Leaves Layer
			var _forest_leaves_layer = layer_create(100, "Forest_Leaves");
			var _forest_leaves_bg = layer_background_create(_forest_leaves_layer, bg_forest_canopy);
			layer_background_htiled(_forest_leaves_bg, true);
			layer_set_visible(_forest_leaves_bg, visible);
			
			// Background Leaf Fringe Layer
			var _forest_canopy_layer = layer_create(101, "Forest_Canopy");
			var _forest_canopy_bg = layer_background_create(_forest_canopy_layer, bg_forest_leaves);
			layer_background_htiled(_forest_canopy_bg, true);
			layer_y(_forest_canopy_bg, 104);
			layer_hspeed(_forest_canopy_bg, 1);
			layer_background_speed(_forest_canopy_bg, 0.25);
			layer_set_visible(_forest_leaves_bg, visible);
			
			// Background Tree Layer
			var _forest_tress_layer = layer_create(102, "Forest_Trees");
			var _forest_tresss_bg = layer_background_create(_forest_tress_layer, bg_forest_trees);
			layer_background_htiled(_forest_tresss_bg, true);
			layer_background_vtiled(_forest_tresss_bg, true);
			layer_y(_forest_tresss_bg, 104);
			layer_hspeed(_forest_canopy_bg, 0.125);
			layer_set_visible(_forest_leaves_bg, visible);
			
			break;
		}
	}
}