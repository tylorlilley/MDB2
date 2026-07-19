event_inherited();

enum PORTAL_STATES {
	OFF,
	SLOW,
	FAST
}

state = PORTAL_STATES.SLOW;
activation_timer = 0;

depth = 0;
main_palette = PALETTES.PORTAL;
anim_timer = 0;
anim_speed = 8;

deactivate_portal = function() {
	if (state != PORTAL_STATES.OFF) {
		activation_timer = 80;
		state = PORTAL_STATES.OFF;
		play_sound(snd_warp);
		create_sparkles(2+irandom(4));
		other_portal.deactivate_portal();
	}
}
