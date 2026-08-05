event_inherited();
if (transition_timer == 24) { audio_stop_sound(bgm_transition); }

with (obj_static_area) { should_draw = false; }
with (obj_door) { visible = false; }
with (obj_player) { key_right = false; }