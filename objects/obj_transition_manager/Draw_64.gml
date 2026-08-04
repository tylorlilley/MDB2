var _third_height = room_height/4;
draw_set_color(C_BLACK);
draw_rectangle(0, 0, room_width, _third_height, false);
draw_rectangle(0, _third_height*3, room_width, room_height, false);

draw_set_color(C_WHITE);
draw_set_font(ft_nirmala_ui);
draw_set_halign(fa_center);

#macro WAIT_TIME 24
#macro TEXT_FLY_TIME 8
#macro TEXT_SCRAWL_TIME 32

enum TRANSITION_STATES {
	INITIAL_WAIT,
	TOP_TEXT_FLY_IN,
	TOP_TEXT_SCRAWL,
	TOP_TEXT_FLY_OUT,
	MIDDLE_WAIT,
	BOTTOM_TEXT_FLY_IN,
	BOTTOM_TEXT_SCRAWL,
	BOTTOM_TEXT_FLY_OUT,
	FINAL_WAIT
}

// Determine current state
var _time_in_transition = 0, _threshold = 0;
var _state_threshold_1 = WAIT_TIME,
	_state_threshold_2 = WAIT_TIME + TEXT_FLY_TIME,
	_state_threshold_3 = WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME,
	_state_threshold_4 = WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME + TEXT_FLY_TIME,
	_state_threshold_5 = WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME + TEXT_FLY_TIME + WAIT_TIME,
	_state_threshold_6 = WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME + TEXT_FLY_TIME + WAIT_TIME + TEXT_FLY_TIME,
	_state_threshold_7 = WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME + TEXT_FLY_TIME + WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME,
	_state_threshold_8 = WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME + TEXT_FLY_TIME + WAIT_TIME + TEXT_FLY_TIME + TEXT_SCRAWL_TIME + TEXT_FLY_TIME;

if (transition_timer < _state_threshold_1) { state = TRANSITION_STATES.INITIAL_WAIT; _threshold = 0; }
else if (transition_timer < _state_threshold_2) { state = TRANSITION_STATES.TOP_TEXT_FLY_IN; _threshold = _state_threshold_1; }
else if (transition_timer < _state_threshold_3) { state = TRANSITION_STATES.TOP_TEXT_SCRAWL; _threshold = _state_threshold_2; }
else if (transition_timer < _state_threshold_4) { state = TRANSITION_STATES.TOP_TEXT_FLY_OUT; _threshold = _state_threshold_3; }
else if (transition_timer < _state_threshold_5) { state = TRANSITION_STATES.MIDDLE_WAIT; _threshold = _state_threshold_4; }
else if (transition_timer < _state_threshold_6) { state = TRANSITION_STATES.BOTTOM_TEXT_FLY_IN; _threshold = _state_threshold_5; }
else if (transition_timer < _state_threshold_7) { state = TRANSITION_STATES.BOTTOM_TEXT_SCRAWL; _threshold = _state_threshold_6; }
else if (transition_timer < _state_threshold_8) { state = TRANSITION_STATES.BOTTOM_TEXT_FLY_OUT; _threshold = _state_threshold_7; }
else { state = TRANSITION_STATES.FINAL_WAIT; _threshold = _state_threshold_8; }
_time_in_transition = transition_timer - _threshold; 

var _top_string = "Now Leaving", _bottom_string = "Now Entering", _top_string_additional = "... " + from_string, _bottom_string_additional = "... " + to_string, _top_string_width = string_width(_top_string), _bottom_string_width = string_width(_bottom_string + _bottom_string_additional)
var _top_x_pos = room_width, _target_x_pos = 0, _top_y_pos = (room_height/4)-24, _bottom_x_pos = 0, _bottom_y_pos = ((3*room_height/4)+24);
draw_set_halign(fa_left);
switch (state) {
	case (TRANSITION_STATES.TOP_TEXT_FLY_IN): {
		_top_string_width = string_width(_top_string);
		_top_x_pos = room_width;
		_target_x_pos = (room_width/2) - _top_string_width/2;
		_top_x_pos -= ((_top_x_pos - _target_x_pos) / TEXT_FLY_TIME) * _time_in_transition;
		
		draw_text(_top_x_pos, _top_y_pos, _top_string);
		break;
	}
	case (TRANSITION_STATES.TOP_TEXT_SCRAWL): {
		_top_string += string_copy(_top_string_additional, 1, _time_in_transition div (TEXT_SCRAWL_TIME div string_length(_top_string_additional)));
		_top_string_width = string_width(_top_string);
		
		_top_x_pos = (room_width/2) - _top_string_width/2;
		_target_x_pos = (room_width/2) - _top_string_width;
		_top_x_pos -= ((_top_x_pos - _target_x_pos) / TEXT_SCRAWL_TIME) * _time_in_transition;
		
		
		draw_text(_top_x_pos, _top_y_pos, _top_string);
		break;
	}
	case (TRANSITION_STATES.TOP_TEXT_FLY_OUT): {
		_top_string += _top_string_additional;
		_top_string_width = string_width(_top_string);
		
		_top_x_pos = (room_width/2) - _top_string_width;
		_target_x_pos = 0;
		_top_x_pos -= ((_top_x_pos - _target_x_pos) / TEXT_FLY_TIME) * _time_in_transition;
		
		draw_text(_top_x_pos, _top_y_pos, _top_string);
		break;
	}
	case (TRANSITION_STATES.MIDDLE_WAIT): {
		_top_string += _top_string_additional;
		_top_string_width = string_width(_top_string);
		
		_top_x_pos = 0;
		_target_x_pos = -_top_string_width;
		_top_x_pos -= ((((room_width/2) - _top_string_width/2)) / TEXT_FLY_TIME) * _time_in_transition;
		
		draw_text(_top_x_pos, _top_y_pos, _top_string);
		break;
	}
}

