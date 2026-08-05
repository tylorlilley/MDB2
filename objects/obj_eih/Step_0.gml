walk_timer++;
should_draw = true;
if (x < room_width/2-8) {
	if (walk_timer == 6) { grid_move_to(x+8,y); walk_timer = 0; play_sound(snd_eih_step); image_index++; }
}
else if (walk_timer > 80 && instance_number(obj_player) == 0)  { instance_create(x, -16, obj_player); }