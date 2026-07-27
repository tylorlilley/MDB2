enum WORLDS {
	BEACH,
	FOREST,
	FACTORY,
	CASTLE,
	SKY,
	SKY_2,
	SKY_3,
	SKY_4,
	NIGHT
}

function build_background(_world) {
	global.world_tint = c_white;
	switch(_world) {
		case WORLDS.BEACH:
		case WORLDS.SKY:
		case WORLDS.SKY_2:
		case WORLDS.SKY_3:
		case WORLDS.SKY_4:
		case WORLDS.NIGHT: {
			// Choose Sky Sprite and World Tint
			var _sprite = (_world == WORLDS.NIGHT) ? bg_stars : bg_sky;
			if (_world == WORLDS.SKY_2) { _sprite = bg_sky_2; }
			if (_world == WORLDS.SKY_3) { _sprite = bg_sky_3; global.world_tint = make_colour_rgb(255, 169, 128); }
			if (_world == WORLDS.SKY_4) { _sprite = bg_sky_3; global.world_tint = make_colour_rgb(148, 54, 44); }
			if (_world == WORLDS.NIGHT) { _sprite = bg_stars; global.world_tint = C_PURPLE_DARK; }
			
			// BG Sky Layer
			var _sky_layer = layer_create(100, "Beach_Sky");
			var _sky_bg = layer_background_create(_sky_layer, _sprite);
			layer_background_htiled(_sky_bg, true);
			layer_background_vtiled(_sky_bg, true);
			layer_background_speed(_sky_bg, (_sprite == bg_stars) ? 15 : 0);
			layer_hspeed(_sky_layer, 0.125);
			layer_vspeed(_sky_layer, 0.038);
			layer_set_visible(_sky_layer, true);
			
			break;
		}
		case WORLDS.CASTLE: {
			global.world_tint = C_RED_DARK;
			
			// BG Castle Layer
			var _castle_layer = layer_create(100, "Castle_Background");
			var _castle_bg = layer_background_create(_castle_layer, bg_castle);
			layer_background_htiled(_castle_bg, true);
			layer_background_vtiled(_castle_bg, true);
			layer_hspeed(_castle_layer, -0.0625);
			layer_vspeed(_castle_layer, -0.0625);
			layer_set_visible(_castle_layer, true);
			
			break;
		}
		case WORLDS.FACTORY: {
			global.world_tint = C_GRAY_DARK;
			
			// BG Castle Layer
			var _gears_layer = layer_create(100, "Factory_Gears");
			var _gear_bg = layer_background_create(_gears_layer, bg_factory);
			layer_background_htiled(_gear_bg, true);
			layer_background_vtiled(_gear_bg, true);
			layer_background_speed(_gear_bg, 10);
			//layer_hspeed(_gears_layer, -0.125);
			//layer_vspeed(_gears_layer, -0.25);
			layer_set_visible(_gears_layer, true);
			
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
	if (global.controller.show_debug_gui) { exit; }

	var _sound_to_play = noone;
	switch (_world) {
		case WORLDS.BEACH:{ _sound_to_play = bgm_w1; break; }
		case WORLDS.FOREST: { _sound_to_play = bgm_w2; break; }
		case WORLDS.FACTORY: { _sound_to_play = bgm_w3; break; }
		case WORLDS.CASTLE: { _sound_to_play = bgm_w4; break; }
		case WORLDS.SKY:
		case WORLDS.SKY_2:
		case WORLDS.SKY_3:
		case WORLDS.SKY_4:
		case WORLDS.NIGHT: { _sound_to_play = bgm_w5; break; }
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
			
			// MDB World 1
			{ rm: rm_mdb_1_1, world: WORLDS.BEACH,  title: "Under the Pier" },
			{ rm: rm_mdb_1_2, world: WORLDS.BEACH,  title: "Rock Bottom" },
			{ rm: rm_mdb_1_3, world: WORLDS.BEACH,  title: "Quicksand" },
			{ rm: rm_mdb_1_4, world: WORLDS.BEACH,  title: "Dropping In" },
			{ rm: rm_mdb_1_5, world: WORLDS.BEACH,  title: "Sandy Sinkholes" },
			{ rm: rm_mdb_1_6, world: WORLDS.BEACH,  title: "Digging for Gold" },
			{ rm: rm_mdb_1_7, world: WORLDS.BEACH,  title: "Ancient Ruins" },
			{ rm: rm_mdb_1_8, world: WORLDS.BEACH,  title: "Thieves' Hideout" },
			
			// MDB World 2
			{ rm: rm_mdb_2_1, world: WORLDS.FOREST,  title: "Wooden Gate" },
			{ rm: rm_mdb_2_2, world: WORLDS.FOREST,  title: "The Elder Tree" },
			{ rm: rm_mdb_2_3, world: WORLDS.FOREST,  title: "Tree Fort" },
			{ rm: rm_mdb_2_4, world: WORLDS.FOREST,  title: "The Forest Mystery" },
			{ rm: rm_mdb_2_5, world: WORLDS.FOREST,  title: "Volcanic Interlude" },
			{ rm: rm_mdb_2_6, world: WORLDS.FOREST,  title: "Controlled Burn" },
			{ rm: rm_mdb_2_7, world: WORLDS.FOREST,  title: "Bamboo Rhapsody" },
			{ rm: rm_mdb_2_8, world: WORLDS.FOREST,  title: "Firewood" },
			
			// MDB World 3
			{ rm: rm_mdb_3_1, world: WORLDS.FACTORY,  title: "Seeing Red" },
			{ rm: rm_mdb_3_2, world: WORLDS.FACTORY,  title: "Circular Logic" },
			{ rm: rm_mdb_3_3, world: WORLDS.FACTORY,  title: "Trash Compactor" },
			{ rm: rm_mdb_3_4, world: WORLDS.FACTORY,  title: "Grinding Gears" },
			{ rm: rm_mdb_3_5, world: WORLDS.FACTORY,  title: "Mounting Tension" },
			{ rm: rm_mdb_3_6, world: WORLDS.FACTORY,  title: "Factory Worker" },
			{ rm: rm_mdb_3_7, world: WORLDS.FACTORY,  title: "Primary Colors" },
			{ rm: rm_mdb_3_8, world: WORLDS.FACTORY,  title: "Switch Switching" },
			
			// MDB World 4
			{ rm: rm_mdb_4_1, world: WORLDS.CASTLE,  title: "Rank and File" },
			{ rm: rm_mdb_4_2, world: WORLDS.CASTLE,  title: "Extra Lives" },
			{ rm: rm_mdb_4_3, world: WORLDS.CASTLE,  title: "Key Creations" },
			{ rm: rm_mdb_4_4, world: WORLDS.CASTLE,  title: "Lava Tubes" },
			{ rm: rm_mdb_4_5, world: WORLDS.CASTLE,  title: "The Dying Tree" },
			{ rm: rm_mdb_4_6, world: WORLDS.CASTLE,  title: "Follow the Leader" },
			{ rm: rm_mdb_4_7, world: WORLDS.CASTLE,  title: "Chutes and Ladders" },
			{ rm: rm_mdb_4_8, world: WORLDS.CASTLE,  title: "Mission Control" },
			
			// MDB World 5
			{ rm: rm_mdb_5_1, world: WORLDS.SKY,  title: "Head in the Clouds" },
			{ rm: rm_mdb_5_2, world: WORLDS.SKY,  title: "Flying Too Close" },
			{ rm: rm_mdb_5_3, world: WORLDS.SKY_3,  title: "Setting Sun" },
			{ rm: rm_mdb_5_4, world: WORLDS.SKY_3,  title: "Stairway to Heaven" },
			{ rm: rm_mdb_5_5, world: WORLDS.SKY_3,  title: "The Storm Rolls In" },
			{ rm: rm_mdb_5_6, world: WORLDS.NIGHT,  title: "Darkness Falls" },
			{ rm: rm_mdb_5_7, world: WORLDS.NIGHT,  title: "Torrential Downpour" },
			{ rm: rm_mdb_5_8, world: WORLDS.NIGHT,  title: "Hot Pursuit" },
			
			// Classic World 1
			{ rm: rm_old_w1_1, world: WORLDS.BEACH,  title: "Island Shore" },
			{ rm: rm_old_w1_2, world: WORLDS.BEACH,  title: "Rock Bottom" },
			{ rm: rm_old_w1_3, world: WORLDS.BEACH,  title: "Quicksand" },
			{ rm: rm_old_w1_4, world: WORLDS.BEACH,  title: "Castle Crasher" },
			{ rm: rm_old_w1_5, world: WORLDS.BEACH,  title: "Sandy Sinkholes" }, // OG: "Sandy Sink Holes"
			{ rm: rm_old_w1_6, world: WORLDS.BEACH,  title: "Dig, Dig, Dig" },
			{ rm: rm_old_w1_7, world: WORLDS.BEACH,  title: "Ancient Ruins" },
			{ rm: rm_old_w1_8, world: WORLDS.BEACH,  title: "Far Fortress" },
			
			// Classic World 2
			{ rm: rm_old_w2_1, world: WORLDS.FOREST,  title: "Forest Shrine" },
			{ rm: rm_old_w2_2, world: WORLDS.FOREST,  title: "Forest Floor" },
			{ rm: rm_old_w2_3, world: WORLDS.FOREST,  title: "The Great Elder Tree" },
			{ rm: rm_old_w2_4, world: WORLDS.FOREST,  title: "Firewood" },
			{ rm: rm_old_w2_5, world: WORLDS.FOREST,  title: "Wooden Gate" },
			{ rm: rm_old_w2_6, world: WORLDS.FOREST,  title: "The Forest Mystery" },
			{ rm: rm_old_w2_7, world: WORLDS.FOREST,  title: "Bamboo Leaf Rhapsody" },
			{ rm: rm_old_w2_8, world: WORLDS.FOREST,  title: "Sacred Forest Orchard" },
			
			// Classic World 3
			{ rm: rm_old_w3_1, world: WORLDS.FACTORY,  title: "Spike Factory" },
			{ rm: rm_old_w3_2, world: WORLDS.FACTORY,  title: "Switching Switches" },
			{ rm: rm_old_w3_3, world: WORLDS.FACTORY,  title: "Circular Logic" },
			{ rm: rm_old_w3_4, world: WORLDS.FACTORY,  title: "Breaking Stuff" },
			{ rm: rm_old_w3_5, world: WORLDS.FACTORY,  title: "Clickety Clack" }, // OG: "Clickity Clack"
			{ rm: rm_old_w3_6, world: WORLDS.FACTORY,  title: "Factory Worker" },
			{ rm: rm_old_w3_7, world: WORLDS.FACTORY,  title: "Sacred Golden Switch" },
			{ rm: rm_old_w3_8, world: WORLDS.FACTORY,  title: "Primary Colors" },
			
			// Classic World 4
			{ rm: rm_old_w4_1, world: WORLDS.CASTLE,  title: "Patroling the Labyrinth" },
			{ rm: rm_old_w4_2, world: WORLDS.CASTLE,  title: "Living Key Soldiers" },
			{ rm: rm_old_w4_3, world: WORLDS.CASTLE,  title: "The Barracks" },
			{ rm: rm_old_w4_4, world: WORLDS.CASTLE,  title: "Follow the Leader" },
			{ rm: rm_old_w4_5, world: WORLDS.CASTLE,  title: "The Dying Magic Tree" },
			{ rm: rm_old_w4_6, world: WORLDS.CASTLE,  title: "Frozen Magma Fortress" },
			{ rm: rm_old_w4_7, world: WORLDS.CASTLE,  title: "Life Preservers" },
			{ rm: rm_old_w4_8, world: WORLDS.CASTLE,  title: "Sidekick Soldier Assistant" },
			
			// Classic World 5
			{ rm: rm_old_w5_1, world: WORLDS.SKY,  title: "Nimbus Cubs" },
			{ rm: rm_old_w5_2, world: WORLDS.SKY_2,  title: "Warp Whiplash" },
			{ rm: rm_old_w5_3, world: WORLDS.SKY_3,  title: "Tangerine Dreams" },
			{ rm: rm_old_w5_4, world: WORLDS.SKY_4,  title: "Dusk Bowl" },
		];

		_index = {};
		for (var _i = 0; _i < array_length(_defs); _i++) {
			_index[$ room_get_name(_defs[_i].rm)] = _defs[_i];
		}
	}

	return _index[$ room_get_name(_room)] ?? _default;
}