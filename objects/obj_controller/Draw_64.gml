var _room_name = "Room Title"
switch(room) {
	case rm_new_0_1: { _room_name = "The Amazing Digital Tutorial"; break; }
	case rm_new_1_1: { _room_name = "Back Below the Familiar Pier"; break; }
}

// Draw HUD
draw_set_color(c_black);
draw_rectangle(0, 0, 256, 16, false);
draw_set_color(c_white);
draw_set_font(ft_teko);
draw_text(4, 0, _room_name);
draw_text(256-20, 0, "x" + string(instance_number(obj_key)));
draw_sprite(spr_key, 0, 256-20-16, 0);