/*
// Determine X POS
var _top_x_pos = room_width, _bottom_x_pos = 0, _second_scrawl_start = INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME + TRANSITION_WAIT;
if (transition_timer < INITIAL_WAIT) { _top_x_pos = 9999; }
else if (transition_timer < INITIAL_WAIT + TEXT_SCRAWL_TIME) {
	var _time_in_state = transition_timer - INITIAL_WAIT, _time_in_state_max = TEXT_SCRAWL_TIME;
	_top_x_pos = room_width;
	_top_x_pos -= ((room_width/3) / _time_in_state_max) * _time_in_state;
}
else if (transition_timer < INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME + 16) {
	var _time_in_state = transition_timer - (INITIAL_WAIT + TEXT_SCRAWL_TIME), _time_in_state_max = ELIPSES_TIME + 16;
	_top_x_pos = (room_width/3);
	_top_x_pos -= ((room_width/3) / _time_in_state_max) * _time_in_state;
}
else {
	var _time_in_state = transition_timer - (INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME + 16), _time_in_state_max = TEXT_SCRAWL_TIME;
	_top_x_pos = 2*(room_width/3);
	_top_x_pos -= ((room_width/3) / _time_in_state_max) * _time_in_state;
}

if (transition_timer < _second_scrawl_start) {
	_bottom_x_pos += ((room_width/2) / INITIAL_WAIT) * (transition_timer - (INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME));
}
else if (transition_timer < _second_scrawl_start + TEXT_SCRAWL_TIME) {
	_bottom_x_pos += (room_width/2) + (transition_timer - _second_scrawl_start);
}
else {
	_bottom_x_pos += ((room_width/2) + TEXT_SCRAWL_TIME) + ((room_width/2) / INITIAL_WAIT) * (transition_timer - _second_scrawl_start - TEXT_SCRAWL_TIME);
}

// Draw Text
draw_set_valign(fa_top);
var _string = "Now Leaving...", x_pos = room_width/2;
/*
if (transition_timer < INITIAL_WAIT) { }
else if (transition_timer < (INITIAL_WAIT + TEXT_SCRAWL_TIME)) {
	draw_text(_top_x_pos, _third_height-24, string_copy(_string, 1, min((transition_timer - TEXT_SCRAWL_TIME) div 2, string_length(_string))));
}
else if (transition_timer < (INITIAL_WAIT + TEXT_SCRAWL_TIME + ELIPSES_TIME)) {
	draw_text(_top_x_pos, _third_height-24, string_copy(_string, 1, 11 + min((transition_timer - INITIAL_WAIT - TEXT_SCRAWL_TIME)  div 8, string_length(_string))));
}
else {
	_string += " " + from_string;
	draw_text(_top_x_pos, _third_height-24, _string);
}
*/

/*
draw_set_valign(fa_bottom);
var _string2 = "Now Entering...";
if (transition_timer < _second_scrawl_start) { }
else if (transition_timer < _second_scrawl_start + TEXT_SCRAWL_TIME) {
	draw_text(_bottom_x_pos, (_third_height*3)+24, string_copy(_string2, 1, min((transition_timer - _second_scrawl_start) div 2, string_length(_string))));
}
else if (transition_timer < (_second_scrawl_start + TEXT_SCRAWL_TIME + ELIPSES_TIME)) {
	draw_text(_bottom_x_pos, (_third_height*3)+24, string_copy(_string2, 1, 12 + min((transition_timer - _second_scrawl_start - TEXT_SCRAWL_TIME)  div 8, string_length(_string))));
}
else {
	_string2 += " " + to_string;
	draw_text(_bottom_x_pos, (_third_height*3)+24, _string2);
}
*/