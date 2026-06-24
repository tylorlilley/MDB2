if (object_index != obj_player) {
	if (!is_fixed && !is_grounded()) { y += 2; }
}

if (is_moving) {
	if (y_speed < 0) {
		if (is_under_ceiling(true)) { y_speed *= -1; }
		else { y += y_speed; }
	}
	else if (y_speed > 0) {
		if (is_grounded(true)) { y_speed *= -1; }
		else { y += y_speed; }
	}
	if (x_speed < 0) {
		if (is_blocked_on_left(true)) { x_speed *= -1; }
		else { x += x_speed; }
	}
	else if (x_speed > 0) {
		if (is_blocked_on_right(true)) { x_speed *= -1; }
		else { x += x_speed; }
	}
}