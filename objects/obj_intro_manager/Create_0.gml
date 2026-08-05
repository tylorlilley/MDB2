#macro SCREEN_MIDDLE_X 128
#macro SCREEN_MIDDLE_Y 120

event_inherited();

depth = global.controller.depth - 1;
intro_string = "Tylor Lilley Presents"
transition_max = (room == rm_intro_eih) ? 360 : 80;
made_particles = false;
bgm = noone;

