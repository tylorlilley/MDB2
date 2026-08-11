enum WORLDS {
	BEACH,
	FOREST,
	FACTORY,
	FORTRESS,
	SKY,
	SKY_2,
	SKY_3,
	SKY_4,
	NIGHT
}


function room_data(_room = room) {
	static _default = { world: WORLDS.BEACH, title: "Default Title", is_cutscene: false, is_classic: false };
	static _room_data = {
		rm_new_0_1: {world: WORLDS.BEACH,  title: "The Amazing Digital Tutorial", is_cutscene: false, is_classic: false },
		rm_new_1_1: { world: WORLDS.BEACH,  title: "Back Below the Pier", is_cutscene: false, is_classic: false },
		rm_new_1_2: { world: WORLDS.BEACH,  title: "One Way Up", is_cutscene: false, is_classic: false },
		rm_new_1_3: { world: WORLDS.BEACH,  title: "Many Ways Down", is_cutscene: false, is_classic: false },
			
		// MDB World 1
		rm_mdb_1_1: { world: WORLDS.BEACH,  title: "Under the Pier", is_cutscene: false, is_classic: false },
		rm_mdb_1_2: { world: WORLDS.BEACH,  title: "Rock Bottom", is_cutscene: false, is_classic: false },
		rm_mdb_1_3: { world: WORLDS.BEACH,  title: "Quicksand", is_cutscene: false, is_classic: false },
		rm_mdb_1_4: { world: WORLDS.BEACH,  title: "Dropping In", is_cutscene: false, is_classic: false },
		rm_mdb_1_5: { world: WORLDS.BEACH,  title: "Sandy Sinkholes", is_cutscene: false, is_classic: false },
		rm_mdb_1_6: { world: WORLDS.BEACH,  title: "Digging for Gold", is_cutscene: false, is_classic: false },
		rm_mdb_1_7: { world: WORLDS.BEACH,  title: "Ancient Ruins", is_cutscene: false, is_classic: false },
		rm_mdb_1_8: { world: WORLDS.BEACH,  title: "Thieves' Hideout", is_cutscene: false, is_classic: false },
			
		// MDB World 2
		rm_mdb_2_1: { world: WORLDS.FOREST,  title: "Wooden Gate", is_cutscene: false, is_classic: false },
		rm_mdb_2_2: { world: WORLDS.FOREST,  title: "The Elder Tree", is_cutscene: false, is_classic: false },
		rm_mdb_2_3: { world: WORLDS.FOREST,  title: "Tree Fort", is_cutscene: false, is_classic: false },
		rm_mdb_2_4: { world: WORLDS.FOREST,  title: "The Forest Mystery", is_cutscene: false, is_classic: false },
		rm_mdb_2_5: { world: WORLDS.FOREST,  title: "Volcanic Interlude", is_cutscene: false, is_classic: false },
		rm_mdb_2_6: { world: WORLDS.FOREST,  title: "Controlled Burn", is_cutscene: false, is_classic: false },
		rm_mdb_2_7: { world: WORLDS.FOREST,  title: "Bamboo Rhapsody", is_cutscene: false, is_classic: false },
		rm_mdb_2_8: { world: WORLDS.FOREST,  title: "Firewood", is_cutscene: false, is_classic: false },
			
		// MDB World 3
		rm_mdb_3_1: { world: WORLDS.FACTORY,  title: "Seeing Red", is_cutscene: false, is_classic: false },
		rm_mdb_3_2: { world: WORLDS.FACTORY,  title: "Circular Logic", is_cutscene: false, is_classic: false },
		rm_mdb_3_3: { world: WORLDS.FACTORY,  title: "Trash Compactor", is_cutscene: false, is_classic: false },
		rm_mdb_3_4: { world: WORLDS.FACTORY,  title: "Grinding Gears", is_cutscene: false, is_classic: false },
		rm_mdb_3_5: { world: WORLDS.FACTORY,  title: "Mounting Tension", is_cutscene: false, is_classic: false },
		rm_mdb_3_6: { world: WORLDS.FACTORY,  title: "Factory Worker", is_cutscene: false, is_classic: false },
		rm_mdb_3_7: { world: WORLDS.FACTORY,  title: "Primary Colors", is_cutscene: false, is_classic: false },
		rm_mdb_3_8: { world: WORLDS.FACTORY,  title: "Switch Switching", is_cutscene: false, is_classic: false },
			
		// MDB World 4
		rm_mdb_4_1: { world: WORLDS.FORTRESS,  title: "Rank and File", is_cutscene: false, is_classic: false },
		rm_mdb_4_2: { world: WORLDS.FORTRESS,  title: "Extra Lives", is_cutscene: false, is_classic: false },
		rm_mdb_4_3: { world: WORLDS.FORTRESS,  title: "Key Creations", is_cutscene: false, is_classic: false },
		rm_mdb_4_4: { world: WORLDS.FORTRESS,  title: "Lava Tubes", is_cutscene: false, is_classic: false },
		rm_mdb_4_5: { world: WORLDS.FORTRESS,  title: "The Dying Tree", is_cutscene: false, is_classic: false },
		rm_mdb_4_6: { world: WORLDS.FORTRESS,  title: "Follow the Leader", is_cutscene: false, is_classic: false },
		rm_mdb_4_7: { world: WORLDS.FORTRESS,  title: "Chutes and Ladders", is_cutscene: false, is_classic: false },
		rm_mdb_4_8: { world: WORLDS.FORTRESS,  title: "Mission Control", is_cutscene: false, is_classic: false },
			
		// MDB World 5
		rm_mdb_5_1: { world: WORLDS.SKY,  title: "Head in the Clouds", is_cutscene: false, is_classic: false },
		rm_mdb_5_2: { world: WORLDS.SKY,  title: "Flying Too Close", is_cutscene: false, is_classic: false },
		rm_mdb_5_3: { world: WORLDS.SKY_3,  title: "Setting Sun", is_cutscene: false, is_classic: false },
		rm_mdb_5_4: { world: WORLDS.SKY_3,  title: "Stairway to Heaven", is_cutscene: false, is_classic: false },
		rm_mdb_5_5: { world: WORLDS.SKY_3,  title: "The Storm Rolls In", is_cutscene: false, is_classic: false },
		rm_mdb_5_6: { world: WORLDS.NIGHT,  title: "Darkness Falls", is_cutscene: false, is_classic: false },
		rm_mdb_5_7: { world: WORLDS.NIGHT,  title: "Torrential Downpour", is_cutscene: false, is_classic: false },
		rm_mdb_5_8: { world: WORLDS.NIGHT,  title: "Hot Pursuit", is_cutscene: false, is_classic: false },
			
		// Classic World 1
		rm_old_w1_1: { world: WORLDS.BEACH,  title: "Island Shore", is_cutscene: false, is_classic: true },
		rm_old_w1_2: { world: WORLDS.BEACH,  title: "Rock Bottom", is_cutscene: false, is_classic: true },
		rm_old_w1_3: { world: WORLDS.BEACH,  title: "Quicksand", is_cutscene: false, is_classic: true },
		rm_old_w1_4: { world: WORLDS.BEACH,  title: "Castle Crasher", is_cutscene: false, is_classic: true },
		rm_old_w1_5: { world: WORLDS.BEACH,  title: "Sandy Sinkholes", is_cutscene: false, is_classic: true }, // OG: "Sandy Sink Holes"
		rm_old_w1_6: { world: WORLDS.BEACH,  title: "Dig, Dig, Dig", is_cutscene: false, is_classic: true },
		rm_old_w1_7: { world: WORLDS.BEACH,  title: "Ancient Ruins", is_cutscene: false, is_classic: true },
		rm_old_w1_8: { world: WORLDS.BEACH,  title: "Far Fortress", is_cutscene: false, is_classic: true },
			
		// Classic World 2
		rm_old_w2_1: { world: WORLDS.FOREST,  title: "Forest Shrine", is_cutscene: false, is_classic: true },
		rm_old_w2_2: { world: WORLDS.FOREST,  title: "Forest Floor", is_cutscene: false, is_classic: true },
		rm_old_w2_3: { world: WORLDS.FOREST,  title: "The Great Elder Tree", is_cutscene: false, is_classic: true },
		rm_old_w2_4: { world: WORLDS.FOREST,  title: "Firewood", is_cutscene: false, is_classic: true },
		rm_old_w2_5: { world: WORLDS.FOREST,  title: "Wooden Gate", is_cutscene: false, is_classic: true },
		rm_old_w2_6: { world: WORLDS.FOREST,  title: "The Forest Mystery", is_cutscene: false, is_classic: true },
		rm_old_w2_7: { world: WORLDS.FOREST,  title: "Bamboo Leaf Rhapsody", is_cutscene: false, is_classic: true },
		rm_old_w2_8: { world: WORLDS.FOREST,  title: "Sacred Forest Orchard", is_cutscene: false, is_classic: true },
			
		// Classic World 3
		rm_old_w3_1: { world: WORLDS.FACTORY,  title: "Spike Factory", is_cutscene: false, is_classic: true },
		rm_old_w3_2: { world: WORLDS.FACTORY,  title: "Switching Switches", is_cutscene: false, is_classic: true },
		rm_old_w3_3: { world: WORLDS.FACTORY,  title: "Circular Logic", is_cutscene: false, is_classic: true },
		rm_old_w3_4: { world: WORLDS.FACTORY,  title: "Breaking Stuff", is_cutscene: false, is_classic: true },
		rm_old_w3_5: { world: WORLDS.FACTORY,  title: "Clickety Clack", is_cutscene: false, is_classic: true }, // OG: "Clickity Clack"
		rm_old_w3_6: { world: WORLDS.FACTORY,  title: "Factory Worker", is_cutscene: false, is_classic: true },
		rm_old_w3_7: { world: WORLDS.FACTORY,  title: "Sacred Golden Switch", is_cutscene: false, is_classic: true },
		rm_old_w3_8: { world: WORLDS.FACTORY,  title: "Primary Colors", is_cutscene: false, is_classic: true },
			
		// Classic World 4
		rm_old_w4_1: { world: WORLDS.FORTRESS,  title: "Patrol the Labyrinth", is_cutscene: false, is_classic: true }, // OG: Patroling the Labyrinth
		rm_old_w4_2: { world: WORLDS.FORTRESS,  title: "Living Key Soldiers", is_cutscene: false, is_classic: true },
		rm_old_w4_3: { world: WORLDS.FORTRESS,  title: "The Barracks", is_cutscene: false, is_classic: true },
		rm_old_w4_4: { world: WORLDS.FORTRESS,  title: "Follow the Leader", is_cutscene: false, is_classic: true },
		rm_old_w4_5: { world: WORLDS.FORTRESS,  title: "The Dying Magic Tree", is_cutscene: false, is_classic: true },
		rm_old_w4_6: { world: WORLDS.FORTRESS,  title: "Frozen Magma Fortress", is_cutscene: false, is_classic: true },
		rm_old_w4_7: { world: WORLDS.FORTRESS,  title: "Life Preservers", is_cutscene: false, is_classic: true },
		rm_old_w4_8: { world: WORLDS.FORTRESS,  title: "Sidekick Soldier Assistant", is_cutscene: false, is_classic: true },
			
		// Classic World 5
		rm_old_w5_1: { world: WORLDS.SKY,  title: "Nimbus Cubs", is_cutscene: false, is_classic: true },
		rm_old_w5_2: { world: WORLDS.SKY_2,  title: "Warp Whiplash", is_cutscene: false, is_classic: true },
		rm_old_w5_3: { world: WORLDS.SKY_3,  title: "Tangerine Dreams", is_cutscene: false, is_classic: true },
		rm_old_w5_4: { world: WORLDS.SKY_4,  title: "Dusk Bowl", is_cutscene: false, is_classic: true },
			
		// World Transition Cutscenes
		rm_intro: { world: WORLDS.BEACH,  title: "Intro", is_cutscene: true , is_classic: false },
		rm_intro_eih: { world: WORLDS.BEACH,  title: "EIH Intro", is_cutscene: true, is_classic: false },
		rm_title: { world: WORLDS.BEACH,  title: "Intro", is_cutscene: true, is_classic: false },
		rm_controller: { world: WORLDS.BEACH,  title: "Controller", is_cutscene: true, is_classic: false },
		rm_t1: { world: WORLDS.BEACH,  title: "From Beach to Forest", is_cutscene: true, is_classic: false },
		rm_t2: { world: WORLDS.FOREST,  title: "From Forest to Factory", is_cutscene: true, is_classic: false },
		rm_t3: { world: WORLDS.BEACH,  title: "From Factory to Fortress", is_cutscene: true, is_classic: false },
	};

	return _room_data[$ room_get_name(_room)] ?? _default;
}


