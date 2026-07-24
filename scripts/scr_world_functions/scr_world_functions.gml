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
			layer_background_htiled(_sky_bg, true);
			layer_background_vtiled(_sky_bg, true);
			layer_hspeed(_sky_layer, 0.125);
			layer_vspeed(_sky_layer, 0.038);
			layer_set_visible(_sky_layer, true);
			
			break;
		}
		case WORLDS.FOREST: {
			// Background Leaves Layer
			var _forest_leaves_layer = layer_create(100, "Forest_Canopy");
			var _forest_leaves_bg = layer_background_create(_forest_leaves_layer, bg_forest_canopy);
			layer_background_htiled(_forest_leaves_bg, true);
			layer_background_speed(_forest_leaves_bg, 0);
			layer_set_visible(_forest_leaves_layer, true);
			
			// Background Leaf Fringe Layer
			var _forest_canopy_layer = layer_create(101, "Forest_Leaves");
			var _forest_canopy_bg = layer_background_create(_forest_canopy_layer, bg_forest_leaves);
			layer_background_htiled(_forest_canopy_bg, true);
			layer_background_speed(_forest_canopy_bg, 2);
			layer_y(_forest_canopy_layer, 104);
			//layer_hspeed(_forest_canopy_layer, 0.125);
			layer_set_visible(_forest_canopy_layer, true);
			
			// Background Tree Layer
			var _forest_tress_layer = layer_create(102, "Forest_Trees");
			var _forest_tresss_bg = layer_background_create(_forest_tress_layer, bg_forest_trees);
			layer_background_htiled(_forest_tresss_bg, true);
			layer_background_vtiled(_forest_tresss_bg, true);
			layer_background_speed(_forest_tresss_bg, 0);
			layer_y(_forest_tress_layer, 104);
			layer_hspeed(_forest_tress_layer, -0.38);
			layer_set_visible(_forest_tress_layer, true);
			
			break;
		}
	}
}

function play_music(_world) {
	var _sound_to_play = noone;
	switch (_world) {
		case WORLDS.BEACH: { _sound_to_play = bgm_w1; break; }
		case WORLDS.FOREST: { _sound_to_play = bgm_w2; break; }
		case WORLDS.FACTORY: { _sound_to_play = bgm_w3; break; }
		case WORLDS.CASTLE: { _sound_to_play = bgm_w4; break; }
		case WORLDS.SKY: { _sound_to_play = bgm_w5; break; }
	}
	if (_sound_to_play != noone && !audio_is_playing(_sound_to_play)) { audio_play_sound(_sound_to_play, 100, true); }
}