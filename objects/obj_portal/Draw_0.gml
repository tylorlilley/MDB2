event_inherited();
if (instance_exists(linked_portal) && activation_timer > 78) {
	draw_set_color(C_GRAY);
	draw_line(x+8, y+8, linked_portal.x+8, linked_portal.y+8);
}