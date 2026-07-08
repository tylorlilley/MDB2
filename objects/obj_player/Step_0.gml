update_player_state();
update_player_collisions_at_position();
update_player_graphics();
update_cape_graphics();

if (x > 0 && y > 0 && x < room_width && y < room_height) {
	last_x = x;
	last_y = y;
}