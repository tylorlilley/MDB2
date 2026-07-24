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

function room_data(_room = room) {
	static _default = { rm: noone, world: WORLDS.BEACH, title: "Default Title" };
	static _index = undefined;
	
	if (is_undefined(_index)) {
		var _defs = [
			{ rm: rm_new_0_1,  world: WORLDS.BEACH,  title: "The Amazing Digital Tutorial" },
			{ rm: rm_new_1_1,  world: WORLDS.BEACH,  title: "Back Below the Pier" },
			{ rm: rm_new_1_2,  world: WORLDS.BEACH,  title: "One Way Up" },
			{ rm: rm_new_1_3,  world: WORLDS.BEACH,  title: "Many Ways Down" },
			{ rm: rm_w2_1,     world: WORLDS.FOREST, title: "The Great Gate" },

			{ rm: rm_old2_1_1, world: WORLDS.BEACH,  title: "Under the Pier" },
			{ rm: rm_old2_1_2, world: WORLDS.BEACH,  title: "Rock Bottom" },
			{ rm: rm_old2_1_3, world: WORLDS.BEACH,  title: "Quicksand" },
			{ rm: rm_old2_1_4, world: WORLDS.BEACH,  title: "Dropping In" },
			
				/*
	// Original Game
	case rm_old_1_1: { _room_name = "Island Shore"; break; }
	//case rm_old_1_2: { _room_name = "Rock Bottom"; break; }
	//case rm_old_1_3: { _room_name = "Quicksand"; break; }
	case rm_old_1_4: { _room_name = "Castle Crasher"; break; }
	case rm_old_1_5: { _room_name = "Sandy Sinkholes"; break; } // Dusty Dune
	case rm_old_1_6: { _room_name = "Dig, Dig, Dig"; break; } // Digging for Gold
	case rm_old_1_7: { _room_name = "Ancient Ruins"; break; } // Spelunking
	case rm_old_1_8: { _room_name = "Far Fortress"; break; }
		
	case rm_old_2_1: { _room_name = "Forest Shrine"; break; } // Sacred Shrine
	case rm_old_2_2: { _room_name = "Forest Floor"; break; }
	//case rm_old_2_3: { _room_name = "The Great Elder Tree"; break; } // The Elder Tree
	//case rm_old_2_4: { _room_name = "Firewood"; break; }
	//case rm_old_2_5: { _room_name = "Wooden Gate"; break; }
	//case rm_old_2_6: { _room_name = "The Forest Mystery"; break; }
	//case rm_old_2_7: { _room_name = "Bamboo Leaf Rhapsody"; break; } // Bamboo Rhapsody
	case rm_old_2_8: { _room_name = "Sacred Forest Orchard"; break; } // The Spirit Orchard
	
	case rm_old_3_1: { _room_name = "Spike Factory"; break; }
	case rm_old_3_2: { _room_name = "Switching Switches"; break; }
	//case rm_old_3_3: { _room_name = "Circular Logic"; break; }
	//case rm_old_3_4: { _room_name = "Breaking Stuff"; break; } // Trash Compactor
	case rm_old_3_5: { _room_name = "Clickety Clack"; break; }
	//case rm_old_3_6: { _room_name = "Factory Worker"; break; }
	//case rm_old_3_7: { _room_name = "Sacred Golden Switch"; break; }
	case rm_old_3_8: { _room_name = "Primary Colors"; break; }
	
	case rm_old_4_1: { _room_name = "Patrolling the Labyrinth"; break; } // Patrol the Labyrinth
	case rm_old_4_2: { _room_name = "Living Key Soldiers"; break; }
	case rm_old_4_3: { _room_name = "The Barracks"; break; }
	// case rm_old_4_4: { _room_name = "Follow the Leader"; break; }
	//case rm_old_4_5: { _room_name = "The Dying Magic Tree"; break; } // The Dying Tree
	case rm_old_4_6: { _room_name = "Frozen Magma Fortress"; break; } // Frozen Fortress
	//case rm_old_4_7: { _room_name = "Life Preservers"; break; } // Extra Lives
	//case rm_old_4_8: { _room_name = "Sidekick Soldier Assistant"; break; } // Mission Control
	
	//case rm_old_5_1: { _room_name = "Nimbus Cubs"; break; } // Head in the Clouds
	case rm_old_5_2: { _room_name = "Warp Whiplash"; break; }
	case rm_old_5_3: { _room_name = "Tangerine Dreams"; break; }
	case rm_old_5_4: { _room_name = "Dusk Bowl"; break; }
	*/

	/*
	case rm_old2_1_5: { _room_name = "Dusty Dune"; break; }
	case rm_old2_1_6: { _room_name = "Digging for Gold"; break; }
	case rm_old2_1_7: { _room_name = "Spelunking"; break; }
	case rm_old2_1_8: { _room_name = "Thieves' Hideout"; break; }
	
	case rm_old2_2_1: { _room_name = "Wooden Gate"; break; }
	case rm_old2_2_2: { _room_name = "The Elder Tree"; break; }
	case rm_old2_2_3: { _room_name = "Tree Fort"; break; }
	case rm_old2_2_4: { _room_name = "The Forest Mystery"; break; }
	case rm_old2_2_5: { _room_name = "Volcanic Interlude"; break; }
	case rm_old2_2_6: { _room_name = "Controlled Burn"; break; }
	case rm_old2_2_7: { _room_name = "Bamboo Rhapsody"; break; }
	case rm_old2_2_8: { _room_name = "Firewood"; break; }
	
	case rm_old2_3_1: { _room_name = "Seeing Red"; break; }
	case rm_old2_3_2: { _room_name = "Circular Logic"; break; }
	case rm_old2_3_3: { _room_name = "Trash Compactor"; break; }
	case rm_old2_3_4: { _room_name = "Grinding Gears"; break; }
	case rm_old2_3_5: { _room_name = "Mounting Tension"; break; }
	case rm_old2_3_6: { _room_name = "Factory Worker"; break; }
	case rm_old2_3_7: { _room_name = "Primary Colors"; break; }
	case rm_old2_3_8: { _room_name = "Switch Switching"; break; }
	
	case rm_old2_4_1: { _room_name = "Rank and File"; break; }
	case rm_old2_4_2: { _room_name = "Extra Lives"; break; }
	case rm_old2_4_3: { _room_name = "Key Creations"; break; }
	case rm_old2_4_4: { _room_name = "Lava Tubes"; break; }
	case rm_old2_4_5: { _room_name = "The Dying Tree"; break; }
	case rm_old2_4_6: { _room_name = "Follow the Leader"; break; }
	case rm_old2_4_7: { _room_name = "Chutes and Ladders"; break; }
	case rm_old2_4_8: { _room_name = "Mission Control"; break; }
	
	case rm_old2_5_1: { _room_name = "Head in the Clouds"; break; }
	case rm_old2_5_2: { _room_name = "Flying Too Close"; break; }
	case rm_old2_5_3: { _room_name = "Setting Sun"; break; }
	case rm_old2_5_4: { _room_name = "Stairway to Heaven"; break; }
	case rm_old2_5_5: { _room_name = "The Storm Rolls In"; break; }
	case rm_old2_5_6: { _room_name = "Darkness Falls"; break; }
	case rm_old2_5_7: { _room_name = "Torrential Downpour"; break; }
	case rm_old2_5_8: { _room_name = "Hot Pursuit"; break; }
	
	*/
		];

		_index = {};
		for (var _i = 0; _i < array_length(_defs); _i++) {
			_index[$ room_get_name(_defs[_i].rm)] = _defs[_i];
		}
	}

	return _index[$ room_get_name(_room)] ?? _default;
}