function get_world_palette(_object_index) {
	switch (_object_index) {
		// NO line for obj_wood; this breaks log's variable definition palette steting
		case obj_bg_dirt: {
			switch (global.controller.room_world) {
				case WORLDS.FOREST: { return PALETTES.BACKGROUND_ROCK; }
				case WORLDS.FACTORY: { return PALETTES.TRASH_DARKEST; }
				case WORLDS.FORTRESS: { return PALETTES.GRAY_DARK; }
				default: { return PALETTES.BACKGROUND_DIRT; } // Cotton Candy has DIRT BG? Used in 5_2
			}
		}
		case obj_sand: {
			switch (global.controller.room_world) {
				case WORLDS.BEACH: { return PALETTES.SAND; }
				case WORLDS.FOREST: { return PALETTES.SOIL; }
				case WORLDS.FACTORY: { return PALETTES.TRASH; }
				case WORLDS.FORTRESS: { return PALETTES.SOOT; }
				default: { return PALETTES.COTTON_CANDY; }
			}
		}
		case obj_rock: {
			switch (global.controller.room_world) {
				case WORLDS.BEACH: { return PALETTES.BROWN; }
				case WORLDS.FOREST: { return PALETTES.ROCK; }
				case WORLDS.FACTORY: { return PALETTES.MAGENTA; }
				case WORLDS.FORTRESS: { return PALETTES.BRICK; }
				default: { return PALETTES.MARBLE; }
			}
		}
		case obj_brick: {
			// Any palette you assign needs to support two sahdes of darker palettes for this object
			switch (global.controller.room_world) {
				case WORLDS.BEACH: { return PALETTES.GRAY_LIGHT; } // TODO: Make different, but this ruins t3 cutscene?
				case WORLDS.FOREST: { return PALETTES.BRICK; }
				case WORLDS.FACTORY: { return PALETTES.BROWN; }
				case WORLDS.FORTRESS: { return PALETTES.GRAY_LIGHT; }
				default: { return PALETTES.YELLOW; }
			}
		}
		case obj_portal: {
			// This returns the initial masked portal palette color only
			switch (global.controller.room_world) {
				case WORLDS.BEACH: { return PALETTES.TRASH; } // TODO: Make different, but this ruins t3 cutscene?
				case WORLDS.FOREST: { return PALETTES.PURPLE_DARK; }
				case WORLDS.FACTORY: { return PALETTES.INDIGO_DARK; }
				case WORLDS.FORTRESS: { return PALETTES.BLUE_DARK; }
				default: { return PALETTES.PINK; }
			}
		}
	}
	return undefined;
}

