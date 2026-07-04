
if (instance_number(obj_player) == 0 && transition_timer == 0) { transition_timer = 1; }
else if (transition_timer > 0) {
	transition_timer++;

	if (transition_timer == transition_duration + transition_hold + transition_delay) { reset_room(); }
	else if (transition_timer >= (transition_duration * 2) + transition_hold + transition_delay) { transition_timer = 0; }
}