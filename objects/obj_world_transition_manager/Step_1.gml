event_inherited();

if (!global.controller.is_logic_frame()) { exit; }

if (cutscene_timer == 24) { play_global_sound(bgm_mdb_transition, false); }