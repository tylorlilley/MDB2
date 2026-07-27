// Inherit the parent event
event_inherited();

depth = KEY_DEPTH;
main_palette = PALETTES.YELLOW;
destroyed_sound = snd_key;
sway_timer = -(irandom(60) + 60);

shine_timer = 60 + irandom(8);
global.room_keys++;
