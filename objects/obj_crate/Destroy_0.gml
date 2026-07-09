// Inherit the parent event
event_inherited();

with (contents) {
	grid_move_to(other.x, other.y);
	instance_activate_object(contents);
}
