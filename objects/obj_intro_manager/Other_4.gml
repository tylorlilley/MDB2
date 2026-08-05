event_inherited();
audio_stop_sound(snd_fade_in);

with (obj_static_area) { should_draw = false; particle_palette = PALETTES.ALL_WHITE; }
with (obj_door) { visible = false; }