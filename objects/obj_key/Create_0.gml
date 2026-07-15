// Inherit the parent event
event_inherited();

depth = -1;
main_palette = global.PALETTE_YELLOW;
destroyed_sound = snd_key;

shine_timer = 60 + irandom(8);
global.controller.room_keys++;
