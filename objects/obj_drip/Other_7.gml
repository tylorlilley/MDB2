if (state == 2) {
	if (looped) { instance_destroy(); }
	else { looped = true; }
}
else { state = 1; }