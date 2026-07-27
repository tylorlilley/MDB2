// Inherit the parent event
event_inherited();

depth = KEY_DEPTH;
main_palette = PALETTES.YELLOW;
destroyed_sound = snd_key;
sway_timer = -(irandom(60) + 60);
draw_offsets = [[0], [2,-2], [2,0,-2], [3,1,-1,-3], [4,2,0,-2,-4]];

shine_timer = 60 + irandom(8);
global.room_keys++;
