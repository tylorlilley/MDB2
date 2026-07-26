// Inherit the parent event
event_inherited();

depth = -1;
main_palette = PALETTES.YELLOW;
destroyed_sound = snd_key;
sway_offset = irandom(359);
sway_timer = 0;

shine_timer = 60 + irandom(8);
global.controller.room_keys++;