global.portal_color_palettes = [
	PALETTES.BLUE,
	PALETTES.PURPLE,
	PALETTES.INDIGO,
	PALETTES.PURPLE_DARK,
	PALETTES.PINK,
	PALETTES.BLUE_LIGHT,
	PALETTES.MAGENTA,
	PALETTES.SAND,
	PALETTES.GREEN_DARK,
	PALETTES.YELLOW_DARK,
	PALETTES.RED,
	PALETTES.YELLOW,
	PALETTES.ROCK,
	PALETTES.TRASH_LIGHT
];


function build_world_background(_world) {
	global.world_tint = c_white;
	global.world_tint_strength = 0;
	switch(_world) {
		case WORLDS.BEACH:
		case WORLDS.SKY:
		case WORLDS.SKY_2:
		case WORLDS.SKY_3:
		case WORLDS.SKY_4:
		case WORLDS.NIGHT: {
			global.border_alpha = 0.5;
			
			// Choose Sky Sprite and World Tint
			var _sprite = (_world == WORLDS.NIGHT) ? bg_stars : bg_sky;
			if (_world == WORLDS.SKY_2) { _sprite = bg_sky_2; }
			if (_world == WORLDS.SKY_3) { _sprite = bg_sky_3; global.world_tint = make_colour_rgb(255, 169, 128); global.world_tint_strength = 0.42; }
			if (_world == WORLDS.SKY_4) { _sprite = bg_sky_3; global.world_tint = make_colour_rgb(148, 54, 44); global.world_tint_strength = 0.42; }
			if (_world == WORLDS.NIGHT) { _sprite = bg_stars; global.border_alpha = 0.6; global.world_tint = C_PURPLE_DARK; global.world_tint_strength = 0.42; }
			
			// BG Sky Layer
			var _sky_layer = layer_create(800, "Beach_Sky");
			var _sky_bg = layer_background_create(_sky_layer, _sprite);
			layer_background_htiled(_sky_bg, true);
			layer_background_vtiled(_sky_bg, true);
			layer_background_speed(_sky_bg, (_sprite == bg_stars) ? 15 : 0);
			layer_hspeed(_sky_layer, 0.125);
			layer_vspeed(_sky_layer, 0.038);
			layer_set_visible(_sky_layer, true);
			
			break;
		}
		case WORLDS.FORTRESS: {
			global.world_tint = C_RED_DARK;
			global.world_tint_strength = 0.32;
			global.border_alpha = 0.6;
			
			// BG Castle Layer
			var _castle_layer = layer_create(800, "Castle_Background");
			var _castle_bg = layer_background_create(_castle_layer, bg_castle);
			layer_background_htiled(_castle_bg, true);
			layer_background_vtiled(_castle_bg, true);
			layer_hspeed(_castle_layer, -0.0625);
			layer_vspeed(_castle_layer, -0.0625);
			layer_set_visible(_castle_layer, true);
			
			break;
		}
		case WORLDS.FACTORY: {
			global.world_tint = C_TRASH_DARK;
			global.world_tint_strength = 0.52;
			global.border_alpha = 0.6;
			
			// BG Fence Layer
			var _fence_layer = layer_create(800, "Factory_Fence");
			var _fence_bg = layer_background_create(_fence_layer, bg_fence);
			layer_background_htiled(_fence_bg, true);
			layer_background_vtiled(_fence_bg, true);
			layer_background_speed(_fence_bg, 0);
			layer_hspeed(_fence_layer, 0.0625);
			layer_vspeed(_fence_layer, 0.0625);
			layer_set_visible(_fence_layer, true);
			
			break;
		}
		case WORLDS.FOREST: {
			global.world_tint = C_GREEN_DARK;
			global.world_tint_strength = 0.12;
			global.border_alpha = 0.5;
			
			// Determine Canopy Height
			var _lowest_leaf_y = 0;
			with (obj_leaf) { if (y > _lowest_leaf_y) { _lowest_leaf_y = y; } }
			var _canopy_y = _lowest_leaf_y + 20 - sprite_get_height(bg_forest_leaves);
			var _leaves_y = _canopy_y - sprite_get_height(bg_forest_canopy)
			
			// Background Leaves Layer
			var _forest_leaves_layer = layer_create(800, "Forest_Leaves");
			var _forest_leaves_bg = layer_background_create(_forest_leaves_layer, bg_forest_canopy);
			layer_background_htiled(_forest_leaves_bg, true);
			layer_background_speed(_forest_leaves_bg, 0);
			layer_y(_forest_leaves_layer, _leaves_y);
			layer_hspeed(_forest_leaves_layer, -0.125);
			layer_set_visible(_forest_leaves_layer, true);
			
			// Background Leaf Fringe Layer
			var _forest_canopy_layer = layer_create(801, "Forest_Canopy");
			var _forest_canopy_bg = layer_background_create(_forest_canopy_layer, bg_forest_leaves);
			layer_background_htiled(_forest_canopy_bg, true);
			layer_background_speed(_forest_canopy_bg, 2);
			layer_y(_forest_canopy_layer, _canopy_y);
			layer_hspeed(_forest_canopy_layer, -0.125);
			layer_set_visible(_forest_canopy_layer, true);
			
			// Background Tree Layer
			var _forest_tress_layer = layer_create(802, "Forest_Trees");
			var _forest_tresss_bg = layer_background_create(_forest_tress_layer, bg_forest_trees);
			layer_background_htiled(_forest_tresss_bg, true);
			layer_background_vtiled(_forest_tresss_bg, true);
			layer_background_speed(_forest_tresss_bg, 0);
			layer_y(_forest_tress_layer, _canopy_y - 16);
			layer_hspeed(_forest_tress_layer, -0.038);
			layer_set_visible(_forest_tress_layer, true);
			
			break;
		}
	}
}

function play_world_music(_world) {
	if (global.controller.show_debug_gui) { exit; }

	var _sound_to_play = undefined;
	switch (_world) {
		case WORLDS.BEACH:{ _sound_to_play = bgm_w1; break; }
		case WORLDS.FOREST: { _sound_to_play = bgm_w2; break; }
		case WORLDS.FACTORY: { _sound_to_play = bgm_w3; break; }
		case WORLDS.FORTRESS: { _sound_to_play = bgm_w4; break; }
		case WORLDS.SKY:
		case WORLDS.SKY_2:
		case WORLDS.SKY_3:
		case WORLDS.SKY_4:
		case WORLDS.NIGHT: { _sound_to_play = bgm_w5; break; }
	}
	if (!is_undefined(_sound_to_play) && !audio_is_playing(_sound_to_play)) { play_global_sound(_sound_to_play, true); }
}

function is_cutscene_room(_room = room) {
	return room_data(_room)[$ "is_cutscene"] ?? false;
}