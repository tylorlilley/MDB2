function shine() {
	anim_timer--;
	if (anim_timer == 0) {
		image_index = 1;
		anim_timer = 120 + irandom(16);
	}
	else {
		image_index = 0;
	}
}