audio_stop_all();

with (obj_static_area) { should_draw = false; }
with (obj_door) { visible = false; } // TODO: Replace visible with should_draw for non-static-area objects