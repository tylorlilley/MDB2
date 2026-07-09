if ((x + sprite_get_width(sprite_index) <= 0) || (x >= room_width) || (y >= room_height) || (y + sprite_get_height(sprite_index) <= 0)) { 
	ring_out_timer++;
}
else { ring_out_timer = 0; }

if (ring_out_timer == 8) { play_sound(snd_player_offscreen); }
else if (ring_out_timer == 40) { instance_destroy(); }