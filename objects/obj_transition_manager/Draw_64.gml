var _third_height = room_height/4;
draw_set_color(C_BLACK);
draw_rectangle(0, 0, room_width, _third_height, false);
draw_rectangle(0, _third_height*3, room_width, room_height, false);

draw_set_color(C_WHITE);
draw_set_font(ft_teko);
draw_set_halign(fa_center);

#macro INITIAL_WAIT 24
#macro TEXT_SCRAWL_TIME 24
#macro ELIPSES_TIME 40
#macro TRANSITION_WAIT 24

draw_set_valign(fa_top);
var _string = "Now Leaving...";
if (transition_timer < INITIAL_WAIT) { }
else if (transition_timer < (INITIAL_WAIT + TEXT_SCRAWL_TIME)) {
	draw_text(room_width/2, _third_height-24, string_copy(_string, 1, min((transition_timer - TEXT_SCRAWL_TIME) div 2, string_length(_string))));
}
else if (transition_timer < (INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME)) {
	draw_text(room_width/2, _third_height-24, string_copy(_string, 1, 11 + min((transition_timer - INITIAL_WAIT - TEXT_SCRAWL_TIME)  div 8, string_length(_string))));
}
else {
	_string += " " + from_string;
	draw_text(room_width/2, _third_height-24, _string);
}

draw_set_valign(fa_bottom);
var _string2 = "Now Entering...", _second_scrawl_start = INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME + TRANSITION_WAIT;
if (transition_timer < _second_scrawl_start) { }
else if (transition_timer < _second_scrawl_start + TEXT_SCRAWL_TIME) {
	draw_text(room_width/2, (_third_height*3)+24, string_copy(_string2, 1, min((transition_timer - _second_scrawl_start) div 2, string_length(_string))));
}
else if (transition_timer < (_second_scrawl_start + TEXT_SCRAWL_TIME + ELIPSES_TIME)) {
	draw_text(room_width/2, (_third_height*3)+24, string_copy(_string2, 1, 12 + min((transition_timer - _second_scrawl_start - TEXT_SCRAWL_TIME)  div 8, string_length(_string))));
}
else {
	_string2 += " " + to_string;
	draw_text(room_width/2, (_third_height*3)+24, _string2);
}